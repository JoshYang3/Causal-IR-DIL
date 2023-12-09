#!/bin/bash

ckpt_base="/home/featurize/work/Causal-IR-DIL-main/ckeckpoint_50"
save_base="/home/featurize/work/Causal-IR-DIL-main/results_30"

# Set14 and Set5
testset_base1="/home/featurize/work/data"
declare -a testsets14=("Set14/GTmod12" "Set14/LRbicx2" "Set14/LRbicx3" "Set14/LRbicx4" "Set14/original")
declare -a testsets5=("Set5/GTmod12" "Set5/LRbicx2" "Set5/LRbicx3" "Set5/LRbicx4" "Set5/original")

# Other
declare -a testsets2=("manga109" "urban100" "CBSD68")

run_script() {
    local model="$1"
    local testset_path="$2"
    local save_path="$3"

    python eval_noise.py --ckpt "$model" --testset "$testset_path" --save "$save_path" --level 30

    echo "Processed with model $(basename $model) on ${testset_path}, results saved in ${save_path}"
}

for num in {1..10}; do
    model_path="${ckpt_base}/model_${num}.pt"

    for testset in "${testsets2[@]}"; do
        run_script "$model_path" "${testset_base1}/${testset}" "${save_base}/${testset}_${num}"
    done

done
