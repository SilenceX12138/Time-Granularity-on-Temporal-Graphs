#/bin/bash

logfile=$(date +%Y%m%d)_$(date +%H%M%S)

mkdir log
bash EdgeBank_run.sh >log/$logfile.log
