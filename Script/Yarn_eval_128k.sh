#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/Yarn/eval/perplexity.py"
Data_Folder="Data/LLM"
Dataset_Folder="Dataset/LLM"
Model_Folder="Model/LLM"

Dataset_Folder="Dataset/LLM"
PROOFPG19="${Dataset_Folder}/pg19_Part_tokenization_test"
#PROOFPG19="emozilla/pg19-test-tokenized"

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
python ${PYTHON_FILE} \
    -m ${Model_Folder}/pythia-14m \
    --dataset ${Dataset_Folder}/pg19_Part \
    --split test \
    --feature text \
    --save-tokenized ${PROOFPG19}

python ${PYTHON_FILE} \
    -m ${Model_Folder}/pythia-14m-128k \
    --tokenized ${PROOFPG19} \
    --max-tokens 512 --min-tokens 512 --tokens-step 1  --aggressive-memory \
    --output-file ${Data_Folder}/pythia-14m-128k.csv \
    --flash-attention \
    #--max-tokens 16384 --min-tokens 2048 --tokens-step 2048  --aggressive-memory \