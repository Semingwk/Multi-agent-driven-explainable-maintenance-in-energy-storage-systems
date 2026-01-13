# build_two_vectorstores_only.py
# -*- coding: utf-8 -*-

import re
from pathlib import Path
from typing import List, Optional
from datetime import datetime

# =========================
# 0) Path & config (keep same as your code)
# =========================
INCONSISTENCY_DATASET_DIR = Path("./Inconsistency_dataset")
INCONSISTENCY_CHROMA_DIR = Path("./Inconsistency_dataset_chroma")

KNOWLEDGESET_DIR = Path("./inconsistency_knowledgeset")
KNOWLEDGE_CHROMA_DIR = Path("./inconsistency_knowledgeset_chroma")

LOCAL_MODEL_DIR = "./bge-base-en-v1_5" # require to download the bge embedding model 
EMBED_DEVICE = "cuda" # if applicable

COLL_INCONSISTENCY = "inconsistency"
COLL_KNOWLEDGE = "knowledge"

# =========================
# 1) LangChain basics
# =========================
try:
    from langchain_core.documents import Document
except Exception:
    from langchain.schema import Document

from langchain_community.vectorstores import Chroma
from langchain_community.document_loaders import PyPDFLoader, TextLoader

# splitter
try:
    from langchain_text_splitters import RecursiveCharacterTextSplitter
except Exception:
    from langchain.text_splitter import RecursiveCharacterTextSplitter


def get_local_embeddings(
    model_dir: str | Path,
    device: str = "cuda",
    normalize: bool = True,
):
    """
    Use local sentence-transformer style model for embeddings.
    Same as your original function.
    """
    from langchain_huggingface import HuggingFaceEmbeddings

    model_dir = Path(model_dir)
    if not model_dir.exists():
        raise FileNotFoundError(f"Embedding model directory does not exist: {model_dir}")

    print(f"[Embeddings] Using local model: {model_dir} (device={device})")
    return HuggingFaceEmbeddings(
        model_name=str(model_dir),
        model_kwargs={"device": device, "local_files_only": True},
        encode_kwargs={"normalize_embeddings": normalize},
    )


def load_vectorstore_generic(
    chroma_dir: Path,
    embeddings,
    collection_name: str,
):
    """
    Same as your original function.
    """
    return Chroma(
        persist_directory=str(chroma_dir),
        embedding_function=embeddings,
        collection_name=collection_name,
    )

# =========================
# 2) inconsistency_dataset: MD split + load + build
# =========================

def _norm_date(s: str) -> str:
    return datetime.strptime(
        s.replace("/", "-").replace(".", "-"), "%Y-%m-%d"
    ).strftime("%Y-%m-%d")


def _date_to_int(s_norm: str) -> int:
    return int(s_norm.replace("-", ""))


def split_md_by_h1_data(md_path: Path) -> List[Document]:
    """
    Same logic as your original: split by H1 (usually date).
    """
    text = md_path.read_text(encoding="utf-8", errors="ignore")
    matches = list(re.finditer(r"^# (.+)$", text, flags=re.MULTILINE))
    if not matches:
        return [Document(page_content=text, metadata={"source": str(md_path)})]

    docs: List[Document] = []
    for i, m in enumerate(matches):
        start = m.start()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        block = text[start:end].strip()
        title = m.group(1).strip()

        try:
            date_norm = _norm_date(title)
            date_epoch = _date_to_int(date_norm)
        except Exception:
            date_norm, date_epoch = title, None

        meta = {
            "h1": title,
            "date": title,
            "date_norm": date_norm,
            "date_epoch": date_epoch,
            "section_path": title,
            "source": str(md_path),
            "already_chunked": True,
        }
        docs.append(Document(page_content=f"[Section] {title}\n{block}", metadata=meta))
    return docs


def load_supported_docs(folder: Path) -> List[Document]:
    """
    Same as your original:
    - PDF -> PyPDFLoader
    - TXT -> TextLoader
    - MD  -> split_md_by_h1_data
    """
    docs: List[Document] = []

    for pdf_path in sorted(folder.glob("**/*.pdf")):
        try:
            loader = PyPDFLoader(str(pdf_path))
            pdf_docs = loader.load()
            for d in pdf_docs:
                d.metadata["source"] = str(pdf_path)
            docs.extend(pdf_docs)
        except Exception as e:
            print(f"Warning: failed to load PDF {pdf_path}: {e}")

    for txt_path in sorted(folder.glob("**/*.txt")):
        try:
            loader = TextLoader(str(txt_path), encoding="utf-8")
            txt_docs = loader.load()
            for d in txt_docs:
                d.metadata["source"] = str(txt_path)
            docs.extend(txt_docs)
        except Exception as e:
            print(f"Warning: failed to load TXT {txt_path}: {e}")

    for md_path in sorted(folder.glob("**/*.md")):
        try:
            md_docs = split_md_by_h1_data(md_path)
            docs.extend(md_docs)
        except Exception as e:
            print(f"Warning: H1 split failed for {md_path}: {e}")

    return docs


