(* VDM to Isabelle Translation @2022-02-27T12:43:43.849662Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 11:7
files = [./src/test/resources/Examples/Gateway/gateway.vdmsl]
*)
theory gateway_PO
imports gateway
begin


\<comment>\<open>VDM source: String = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 11:7\<close>
theorem String_TOTAL_PO1:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (s :: VDMChar VDMSeq)  . ((((inv_VDMSeq' (inv_VDMChar) s))) \<longrightarrow> isTest ((inv_String s)) (inv_bool))))"
	by simp
	
	
	
	
\<comment>\<open>VDM source: String = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 10:3\<close>
theorem String_INV_SATISFIABILITY_PO2:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (s :: VDMChar VDMSeq)  . ((((inv_VDMSeq' (inv_VDMChar) s))) \<longrightarrow> (s \<noteq> []))))"
	
	by force
	
	
	
	
\<comment>\<open>VDM source: Message = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 14:7\<close>
theorem Message_TOTAL_PO3:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (m :: String)  . ((((inv_String m))) \<longrightarrow> isTest ((inv_Message m)) (inv_bool))))"
	
	oops
	
	
	
	
\<comment>\<open>VDM source: Message = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 13:3\<close>
theorem Message_INV_SATISFIABILITY_PO4:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (m :: String)  . ((((inv_String m))) \<longrightarrow> ((len m) \<le> (100::VDMNat1)))))"
	
	oops
	
	
	
	(*
	\<comment>\<open>VDM proof obligation `Gateway_measure_Gateway` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: Gateway; measure_Gateway = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 58:12\<close>
theorem Gateway_measure_Gateway_TOTAL_PO5:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ms :: Message VDMSeq)   (cat :: Category)  . ((((inv_VDMSeq' (inv_String) ms)))  \<and>  (((inv_Category cat))) \<longrightarrow> isTest ((measure_Gateway ms   cat)) (inv_VDMNat))))"
	
	oops
	
	
	*)
	
	(*
	\<comment>\<open>VDM proof obligation `Gateway_rest_p` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: Gateway; rest_p = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 50:3\<close>
theorem Gateway_rest_p_RECURSIVE_PO6:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ms :: Message VDMSeq)   (cat :: Category)  . ((((inv_VDMSeq' (inv_String) ms)))  \<and>  (((inv_Category cat))) \<longrightarrow> ((\<not> (ms = [])) \<longrightarrow> ((measure_Gateway ms   cat) > (measure_Gateway (tl ms)   cat))))))"
	
	oops
	
	
	*)
	
	
\<comment>\<open>VDM source: Gateway; rest_p = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 54:34\<close>
theorem Gateway_rest_p_NON_EMPTY_SEQ_PO7:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ms :: Message VDMSeq)   (cat :: Category)  . ((((inv_VDMSeq' (inv_String) ms)))  \<and>  (((inv_Category cat))) \<longrightarrow> ((\<not> (ms = [])) \<longrightarrow> (ms \<noteq> [])))))"
	by meson
	
	
	
	
\<comment>\<open>VDM source: Gateway = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 56:30\<close>
theorem Gateway_NON_EMPTY_SEQ_PO8:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ms :: Message VDMSeq)   (cat :: Category)  . ((((inv_VDMSeq' (inv_String) ms)))  \<and>  (((inv_Category cat))) \<longrightarrow> ((\<not> (ms = [])) \<longrightarrow> (
		let 
(rest_p::Ports) = (Gateway (tl ms)   cat)
		in
			(if (inv_Ports rest_p) then
			(ms \<noteq> [])
		 else
			undefined
		)
		)))))"
	  apply (simp del: Gateway.simps, safe)
  unfolding inv_Ports_defs list_all_def
	apply (simp del: Gateway.simps, safe)
  apply (simp del: Gateway.simps split:if_splits)
	oops
	
	
	
	
\<comment>\<open>VDM source: FlattenMessages = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 77:3\<close>
theorem FlattenMessages_SUB_TYPE_PO9:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ms :: Message VDMSeq)  . ((((inv_VDMSeq' (inv_String) ms))) \<longrightarrow> (((len (conc ms)) \<le> (100::VDMNat1)) \<longrightarrow> ((inv_Message (conc ms)) \<and> ((inv_String (conc ms)) \<and> isTest ((conc ms)) (inv_VDMSeq' (inv_VDMChar))))))))"
	nitpick
	oops
	
	
	
	
\<comment>\<open>VDM source: FlattenMessages' = ?\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 82:3\<close>
theorem FlattenMessages'_SUB_TYPE_PO10:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ms :: Message VDMSeq)  . ((((inv_VDMSeq' (inv_String) ms))) \<longrightarrow> (((ms \<noteq> []) \<and> ((len (conc ms)) \<le> (100::VDMNat1))) \<longrightarrow> ((inv_Message (conc ms)) \<and> ((inv_String (conc ms)) \<and> isTest ((conc ms)) (inv_VDMSeq' (inv_VDMChar))))))))"
		unfolding inv_Message_defs list_all_def len_def conc_def by simp
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>

\<comment> \<open>@LF 5 sledgehammered; 1 simplified expansion; 1 counter exampled; 2 ignored about measures; 1 induction + involved over recursion\<close>

end