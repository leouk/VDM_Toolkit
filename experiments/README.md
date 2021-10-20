# Interesting Experiments
Interesting VDM-SL experiments. We assume latest version of [VDMJ] (https://github.com/nickbattle/vdmj/). 

## Asynch
Experimenting with the VDM-RT-style asynchronous calls in an attempt to make them available for for VDM-SL. 


## Basic: VDM-SL
Exploration of various VDM-SL constructs through examples. This includes (no) use of currying in VDM and how that relates to Isabelle, the use of polymorphism, what the VDM specification principles do for you, varied notions of recursion, etc.

## COOL: programming language
Concurrent object-oriented language semantics based on Cliff Jones' Understanding Programming Languages [book](https://doi.org/10.1007%2F978-3-030-59257-8). This also includes ANTLR grammar for COOL. The semantics is not yet complete. 

## Folderol: first-order logic theorem prover 
Larry Paulson's [Folderol theorem prover] (https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-192.pdf) is defined in ML. I updated it to [Isabelle/ML (2021-1)] (https://isabelle.in.tum.de) and translated to VDM-SL.
 
## DisjointPartition: 
Disjoint partition definition in VDM-SL.

## IsaGenOverture: VDM-SL to Isabelle/HOL
VDM-SL to Isabelle/HOL translator based on recipes developed for my [CSC3323 Software Verification Technologies course] (https://www.ncl.ac.uk/module-catalogue/moduleoutline.php?code=CSC3323). 

It is the result of Jammie Simms' BSC thesis. We are working on a VDMJ plugin version, which is elsewhere in the repository. 

To build it, you will have to symbolically link latest version of [Overture] (https://www.overturetool.org/). 

## Structural Measures
VDM-SL measures enable specification of recursion termination (e.g., over lists, sets, maps, etc.). This experiment attempts to create measures for recursive data types (i.e. records referening themselves, like in a linked list). 

## Verifier
Simple specification verifier, which allows for non-deterministic choices between satisfiable specifications. 