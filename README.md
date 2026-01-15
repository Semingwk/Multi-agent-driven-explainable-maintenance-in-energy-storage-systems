# From inconsistency to decision: explainable operation and maintenance of battery energy storage systems
Article: From inconsistency to decision: explainable operation and maintenance of battery energy storage systems

Arxiv link: https://arxiv.org/abs/2601.03007

Main content:  An inconsistency-driven O&M paradigm for large-scale BESSs that systematically transforms routine monitoring data into explainable and decision-oriented guidance via large language model–based semantic reasoning.

Structure (to be updated):
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

In Dataset/, the Inconsistency_dataset/ contains the record dataset of inconsistency evaluation; Inconsistency_dataset_chroma/ contains the vectorization of the record dataset.
In Dataset/, the inconsistency_knowledgeset/review_paper/ contains all the relevant knowledge extracted and curated from review papers; inconsistency_knowledgeset_chroma/ contains the vectorization of the knowledge pieces.
In Script/, Dataset2Vec.py provides source codes to finish vectorization, which requires local installation of bge embedding model. 
The record_dataset_construct.m is used to construct the record dataset from the original data and the inconsistency evaluation results by developed algorithms (which will be uploaded in the future).

The source data and code are still under refinement and will be fully organized and uploaded to the GitHub repository upon completion of the work.
