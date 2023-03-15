#/bin/bash

logfile=eval_$(date +%Y%m%d)_$(date +%H%M%S)

mkdir log
bash eval_tgat_test_run.sh >log/$logfile.log
