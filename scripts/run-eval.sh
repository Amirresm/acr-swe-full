#!/bin/bash

# script to run the ACR evaluation

if [ -z "$ACR_OUTPUT" ]; then
    echo "ACR_OUTPUT environment variable is not set. Please set it to the path of the output directory for ACR results."
    exit 1
fi

if [ -z "$TASK_FILE" ]; then
    echo "TASK_FILE environment variable is not set. Please set it to the path of the task list file."
    exit 1
fi
conda activate auto-code-rover

echo "Running ACR evaluation"
echo "Outputting ACR results to: $ACR_OUTPUT/eval"

echo "Using task file: $TASK_FILE"

mkdir -p $ACR_OUTPUT/eval/eval_logs
mkdir -p $ACR_OUTPUT/eval/eval_testbed

python harness/run_evaluation.py \
    --predictions_path $ACR_OUTPUT/predictions_for_swebench.json \
    --swe_bench_tasks /opt/assets/swe-bench.json \
    --log_dir $ACR_OUTPUT/eval/eval_logs \
    --testbed $ACR_OUTPUT/eval/eval_testbed \
    --verbose

conda deactivate
