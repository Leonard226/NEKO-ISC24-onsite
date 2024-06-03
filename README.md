### NEKO-ISC24-Onsite
In the onsite part of the ISC24 Student Cluster Competition eight teams from all over the world compete in various applications against each other.
In contrast to the virtual part, each Team has to bring its own remote cluster to the competition. To limit hardware resources, there is a power limit of 6.5 kW. 
Our cluster, called "Srbinz" (yes, like the Swiss cheese), consists of five nodes each armed with NVIDIA GH200 Superchip.

Out of the eight finalists, we were really proud to be honored with the 3rd place by the HPC-advisory council. 

### Tasks
The tasks of the onsite competition are always really similar to the tasks presented in the virtual part. Additionally, one mystery application is presented and a couple of Benchmarks like HPL or HPCG. 
I was working on NEKO and HPL. For NEKO the following task description was given: 

*The aim of this task is to compute as many time steps as possible for the given flow case within a time limit of maximum 15 minutes.
Run Neko with the given input
tgv.zip (neko tgv_Re1600.case) on either CPUs or GPUs.
Submit your best result (standard output). Do not submit binary output files nor multiple results.
Note: You are allowed to experiment with different linear solvers in Neko (see the manual) to achieve the fastest runtime. 
However, all of them are not guaranteed to work for the given case or support all hardware backends in Neko. 
Furthermore, it is allowed to experiment with different configuration options when building Neko, e.g., enabling device-aware MPI.
However, it is not allowed to use single precision, changing the time-step size or any other parameters related to the case.*


### Our Approach
Our Approach consists of 
