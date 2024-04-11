#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/Yarn/tokenization.py"
Dataset_Folder="Dataset/LLM"
Model_Folder="Model/LLM"

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
python ${PYTHON_FILE} \
    --dataset ${Dataset_Folder}/pg19_Part \
    --tokenizer ${Model_Folder}/pythia-14m \
    --sequence-length 8192 \
    --feature text \
    --split train \
    --output ${Dataset_Folder}/pg19_Part_tokenization \
    --seed 42 \
    --num-proc 4 \