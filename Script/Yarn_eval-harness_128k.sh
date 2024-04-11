#!/bin/bash

set -e

cd ..

PYTHON_FILE="Module/LmEvaluationHarness/main.py"
Data_Folder="Data/LLM"
Model_Folder="Model/LLM"

MODEL_ARGS="use_accelerate=True,dtype=float32,trust_remote_code=True"
ARGS="--model=hf-causal-experimental --batch_size 2"
HELLASWAG="--tasks=hellaswag --num_fewshot=10"
ARC="--tasks=arc_challenge --num_fewshot=25"
TRUTHFULQA="--tasks=truthfulqa_mc --num_fewshot=0"
MMLU="--tasks=hendrycksTest-abstract_algebra,hendrycksTest-anatomy,hendrycksTest-astronomy,hendrycksTest-business_ethics,hendrycksTest-clinical_knowledge,hendrycksTest-college_biology,hendrycksTest-college_chemistry,hendrycksTest-college_computer_science,hendrycksTest-college_mathematics,hendrycksTest-college_medicine,hendrycksTest-college_physics,hendrycksTest-computer_security,hendrycksTest-conceptual_physics,hendrycksTest-econometrics,hendrycksTest-electrical_engineering,hendrycksTest-elementary_mathematics,hendrycksTest-formal_logic,hendrycksTest-global_facts,hendrycksTest-high_school_biology,hendrycksTest-high_school_chemistry,hendrycksTest-high_school_computer_science,hendrycksTest-high_school_european_history,hendrycksTest-high_school_geography,hendrycksTest-high_school_government_and_politics,hendrycksTest-high_school_macroeconomics,hendrycksTest-high_school_mathematics,hendrycksTest-high_school_microeconomics,hendrycksTest-high_school_physics,hendrycksTest-high_school_psychology,hendrycksTest-high_school_statistics,hendrycksTest-high_school_us_history,hendrycksTest-high_school_world_history,hendrycksTest-human_aging,hendrycksTest-human_sexuality,hendrycksTest-international_law,hendrycksTest-jurisprudence,hendrycksTest-logical_fallacies,hendrycksTest-machine_learning,hendrycksTest-management,hendrycksTest-marketing,hendrycksTest-medical_genetics,hendrycksTest-miscellaneous,hendrycksTest-moral_disputes,hendrycksTest-moral_scenarios,hendrycksTest-nutrition,hendrycksTest-philosophy,hendrycksTest-prehistory,hendrycksTest-professional_accounting,hendrycksTest-professional_law,hendrycksTest-professional_medicine,hendrycksTest-professional_psychology,hendrycksTest-public_relations,hendrycksTest-security_studies,hendrycksTest-sociology,hendrycksTest-us_foreign_policy,hendrycksTest-virology,hendrycksTest-world_religions --num_fewshot=5"

if [ ! -f ${PYTHON_FILE} ]; then
    echo "Error: File not found: $PYTHON_FILE"
    exit 1
fi

echo "Executing $PYTHON_FILE..."
### Hellaswag
python ${PYTHON_FILE} \
    ${ARGS} \
    ${HELLASWAG} \
    --model_args "pretrained=${Model_Folder}/pythia-14m-128k,${MODEL_ARGS}" \
    --output_path "${Data_Folder}/pythia-14m-128k-hellaswag.json"

### ARC-Challenge
python ${PYTHON_FILE} \
    ${ARGS} \
    ${ARC} \
    --model_args "pretrained=${Model_Folder}/pythia-14m-128k,${MODEL_ARGS}" \
    --output_path "${Data_Folder}/pythia-14m-128k-arc.json"

### MMLU
python ${PYTHON_FILE} \
    ${ARGS} \
    ${MMLU} \
    --model_args "pretrained=${Model_Folder}/pythia-14m-128k,${MODEL_ARGS}" \
    --output_path "${Data_Folder}/pythia-14m-128k-mmlu.json"

## TruthfulQA
python ${PYTHON_FILE} \
    ${ARGS} \
    ${TRUTHFULQA} \
    --model_args "pretrained=${Model_Folder}/pythia-14m-128k,${MODEL_ARGS}" \
    --output_path "${Data_Folder}/pythia-14m-128k-truthfulqa.json"