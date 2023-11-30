#!/bin/bash

for i in {23..30}
do
    python eval_noise.py \
        --ckpt /scratch/cky5217/597/Causal-IR-DIL/checkpoint/model_$i.pt \
        --testset /scratch/cky5217/597/Causal-IR-DIL/2K_Resolution/DIV2K/DIV2K_valid_HR \
        --save /scratch/cky5217/597/Causal-IR-DIL/results_15/$i \
        --level 15
done

wait

