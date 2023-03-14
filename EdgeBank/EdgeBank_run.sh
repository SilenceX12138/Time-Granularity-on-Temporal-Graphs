#!/bin/bash

function print_args() {
  p_arr=("$@")
  for each in "${p_arr[@]}"; do
    echo "$each"
  done
}

echo "**********************************************************************************"
echo ">>> *** EdgeBank *** <<<"
echo "**********************************************************************************"
echo "$(date)"

n_runs=1

for data in wikipedia reddit mooc lastfm enron SocialEvo uci; do
  for mem_mode in unlim_mem time_window; do
    for neg_sample in rnd hist_nre induc_nre; do
      if [ "${mem_mode}" = "time_window" ]; then
        for w_mode in fixed; do

          start_time="$(date -u +%s)"

          echo "================================================"
          arguments=("ARGS:" "Data: ${data}" "Memory: ${mem_mode}" "w_mode: ${w_mode}" "n_runs: $n_runs")
          print_args "${arguments[@]}"
          echo "================================================"

          python link_pred/edge_bank_baseline.py --data "$data" --mem_mode "$mem_mode" --w_mode "$w_mode" --n_runs "$n_runs" --neg_sample "$neg_sample"

          end_time="$(date -u +%s)"
          elapsed="$(($end_time - $start_time))"
          echo "================================================"
          arguments=("Method: EBank" "NEG_SAMPLE: ${neg_sample}" "Data: ${data}" "mem_mode: ${mem_mode}" "w_mode: ${w_mode}" "Elapsed Time: ${elapsed} seconds")
          print_args "${arguments[@]}"
          echo "================================================================================================"
          echo ""

        done
      else

        start_time="$(date -u +%s)"

        echo "================================================"
        arguments=("ARGS:" "Data: ${data}" "Memory: ${mem_mode}" "n_runs: $n_runs")
        print_args "${arguments[@]}"
        echo "================================================"

        python link_pred/edge_bank_baseline.py --data "$data" --mem_mode "$mem_mode" --n_runs "$n_runs" --neg_sample "$neg_sample"

        end_time="$(date -u +%s)"
        elapsed="$(($end_time - $start_time))"
        echo "================================================"
        arguments=("Method: EBank" "NEG_SAMPLE: ${neg_sample}" "Data: ${data}" "mem_mode: ${mem_mode}" "w_mode: ${w_mode}" "Elapsed Time: ${elapsed} seconds")
        print_args "${arguments[@]}"
        echo "================================================================================================"
        echo ""

      fi
    done
  done
done
