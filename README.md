# From inconsistency to decision: explainable operation and maintenance of battery energy storage systems
## Article: From inconsistency to decision: explainable operation and maintenance of battery energy storage systems

## Arxiv link: https://arxiv.org/abs/2601.03007

## Main content: 
An inconsistency-driven O&M paradigm for large-scale BESSs that systematically transforms routine monitoring data into explainable and decision-oriented guidance via large language model–based semantic reasoning.

## Structure (to be updated):
```text
.
├── Dataset/
│   ├── Inconsistency_dataset/ 
│   ├── Inconsistency_dataset_chroma/
│   ├── inconsistency_knowledgeset/
│   │   └── review_paper/
│   └── inconsistency_knowledgeset_chroma/
│
├── Script/
│   ├── Dataset2Vec.py
│   ├── record_dataset_construct.m
│   └── README.md
```
## Project Structure Description

### Dataset/

- **Inconsistency_dataset/**  
  Contains the *record dataset* used for inconsistency evaluation.

- **Inconsistency_dataset_chroma/**  
  Contains the vectorized representations of the record dataset, generated for semantic retrieval and downstream analysis.

- **inconsistency_knowledgeset/review_paper/**  
  Contains curated knowledge pieces extracted from relevant review papers, serving as the knowledge base for inconsistency analysis.

- **inconsistency_knowledgeset_chroma/**  
  Contains the vectorized representations of the extracted knowledge pieces.

### Script/

- **Dataset2Vec.py**  
  Provides the source code for dataset and knowledge base vectorization.  
  This script requires a local installation of the **BGE embedding model**.

- **record_dataset_construct.m**  
  Used to construct the record dataset by integrating the original source data with inconsistency evaluation results produced by the developed algorithms (to be released in future updates).

---

### Notes

The source data and algorithm implementations are still under refinement.  
All materials will be fully organized and made publicly available in the GitHub repository upon completion of the work.






