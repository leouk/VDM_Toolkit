# VDM scripts
Repository of various VDM scripts useful for VDMJ (Linux/Mac) integration. Corresponding Windows versions should be easy to add.

* _**TODO: Test/add on Windows?**_

# Dependencies

1. [Apache Maven](https://maven.apache.org)
2. [Java JDK 8](https://www.oracle.com/java/technologies/downloads/)>=
3. [VDMJ 4.4.4](https://github.com/nickbattle/vdmj)>=

# Installation
The instructions below presumes a Linux/MacOS environment, but Windows should be similar with necessary adjustments. 

1. Assumptions:
	* All dependencies are properly installed
	* `VDMJ` repo is cloned (`git clone https://github.com/nickbattle/vdmj.git`) 
	* `VDM_Toolkit` repo is cloned 
	(`git clone https://github.com/leouk/VDM_Toolkit`) 

2. Set these environment variables: 
	* `export VDMJ_HOME=$HOME/git/vdmj`
	* `export VDMJTK_HOME=$HOME/git/VDM_Toolkit`
	* `export VDMJ_VERSION=4.4.4-SNAPSHOT`
 
3. Link `vdmj_build` and `vdmj` [scripts](https://github.com/leouk/VDM_Toolkit/tree/main/scripts) to `/usr/local/bin`

4. Call `vdmj_build`; this should:
	* Pull and build latest [VDMJ](https://github.com/nickbattle/vdmj)
	* Pull and build latest [VDM_Toolkit](https://github.com/leouk/VDM_Toolkit) 
	* Test it's working by calling `vdmj`
	
5. Call `vdmj` with necessary parameters; this should:
	* Start `vdmj` with all plugins loaded
	* e.g., `vdmj -i ./M.vdmsl` then call `isapog` on console

# Scripts

## setlinks
Sets new VDMJ version links into VSCode distribution

## unsetlinks
Unsets new VDMJ version links into VSCode distribution

## vdmj_build
Build's VDMJ linking jars to `/usr/local/lib` (or other set in)  `vdmj_env` variables. Assumes `vdmj` linked to `/usr/local/bin`.

## vdmj_env
Sets key VDMJ and build environment variables.

* **TODO: fix/complete! **

## vdmj
`rlwrap`ped script call for VDMJ. This enables console "history" in VDMJ. It uses my prefered VDMJ flags too. Link to `/usr/local/bin`.

## vdmj0
Simplest/raw script call for VDMJ. This enables external tool (e.g. Overture builders) integration with VDMJ without console wrapping and other xinenegans. Link to `/usr/local/bin`.