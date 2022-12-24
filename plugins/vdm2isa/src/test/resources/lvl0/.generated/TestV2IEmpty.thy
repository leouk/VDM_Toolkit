(* VDM to Isabelle Translation @2022-12-24T08:19:59.994Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2IEmpty
   in './lvl0/TestV2IEmpty.vdmsl' at line 1:8
   files = [./lvl0/TestV2IEmpty.vdmsl]
*)
theory TestV2IEmpty
imports VDMToolkit 
begin

\<comment>\<open>VDM source: x = nat\<close>
\<comment>\<open>in 'TestV2IEmpty' (./lvl0/TestV2IEmpty.vdmsl) at line 4:7\<close>
type_synonym x = \<open>VDMNat\<close>
	
\<comment>\<open>VDM source: inv_x: (x +> bool)
	inv_x(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IEmpty' (./lvl0/TestV2IEmpty.vdmsl) at line 4:7\<close>
definition
	inv_x :: \<open>x \<Rightarrow> bool\<close>
where
	\<open>inv_x dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_x` specification.\<close>
		(((inv_VDMNat dummy0)))\<close>

		 
lemmas inv_x_defs = inv_VDMNat_def inv_x_def 


 

end 