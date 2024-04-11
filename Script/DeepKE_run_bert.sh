#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/DeepKE/example/ner/standard/run_bert.py"

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
python ${PYTHON_FILE} \