#/bin/bash

logfile=eval_$(date +%Y%m%d)_$(date +%H%M%S)

mkdir log
bash eval_tgn_self_sup.sh >log/$logfile.log
