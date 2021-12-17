(* VDM to Isabelle Translation @2021-12-17T14:01:51.180300Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 6:5
files = [./src/test/resources/TestV2IExprsIs.vdmsl]
*)
theory TestV2IExprsIs_PO
imports TestV2IExprsIs
begin


\<comment>\<open>VDM source: T = ?\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 6:5\<close>
theorem T_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (t :: VDMReal)  . ((((inv_VDMReal t))) \<longrightarrow> (t > (0::VDMNat)))))"
	
	oops
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "T"

end