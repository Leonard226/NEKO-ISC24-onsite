#!/bin/bash

CURR_DIR=$PWD
INSTALLATION_DIR="${CURR_DIR}/neko-install"


cd $CURR_DIR/neko-0.8.0-rc1
./regen.sh

GNU_FLAGS="-Ofast"
NVCC_FLAGS="-O3"

./configure CC=gcc \
            FC=gfortran \
            MPICC=mpicc \
            MPIFC=mpif90 \
            FCFLAGS="${GNU_FLAGS}" \
            CCFLAGS="${GNU_FLAGS}" \
            LDFLAGS="-L${P_nvpllapack}/lib -L${P_nvplblas}/lib -L${P_nccl}/lib" \
            --enable-device-mpi \
            --with-cuda=${P_cuda} CUDA_ARCH=-arch=sm_90 NVCC="${P_NVCC}" CUDA_FLAGS="${NVCC_FLAGS}" \
            --with-nccl="${P_nccl}" \
            --with-metis=${P_metis} \
            --with-parmetis=${P_parmetis} \
            --with-blas="${P_nvplblas}/libnvpl_blas_lp64_seq.so" \
            --with-lapack="${P_nvpllapack}/libnvpl_lapack_lp64_seq.so" \
            --prefix=${INSTALLATION_DIR}


make -j32 && make -j32 install


