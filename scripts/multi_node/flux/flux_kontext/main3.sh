#!/bin/bash
# Common part for all nodes
export NCCL_IB_DISABLE=0
export NCCL_IB_HCA=mlx5
export NCCL_DEBUG=WARN
export NCCL_IB_GID_INDEX=3

MASTER_PORT=19001
RANK=3
MASTER_ADDR=10.82.139.22
# Launch command (parameters automatically read from accelerate_multi_node.yaml)
accelerate launch --config_file scripts/accelerate_configs/deepspeed_zero2.yaml \
    --num_machines 4 --num_processes 28 \
    --machine_rank ${RANK} --main_process_ip ${MASTER_ADDR} --main_process_port ${MASTER_PORT} \
    scripts/train_flux_kontext.py \
    --config config/grpo.py:counting_flux_kontext
