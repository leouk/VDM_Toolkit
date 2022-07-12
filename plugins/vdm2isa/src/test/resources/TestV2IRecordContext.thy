(* VDM to Isabelle Translation @2022-07-06T14:31:23.003177Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './vdm2isa/src/test/resources/TestV2IRecordContext.vdmsl' at line 1:8
files = [./vdm2isa/src/test/resources/TestV2IRecordContext.vdmsl]
*)
theory TestV2IRecordContext
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: R = compose R of x:nat end
	inv mk_R(x) == (x > 10)
	ord mk_R(x1) < mk_R(x2) == (x1 < x2)\<close>
\<comment>\<open>in 'TestV2IRecordContext' (./vdm2isa/src/test/resources/TestV2IRecordContext.vdmsl) at line 5:5\<close>
record R = 
		x\<^sub>R :: "VDMNat"
		

\<comment>\<open>VDM source: inv_R: (R +> bool)
	inv_R(mk_R(x)) ==
(x > 10)\<close>
\<comment>\<open>in 'TestV2IRecordContext' (./vdm2isa/src/test/resources/TestV2IRecordContext.vdmsl) at line 7:22\<close>
definition
	inv_R :: "R \<Rightarrow> bool"
where
	"inv_R dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_R` specification.\<close>
		( (((inv_VDMNat (x\<^sub>R dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context projection for `function parameters`\<close>
		(\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	
			let x = (x\<^sub>R dummy0) in 
		\<comment>\<open>User defined body of inv_R.\<close>
		(x > (10::VDMNat1)))"

		

\<comment>\<open>VDM source: ord_R: (R * R +> bool)
	ord_R(mk_R(x1), mk_R(x2)) ==
(x1 < x2)\<close>
\<comment>\<open>in 'TestV2IRecordContext' (./vdm2isa/src/test/resources/TestV2IRecordContext.vdmsl) at line 8:9\<close>
definition
	ord_R :: "R \<Rightarrow> R \<Rightarrow> bool"
where
	"ord_R dummy0   dummy1 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_R` specification.\<close>
		(inv_R dummy0  \<and>  inv_R dummy1)  \<and> 
		\<comment>\<open>Implicit pattern context projection for `function parameters`\<close>
		(\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	
			let x1 = (x\<^sub>R dummy0); 
			x2 = (x\<^sub>R dummy1) in 
		\<comment>\<open>User defined body of ord_R.\<close>
		(x1 < x2))"

		
lemmas inv_R_defs = inv_R_def inv_VDMNat_def 




end