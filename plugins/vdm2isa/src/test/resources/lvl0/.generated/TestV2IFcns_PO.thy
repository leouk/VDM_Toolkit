(* VDM to Isabelle Translation @2022-12-24T08:20:03.148Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2IFcns_PO
   in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 12:5
   files = [./lvl0/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns_PO
imports VDMToolkit "TestV2IFcns" 
begin


\<comment>\<open>VDM source: constS = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 12:5\<close>


definition
	PO_104_constS_FUNC_POST_CONDITION :: \<open>\<bool>\<close>
where
	\<open>PO_104_constS_FUNC_POST_CONDITION  \<equiv> ((pre_constS ) \<longrightarrow> (post_constS (10::VDMNat1)))\<close>

	

\<comment>\<open>VDM source: g = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 22:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_105_g_FUNC_POST_CONDITION :: \<open>\<bool>\<close>
where
	\<open>PO_105_g_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat1)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_g x  y) \<longrightarrow> (post_g x  y  (x + y)))))\<close>

	

\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 30:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_106_h_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_106_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (x > (0::VDMNat))))\<close>

	

\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 28:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_107_h_FUNC_POST_CONDITION :: \<open>\<bool>\<close>
where
	\<open>PO_107_h_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (post_h x  (g x  x)))))\<close>

	

\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 31:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_108_h_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_108_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (
		let (RESULT::VDMNat) = (g x  x)
		in
			
			(if ((inv_VDMNat RESULT)) then
			(x > (0::VDMNat))
		 else
			undefined
		)
		))))\<close>

	

\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 31:23\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_109_h_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_109_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (
		let (RESULT::VDMNat) = (g x  x)
		in
			
			(if ((inv_VDMNat RESULT)) then
			(RESULT > (0::VDMNat))
		 else
			undefined
		)
		))))\<close>

	

\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 29:13\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_110_h_FUNC_APPLY :: \<open>\<bool>\<close>
where
	\<open>PO_110_h_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (pre_g x  x))))\<close>

	

\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 29:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_111_h_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_111_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (x > (0::VDMNat)))))\<close>

	

\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 34:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_112_h'_FUNC_POST_CONDITION :: \<open>\<bool>\<close>
where
	\<open>PO_112_h'_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (post_h' x  (g x  x)))))\<close>

	

\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 35:14\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_113_h'_FUNC_APPLY :: \<open>\<bool>\<close>
where
	\<open>PO_113_h'_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (pre_g x  x))))\<close>

	

\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 35:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_114_h'_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_114_h'_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (x > (0::VDMNat)))))\<close>

	

\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 40:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_115_h''_FUNC_POST_CONDITION :: \<open>\<bool>\<close>
where
	\<open>PO_115_h''_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (post_h'' x  (g x  x)))))\<close>

	

\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 43:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_116_h''_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_116_h''_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (
		let (RESULT::VDMNat) = (g x  x)
		in
			
			(if ((inv_VDMNat RESULT)) then
			(RESULT > (0::VDMNat))
		 else
			undefined
		)
		))))\<close>

	

\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 41:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_117_h''_FUNC_APPLY :: \<open>\<bool>\<close>
where
	\<open>PO_117_h''_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (pre_g x  x))))\<close>

	

\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 41:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_118_h''_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_118_h''_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (x > (0::VDMNat)))))\<close>

	

\<comment>\<open>VDM source: curriedS = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 50:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_119_curriedS_FUNC_POST_CONDITION :: \<open>\<bool>\<close>
where
	\<open>PO_119_curriedS_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y))) \<longrightarrow> (((pre_curriedS x) y) \<longrightarrow> ((post_curriedS x) y  (x + y)))))\<close>

	

\<comment>\<open>VDM source: implicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 56:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_120_implicit_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_120_implicit_TOTAL  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> isTest ((pre_implicit x  y  z)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: implicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 55:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_121_implicit_FUNC_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_121_implicit_FUNC_SATISFIABILITY  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> ((pre_implicit x  y  z) \<longrightarrow> (\<exists> (r :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) r))) \<longrightarrow> (post_implicit x  y  z  r))))))\<close>

	

\<comment>\<open>VDM source: implicitexplicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 61:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_122_implicitexplicit_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_122_implicitexplicit_TOTAL  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> isTest ((pre_implicitexplicit x  y  z)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: implicitexplicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (./lvl0/TestV2IFcns.vdmsl) at line 59:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_123_implicitexplicit_FUNC_POST_CONDITION :: \<open>\<bool>\<close>
where
	\<open>PO_123_implicitexplicit_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> ((pre_implicitexplicit x  y  z) \<longrightarrow> (post_implicitexplicit x  y  z  [x , y]))))\<close>

	
 

end 