(* VDM to Isabelle Translation @2021-12-17T14:01:51.038193Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsToken.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsToken.vdmsl]
*)
theory TestV2IExprsToken
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: t1:token = mk_token(1)\<close>
\<comment>\<open>in 'TestV2IExprsToken' (./src/test/resources/TestV2IExprsToken.vdmsl) at line 7:5\<close>
abbreviation
	t1 :: "VDMNat1 VDMToken"
where
	"t1 \<equiv> (Token (1::VDMNat1))"

	definition
	inv_t1 :: "\<bool>"
where
	"inv_t1  \<equiv> (inv_VDMToken' (inv_VDMNat1) t1)"

	
	
\<comment>\<open>VDM source: t2:token = mk_token("S")\<close>
\<comment>\<open>in 'TestV2IExprsToken' (./src/test/resources/TestV2IExprsToken.vdmsl) at line 8:5\<close>
abbreviation
	t2 :: "VDMChar VDMSeq1 VDMToken"
where
	"t2 \<equiv> (Token (''S''))"

	definition
	inv_t2 :: "\<bool>"
where
	"inv_t2  \<equiv> (inv_VDMToken' (inv_VDMSeq1' (inv_VDMChar)) t2)"

	
	
\<comment>\<open>VDM source: t3:token = mk_token({x | x in set {1, 2, 3} & (x > 1)})\<close>
\<comment>\<open>in 'TestV2IExprsToken' (./src/test/resources/TestV2IExprsToken.vdmsl) at line 9:5\<close>
abbreviation
	t3 :: "VDMNat1 VDMSet VDMToken"
where
	"t3 \<equiv> (Token { x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > (1::VDMNat1)) })"

	definition
	inv_t3 :: "\<bool>"
where
	"inv_t3  \<equiv> (inv_VDMToken' (inv_VDMSet' (inv_VDMNat1)) t3)"

	
end