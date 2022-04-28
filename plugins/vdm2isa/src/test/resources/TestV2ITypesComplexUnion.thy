(* VDM to Isabelle Translation @2021-12-13T14:25:22.446Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl]
*)
theory TestV2ITypesComplexUnion
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: TUnion = int\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 8:5\<close>
datatype TUnion = U_VDMInt "VDMInt"
	

\<comment>\<open>VDM source: inv_TUnion = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 8:5\<close>
definition
	inv_TUnion :: "TUnion \<Rightarrow> bool"
where
	"inv_TUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TUnion` specification.\<close>
		(((case dummy0 of
		 TUnion.U_VDMInt dummy0 \<Rightarrow> (inv_VDMInt dummy0)
		 )))"

		 

	
\<comment>\<open>VDM source: TUnion' = real\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 9:5\<close>
datatype TUnion' = U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_TUnion' = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 9:5\<close>
definition
	inv_TUnion' :: "TUnion' \<Rightarrow> bool"
where
	"inv_TUnion' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TUnion'` specification.\<close>
		(((case dummy0 of
		 TUnion'.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 

	
\<comment>\<open>VDM source: TUnion2 = (seq of (nat) | set of (real))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 12:5\<close>
datatype TUnion2 = U_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 U_VDMReal_VDMSet "VDMReal VDMSet"
	

\<comment>\<open>VDM source: inv_TUnion2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 12:5\<close>
definition
	inv_TUnion2 :: "TUnion2 \<Rightarrow> bool"
where
	"inv_TUnion2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TUnion2` specification.\<close>
		(((case dummy0 of
		 TUnion2.U_VDMNat_VDMSeq dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy0)
		  | TUnion2.U_VDMReal_VDMSet dummy0 \<Rightarrow> (inv_VDMSet' (inv_VDMReal) dummy0)
		 )))"
 

	
\<comment>\<open>VDM source: TUnion2' = (seq of (nat) | seq of (real))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 13:5\<close>
datatype TUnion2' = U_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 U_VDMReal_VDMSeq "VDMReal VDMSeq"
	

\<comment>\<open>VDM source: inv_TUnion2' = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 13:5\<close>
definition
	inv_TUnion2' :: "TUnion2' \<Rightarrow> bool"
where
	"inv_TUnion2' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TUnion2'` specification.\<close>
		(((case dummy0 of
		 TUnion2'.U_VDMNat_VDMSeq dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy0)
		  | TUnion2'.U_VDMReal_VDMSeq dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMReal) dummy0)
		 )))"
 

	
\<comment>\<open>VDM source: TUnion21 = real\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 15:5\<close>
datatype TUnion21 = U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_TUnion21 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 15:5\<close>
definition
	inv_TUnion21 :: "TUnion21 \<Rightarrow> bool"
where
	"inv_TUnion21 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TUnion21` specification.\<close>
		(((case dummy0 of
		 TUnion21.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 

	
\<comment>\<open>VDM source: TUnion21' = set of (TUnion21)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 16:5\<close>
type_synonym TUnion21' = "TUnion21 VDMSet"
	

\<comment>\<open>VDM source: inv_TUnion21' = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 16:5\<close>
definition
	inv_TUnion21' :: "TUnion21' \<Rightarrow> bool"
where
	"inv_TUnion21' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TUnion21'` specification.\<close>
		(((inv_VDMSet' (inv_TUnion21) dummy0)))"

		 

	
\<comment>\<open>VDM source: TBasic = nat\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 18:5\<close>
type_synonym TBasic = "VDMNat"
	

\<comment>\<open>VDM source: inv_TBasic = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 18:5\<close>
definition
	inv_TBasic :: "TBasic \<Rightarrow> bool"
where
	"inv_TBasic dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TBasic` specification.\<close>
		(((inv_VDMNat dummy0)))"
 

	
\<comment>\<open>VDM source: TBasic2 = TBasic
	inv t == (t > 10)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 20:5\<close>
type_synonym TBasic2 = "TBasic"
	

\<comment>\<open>VDM source: inv_TBasic2: (TBasic +> bool)
	inv_TBasic2(t) ==
(t > 10)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 21:9\<close>
definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> bool"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TBasic2` specification.\<close>
		((inv_TBasic t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2.\<close>
		(t > (10::VDMNat1))"

		 

	
\<comment>\<open>VDM source: TUnion3 = (TBasic2 | TUnion2)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 23:5\<close>
datatype TUnion3 = U_TBasic2 "TBasic2" | 
		 U_TUnion2 "TUnion2"
	

\<comment>\<open>VDM source: inv_TUnion3 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 23:5\<close>
definition
	inv_TUnion3 :: "TUnion3 \<Rightarrow> bool"
where
	"inv_TUnion3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TUnion3` specification.\<close>
		(((case dummy0 of
		 TUnion3.U_TBasic2 dummy0 \<Rightarrow> (inv_TBasic2 dummy0)
		  | TUnion3.U_TUnion2 dummy0 \<Rightarrow> (inv_TUnion2 dummy0)
		 )))"

		 

	
\<comment>\<open>VDM source: TUnion4 = real
	inv u == (u > 0)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 27:5\<close>
datatype TUnion4 = U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_TUnion4: (real +> bool)
	inv_TUnion4(u) ==
(u > 0)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 28:9\<close>
definition
	inv_TUnion4 :: "TUnion4 \<Rightarrow> bool"
where
	"inv_TUnion4 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TUnion4` specification.\<close>
		(((case u of
		 TUnion4.U_VDMReal u \<Rightarrow> (inv_VDMReal u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion4.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		(case u of
			U_VDMReal u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u > (0::VDMNat))
		 ))"

		 

	
\<comment>\<open>VDM source: TUnion5 = int
	inv u == (u < 0)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 30:5\<close>
datatype TUnion5 = U_VDMInt "VDMInt"
	

\<comment>\<open>VDM source: inv_TUnion5: (int +> bool)
	inv_TUnion5(u) ==
(u < 0)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 31:9\<close>
definition
	inv_TUnion5 :: "TUnion5 \<Rightarrow> bool"
where
	"inv_TUnion5 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TUnion5` specification.\<close>
		(((case u of
		 TUnion5.U_VDMInt u \<Rightarrow> (inv_VDMInt u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion5.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		(case u of
			U_VDMInt u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u < (0::VDMNat))
		 ))"

		 

	
\<comment>\<open>VDM source: TUnion6 = int
	inv u == ((is_(u, nat) => (u > 0)) and (is_(u, int) => (u < 0)))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 35:5\<close>
datatype TUnion6 = U_VDMInt "VDMInt"
	

\<comment>\<open>VDM source: inv_TUnion6: (int +> bool)
	inv_TUnion6(u) ==
((is_(u, nat) => (u > 0)) and (is_(u, int) => (u < 0)))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 36:9\<close>
definition
	inv_TUnion6 :: "TUnion6 \<Rightarrow> bool"
where
	"inv_TUnion6 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TUnion6` specification.\<close>
		(((case u of
		 TUnion6.U_VDMInt u \<Rightarrow> (inv_VDMInt u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion6.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		(case u of
			U_VDMInt u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 ((isTest (u) (inv_VDMNat) \<longrightarrow> (u > (0::VDMNat))) \<and> (isTest (u) (inv_VDMInt) \<longrightarrow> (u < (0::VDMNat))))
		 ))"
 

	
\<comment>\<open>VDM source: TUnion6' = int
	inv u == ((is_(u, int) => (u < 0)) and (is_(u, TBasic) => (u > 0)))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 39:5\<close>
datatype TUnion6' = U_VDMInt "VDMInt"
	

\<comment>\<open>VDM source: inv_TUnion6': (int +> bool)
	inv_TUnion6'(u) ==
((is_(u, int) => (u < 0)) and (is_(u, TBasic) => (u > 0)))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 40:9\<close>
definition
	inv_TUnion6' :: "TUnion6' \<Rightarrow> bool"
where
	"inv_TUnion6' u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TUnion6'` specification.\<close>
		(((case u of
		 TUnion6'.U_VDMInt u \<Rightarrow> (inv_VDMInt u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion6'.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		(case u of
			U_VDMInt u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 ((isTest (u) (inv_VDMInt) \<longrightarrow> (u < (0::VDMNat))) \<and> (isTest (u) inv_TBasic \<longrightarrow> (u > (0::VDMNat))))
		 ))"
 

	
\<comment>\<open>VDM source: TQuoteUnion = (<A> | <B> | <C>)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 43:5\<close>
datatype TQuoteUnion = U_A  | 
		 U_B  | 
		 U_C 
	

\<comment>\<open>VDM source: inv_TQuoteUnion = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 43:5\<close>
definition
	inv_TQuoteUnion :: "TQuoteUnion \<Rightarrow> bool"
where
	"inv_TQuoteUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TQuoteUnion` specification.\<close>
		((((inv_True dummy0))))"
 

	
\<comment>\<open>VDM source: TBasicUnion = int\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 46:5\<close>
datatype TBasicUnion = U_VDMInt "VDMInt"
	

\<comment>\<open>VDM source: inv_TBasicUnion = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 46:5\<close>
definition
	inv_TBasicUnion :: "TBasicUnion \<Rightarrow> bool"
where
	"inv_TBasicUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TBasicUnion` specification.\<close>
		(((case dummy0 of
		 TBasicUnion.U_VDMInt dummy0 \<Rightarrow> (inv_VDMInt dummy0)
		 )))"
 

	
\<comment>\<open>VDM source: TBasicQuoteUnion = (TBasicUnion | TQuoteUnion)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 49:5\<close>
datatype TBasicQuoteUnion = U_TBasicUnion "TBasicUnion" | 
		 U_TQuoteUnion "TQuoteUnion"
	

\<comment>\<open>VDM source: inv_TBasicQuoteUnion = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 49:5\<close>
definition
	inv_TBasicQuoteUnion :: "TBasicQuoteUnion \<Rightarrow> bool"
where
	"inv_TBasicQuoteUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TBasicQuoteUnion` specification.\<close>
		(((case dummy0 of
		 TBasicQuoteUnion.U_TBasicUnion dummy0 \<Rightarrow> (inv_TBasicUnion dummy0)
		  | TBasicQuoteUnion.U_TQuoteUnion dummy0 \<Rightarrow> (inv_TQuoteUnion dummy0)
		 )))"
 

	
\<comment>\<open>VDM source: f1: (TUnion6 -> bool)
	f1(u6) ==
(u6 > 10)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 53:5\<close>

\<comment>\<open>VDM source: pre_f1 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 53:5\<close>
definition
	pre_f1 :: "TUnion6 \<Rightarrow> bool"
where
	"pre_f1 u6 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f1` specification.\<close>
		((inv_TUnion6 u6))"


\<comment>\<open>VDM source: post_f1 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 53:5\<close>
definition
	post_f1 :: "TUnion6\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f1 u6  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f1` specification.\<close>
		((inv_TUnion6 u6)  \<and>  (inv_bool RESULT))"

definition
	f1 :: "TUnion6 \<Rightarrow> bool"
where
	"f1 u6 \<equiv> 
	\<comment>\<open>User defined body of f1.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u6 > (10::VDMNat1))
		 ))"

	
\<comment>\<open>VDM source: f2: (TUnion2 -> bool)
	f2(u2) ==
(is_(u2, seq of (nat)) => ((card (elems u2)) = (len u2)))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 56:5\<close>

\<comment>\<open>VDM source: pre_f2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 56:5\<close>
definition
	pre_f2 :: "TUnion2 \<Rightarrow> bool"
where
	"pre_f2 u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f2` specification.\<close>
		((inv_TUnion2 u2))"


\<comment>\<open>VDM source: post_f2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 56:5\<close>
definition
	post_f2 :: "TUnion2\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f2 u2  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f2` specification.\<close>
		((inv_TUnion2 u2)  \<and>  (inv_bool RESULT))"

definition
	f2 :: "TUnion2 \<Rightarrow> bool"
where
	"f2 u2 \<equiv> 
	\<comment>\<open>User defined body of f2.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case u2 of
			TUnion2.U_VDMNat_VDMSeq u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> ((vdm_card (elems u2)) = (len u2)))
		  | TUnion2.U_VDMReal_VDMSet u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> ((vdm_card (elems u2)) = (len u2)))
		 ))"

	
\<comment>\<open>VDM source: f3: (TUnion6 -> bool)
	f3(u6) ==
(cases true :
(is_(u6, nat)) -> (u6 > 10),
(is_(u6, int)) -> (u6 < 10)
others -> (u6 > 100)
end)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 59:5\<close>

\<comment>\<open>VDM source: pre_f3 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 59:5\<close>
definition
	pre_f3 :: "TUnion6 \<Rightarrow> bool"
where
	"pre_f3 u6 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f3` specification.\<close>
		((inv_TUnion6 u6))"


\<comment>\<open>VDM source: post_f3 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 59:5\<close>
definition
	post_f3 :: "TUnion6\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f3 u6  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f3` specification.\<close>
		((inv_TUnion6 u6)  \<and>  (inv_bool RESULT))"

definition
	f3 :: "TUnion6 \<Rightarrow> bool"
where
	"f3 u6 \<equiv> 
	\<comment>\<open>User defined body of f3.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (
		 \<comment>\<open>VDM `cases true` expressions are translated as an and-chain of implications\<close>
		 ((isTest (u6) (inv_VDMNat)) \<longrightarrow> (u6 > (10::VDMNat1))) \<and> 
			 ((isTest (u6) (inv_VDMInt)) \<longrightarrow> (u6 < (10::VDMNat1)))
		  \<or> (u6>(100::VDMNat1)))
		 ))"

	
\<comment>\<open>VDM source: f4: (TUnion6 * TUnion2 -> bool)
	f4(u6, u2) ==
((is_(u6, int) => ((is_(u2, seq of (nat)) => (u6 in set (elems u2))) and (is_(u2, set of (real)) => (u6 in set u2)))) and (is_(u6, nat) => ((is_(u2, seq of (nat)) => (not (u6 in set (elems u2)))) and (is_(u2, set of (real)) => (not (u6 in set u2))))))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 68:5\<close>

\<comment>\<open>VDM source: pre_f4 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 68:5\<close>
definition
	pre_f4 :: "TUnion6\<Rightarrow> TUnion2 \<Rightarrow> bool"
where
	"pre_f4 u6  u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f4` specification.\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2 u2))"


\<comment>\<open>VDM source: post_f4 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 68:5\<close>
definition
	post_f4 :: "TUnion6\<Rightarrow> TUnion2\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f4 u6  u2  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f4` specification.\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2 u2)  \<and>  (inv_bool RESULT))"

definition
	f4 :: "TUnion6\<Rightarrow> TUnion2 \<Rightarrow> bool"
where
	"f4 u6  u2 \<equiv> 
	\<comment>\<open>User defined body of f4.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case u2 of
			TUnion2.U_VDMNat_VDMSeq u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 
		 (case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		 )
		  | TUnion2.U_VDMReal_VDMSet u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 
		 (case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		 )
		 ))"

	
\<comment>\<open>VDM source: f4': (TUnion6 * TUnion2' -> bool)
	f4'(u6, u2) ==
(u6 in set (elems u2))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 101:5\<close>

\<comment>\<open>VDM source: pre_f4' = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 101:5\<close>
definition
	pre_f4' :: "TUnion6\<Rightarrow> TUnion2' \<Rightarrow> bool"
where
	"pre_f4' u6  u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f4'` specification.\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2' u2))"


\<comment>\<open>VDM source: post_f4' = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 101:5\<close>
definition
	post_f4' :: "TUnion6\<Rightarrow> TUnion2'\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f4' u6  u2  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f4'` specification.\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2' u2)  \<and>  (inv_bool RESULT))"

definition
	f4' :: "TUnion6\<Rightarrow> TUnion2' \<Rightarrow> bool"
where
	"f4' u6  u2 \<equiv> 
	\<comment>\<open>User defined body of f4'.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case u2 of
			TUnion2'.U_VDMNat_VDMSeq u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 
		 (case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u6 \<in> (elems u2))
		 )
		  | TUnion2'.U_VDMReal_VDMSeq u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 
		 (case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u6 \<in> (elems u2))
		 )
		 ))"

	
\<comment>\<open>VDM source: f6: (TUnion6 -> int)
	f6(u) ==
u\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 105:5\<close>

\<comment>\<open>VDM source: pre_f6 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 105:5\<close>
definition
	pre_f6 :: "TUnion6 \<Rightarrow> bool"
where
	"pre_f6 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f6` specification.\<close>
		((inv_TUnion6 u))"


\<comment>\<open>VDM source: post_f6 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 105:5\<close>
definition
	post_f6 :: "TUnion6\<Rightarrow> VDMInt \<Rightarrow> bool"
where
	"post_f6 u  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f6` specification.\<close>
		((inv_TUnion6 u)  \<and>  (inv_VDMInt RESULT))"

definition
	f6 :: "TUnion6 \<Rightarrow> VDMInt"
where
	"f6 u \<equiv> 
	\<comment>\<open>User defined body of f6.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case u of
			TUnion6.U_VDMInt u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 u
		 ))"

	
\<comment>\<open>VDM source: f6': (TUnion6' -> int)
	f6'(u) ==
u\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 108:5\<close>

\<comment>\<open>VDM source: pre_f6' = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 108:5\<close>
definition
	pre_f6' :: "TUnion6' \<Rightarrow> bool"
where
	"pre_f6' u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f6'` specification.\<close>
		((inv_TUnion6' u))"


\<comment>\<open>VDM source: post_f6' = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 108:5\<close>
definition
	post_f6' :: "TUnion6'\<Rightarrow> VDMInt \<Rightarrow> bool"
where
	"post_f6' u  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f6'` specification.\<close>
		((inv_TUnion6' u)  \<and>  (inv_VDMInt RESULT))"

definition
	f6' :: "TUnion6' \<Rightarrow> VDMInt"
where
	"f6' u \<equiv> 
	\<comment>\<open>User defined body of f6'.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case u of
			TUnion6'.U_VDMInt u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 u
		 ))"

	
\<comment>\<open>VDM source: f7: (TQuoteUnion -> bool)
	f7(qu) ==
(qu <> <A>)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 112:5\<close>

\<comment>\<open>VDM source: pre_f7 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 112:5\<close>
definition
	pre_f7 :: "TQuoteUnion \<Rightarrow> bool"
where
	"pre_f7 qu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f7` specification.\<close>
		((inv_TQuoteUnion qu))"


\<comment>\<open>VDM source: post_f7 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 112:5\<close>
definition
	post_f7 :: "TQuoteUnion\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f7 qu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f7` specification.\<close>
		((inv_TQuoteUnion qu)  \<and>  (inv_bool RESULT))"

definition
	f7 :: "TQuoteUnion \<Rightarrow> bool"
where
	"f7 qu \<equiv> 
	\<comment>\<open>User defined body of f7.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	((qu \<noteq> TQuoteUnion.U_A )))"

	
\<comment>\<open>VDM source: f8: (TBasicUnion -> int)
	f8(bu) ==
bu\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 115:5\<close>

\<comment>\<open>VDM source: pre_f8 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 115:5\<close>
definition
	pre_f8 :: "TBasicUnion \<Rightarrow> bool"
where
	"pre_f8 bu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f8` specification.\<close>
		((inv_TBasicUnion bu))"


\<comment>\<open>VDM source: post_f8 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 115:5\<close>
definition
	post_f8 :: "TBasicUnion\<Rightarrow> VDMInt \<Rightarrow> bool"
where
	"post_f8 bu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f8` specification.\<close>
		((inv_TBasicUnion bu)  \<and>  (inv_VDMInt RESULT))"

definition
	f8 :: "TBasicUnion \<Rightarrow> VDMInt"
where
	"f8 bu \<equiv> 
	\<comment>\<open>User defined body of f8.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case bu of
			TBasicUnion.U_VDMInt bu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 bu
		 ))"

	
\<comment>\<open>VDM source: f9: (TBasicQuoteUnion -> bool)
	f9(bqu) ==
(if is_(bqu, TBasicUnion)
then (f8(bqu) > 10)
else f7(bqu))\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 121:5\<close>

\<comment>\<open>VDM source: pre_f9 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 121:5\<close>
definition
	pre_f9 :: "TBasicQuoteUnion \<Rightarrow> bool"
where
	"pre_f9 bqu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f9` specification.\<close>
		((inv_TBasicQuoteUnion bqu))"


\<comment>\<open>VDM source: post_f9 = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 121:5\<close>
definition
	post_f9 :: "TBasicQuoteUnion\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f9 bqu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f9` specification.\<close>
		((inv_TBasicQuoteUnion bqu)  \<and>  (inv_bool RESULT))"

definition
	f9 :: "TBasicQuoteUnion \<Rightarrow> bool"
where
	"f9 bqu \<equiv> 
	\<comment>\<open>User defined body of f9.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case bqu of
			TBasicQuoteUnion.U_TBasicUnion bqu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (
		if (isTest (bqu) inv_TBasicUnion) then
		(((f8 bqu) > (10::VDMNat1)))
		else
		((f7 bqu)))
		  | TBasicQuoteUnion.U_TQuoteUnion bqu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (
		if (isTest (bqu) inv_TBasicUnion) then
		(((f8 bqu) > (10::VDMNat1)))
		else
		((f7 bqu)))
		 ))"

	
\<comment>\<open>VDM source: f9': (TBasicQuoteUnion -> bool)
	f9'(bqu) ==
(cases true :
(is_(bqu, TBasicUnion)) -> (f8(bqu) > 10),
(is_(bqu, TQuoteUnion)) -> f7(bqu)
end)\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 124:5\<close>

\<comment>\<open>VDM source: pre_f9' = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 124:5\<close>
definition
	pre_f9' :: "TBasicQuoteUnion \<Rightarrow> bool"
where
	"pre_f9' bqu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f9'` specification.\<close>
		((inv_TBasicQuoteUnion bqu))"


\<comment>\<open>VDM source: post_f9' = ?\<close>
\<comment>\<open>in 'TestV2ITypesComplexUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 124:5\<close>
definition
	post_f9' :: "TBasicQuoteUnion\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f9' bqu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f9'` specification.\<close>
		((inv_TBasicQuoteUnion bqu)  \<and>  (inv_bool RESULT))"

definition
	f9' :: "TBasicQuoteUnion \<Rightarrow> bool"
where
	"f9' bqu \<equiv> 
	\<comment>\<open>User defined body of f9'.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(case bqu of
			TBasicQuoteUnion.U_TBasicUnion bqu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (
		 \<comment>\<open>VDM `cases true` expressions are translated as an and-chain of implications\<close>
		 ((isTest (bqu) inv_TBasicUnion) \<longrightarrow> ((f8 bqu) > (10::VDMNat1))) \<and> 
			 ((isTest (bqu) inv_TQuoteUnion) \<longrightarrow> (f7 bqu)))
		  | TBasicQuoteUnion.U_TQuoteUnion bqu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (
		 \<comment>\<open>VDM `cases true` expressions are translated as an and-chain of implications\<close>
		 ((isTest (bqu) inv_TBasicUnion) \<longrightarrow> ((f8 bqu) > (10::VDMNat1))) \<and> 
			 ((isTest (bqu) inv_TQuoteUnion) \<longrightarrow> (f7 bqu)))
		 ))"

end