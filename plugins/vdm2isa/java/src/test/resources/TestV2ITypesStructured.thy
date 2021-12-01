(* VDM to Isabelle Translation @2021-12-01T14:57:49.848337Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesStructured.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesStructured.vdmsl]
*)
theory TestV2ITypesStructured
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 10:5\<close>
type_synonym G2 = "(VDMInt\<times> VDMInt)"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 11:9\<close>
definition
	inv_G2 :: "G2 \<Rightarrow> bool"
where
	"inv_G2 (l  r) \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_G2 specification\<close>
		((
		((inv_VDMInt (fst (l  r)))\<and>
		 (inv_VDMInt (snd (l  r)))
		)))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let l = (fst (l  r)); r = (snd (l  r)) in 
		\<comment>\<open>User defined body of inv_G2\<close>
		(l < r))"

		 

end