#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/Yarn/inference.py"
Model_Folder="Model/LLM"

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
python ${PYTHON_FILE} \
    --model ${Model_Folder}/pythia-14m-128k \
    --prompt "The weather is so nice today," \
    --return_tensors pt \
    --max_length 50 \
    --num_return_sequences 1 \
    --skip_special_tokens True