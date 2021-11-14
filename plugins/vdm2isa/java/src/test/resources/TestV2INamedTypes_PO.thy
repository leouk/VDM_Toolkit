(* VDM to Isabelle Translation @2021-11-14T16:33:06.451680Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2INamedTypes' (./src/test/resources/TestV2INamedTypes.vdmsl) at line 14:5
files = [./src/test/resources/TestV2INamedTypes.vdmsl]
*)
theory TestV2INamedTypes_PO
imports TestV2INamedTypes
begin


theorem TBasic2_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (t :: TBasic1)  . ((((inv_VDMNat1 t))) \<longrightarrow> (t > (10::VDMNat1)))))"
	
	oops
	
	
	
theorem TBasic2_EQUIV_RELATION:
	"(((\<forall> (x :: TBasic2)  . ((((inv_TBasic2 x))) \<longrightarrow> (eq_TBasic2 x  x))) \<and> ((\<forall> (x :: TBasic2)  (y :: TBasic2)  . ((((inv_TBasic2 x))) \<and>  (((inv_TBasic2 y))) \<longrightarrow> ((eq_TBasic2 x  y) \<longrightarrow> (eq_TBasic2 y  x)))) \<and> (\<forall> (x :: TBasic2)  (y :: TBasic2)  (z :: TBasic2)  . ((((inv_TBasic2 x))) \<and>  (((inv_TBasic2 y))) \<and>  (((inv_TBasic2 z))) \<longrightarrow> (((eq_TBasic2 x  y) \<and> (eq_TBasic2 y  z)) \<longrightarrow> (eq_TBasic2 x  z)))))))"
	
	oops
	
	
	
theorem TBasic2_STRICT_ORDER:
	"(((\<forall> (x :: TBasic2)  . ((((inv_TBasic2 x))) \<longrightarrow> (\<not> (ord_TBasic2 x  x)))) \<and> (\<forall> (x :: TBasic2)  (y :: TBasic2)  (z :: TBasic2)  . ((((inv_TBasic2 x))) \<and>  (((inv_TBasic2 y))) \<and>  (((inv_TBasic2 z))) \<longrightarrow> (((ord_TBasic2 x  y) \<and> (ord_TBasic2 y  z)) \<longrightarrow> (ord_TBasic2 x  z))))))"
	
	oops
	
	
end