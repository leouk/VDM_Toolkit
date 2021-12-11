(* VDM to Isabelle Translation @2021-12-11T13:31:51.580160Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IBindsComplex.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IBindsComplex.vdmsl]
*)
theory TestV2IComplexBinds
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: R = compose R of a:nat, b:nat end
	inv mk_R(a, b) == (a < b)\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 6:5\<close>
record R = 
	a\<^sub>R :: "VDMNat"
		 b\<^sub>R :: "VDMNat"
	

\<comment>\<open>VDM source: inv_R: (R +> bool)
	inv_R(mk_R(a, b)) ==
(a < b)\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 7:9\<close>
definition
	inv_R :: "R \<Rightarrow> bool"
where
	"inv_R dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_R` specification.\<close>
		( (((inv_VDMNat (a\<^sub>R dummy0))) \<and> 
		 ((inv_VDMNat (b\<^sub>R dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let a = (a\<^sub>R dummy0); b = (b\<^sub>R dummy0) in 
		\<comment>\<open>User defined body of inv_R.\<close>
		(a < b))"

		

	
\<comment>\<open>VDM source: v0:nat = 10\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 10:5\<close>
abbreviation
	v0 :: "VDMNat"
where
	"v0 \<equiv> (10::VDMNat1)"

	definition
	inv_v0 :: "\<bool>"
where
	"inv_v0  \<equiv> (inv_VDMNat v0)"

	
	
\<comment>\<open>VDM source: v1:(nat1 * nat1) = mk_(1, 2)\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 11:5\<close>
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

	
	
\<comment>\<open>VDM source: v11:R = mk_R(1, 2)\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 12:5\<close>
abbreviation
	v11 :: "R"
where
	"v11 \<equiv> \<lparr>a\<^sub>R = (1::VDMNat1), b\<^sub>R = (2::VDMNat1)\<rparr>"

	definition
	inv_v11 :: "\<bool>"
where
	"inv_v11  \<equiv> inv_R v11"

	
	
\<comment>\<open>VDM source: v2:nat1 = let mk_(x, y):(nat1 * nat1) = mk_(1, 2) in (x + y)\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 14:5\<close>
abbreviation
	v2 :: "VDMNat1"
where
	"v2 \<equiv> (
		let 
(dummy0::(VDMNat1\<times> VDMNat1)) = ((1::VDMNat1), (2::VDMNat1))
		in
			(if (
		((inv_VDMNat1 (fst dummy0))\<and>
		 (inv_VDMNat1 (snd dummy0))
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

	
	
\<comment>\<open>VDM source: v21:nat1 = let mk_(x, y):(nat1 * nat1) = v1 in (x + y)\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 15:5\<close>
abbreviation
	v21 :: "VDMNat1"
where
	"v21 \<equiv> (
		let 
(dummy0::(VDMNat1\<times> VDMNat1)) = v1
		in
			(if (
		((inv_VDMNat1 (fst dummy0))\<and>
		 (inv_VDMNat1 (snd dummy0))
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

	
	
\<comment>\<open>VDM source: v3:nat1 = ((mk_(1, 2).#1) + (mk_(1, 2).#2))\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 16:5\<close>
abbreviation
	v3 :: "VDMNat1"
where
	"v3 \<equiv> ((fst (((1::VDMNat1), (2::VDMNat1)))) + (snd (((1::VDMNat1), (2::VDMNat1)))))"

	definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_VDMNat1 v3)"

	
	
\<comment>\<open>VDM source: v4:map ((nat1 * nat1)) to (seq1 of (nat1)) = {mk_(x, y) |-> [x, y] | x, y in set {1, 2}}\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 18:5\<close>
abbreviation
	v4 :: "((VDMNat1\<times> VDMNat1) \<rightharpoonup> VDMNat1 VDMSeq1)"
where
	"v4 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{(x, y)} 
		{[x, y]} 
		
		((inv_VDMNat1 )\<and>
		 (inv_VDMNat1 )
		) 
		(inv_VDMSeq1' (inv_VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  (dummy0RANGE :: VDMNat1 VDMSeq1) .
		(if ((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<and>  (((inv_VDMSeq1' (inv_VDMNat1) dummy0RANGE))) \<and> 
		((inv_VDMNat1 (fst (
		if ((\<exists> (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  . (((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<and>  ((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<longrightarrow> ((dummy0DOMAIN = (x, y)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))))\<and>
		 (inv_VDMNat1 (snd (
		if ((\<exists> (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  . (((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<and>  ((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<longrightarrow> ((dummy0DOMAIN = (x, y)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))))
		) then
		(
		if ((\<exists> (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  . (((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<and>  ((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<longrightarrow> ((dummy0DOMAIN = (x, y)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  (dummy0RANGE :: VDMNat1 VDMSeq1) .
		(if ((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<and>  (((inv_VDMSeq1' (inv_VDMNat1) dummy0RANGE))) \<and> (inv_VDMSeq1' (inv_VDMNat1) (
		if ((\<exists> (dummy0RANGE :: VDMNat1 VDMSeq1)  (dummy0RANGE :: VDMNat1 VDMSeq1)  . ((((inv_VDMSeq1' (inv_VDMNat1) dummy0RANGE))) \<and>  (((inv_VDMSeq1' (inv_VDMNat1) dummy0RANGE))) \<longrightarrow> ((dummy0RANGE = [x, y]) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))) then
		(
		if ((\<exists> (dummy0RANGE :: VDMNat1 VDMSeq1)  (dummy0RANGE :: VDMNat1 VDMSeq1)  . ((((inv_VDMSeq1' (inv_VDMNat1) dummy0RANGE))) \<and>  (((inv_VDMSeq1' (inv_VDMNat1) dummy0RANGE))) \<longrightarrow> ((dummy0RANGE = [x, y]) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(truecnst ))"

	definition
	inv_v4 :: "\<bool>"
where
	"inv_v4  \<equiv> (inv_Map 
		((inv_VDMNat1 )\<and>
		 (inv_VDMNat1 )
		) (inv_VDMSeq1' (inv_VDMNat1)) v4)"

	
	
\<comment>\<open>VDM source: [v5, v6]:seq1 of (nat1) = [1, 2]\<close>
\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IBindsComplex.vdmsl) at line 20:5\<close>
abbreviation
	v5 :: "VDMNat1"
where
	"v5 \<equiv> [(1::VDMNat1), (2::VDMNat1)]"

	definition
	inv_v5 :: "\<bool>"
where
	"inv_v5  \<equiv> (inv_VDMNat1 v5)"

	
end