#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/DeepKE/example/ner/prepare-data/prepare_weaksupervised_data.py"
Data_Folder="Data/NER"

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
python ${PYTHON_FILE} \
    --language en \
    --dict_dir ${Data_Folder}/Dict/output.csv \
    --source_dir ${Data_Folder}/Untagged \
    --output_dir ${Data_Folder}/Tagged/ouput \