
### NEKO-ISC24-Onsite
In the onsite part of the ISC24 Student Cluster Competition, eight teams from around the world compete in various applications against each other. Unlike the virtual part, each team must bring its own remote cluster to the competition. To limit hardware resources, there is a power limit of 6.5 kW. 

Our cluster, called "Srbinz" (yes, like the Swiss cheese), consists of five nodes, each armed with an NVIDIA GH200 Superchip.

Out of the eight finalists, we were proud to be honored with 3rd place by the HPC Advisory Council.

### Tasks
The tasks of the onsite competition are always similar to those presented in the virtual part. Additionally, one mystery application is presented, along with several benchmarks like HPL and HPCG. 

I was working on NEKO and HPL. NEKO is a high-order spectral element flow simulation written in Fortran, with many applications in fluid dynamics simulations. For NEKO, the following task description was given:

*The aim of this task is to compute as many time steps as possible for the given flow case within a time limit of 15 minutes. Run NEKO with the given input `tgv.zip` (`neko tgv_Re1600.case`) on either CPUs or GPUs. Submit your best result (standard output). Do not submit binary output files or multiple results. Note: You are allowed to experiment with different linear solvers in NEKO (see the manual) to achieve the fastest runtime. However, all solvers are not guaranteed to work for the given case or support all hardware backends in NEKO. Furthermore, you are allowed to experiment with different configuration options when building NEKO, such as enabling device-aware MPI. However, it is not allowed to use single precision, change the time-step size, or alter any other parameters related to the case.*



### Our Approach

Since the task allows us to submit either a CPU or a GPU run of NEKO, we built both versions and chose the faster one. The base run of the GPU version performed significantly faster than the CPU version, so we focused on optimizing the GPU version. Our optimization approach involved experimenting with different combinations of compilers and MPI implementations. For instance, we tried `gcc11`, `gcc13`, and `nvhpc` as compilers, and `openmpi` and `mpich` as MPI libraries. The combination `gcc11 x openmpi` performed best.

Here is a list of all dependencies we used:

- `gcc11`
- `openmpi`
- `nvpl-blas`, `nvpl-lapack`
- `json-fortran`
- `metis`, `parmetis` (optional)
- `nccl` (optional)

All dependency trees for each package can be found in `spack.yaml`.

We used `metis` and `parmetis` for graph and mesh partitioning algorithms, which we thought would be useful for large input cases. Additionally, we used `nccl` (NVIDIA's high-performance collective communication library) to optimize our multi-GPU communication. We also enabled `--enable-device-mpi` to avoid unnecessary device-host copies.

We used `nvpl-blas` and `nvpl-lapack` as our BLAS/LAPACK implementation since `openblas` is not compatible with our architecture. We installed the newest versions of `nvpl-blas` and `nvpl-lapack` manually since Spack doesn't provide them. However, note that multithreaded BLAS/LAPACK implementations don't significantly impact performance, as these libraries are only required at the beginning of the code to invert some matrices. NEKO heavily relies on small matrix multiplications, which are not well-suited for these libraries. Consequently, the developers of NEKO have implemented their own math kernels.

Additionally, we used hardware-specific compiler flags like `-march=neoverse-v2 -mtune-neoverse-v2` and performance flags like `-O3 -funroll-loops`. We ensured that each MPI task is explicitly bound to exactly one GPU, resulting in a total of 5 MPI tasks.

To figure out the best linear solver configuration, we tried out each combination of velocity and pressure solver and compared the runtime. In the end we choose `gmres` as our velocity solver and `fusedcg` as our pressure solver.

To avoid some cache traffic we have also manually cleaned the caches before doing the performance run (`clean_caches.sh`).


For bonus points, we also visualized and GPU-profiled NEKO. The profiling outputs can be found in the directory `profiling`. It should be noted that while NEKO might scale well on GPU devices, it does not use the device efficiently. However, improvement is observable between the newer and older NEKO versions.
