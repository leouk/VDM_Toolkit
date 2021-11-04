# VDM-SL (VDM10) To Isabelle (2021-RC1)

# Design 


This plugin project creates an interconnected eco system of plugins as:

1. `exu` plugin:
	1. depends on successful type check.
	2. looks for stuff you shouldn’t do (i.e. “bad” style that will make proofs harder, e.g., push structured type invariants up as much as possible). 
	3. looks for stuff you mustn’t do (i.e. VDM that will generate Isabelle errors, like declare after use, cyclic dependencies, etc.).
	
2. `vdm2isa` plugin: 
	1. depends on successful typecheck. 
	2. presumes successful call to `exu` (i.e. if user doesn’t, user is own its own). 
	2. maps type checked AST to translation AST. 
	3. translates `M.vdmsl` to `M.thy` for every `module M`.
	
3. `isapog` plugin:
	1. depends on successful `vdm2isa` call.
	2. goes over translation AST looking for certain POs (beyond VDMJ `pog`).
	3. spots opportunities for potential lemmas.
	3. goes over VDM POGs POs + new POs.  
	4. creates `M_PO.thy` for every `M.thy`.
	
4. `ps2isa` plugin:
	1. depends on successful `isapog` call.
	2. goes over proof obligation list and infers/chooses proof strategies to attempt; multiple outputs are possible.
	3. creates `M_PS_i.thy` for every `M_PO.thy` for every strategy `i`.

# Dependencies

1. [Apache Maven](https://maven.apache.org)
2. [Java JDK 8](https://www.oracle.com/java/technologies/downloads/)>=
3. [VDMJ 4.4.4](https://github.com/nickbattle/vdmj)>=
4. [Isabelle/HOL 2021-RC1](http://isabelle.in.tum.de)>=


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

# IDEAS IMPL

1. `--@witness(expr)`
2. test template translations
3. `VDMToolkit` file hooks


