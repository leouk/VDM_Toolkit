# VDM scripts
Repository of various VDM scripts useful for (Linux/Mac) integration.

* _**TODO: Test/add on Windows?**_

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