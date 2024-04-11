#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/DeepKE/example/ner/prepare-data/jsonl2csv.py"
Data_Folder="Data/NER"

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
python ${PYTHON_FILE} \
    --jsonl_file ${Data_Folder}/Dict/input.jsonl \
    --csv_file ${Data_Folder}/Dict/output.csv \