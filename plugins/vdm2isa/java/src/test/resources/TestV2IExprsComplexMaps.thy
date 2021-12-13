(* VDM to Isabelle Translation @2021-12-13T14:25:22.297Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl]
*)
theory TestV2IExprsComplexMaps
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: R = compose R of x:nat, y:nat end
	inv r == ((r.x) < (r.y))\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 6:5\<close>
record R = 
	x\<^sub>R :: "VDMNat"
		 y\<^sub>R :: "VDMNat"
	

\<comment>\<open>VDM source: inv_R: (R +> bool)
	inv_R(r) ==
((r.x) < (r.y))\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 9:9\<close>
definition
	inv_R :: "R \<Rightarrow> bool"
where
	"inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_R` specification.\<close>
		( (((inv_VDMNat (x\<^sub>R r))) \<and> 
		 ((inv_VDMNat (y\<^sub>R r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_R.\<close>
		((x\<^sub>R (r)) < (y\<^sub>R (r)))"

		

	
\<comment>\<open>VDM source: f: (nat * nat -> real)
	f(x, y) ==
(if (y = 0)
then 0
else ((x / y) + x))\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 13:5\<close>

\<comment>\<open>VDM source: pre_f = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 13:5\<close>
definition
	pre_f :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_f x  y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y))"


\<comment>\<open>VDM source: post_f = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 13:5\<close>
definition
	post_f :: "VDMNat\<Rightarrow> VDMNat\<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"post_f x  y  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMReal RESULT))"

definition
	f :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> VDMReal"
where
	"f x  y \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	(
		if ((y = (0::VDMNat))) then
		((0::VDMNat))
		else
		(((x / y) + x)))"

	
\<comment>\<open>VDM source: g: (nat * nat -> nat)
	g(x, y) ==
(x + y)\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 16:5\<close>

