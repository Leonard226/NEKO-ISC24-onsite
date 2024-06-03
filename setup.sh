#!/bin/bash

# CURRENT DIRECTORY
currdir=$PWD

# HASH-CODES
H_openmpi="/uvbwrm6"
H_jsonfortran="/gfdnue6"
H_metis="/7hrinzj"
H_parmetis="/myk6gcl"

# Hashes work but we use manual BLAS/LPACK implementation
#H_nvplblas="/4t26kha"
#H_nvpllapack="/qfqkyx2"

# LOADING PACKAGES
spack unload --all
module load cuda12.3/toolkit/12.3.2
spack load $H_openmpi $H_jsonfortran $H_metis $H_parmetis $H_nvplblas $H_nvpllapack

# PATHS
export P_cuda=$CUDA_HOME
export P_nvcc="/cm/shared/apps/cuda-latest/toolkit/current/bin/nvcc"
export P_nccl="/cm/shared/apps/nvhpc/24.1/Linux_aarch64/24.1/comm_libs/12.3/nccl"
export P_jsonfortran=$(spack location -i $H_jsonfortran)
export P_metis=$(spack location -i $H_metis)
export P_parmetis=$(spack location -i $H_parmetis)

# Hashes work but we use manual BLAS/LAPACK implementation
#export P_nvplblas=$(spack location -i $H_nvplblas)
#export P_nvpllapack=$(spack location -i $H_nvpllapack)

cd $currdir

# SETTING ENVIRONMENT VARIABLES
export P_nvplblas=/home/sleonard/my-packages/nvpl/lib
export P_nvpllapack=/home/sleonard/my-packages/nvpl/lib
export LD_LIBRARY_PATH=$P_jsonfortran/lib64:$P_metis/lib:$P_parmetis/lib:$P_nccl/lib:$P_nvplblas:$P_nvpllapack:$LD_LIBRARY_PATH

