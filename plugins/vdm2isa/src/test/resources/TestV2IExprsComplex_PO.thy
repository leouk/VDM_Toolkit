(* VDM to Isabelle Translation @2021-12-17T14:01:51.178771Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 20:15
files = [./src/test/resources/TestV2IExprsComplex.vdmsl]
*)
theory TestV2IExprsComplex_PO
imports TestV2IExprsComplex
begin


\<comment>\<open>VDM source: vc31 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 20:15\<close>
theorem vc31_FINITE_SET:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (finmap1 :: (VDMNat \<rightharpoonup> VDMNat))  . ((((inv_Map (inv_VDMNat) (inv_VDMNat) finmap1))) \<longrightarrow> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x > (10::VDMNat1)) \<longrightarrow> (\<exists> findex2 \<in> (dom finmap1)  . ((the(finmap1 findex2)) = x))))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: vc32 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 24:15\<close>
theorem vc32_FINITE_SET:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (finmap1 :: (VDMNat \<rightharpoonup> VDMNat))  . ((((inv_Map (inv_VDMNat) (inv_VDMNat) finmap1))) \<longrightarrow> (\<forall> (x :: VDMNat)  (y :: VDMNat)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat y))) \<longrightarrow> ((x > y) \<longrightarrow> (\<exists> findex2 \<in> (dom finmap1)  . ((the(finmap1 findex2)) = (x + y)))))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: vc41 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 32:15\<close>
theorem vc41_FINITE_SET:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (finmap1 :: (VDMNat \<rightharpoonup> VDMNat))  . ((((inv_Map (inv_VDMNat) (inv_VDMNat) finmap1))) \<longrightarrow> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x > (10::VDMNat1)) \<longrightarrow> (\<exists> findex2 \<in> (dom finmap1)  . ((the(finmap1 findex2)) = x))))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: vc42 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 36:15\<close>
theorem vc42_FINITE_SET:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (finmap1 :: (VDMNat \<rightharpoonup> VDMNat1))  . ((((inv_Map (inv_VDMNat) (inv_VDMNat1) finmap1))) \<longrightarrow> (\<forall> x :: VDMNat  . (\<forall> y \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (((inv_VDMNat x)) \<and>  (y \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<longrightarrow> ((x > y) \<longrightarrow> (\<exists> findex2 \<in> (dom finmap1)  . ((the(finmap1 findex2)) = (x + y))))))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: vc5 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 44:15\<close>
theorem vc5_UNIQUE_EXISTENCE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists>! (var :: VDMNat)  . ((((inv_VDMNat var))) \<longrightarrow> (var < (1::VDMNat1)))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: vc51 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 48:16\<close>
theorem vc51_UNIQUE_EXISTENCE:
	"((\<exists>! var \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (var < (1::VDMNat1))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: vc6 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 51:5\<close>
theorem vc6_SUB_TYPE:
	"((((
	\<lambda> (var :: VDMNat)  (var2 :: VDMNat) .
		(if (((inv_VDMNat var))) \<and>  (((inv_VDMNat var2))) \<and> (inv_VDMNat (var + var2)) then
		(var + var2)
	 else
		undefined
	)
	) (10::VDMNat1)  (20::VDMNat1)) > (0::VDMNat)))"
	
	oops
	
	
	
\<comment>\<open>VDM source: f = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 59:5\<close>
theorem f_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  (y :: VDMNat1)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_f x  y) \<longrightarrow> (post_f x  y  (x + y))))))"
	
	oops
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "vc51"
hide_const "vc41"
hide_const "vc31"
hide_const "vc42"
hide_const "vc32"
hide_const "f"
hide_const "vc6"
hide_const "vc5"

end