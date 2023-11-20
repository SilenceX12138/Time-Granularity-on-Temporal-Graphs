# Exploring Time Granularity on Temporal Graphs for Dynamic Link Prediction in Real-world Networks

## Introduction

Dynamic Graph Neural Networks (DGNNs) have emerged as the predominant approach for processing dynamic graph-structured data. However, the influence of temporal information on model performance and robustness remains insufficiently explored, particularly regarding how models address prediction tasks in the absence of corresponding temporal information. In this study, we explore the optimal choice of time granularity for training DGNNs on dynamic graphs through extensive experimentation. We examined graphs derived from various domains and compared three different DGNNs to the baseline model across four varied time granularities. We mainly consider the interplay between time granularities, model architectures, and negative sampling strategies to obtain general conclusions. Our experiments reveal that a sophisticated memory mechanism and proper time granularity are crucial for a DGNN to deliver exceptional and robust performance in the dynamic link prediction task. We also discuss drawbacks in selected models and datasets and propose promising directions for future research on the time granularity of temporal graphs.

<img width="1103" alt="image" src="https://github.com/SilenceX12138/Time-Granularity-on-Temporal-Graphs/assets/47887520/c589b654-d4ed-45ef-bb98-ae8c164279d7">

## Running the experiments

### Set up Environment
```{bash}
conda create -n dgb python=3.9
```

then run 
```{bash}
source install.sh
```

#### Datasets and Processing
All dynamic graph datasets can be downloaded from [here](https://zenodo.org/record/7213796#.Y1cO6y8r30o).
Then, they can be located in *"DG_data"* folder.
For conducting any experiments, the required data should be in the **data** folder under each model of interest.

* For example, to train a *TGN* model on *Wikipedia* dataset, we can use the following command to move the edgelist to the right folder:
```{bash}
cp DG_data/wikipedia.csv tgn/data/wikipedia.csv
```

* Then, the edgelist should be pre-processed to have the right format.
Considering the example of *Wikipedia* edgelist, we can use the following command for pre-processing the dataset:
```{bash}
# JODIE, DyRep, or TGN
python tgn/utils/preprocess_data.py --data wikipedia
```


### Model Training
* Example of training different graph representation learning models on *Wikipedia* dataset:
```{bash}
data=wikipedia
n_runs=5

# JODIE
method=jodie
prefix="${method}_rnn"
python tgn/train_self_supervised.py -d $data --use_memory --memory_updater rnn --embedding_module time --prefix "$prefix" --n_runs "$n_runs" --gpu 0

# DyRep
method=dyrep
prefix="${method}_rnn"
python tgn/train_self_supervised.py -d "$data" --use_memory --memory_updater rnn --dyrep --use_destination_embedding_in_message --prefix "$prefix" --n_runs "$n_runs" --gpu 0

# TGN
method=tgn
prefix="${method}_attn"
python tgn/train_self_supervised.py -d $data --use_memory --prefix "$prefix" --n_runs "$n_runs" --gpu 0
```

* Example of using EdgeBank for dynamic link prediction with standard *random* negative sampler:
```{bash}
data=Wikipedia
mem_mode=unlim_mem
n_runs=5
neg_sample=rnd  # can be one of these options: "rnd": standard randome, "hist_nre": Historical NS, or "induc_nre": Inductive NS
python EdgeBank/link_pred/edge_bank_baseline.py --data "$data" --mem_mode "$mem_mode" --n_runs "$n_runs" --neg_sample "$neg_sample"
```

### Testing Trained Models
* Testing trained models with different negative edge sampling strategies:
```{bash}
n_runs=5
data=wikipedia
neg_sample=hist_nre  # can be either "hist_nre" for historical NS, or "induc_nre" for inductive NS

# JODIE
method=jodie
python tgn/tgn_test_trained_model_self_sup.py -d "$data" --use_memory --memory_updater rnn --embedding_module time --model $method --neg_sample $neg_sample --n_runs $n_runs --gpu 0

# DyRep
method=dyrep
python tgn/tgn_test_trained_model_self_sup.py -d "$data" --use_memory --memory_updater rnn --dyrep --use_destination_embedding_in_message --model $method --neg_sample $neg_sample --n_runs $n_runs --gpu 0

# TGN
method=tgn
python tgn/tgn_test_trained_model_self_sup.py -d $data --use_memory --model $method --neg_sample $neg_sample --n_runs $n_runs --gpu 0

```

### Environment Requirements
* `python >= 3.7`, `PyTorch >= 1.4`
* Other requirements:
```{bash}
pandas==1.1.0
scikit_learn==0.23.1
tqdm==4.41.1
numpy==1.16.4
matploblib==3.3.1
```

