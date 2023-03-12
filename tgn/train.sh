#/bin/bash

logfile=train_$(date +%Y%m%d)_$(date +%H%M%S)

mkdir log
bash train_tgn_self_sup.sh > log/$logfile.log