\<comment>\<open>VDM source: pre_g = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 16:5\<close>
definition
	pre_g :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_g x  y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_g` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y))"


\<comment>\<open>VDM source: post_g = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 16:5\<close>
definition
	post_g :: "VDMNat\<Rightarrow> VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_g x  y  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMNat RESULT))"

definition
	g :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"g x  y \<equiv> 
	\<comment>\<open>User defined body of g.\<close>
	(x + y)"

	
\<comment>\<open>VDM source: v4:map (nat1) to (nat1) = {(x + x) |-> 10 | x in set {1, 2, 3}, y in set {4, 5, 6}}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 21:5\<close>
abbreviation
	v4 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v4 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (x + x) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  } 
		{(10::VDMNat1)} 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> ((dummy0DOMAIN = (x + x)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> ((dummy0DOMAIN = (x + x)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(rngcnst (10::VDMNat1)) 
		(truecnst ))"

	definition
	inv_v4 :: "\<bool>"
where
	"inv_v4  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v4)"

	
	
\<comment>\<open>VDM source: v5:map (R) to (nat1) = {mk_R(x, y) |-> 10 | x in set {1, 2, 3}, y in set {4, 5, 6} & (x < y)}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 24:5\<close>
abbreviation
	v5 :: "(R \<rightharpoonup> VDMNat1)"
where
	"v5 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr> | (dummy0DOMAIN :: R)  (dummy0DOMAIN :: R) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and> (x < y) } 
		{ (10::VDMNat1) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (x < y) } 
		
		(((inv_VDMNat (x\<^sub>R R))) \<and> 
		 ((inv_VDMNat (y\<^sub>R R)))
		) 
		(inv_VDMNat1) 
		(
	\<lambda> (dummy0DOMAIN :: R)  (dummy0RANGE :: VDMNat1) .
		(if ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> 
		(((inv_VDMNat (x\<^sub>R (
		if ((\<exists> (dummy0DOMAIN :: R)  (dummy0DOMAIN :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<longrightarrow> ((dummy0DOMAIN = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (x < y))))) then
		(dummy0DOMAIN)
		else
		(undefined))))) \<and> 
		 ((inv_VDMNat (y\<^sub>R (
		if ((\<exists> (dummy0DOMAIN :: R)  (dummy0DOMAIN :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<longrightarrow> ((dummy0DOMAIN = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (x < y))))) then
		(dummy0DOMAIN)
		else
		(undefined)))))
		) then
		(
		if ((\<exists> (dummy0DOMAIN :: R)  (dummy0DOMAIN :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<longrightarrow> ((dummy0DOMAIN = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (x < y))))) then
		(dummy0DOMAIN)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(rngcnst (10::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: R)  (dummy0RANGE :: VDMNat1) .
		(if ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v5 :: "\<bool>"
where
	"inv_v5  \<equiv> (inv_Map inv_R  (inv_VDMNat1) v5)"

	
	
\<comment>\<open>VDM source: v6:map ((nat1 * nat1)) to (R) = {mk_(x, y) |-> mk_R(x, y) | x in set {1, 2, 3}, y in set {4, 5, 6}}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 27:5\<close>
abbreviation
	v6 :: "((VDMNat1\<times> VDMNat1) \<rightharpoonup> R)"
where
	"v6 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{(x, y)} 
		{\<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>} 
		
		((inv_VDMNat1 )\<and>
		 (inv_VDMNat1 )
		) 
		
		(((inv_VDMNat (x\<^sub>R R))) \<and> 
		 ((inv_VDMNat (y\<^sub>R R)))
		) 
		(
	\<lambda> (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  (dummy0RANGE :: R) .
		(if ((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0RANGE))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0RANGE)))
		))) \<and> 
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
	\<lambda> (dummy0DOMAIN :: (VDMNat1\<times> VDMNat1))  (dummy0RANGE :: R) .
		(if ((
		((inv_VDMNat1 (fst dummy0DOMAIN))\<and>
		 (inv_VDMNat1 (snd dummy0DOMAIN))
		))) \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0RANGE))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0RANGE)))
		))) \<and> 
		(((inv_VDMNat (x\<^sub>R (
		if ((\<exists> (dummy0RANGE :: R)  (dummy0RANGE :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0RANGE))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0RANGE)))
		))) \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0RANGE))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0RANGE)))
		))) \<longrightarrow> ((dummy0RANGE = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMNat (y\<^sub>R (
		if ((\<exists> (dummy0RANGE :: R)  (dummy0RANGE :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0RANGE))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0RANGE)))
		))) \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0RANGE))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0RANGE)))
		))) \<longrightarrow> ((dummy0RANGE = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))
		) then
		(
		if ((\<exists> (dummy0RANGE :: R)  (dummy0RANGE :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0RANGE))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0RANGE)))
		))) \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0RANGE))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0RANGE)))
		))) \<longrightarrow> ((dummy0RANGE = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(truecnst ))"

	definition
	inv_v6 :: "\<bool>"
where
	"inv_v6  \<equiv> (inv_Map 
		((inv_VDMNat1 )\<and>
		 (inv_VDMNat1 )
		) inv_R  v6)"

	
	
\<comment>\<open>VDM source: v7:map (real) to (nat) = {f(x, y) |-> g(x, y) | x in set {1, 2, 3}, y in set {4, 5, 6}}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 29:5\<close>
abbreviation
	v7 :: "(VDMReal \<rightharpoonup> VDMNat)"
where
	"v7 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (f x  y) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  } 
		{ (g x  y) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  } 
		(inv_VDMReal) 
		(inv_VDMNat) 
		(
	\<lambda> (dummy0DOMAIN :: VDMReal)  (dummy0RANGE :: VDMNat) .
		(if (((inv_VDMReal dummy0DOMAIN))) \<and>  (((inv_VDMNat dummy0RANGE))) \<and> (inv_VDMReal (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (f x  y)) \<and> (True::\<bool>)))))) then
		(dummy0DOMAIN)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (f x  y)) \<and> (True::\<bool>)))))) then
		(dummy0DOMAIN)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: VDMReal)  (dummy0RANGE :: VDMNat) .
		(if (((inv_VDMReal dummy0DOMAIN))) \<and>  (((inv_VDMNat dummy0RANGE))) \<and> (inv_VDMNat (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0RANGE = (g x  y)) \<and> (True::\<bool>)))))) then
		(dummy0RANGE)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0RANGE = (g x  y)) \<and> (True::\<bool>)))))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(truecnst ))"

	definition
	inv_v7 :: "\<bool>"
where
	"inv_v7  \<equiv> (inv_Map (inv_VDMReal) (inv_VDMNat) v7)"

	
	
\<comment>\<open>VDM source: v8:map ((nat1 * nat1)) to (seq1 of (nat1)) = {mk_(x, y) |-> [x, y] | x, y in set {1, 2}}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 31:5\<close>
abbreviation
	v8 :: "((VDMNat1\<times> VDMNat1) \<rightharpoonup> VDMNat1 VDMSeq1)"
where
	"v8 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
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
	inv_v8 :: "\<bool>"
where
	"inv_v8  \<equiv> (inv_Map 
		((inv_VDMNat1 )\<and>
		 (inv_VDMNat1 )
		) (inv_VDMSeq1' (inv_VDMNat1)) v8)"

	
	
\<comment>\<open>VDM source: vWarning1:map (nat1) to (nat1) = {1 |-> 5 | x in set {1, 2, 3}, x in set {4, 5, 6} & (x > 3)}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 33:5\<close>
abbreviation
	vWarning1 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"vWarning1 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (1::VDMNat1) | x .  ((x \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (x > (3::VDMNat1)) } 
		{ (5::VDMNat1) | x .  ((x \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (x > (3::VDMNat1)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domcnst (1::VDMNat1)) 
		(rngcnst (5::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . ((x \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and> (x > (3::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . ((x \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and> (x > (3::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_vWarning1 :: "\<bool>"
where
	"inv_vWarning1  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) vWarning1)"

	
	
\<comment>\<open>VDM source: vWarning11:map (nat1) to (nat1) = {1 |-> 5 | x in set {4, 5, 6}, x in set {1, 2, 3, 4} & (x > 3)}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 34:5\<close>
abbreviation
	vWarning11 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"vWarning11 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (1::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1)}))  \<and> (x > (3::VDMNat1)) } 
		{ (5::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1)}))  \<and> (x > (3::VDMNat1)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domcnst (1::VDMNat1)) 
		(rngcnst (5::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1)}) \<and> (x > (3::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1)}) \<and> (x > (3::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_vWarning11 :: "\<bool>"
where
	"inv_vWarning11  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) vWarning11)"

	
	
\<comment>\<open>VDM source: vWarning2:map (nat1) to (nat1) = {1 |-> 5 | x in set {1, 2, 3}, x in set {4, 5, 6} & (x > 3)}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 35:5\<close>
abbreviation
	vWarning2 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"vWarning2 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (1::VDMNat1) | x .  ((x \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (x > (3::VDMNat1)) } 
		{ (5::VDMNat1) | x .  ((x \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (x > (3::VDMNat1)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domcnst (1::VDMNat1)) 
		(rngcnst (5::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . ((x \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and> (x > (3::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . ((x \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and> (x > (3::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_vWarning2 :: "\<bool>"
where
	"inv_vWarning2  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) vWarning2)"

	
	
\<comment>\<open>VDM source: vWarning3:map (nat1) to (nat1) = {1 |-> 5 | x in set {1, 2, 3}, x in set {4, 5, 6}, x in set {7, 8, 9} & (x > 6)}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 36:5\<close>
abbreviation
	vWarning3 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"vWarning3 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (1::VDMNat1) | x .  ((x \<in>{(7::VDMNat1), (8::VDMNat1), (9::VDMNat1)}))  \<and> (x > (6::VDMNat1)) } 
		{ (5::VDMNat1) | x .  ((x \<in>{(7::VDMNat1), (8::VDMNat1), (9::VDMNat1)}))  \<and> (x > (6::VDMNat1)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domcnst (1::VDMNat1)) 
		(rngcnst (5::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(7::VDMNat1), (8::VDMNat1), (9::VDMNat1)}  . ((x \<in> {(7::VDMNat1), (8::VDMNat1), (9::VDMNat1)}) \<and> (x > (6::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(7::VDMNat1), (8::VDMNat1), (9::VDMNat1)}  . ((x \<in> {(7::VDMNat1), (8::VDMNat1), (9::VDMNat1)}) \<and> (x > (6::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_vWarning3 :: "\<bool>"
where
	"inv_vWarning3  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) vWarning3)"

	
	
\<comment>\<open>VDM source: vWarning4:set of (nat1) = {1 | fv in set {3, 4, 5}, x in set {1, 2, 3} & (x >= fv)}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 37:5\<close>
abbreviation
	vWarning4 :: "VDMNat1 VDMSet"
where
	"vWarning4 \<equiv> { (1::VDMNat1) | fv  x .  ((fv \<in>{(3::VDMNat1), (4::VDMNat1), (5::VDMNat1)})) \<and>  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x \<ge> fv) }"

	definition
	inv_vWarning4 :: "\<bool>"
where
	"inv_vWarning4  \<equiv> (inv_VDMSet' (inv_VDMNat1) vWarning4)"

	
	
\<comment>\<open>VDM source: vWarning5:map (nat1) to (nat1) = {1 |-> 5 | x in set {<A>, <B>, <C>}, x in set {1, 2, 3} & (x = <A>)}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 38:5\<close>
abbreviation
	vWarning5 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"vWarning5 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (1::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x = TQuoteUnion.U_A ) } 
		{ (5::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x = TQuoteUnion.U_A ) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domcnst (1::VDMNat1)) 
		(rngcnst (5::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (x = TQuoteUnion.U_A )))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (x = TQuoteUnion.U_A )))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_vWarning5 :: "\<bool>"
where
	"inv_vWarning5  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) vWarning5)"

	
end