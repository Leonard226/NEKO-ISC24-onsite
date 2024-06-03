#!/bin/bash

#SBATCH --job-name=BABY
#SBATCH --output=output.txt
#SBATCH --nodes=5
#SBATCH --ntasks-per-node=1
#SBATCH --gpus-per-task=1
#SBATCH --exclusive 

CURRDIR=$PWD
NEKO=$CURRDIR/neko
INPUT=$CURRDIR/tgv_Re1600.case

srun --mpi=pmix $NEKO $INPUT
