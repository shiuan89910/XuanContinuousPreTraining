#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/Yarn/finetune.py"
Dataset_Folder="Dataset/LLM"
Model_Folder="Model/LLM"

ACCELERATE_CONFIG="$HOME/.cache/huggingface/accelerate/default_config.yaml"

if [ ! -f "$ACCELERATE_CONFIG" ]; then
    echo "Accelerate config not found. Please run 'accelerate config' to initialize."
    exit 1
fi

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
accelerate launch ${PYTHON_FILE} \
    --output-dir ${Model_Folder}/pythia-14m-64k \
    --model ${Model_Folder}/pythia-14m \
    --deepspeed \
    --dataset ${Dataset_Folder}/pg_books-tokenized-bos-eos-chunked-65536_truncate \