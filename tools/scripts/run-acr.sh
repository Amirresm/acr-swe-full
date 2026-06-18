#!/bin/bash

# script to run the ACR generation

# SWE_TESTBED must be defined as an environment variable
if [ -z "$SWE_TESTBED" ]; then
    echo "SWE_TESTBED environment variable is not set. Please set it to the path of the testbed directory."
    exit 1
fi

if [ -z "$MODEL_NAME" ]; then
    echo "MODEL_NAME environment variable is not set. Please set it to the name of the model to evaluate."
    exit 1
fi

if [ -z "$ACR_OUTPUT" ]; then
    echo "ACR_OUTPUT environment variable is not set. Please set it to the path of the output directory for ACR results."
    exit 1
fi

if [ -z "$TASK_FILE" ]; then
    echo "TASK_FILE environment variable is not set. Please set it to the path of the task list file."
    exit 1
fi

CONDA_ROOT=$(dirname $(dirname $CONDA_EXE))
source "$CONDA_ROOT/etc/profile.d/conda.sh"

conda activate auto-code-rover

echo "Running ACR generation for model: $MODEL_NAME"
echo "Using testbed setup from: $SWE_TESTBED/setup_result"
echo "Outputting ACR results to: $ACR_OUTPUT"

echo "Using task file: $TASK_FILE"

PYTHONPATH=. python app/main.py swe-bench \
    --model $MODEL_NAME \
    --setup-map $SWE_TESTBED/setup_result/setup_map.json \
    --tasks-map $SWE_TESTBED/setup_result/tasks_map.json \
    --output-dir $ACR_OUTPUT \
    --task-list-file $TASK_FILE

conda deactivate
