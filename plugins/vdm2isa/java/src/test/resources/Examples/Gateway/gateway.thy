(* VDM to Isabelle Translation @2022-02-27T12:43:42.932866Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/Examples/Gateway/gateway.vdmsl' at line 1:8
files = [./src/test/resources/Examples/Gateway/gateway.vdmsl]
*)
theory gateway
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: String = seq of (char)
	inv s == (s <> [])\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 10:3\<close>
type_synonym String = "VDMChar VDMSeq"
	

\<comment>\<open>VDM source: inv_String: (seq of (char) +> bool)
	inv_String(s) ==
(s <> [])\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 11:7\<close>
definition
	inv_String :: "String \<Rightarrow> bool"
where
	"inv_String s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_String` specification.\<close>
		(((inv_VDMSeq' (inv_VDMChar) s)))  \<and> 
		\<comment>\<open>User defined body of inv_String.\<close>
		(s \<noteq> [])"
 
lemmas inv_String_defs = inv_String_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs 


	
	
\<comment>\<open>VDM source: Message = String
	inv m == ((len m) <= 100)\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 13:3\<close>
type_synonym Message = "String"
	

\<comment>\<open>VDM source: inv_Message: (String +> bool)
	inv_Message(m) ==
((len m) <= 100)\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 14:7\<close>
definition
	inv_Message :: "Message \<Rightarrow> bool"
where
	"inv_Message m \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Message` specification.\<close>
		((inv_String m))  \<and> 
		\<comment>\<open>User defined body of inv_Message.\<close>
		((len m) \<le> (100::VDMNat1))"
 
lemmas inv_Message_defs = inv_Message_def inv_String_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs 


	
	
\<comment>\<open>VDM source: Classification = (<HI> | <LO>)\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 16:3\<close>
datatype Classification = U_HI  | 
		 U_LO 
	

\<comment>\<open>VDM source: inv_Classification: (Classification +> bool)
	inv_Classification(dummy0) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 16:3\<close>
definition
	inv_Classification :: "Classification \<Rightarrow> bool"
where
	"inv_Classification dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Classification` specification.\<close>
		((((inv_True dummy0))))"

		 
lemmas inv_Classification_defs = inv_Classification_def inv_True_def 


	
	
\<comment>\<open>VDM source: Category = set of (String)\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 18:3\<close>
type_synonym Category = "String VDMSet"
	

\<comment>\<open>VDM source: inv_Category: (Category +> bool)
	inv_Category(dummy0) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 18:3\<close>
definition
	inv_Category :: "Category \<Rightarrow> bool"
where
	"inv_Category dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Category` specification.\<close>
		(((inv_VDMSet' (inv_String) dummy0)))"
 
lemmas inv_Category_defs = inv_Category_def inv_String_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMSet'_def inv_VDMSet'_defs 


	
	
\<comment>\<open>VDM source: Ports = compose Ports of high:seq of (Message), low:seq of (Message) end\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 20:3\<close>
record Ports = 
	high\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s :: "Message VDMSeq"
		 
		 low\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s :: "Message VDMSeq"
	

\<comment>\<open>VDM source: inv_Ports: (Ports +> bool)
	inv_Ports(dummy0) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 20:3\<close>
definition
	inv_Ports :: "Ports \<Rightarrow> bool"
where
	"inv_Ports dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Ports` specification.\<close>
		( (((inv_VDMSeq' (inv_Message) (high\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s dummy0))) \<and> 
		 ((inv_VDMSeq' (inv_Message) (low\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s dummy0))) ))"
 
lemmas inv_Ports_defs = inv_Message_def inv_Ports_def inv_String_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs 


	
	
\<comment>\<open>VDM source: Occurs: (String * String -> bool)
	Occurs(substr, str) ==
(exists [i, j in set (inds str)] & (substr = (str(i, ... ,j))))\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 27:3\<close>

\<comment>\<open>VDM source: pre_Occurs: (String * String +> bool)
	pre_Occurs(substr, str) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 27:3\<close>
definition
	pre_Occurs :: "String \<Rightarrow> String \<Rightarrow> bool"
where
	"pre_Occurs substr   str \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_Occurs` specification.\<close>
		((inv_String substr)  \<and>  (inv_String str))"


\<comment>\<open>VDM source: post_Occurs: (String * String * bool +> bool)
	post_Occurs(substr, str, RESULT) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 27:3\<close>
definition
	post_Occurs :: "String \<Rightarrow> String \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_Occurs substr   str   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_Occurs` specification.\<close>
		((inv_String substr)  \<and>  (inv_String str)  \<and>  (inv_bool RESULT))"

definition
	Occurs :: "String \<Rightarrow> String \<Rightarrow> bool"
where
	"Occurs substr   str \<equiv> 
	\<comment>\<open>User defined body of Occurs.\<close>
	(\<exists> i \<in> (inds str)  . (\<exists> j \<in> (inds str)  . (substr = (str {i$$j}))))"

	
	
\<comment>\<open>VDM source: Classify: (Message * Category -> Classification)
	Classify(m, cat) ==
(if (exists [hi in set cat] & Occurs(hi, m))
then <HI>
else <LO>)\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 33:3\<close>

\<comment>\<open>VDM source: pre_Classify: (Message * Category +> bool)
	pre_Classify(m, cat) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 33:3\<close>
definition
	pre_Classify :: "Message \<Rightarrow> Category \<Rightarrow> bool"
where
	"pre_Classify m   cat \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_Classify` specification.\<close>
		((inv_Message m)  \<and>  (inv_Category cat))"


\<comment>\<open>VDM source: post_Classify: (Message * Category * Classification +> bool)
	post_Classify(m, cat, RESULT) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 33:3\<close>
definition
	post_Classify :: "Message \<Rightarrow> Category \<Rightarrow> Classification \<Rightarrow> bool"
where
	"post_Classify m   cat   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_Classify` specification.\<close>
		((inv_Message m)  \<and>  (inv_Category cat)  \<and>  (inv_Classification RESULT))"

definition
	Classify :: "Message \<Rightarrow> Category \<Rightarrow> Classification"
where
	"Classify m   cat \<equiv> 
	\<comment>\<open>User defined body of Classify.\<close>
	(
		if ((\<exists> hi \<in> cat  . (Occurs hi   m))) then
		(Classification.U_HI )
		else
		(Classification.U_LO ))"

	
	
\<comment>\<open>VDM source: ProcessMessage: (Message * Category * Ports -> Ports)
	ProcessMessage(m, cat, ps) ==
(if (Classify(m, cat) = <HI>)
then mk_Ports(([m] ^ (ps.high)), (ps.low))
else mk_Ports((ps.high), ([m] ^ (ps.low))))\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 41:3\<close>

\<comment>\<open>VDM source: pre_ProcessMessage: (Message * Category * Ports +> bool)
	pre_ProcessMessage(m, cat, ps) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 41:3\<close>
definition
	pre_ProcessMessage :: "Message \<Rightarrow> Category \<Rightarrow> Ports \<Rightarrow> bool"
where
	"pre_ProcessMessage m   cat   ps \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_ProcessMessage` specification.\<close>
		((inv_Message m)  \<and>  (inv_Category cat)  \<and>  inv_Ports ps)"


\<comment>\<open>VDM source: post_ProcessMessage: (Message * Category * Ports * Ports +> bool)
	post_ProcessMessage(m, cat, ps, RESULT) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 41:3\<close>
definition
	post_ProcessMessage :: "Message \<Rightarrow> Category \<Rightarrow> Ports \<Rightarrow> Ports \<Rightarrow> bool"
where
	"post_ProcessMessage m   cat   ps   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_ProcessMessage` specification.\<close>
		((inv_Message m)  \<and>  (inv_Category cat)  \<and>  inv_Ports ps  \<and>  inv_Ports RESULT)"

definition
	ProcessMessage :: "Message \<Rightarrow> Category \<Rightarrow> Ports \<Rightarrow> Ports"
where
	"ProcessMessage m   cat   ps \<equiv> 
	\<comment>\<open>User defined body of ProcessMessage.\<close>
	(
		if (((Classify m   cat) = Classification.U_HI )) then
		(\<lparr>high\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s = ([m] @ (high\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s ps)), low\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s = (low\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s ps)\<rparr>)
		else
		(\<lparr>high\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s = (high\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s ps), low\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s = ([m] @ (low\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s ps))\<rparr>))"

	
	
\<comment>\<open>VDM source: Gateway: (seq of (Message) * Category -> Ports)
	Gateway(ms, cat) ==
(if (ms = [])
then mk_Ports([], [])
else let rest_p:Ports = Gateway((tl ms), cat) in ProcessMessage((hd ms), cat, rest_p))
	measure (len ms)\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 50:3\<close>

\<comment>\<open>VDM source: pre_Gateway: (seq of (Message) * Category +> bool)
	pre_Gateway(ms, cat) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 50:3\<close>
definition
	pre_Gateway :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> bool"
where
	"pre_Gateway ms   cat \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_Gateway` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Category cat))"


\<comment>\<open>VDM source: post_Gateway: (seq of (Message) * Category * Ports +> bool)
	post_Gateway(ms, cat, RESULT) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 50:3\<close>
definition
	post_Gateway :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> Ports \<Rightarrow> bool"
where
	"post_Gateway ms   cat   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_Gateway` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Category cat)  \<and>  inv_Ports RESULT)"

fun
	Gateway :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> Ports"
where
	"Gateway ms   cat = 
	\<comment>\<open>User defined body of Gateway.\<close>
	(
		if ((ms = [])) then
		(\<lparr>high\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s = [], low\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s = []\<rparr>)
		else
		((
		let 
(rest_p::Ports) = (Gateway (tl ms)   cat)
		in
			(if (inv_Ports rest_p) then
			(ProcessMessage (hd ms)   cat   rest_p)
		 else
			undefined
		)
		)))"

	
	
\<comment>\<open>VDM source: Gateway2: (seq of (Message) * Category -> Ports)
	Gateway2(ms, cat) ==
mk_Ports([m | m in seq ms & (Classify(m, cat) = <HI>)], [m | m in seq ms & (Classify(m, cat) = <LO>)])\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 62:3\<close>

\<comment>\<open>VDM source: pre_Gateway2: (seq of (Message) * Category +> bool)
	pre_Gateway2(ms, cat) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 62:3\<close>
definition
	pre_Gateway2 :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> bool"
where
	"pre_Gateway2 ms   cat \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_Gateway2` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Category cat))"


\<comment>\<open>VDM source: post_Gateway2: (seq of (Message) * Category * Ports +> bool)
	post_Gateway2(ms, cat, RESULT) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 62:3\<close>
definition
	post_Gateway2 :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> Ports \<Rightarrow> bool"
where
	"post_Gateway2 ms   cat   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_Gateway2` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Category cat)  \<and>  inv_Ports RESULT)"

definition
	Gateway2 :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> Ports"
where
	"Gateway2 ms   cat \<equiv> 
	\<comment>\<open>User defined body of Gateway2.\<close>
	\<lparr>high\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s = [ m . m \<leftarrow> ms , ((m \<in>(elems ms))) , ((Classify m   cat) = Classification.U_HI ) ], low\<^sub>P\<^sub>o\<^sub>r\<^sub>t\<^sub>s = [ m . m \<leftarrow> ms , ((m \<in>(elems ms))) , ((Classify m   cat) = Classification.U_LO ) ]\<rparr>"

	
	
\<comment>\<open>VDM source: AnyHighClass: (seq of (Message) * Category -> bool)
	AnyHighClass(ms, cat) ==
(exists [m in seq ms] & (Classify(m, cat) = <HI>))\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 69:3\<close>

\<comment>\<open>VDM source: pre_AnyHighClass: (seq of (Message) * Category +> bool)
	pre_AnyHighClass(ms, cat) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 69:3\<close>
definition
	pre_AnyHighClass :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> bool"
where
	"pre_AnyHighClass ms   cat \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_AnyHighClass` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Category cat))"


\<comment>\<open>VDM source: post_AnyHighClass: (seq of (Message) * Category * bool +> bool)
	post_AnyHighClass(ms, cat, RESULT) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 69:3\<close>
definition
	post_AnyHighClass :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_AnyHighClass ms   cat   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_AnyHighClass` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Category cat)  \<and>  (inv_bool RESULT))"

definition
	AnyHighClass :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> bool"
where
	"AnyHighClass ms   cat \<equiv> 
	\<comment>\<open>User defined body of AnyHighClass.\<close>
	(\<exists> m \<in> (elems ms)  . ((Classify m   cat) = Classification.U_HI ))"

	
	
\<comment>\<open>VDM source: Censor: (seq of (Message) * Category -> seq of (Message))
	Censor(ms, cat) ==
[m | m in seq ms & (Classify(m, cat) = <LO>)]\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 73:3\<close>

\<comment>\<open>VDM source: pre_Censor: (seq of (Message) * Category +> bool)
	pre_Censor(ms, cat) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 73:3\<close>
definition
	pre_Censor :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> bool"
where
	"pre_Censor ms   cat \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_Censor` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Category cat))"


\<comment>\<open>VDM source: post_Censor: (seq of (Message) * Category * seq of (Message) +> bool)
	post_Censor(ms, cat, RESULT) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 73:3\<close>
definition
	post_Censor :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> Message VDMSeq \<Rightarrow> bool"
where
	"post_Censor ms   cat   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_Censor` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Category cat)  \<and>  (inv_VDMSeq' (inv_Message) RESULT))"

definition
	Censor :: "Message VDMSeq \<Rightarrow> Category \<Rightarrow> Message VDMSeq"
where
	"Censor ms   cat \<equiv> 
	\<comment>\<open>User defined body of Censor.\<close>
	[ m . m \<leftarrow> ms , ((m \<in>(elems ms))) , ((Classify m   cat) = Classification.U_LO ) ]"

	
	
\<comment>\<open>VDM source: FlattenMessages: (seq of (Message) -> Message)
	FlattenMessages(ms) ==
(conc ms)
	pre ((len (conc ms)) <= 100)\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 77:3\<close>

\<comment>\<open>VDM source: pre_FlattenMessages: (seq of (Message) +> bool)
	pre_FlattenMessages(ms) ==
((len (conc ms)) <= 100)\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 80:19\<close>
definition
	pre_FlattenMessages :: "Message VDMSeq \<Rightarrow> bool"
where
	"pre_FlattenMessages ms \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_FlattenMessages` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms))  \<and> 
		\<comment>\<open>User defined body of pre_FlattenMessages.\<close>
		((len (conc ms)) \<le> (100::VDMNat1))"


\<comment>\<open>VDM source: post_FlattenMessages: (seq of (Message) * Message +> bool)
	post_FlattenMessages(ms, RESULT) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 77:3\<close>
definition
	post_FlattenMessages :: "Message VDMSeq \<Rightarrow> Message \<Rightarrow> bool"
where
	"post_FlattenMessages ms   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_FlattenMessages` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Message RESULT))"

definition
	FlattenMessages :: "Message VDMSeq \<Rightarrow> Message"
where
	"FlattenMessages ms \<equiv> 
	\<comment>\<open>User defined body of FlattenMessages.\<close>
	(conc ms)"

	
	
\<comment>\<open>VDM source: FlattenMessages': (seq of (Message) -> Message)
	FlattenMessages'(ms) ==
(conc ms)
	pre ((ms <> []) and ((len (conc ms)) <= 100))\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 82:3\<close>

\<comment>\<open>VDM source: pre_FlattenMessages': (seq of (Message) +> bool)
	pre_FlattenMessages'(ms) ==
((ms <> []) and ((len (conc ms)) <= 100))\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 85:16\<close>
definition
	pre_FlattenMessages' :: "Message VDMSeq \<Rightarrow> bool"
where
	"pre_FlattenMessages' ms \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_FlattenMessages'` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms))  \<and> 
		\<comment>\<open>User defined body of pre_FlattenMessages'.\<close>
		((ms \<noteq> []) \<and> ((len (conc ms)) \<le> (100::VDMNat1)))"


\<comment>\<open>VDM source: post_FlattenMessages': (seq of (Message) * Message +> bool)
	post_FlattenMessages'(ms, RESULT) ==
null\<close>
\<comment>\<open>in 'gateway' (./src/test/resources/Examples/Gateway/gateway.vdmsl) at line 82:3\<close>
definition
	post_FlattenMessages' :: "Message VDMSeq \<Rightarrow> Message \<Rightarrow> bool"
where
	"post_FlattenMessages' ms   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_FlattenMessages'` specification.\<close>
		((inv_VDMSeq' (inv_Message) ms)  \<and>  (inv_Message RESULT))"

definition
	FlattenMessages' :: "Message VDMSeq \<Rightarrow> Message"
where
	"FlattenMessages' ms \<equiv> 
	\<comment>\<open>User defined body of FlattenMessages'.\<close>
	(conc ms)"

end