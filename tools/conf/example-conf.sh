#!/bin/bash

if [ ! -f /opt/conf/tasks.txt ]; then
    echo "Copying /opt/conf/swe_lite_tasks.txt to /opt/conf/tasks.txt"
    cp /opt/conf/swe_lite_tasks.txt /opt/conf/tasks.txt
fi

export EXP_ID=exp1
export USE_ARISE=1
export MODEL_NAME=generic-vllm
export TASK_FILE=/opt/conf/tasks.txt

# export GENERIC_VLLM_MODEL_ID="/home/amirresm/projects/def-fard/amirresm/models/Qwen/Qwen2.5-Coder-32B-Instruct"
export SWE_TESTBED=/ACR-SWE/$EXP_ID
export ACR_OUTPUT=$SWE_TESTBED/out

export OPENAI_BASE_URL=http://localhost:11888/v1

export NUM_PROCESSES=$(( $(nproc) / 2 - 2 ))
export NUM_PROCESSES_RUN=$(( $(nproc) / 2 - 2 ))
# if use arise

if [ $USE_ARISE -eq 1 ]; then
    export ARISE_DIRECTORY=/opt/arise
else
    unset ARISE_DIRECTORY
fi
