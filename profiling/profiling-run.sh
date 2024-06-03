#/bin/bash

srun --mpi=pmix --nodes=1 --ntasks-per-node=4 --gpus-per-task=1 agi profile -o neko_profile.sql --label="NEKO" -m 600 --wrap="./neko tgv_Re1600.case"
