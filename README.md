# VDM_Toolkit
Repository of various VDM-SL developments.

## experiments

* Colleciton of interesting VDM-SL experiments. 
* Collection of manually translated VDM-SL to Isabelle/HOL. 

## issues 

* Collection of minimal examples highlighting tool issues/errors. 
* Reported to and fixed by corresponding tool builders.

### CG

* Overture code generator issues. 

### TC

* Overture / VDMJ type checker (and occasionally parsing) issues.

### VSCode 

* VSCode LSP related issues. 

## scripts 

* Collection of VDMJ scripts useful for seemless VDMJ updates. 
* Works for Linux/Mac (**TODO: adapt for Windows!**). 

## plugins (other directories)

Repository of VDMJ plugins. Under the expected (latest) VDMJ version, they will run inside the VDMJ interpreter as console commands. 

To build call: 

```
mvn clean install
```

## annotationsVDMToolkit
Collection of VDMJ annotation extensions.

## quickcheck2isa
VDM QuickCheck extension with strategies inspired by common patterns in Isabelle/HOL proofs for VDM-SL models. 

## vdmantlr
ANTLR4 version of the VDM-SL EBNF embedded as an extension/substitution to VDMJ's native parser. 

## vdm2isa
Various VDMJ plugs related to VDM-SL (VDM10) translation to Isabelle/HOL (2021-RC1), see corresponding README.MD.

## vdm2isa-lsp
vdm2isa VSCode LSP extension to enable vdm2isa within VDM-VSCode.

## vdmlib
Various VDM-SL libraries. These are available both directly on the VDMJ command line, as well as within VSCode, if jars are in place. 


