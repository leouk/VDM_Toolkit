(* VDM to Isabelle Translation @2021-12-12T12:40:31.888085Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IErrorsToken.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IErrorsToken.vdmsl]
*)
theory TestV2IErrorsToken
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: f: (set of (nat) -> token)
	f(x) ==
mk_token(x)\<close>
\<comment>\<open>in 'TestV2IErrorsToken' (./src/test/resources/TestV2IErrorsToken.vdmsl) at line 5:5\<close>

\<comment>\<open>VDM source: pre_f = ?\<close>
\<comment>\<open>in 'TestV2IErrorsToken' (./src/test/resources/TestV2IErrorsToken.vdmsl) at line 5:5\<close>
definition
	pre_f :: "VDMNat VDMSet \<Rightarrow> bool"
where
	"pre_f x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) x))"


\<comment>\<open>VDM source: post_f = ?\<close>
\<comment>\<open>in 'TestV2IErrorsToken' (./src/test/resources/TestV2IErrorsToken.vdmsl) at line 5:5\<close>
definition
	post_f :: "VDMNat VDMSet\<Rightarrow> VDMToken \<Rightarrow> bool"
where
	"post_f x  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) x)  \<and>  (inv_VDMToken' RESULT))"

definition
	f :: "VDMNat VDMSet \<Rightarrow> VDMToken"
where
	"f x \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	(Token x)"

	
\<comment>\<open>VDM source: v:token = f({1, 2, 3})\<close>
\<comment>\<open>in 'TestV2IErrorsToken' (./src/test/resources/TestV2IErrorsToken.vdmsl) at line 8:5\<close>
abbreviation
	v :: "VDMToken"
where
	"v \<equiv> (f {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})"

	definition
	inv_v :: "\<bool>"
where
	"inv_v  \<equiv> (inv_VDMToken' v)"

	
end