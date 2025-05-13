#!/usr/bin/env bash

LOG_DIR="arab_no_self"
SCRIPT="hybrid_rescale_server.slim"

mkdir -p "${LOG_DIR}"

# for JOB_NO in {1..1000}; do
#   echo "running replicate ${JOB_NO}"
#   /programs/SLiM-5.0/bin/slim \
#     -d 'log_dir="'"${LOG_DIR}"'"' \
#     -d "job_no=${JOB_NO}" \
#     -d "Q=20" \
#     "${SCRIPT}"
# done

# for JOB_NO in {1..1000}; do
#   echo "running replicate ${JOB_NO}"
#   /programs/SLiM-5.0/bin/slim \
#     -d 'log_dir="'"${LOG_DIR}"'"' \
#     -d "job_no=${JOB_NO}" \
#     -d "Q=10" \
#     "${SCRIPT}"
# done


# for JOB_NO in {1..1000}; do
#   echo "running replicate ${JOB_NO}"
#   /programs/SLiM-5.0/bin/slim \
#     -d 'log_dir="'"${LOG_DIR}"'"' \
#     -d "job_no=${JOB_NO}" \
#     -d "Q=5" \
#     "${SCRIPT}"
# done

for JOB_NO in {1..1000}; do
  echo "running replicate ${JOB_NO}"
  /programs/SLiM-5.0/bin/slim \
    -d 'log_dir="'"${LOG_DIR}"'"' \
    -d "job_no=${JOB_NO}" \
    -d "Q=2" \
    "${SCRIPT}"
done

# for JOB_NO in {1..1000}; do
#   echo "running replicate ${JOB_NO}"
#   /programs/SLiM-5.0/bin/slim \
#     -d 'log_dir="'"${LOG_DIR}"'"' \
#     -d "job_no=${JOB_NO}" \
#     -d "Q=1" \
#     "${SCRIPT}"
# done