def build_vectorstore_from_files(
    dataset_dir: Path,
    chroma_dir: Path,
    embeddings,
    *,
    chunk_size: int = 2000,
    chunk_overlap: int = 0,
    collection_name: Optional[str] = COLL_INCONSISTENCY,
):
    """
    Same as your original:
    - load files
    - split non-MD (not already_chunked)
    - keep MD slices as-is
    - Chroma.from_documents + persist
    """
    docs = load_supported_docs(dataset_dir)
    if not docs:
        raise FileNotFoundError(f"No supported files found in {dataset_dir}")

    need_split = [d for d in docs if not d.metadata.get("already_chunked")]
    already_split = [d for d in docs if d.metadata.get("already_chunked")]

    print(f"[Inconsistency] Found {len(docs)} document(s). Splitting into chunks...")
    all_docs: List[Document] = []
    if need_split:
        splitter = RecursiveCharacterTextSplitter(
            chunk_size=chunk_size,
            chunk_overlap=chunk_overlap,
        )
        all_docs.extend(splitter.split_documents(need_split))
    if already_split:
        all_docs.extend(already_split)

    print(f"[Inconsistency] Total chunks: {len(all_docs)}")
    vectordb = Chroma.from_documents(
        all_docs,
        embedding=embeddings,
        persist_directory=str(chroma_dir),
        collection_name=collection_name,
    )
    vectordb.persist()
    print("[Inconsistency] Vectorstore persisted to:", chroma_dir)
    return vectordb


# =========================
# 3) knowledge_dataset: MD split + load + build
# =========================
H1_PATTERN = re.compile(r"^# (.+)$", flags=re.MULTILINE)

def split_md_by_h1_knowledge(md_path: Path) -> List[Document]:
    """
    Same as your original: store title in page_content, full section in metadata['content_full'].
    """
    text = md_path.read_text(encoding="utf-8", errors="ignore")
    matches = list(H1_PATTERN.finditer(text))
    docs: List[Document] = []

    if not matches:
        title = md_path.stem
        block = text.strip()
        return [Document(page_content=title, metadata={
            "title": title, "source": str(md_path), "content_full": block
        })]

    for i, m in enumerate(matches):
        start = m.start()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        block = text[start:end].strip()
        title = m.group(1).strip()

        docs.append(Document(
            page_content=title,
            metadata={
                "title": title,
                "source": str(md_path),
                "content_full": block
            }
        ))
    return docs


def load_md_docs_knowledge(folder: Path) -> List[Document]:
    """
    Same as your original: scan all .md and split each by H1.
    """
    folder = folder.resolve()
    md_files = list(folder.rglob("*.md"))
    docs: List[Document] = []
    for md_path in md_files:
        docs.extend(split_md_by_h1_knowledge(md_path))
    print(f"[Knowledge] Found {len(md_files)} Markdown files, total {len(docs)} sections.")
    return docs


def build_vectorstore_from_mds(dataset_dir: Path, chroma_dir: Path, embeddings, collection_name: str):
    """
    Same as your original: Chroma.from_documents + persist.
    """
    docs = load_md_docs_knowledge(dataset_dir)
    if not docs:
        raise FileNotFoundError(f"No Markdown files found in {dataset_dir}")

    vectordb = Chroma.from_documents(
        docs,
        embedding=embeddings,
        persist_directory=str(chroma_dir),
        collection_name=collection_name,
    )
    vectordb.persist()
    print("[Knowledge] Vectorstore built and saved to:", chroma_dir)
    return vectordb


# =========================
# 4) Main: ONLY build/load two vectorstores
# =========================
def main():
    embeddings = get_local_embeddings(
        model_dir=LOCAL_MODEL_DIR,
        device=EMBED_DEVICE,
        normalize=True,
    )

    # ---- inconsistency_dataset ----
    INCONSISTENCY_CHROMA_DIR.mkdir(parents=True, exist_ok=True)
    if not any(INCONSISTENCY_CHROMA_DIR.iterdir()):
        vectordb_data = build_vectorstore_from_files(
            dataset_dir=INCONSISTENCY_DATASET_DIR,
            chroma_dir=INCONSISTENCY_CHROMA_DIR,
            embeddings=embeddings,
            chunk_size=2000,
            chunk_overlap=0,
            collection_name=COLL_INCONSISTENCY,
        )
    else:
        vectordb_data = load_vectorstore_generic(
            INCONSISTENCY_CHROMA_DIR,
            embeddings,
            collection_name=COLL_INCONSISTENCY,
        )
    print("[Inconsistency] Chroma doc count:", vectordb_data._collection.count())

    # ---- knowledge_dataset ----
    KNOWLEDGE_CHROMA_DIR.mkdir(parents=True, exist_ok=True)
    if not any(KNOWLEDGE_CHROMA_DIR.iterdir()):
        vectordb_knowledge = build_vectorstore_from_mds(
            dataset_dir=KNOWLEDGESET_DIR,
            chroma_dir=KNOWLEDGE_CHROMA_DIR,
            embeddings=embeddings,
            collection_name=COLL_KNOWLEDGE,
        )
    else:
        vectordb_knowledge = load_vectorstore_generic(
            KNOWLEDGE_CHROMA_DIR,
            embeddings,
            collection_name=COLL_KNOWLEDGE,
        )
    print("[Knowledge] Chroma doc count:", vectordb_knowledge._collection.count())


if __name__ == "__main__":
    main()
