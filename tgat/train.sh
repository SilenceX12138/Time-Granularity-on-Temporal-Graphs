#/bin/bash

logfile=train_$(date +%Y%m%d)_$(date +%H%M%S)

mkdir log
bash train_tgat_run.sh > log/$logfile.log
