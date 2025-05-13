#!/usr/bin/env bash

LOG_DIR="arabid_self_20_simulation_results_constant"
SCRIPT="arabidopsis_stronger_selection_server.slim"

mkdir -p "${LOG_DIR}"

for JOB_NO in {1..1000}; do
  echo "running replicate ${JOB_NO}"
  /programs/SLiM-4.2.1/bin/slim \
    -d 'log_dir="'"${LOG_DIR}"'"' \
    -d "job_no=${JOB_NO}" \
    -d "Q=1" \
    "${SCRIPT}"
done
