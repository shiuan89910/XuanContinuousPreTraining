#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/Yarn/truncate.py"
Dataset_Folder="Dataset/LLM"

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
python ${PYTHON_FILE} \
    1024 \
    ${Dataset_Folder}/pg_books-tokenized-bos-eos-chunked-65536_truncate \
    --num-proc 4 \
    #${Dataset_Folder}/pg19_Part_tokenization_truncate \
    #--dataset ${Dataset_Folder}/pg19_Part_tokenization \
