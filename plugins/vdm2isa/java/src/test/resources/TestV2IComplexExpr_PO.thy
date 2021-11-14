(* VDM to Isabelle Translation @2021-11-14T16:33:06.450474Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IComplexExpr' (./src/test/resources/TestV2IComplexExpr.vdmsl) at line 20:15
files = [./src/test/resources/TestV2IComplexExpr.vdmsl]
*)
theory TestV2IComplexExpr_PO
imports TestV2IComplexExpr
begin


theorem vc31_FINITE_SET:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (finmap1 :: (VDMNat \<rightharpoonup> VDMNat))  . ((((inv_Map (inv_VDMNat) (inv_VDMNat) finmap1))) \<longrightarrow> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x > (10::VDMNat1)) \<longrightarrow> (\<exists> findex2 \<in> (dom finmap1)  . ((the(finmap1 findex2)) = x))))))))"
	
	oops
	
	
	
theorem vc32_FINITE_SET:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (finmap1 :: (VDMNat \<rightharpoonup> VDMNat))  . ((((inv_Map (inv_VDMNat) (inv_VDMNat) finmap1))) \<longrightarrow> (\<forall> (x :: VDMNat)  (y :: VDMNat)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat y))) \<longrightarrow> ((x > y) \<longrightarrow> (\<exists> findex2 \<in> (dom finmap1)  . ((the(finmap1 findex2)) = (x + y)))))))))"
	
	oops
	
	
	
theorem vc41_FINITE_SET:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (finmap1 :: (VDMNat \<rightharpoonup> VDMNat))  . ((((inv_Map (inv_VDMNat) (inv_VDMNat) finmap1))) \<longrightarrow> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x > (10::VDMNat1)) \<longrightarrow> (\<exists> findex2 \<in> (dom finmap1)  . ((the(finmap1 findex2)) = x))))))))"
	
	oops
	
	
	
theorem vc42_FINITE_SET:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (finmap1 :: (VDMNat \<rightharpoonup> VDMNat1))  . ((((inv_Map (inv_VDMNat) (inv_VDMNat1) finmap1))) \<longrightarrow> (\<forall> x :: VDMNat  . (\<forall> y \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (((inv_VDMNat x)) \<and>  (y \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<longrightarrow> ((x > y) \<longrightarrow> (\<exists> findex2 \<in> (dom finmap1)  . ((the(finmap1 findex2)) = (x + y))))))))))"
	
	oops
	
	
	
theorem vc5_UNIQUE_EXISTENCE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists>! (var :: VDMNat)  . ((((inv_VDMNat var))) \<longrightarrow> (var < (1::VDMNat1)))))"
	
	oops
	
	
	
theorem vc51_UNIQUE_EXISTENCE:
	"((\<exists>! var \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (var < (1::VDMNat1))))"
	
	oops
	
	
	
theorem vc6_SUB_TYPE:
	"((((
	\<lambda> (var :: VDMNat)  (var2 :: VDMNat) .
		(if (((inv_VDMNat var))) \<and>  (((inv_VDMNat var2))) then
		(var + var2)
	 else
		undefined
	)
	) (10::VDMNat1)  (20::VDMNat1)) > (0::VDMNat)))"
	
	oops
	
	
	
theorem f_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  (y :: VDMNat1)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_f x  y) \<longrightarrow> (post_f x  y  (x + y))))))"
	
	oops
	
	
end