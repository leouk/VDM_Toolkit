(* VDM to Isabelle Translation @2021-12-17T14:01:51.179804Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IExprsComplexMaps' (./src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 6:5
files = [./src/test/resources/TestV2IExprsComplexMaps.vdmsl]
*)
theory TestV2IExprsComplexMaps_PO
imports TestV2IExprsComplexMaps
begin


\<comment>\<open>VDM source: R = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (./src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 6:5\<close>
theorem R_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (r :: R)  . (((
		(((inv_VDMNat (x\<^sub>R r))) \<and> 
		 ((inv_VDMNat (y\<^sub>R r)))
		))) \<longrightarrow> ((x\<^sub>R (r)) < (y\<^sub>R (r))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: f = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (./src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 14:39\<close>
theorem f_NON_ZERO:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  (y :: VDMNat)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat y))) \<longrightarrow> ((\<not> (y = (0::VDMNat))) \<longrightarrow> (y \<noteq> (0::VDMNat))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v5 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (./src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 24:12\<close>
theorem v5_SUB_TYPE:
	"((\<forall> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<forall> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . ((x < y) \<longrightarrow> (inv_R \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>)))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v6 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (./src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 27:25\<close>
theorem v6_SUB_TYPE:
	"((\<forall> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<forall> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (inv_R \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>))))"
	
	oops
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "f"
hide_const "v6"
hide_const "R"
hide_const "v5"

end