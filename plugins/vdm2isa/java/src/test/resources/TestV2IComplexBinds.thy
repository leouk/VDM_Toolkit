(* VDM to Isabelle Translation @2021-11-27T16:30:27.255041Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IBindsComplex.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IBindsComplex.vdmsl]
*)
theory TestV2IComplexBinds
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 6:5\<close>
record R = 
	a\<^sub>R :: "VDMNat"
		 b\<^sub>R :: "VDMNat"
	

\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 7:9\<close>
definition
	inv_R :: "R \<Rightarrow> \<bool>"
where
	"inv_R dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_R specification\<close>
		( (((inv_VDMNat (a\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (b\<^sub>R dummy0))) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let a = (a\<^sub>R dummy0); b = (b\<^sub>R dummy0) in 
		\<comment>\<open>User defined body of inv_R\<close>
		(a < b))"

		

	
abbreviation
	v0 :: "VDMNat"
where
	"v0 \<equiv> (10::VDMNat1)"

	definition
	inv_v0 :: "\<bool>"
where
	"inv_v0  \<equiv> (inv_VDMNat v0)"

	
	
abbreviation
	v1 :: "(VDMNat1\<times> VDMNat1)"
where
	"v1 \<equiv> ((1::VDMNat1), (2::VDMNat1))"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> 
		((inv_VDMNat1 (fst v1))\<and>
		 (inv_VDMNat1 (snd v1))
		)"

	
	
abbreviation
	v11 :: "R"
where
	"v11 \<equiv> \<lparr>a\<^sub>R = (1::VDMNat1), b\<^sub>R = (2::VDMNat1)\<rparr>"

	definition
	inv_v11 :: "\<bool>"
where
	"inv_v11  \<equiv> inv_R v11"

	
	
abbreviation
	v2 :: "VDMNat1"
where
	"v2 \<equiv> (
		let 
((x  y)::(VDMNat1\<times> VDMNat1)) = ((1::VDMNat1), (2::VDMNat1))
		in
			(if (
		((inv_VDMNat1 (fst (x  y)))\<and>
		 (inv_VDMNat1 (snd (x  y)))
		)) then
			(x + y)
		 else
			undefined
		)
		)"

	definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_VDMNat1 v2)"

	
	
abbreviation
	v21 :: "VDMNat1"
where
	"v21 \<equiv> (
		let 
((x  y)::(VDMNat1\<times> VDMNat1)) = v1
		in
			(if (
		((inv_VDMNat1 (fst (x  y)))\<and>
		 (inv_VDMNat1 (snd (x  y)))
		)) then
			(x + y)
		 else
			undefined
		)
		)"

	definition
	inv_v21 :: "\<bool>"
where
	"inv_v21  \<equiv> (inv_VDMNat1 v21)"

	
	
abbreviation
	v3 :: "VDMNat1"
where
	"v3 \<equiv> ((fst (((1::VDMNat1), (2::VDMNat1)))) + (snd (((1::VDMNat1), (2::VDMNat1)))))"

	definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_VDMNat1 v3)"

	
	
abbreviation
	v4 :: "((VDMNat1\<times> VDMNat1) \<rightharpoonup> VDMNat1 VDMSeq1)"
where
	"v4 \<equiv> "

	definition
	inv_v4 :: "\<bool>"
where
	"inv_v4  \<equiv> (inv_Map 
		((inv_VDMNat1 )\<and>
		 (inv_VDMNat1 )
		) (inv_VDMSeq1' (inv_VDMNat1)) v4)"

	
	
abbreviation
	v5 :: "VDMNat1"
where
	"v5 \<equiv> [(1::VDMNat1), (2::VDMNat1)]"

	definition
	inv_v5 :: "\<bool>"
where
	"inv_v5  \<equiv> (inv_VDMNat1 v5)"

	
end