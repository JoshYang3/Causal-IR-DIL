#!/bin/bash

ckpt_base="/home/featurize/work/Causal-IR-DIL-main/ckeckpoint_50"
save_base="/home/featurize/work/Causal-IR-DIL-main/results"

# Testsets for Set14 and Set5
testset_base1="/home/featurize/work/data"
declare -a testsets14=("Set14/GTmod12" "Set14/LRbicx2" "Set14/LRbicx3" "Set14/LRbicx4" "Set14/original")
declare -a testsets5=("Set5/GTmod12" "Set5/LRbicx2" "Set5/LRbicx3" "Set5/LRbicx4" "Set5/original")

# Other Testsets
declare -a testsets2=("BSDS100" "BSDS200" "General100" "manga109" "T91" "urban100")

# Function to run the script
run_script() {
    local model="$1"
    local testset_path="$2"
    local save_path="$3"

    python eval_noise.py --ckpt "$model" --testset "$testset_path" --save "$save_path" --level 5

    echo "Processed with model $(basename $model) on ${testset_path}, results saved in ${save_path}"
}

for num in {3..10}; do
    model_path="${ckpt_base}/model_${num}.pt"

    # Set14 testsets
    for testset in "${testsets14[@]}"; do
        run_script "$model_path" "${testset_base1}/${testset}" "${save_base}/Set14_$(basename $testset)_${num}"
    done

    # Set5 testsets
    for testset in "${testsets5[@]}"; do
        run_script "$model_path" "${testset_base1}/${testset}" "${save_base}/Set5_$(basename $testset)_${num}"
    done

    # other testsets
    for testset in "${testsets2[@]}"; do
        run_script "$model_path" "${testset_base1}/${testset}" "${save_base}/${testset}_${num}"
    done

    # historical/LR
    run_script "$model_path" "${testset_base1}/historical/LR" "${save_base}/historical_LR_${num}"
done
