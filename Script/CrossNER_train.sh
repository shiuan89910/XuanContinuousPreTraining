#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/CrossNER/run_language_modeling.py"
Dataset_Folder="Dataset/NER/PreTrain"
Model_Folder="Model/NER"

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
python ${PYTHON_FILE} \
    --model_name_or_path ${Model_Folder}/bert-base-cased \
    --model_type bert \
    --train_data_file ${Dataset_Folder}/AI/ai_integrated.txt \
    --mlm \
    --mlm_probability 0.15\
    --block_size 32 \
    --do_train \
    --overwrite_output_dir true\
    --output_dir ${Model_Folder}/AI_integrated \