#!/bin/bash

# script to setup the testbed

# SWE_TESTBED must be defined as an environment variable
if [ -z "$SWE_TESTBED" ]; then
    echo "SWE_TESTBED environment variable is not set. Please set it to the path of the testbed directory."
    exit 1
fi

if [ -z "$TASK_FILE" ]; then
    echo "TASK_FILE environment variable is not set. Please set it to the path of the task list file."
    exit 1
fi

CONDA_ROOT=$(dirname $(dirname $CONDA_EXE))
source "$CONDA_ROOT/etc/profile.d/conda.sh"

conda activate swe-bench

echo "Running testbed setup with testbed directory: $SWE_TESTBED"

# num processes can be set as an environment variable, default to max - 2
NUM_PROCESSES=${NUM_PROCESSES:-$(($(nproc) - 2))}
echo "Using $NUM_PROCESSES processes for setup."

echo "Using task file: $TASK_FILE"

python harness/run_setup.py \
    --log_dir $SWE_TESTBED/logs \
    --testbed $SWE_TESTBED/testbed \
    --result_dir $SWE_TESTBED/setup_result \
    --subset_file $TASK_FILE \
    --num_processes $NUM_PROCESSES

conda deactivate
