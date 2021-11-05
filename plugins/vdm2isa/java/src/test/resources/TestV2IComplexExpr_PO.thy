(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IComplexExpr' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IComplexExpr.vdmsl) at line 20:15files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IComplexExpr.vdmsl]
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
	
	
theorem f_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  (y :: VDMNat1)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_f x  y) \<longrightarrow> (post_f x  y  (x + y))))))"
	
	oops
	
end
(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.syntax.ParserException error:
	VDM PO: vc6: function apply obligation in 'TestV2IComplexExpr' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IComplexExpr.vdmsl) at line 56:15
pre_((lambda [var:nat, var2:nat] & (var + var2)), 10, 20)

	Reason: Mismatched square brackets in pattern
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.syntax.ParserException error:
	VDM PO: vc6: subtype obligation in 'TestV2IComplexExpr' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IComplexExpr.vdmsl) at line 55:5
(lambda [var:nat, var2:nat] & (var + var2))(10, 20) > 0

	Reason: Mismatched square brackets in pattern
*)
