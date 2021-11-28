(* VDM to Isabelle Translation @2021-11-28T07:24:21.309Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl]
*)
theory TestV2ITypesUnion
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 7:5\<close>
datatype TUnion = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 7:5\<close>
definition
	inv_TUnion :: "TUnion \<Rightarrow> \<bool>"
where
	"inv_TUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion specification\<close>
		(((case dummy0 of
		 TUnion.U_VDMInt dummy0 \<Rightarrow> (inv_VDMInt dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 8:5\<close>
datatype TUnion' = U_VDMReal "VDMReal"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 8:5\<close>
definition
	inv_TUnion' :: "TUnion' \<Rightarrow> \<bool>"
where
	"inv_TUnion' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion' specification\<close>
		(((case dummy0 of
		 TUnion'.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
datatype TUnion2 = U_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 U_VDMReal_VDMSet "VDMReal VDMSet"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
definition
	inv_TUnion2 :: "TUnion2 \<Rightarrow> \<bool>"
where
	"inv_TUnion2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2 specification\<close>
		(((case dummy0 of
		 TUnion2.U_VDMNat_VDMSeq dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy0)
		  | TUnion2.U_VDMReal_VDMSet dummy0 \<Rightarrow> (inv_VDMSet' (inv_VDMReal) dummy0)
		 )))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 12:5\<close>
datatype TUnion2' = U_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 U_VDMReal_VDMSeq "VDMReal VDMSeq"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 12:5\<close>
definition
	inv_TUnion2' :: "TUnion2' \<Rightarrow> \<bool>"
where
	"inv_TUnion2' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2' specification\<close>
		(((case dummy0 of
		 TUnion2'.U_VDMNat_VDMSeq dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy0)
		  | TUnion2'.U_VDMReal_VDMSeq dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMReal) dummy0)
		 )))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 14:5\<close>
datatype TUnion21 = U_VDMReal "VDMReal"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 14:5\<close>
definition
	inv_TUnion21 :: "TUnion21 \<Rightarrow> \<bool>"
where
	"inv_TUnion21 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion21 specification\<close>
		(((case dummy0 of
		 TUnion21.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 15:5\<close>
type_synonym TUnion21' = "TUnion21 VDMSet"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 15:5\<close>
definition
	inv_TUnion21' :: "TUnion21' \<Rightarrow> \<bool>"
where
	"inv_TUnion21' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion21' specification\<close>
		(((inv_VDMSet' (inv_TUnion21) dummy0)))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 17:5\<close>
type_synonym TBasic = "VDMNat"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 17:5\<close>
definition
	inv_TBasic :: "TBasic \<Rightarrow> \<bool>"
where
	"inv_TBasic dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasic specification\<close>
		(((inv_VDMNat dummy0)))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 19:5\<close>
type_synonym TBasic2 = "TBasic"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 20:9\<close>
definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> \<bool>"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TBasic2 specification\<close>
		((inv_TBasic t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2\<close>
		(t > (10::VDMNat1))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 22:5\<close>
datatype TUnion3 = U_TBasic2 "TBasic2" | 
		 U_TUnion2 "TUnion2"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 22:5\<close>
definition
	inv_TUnion3 :: "TUnion3 \<Rightarrow> \<bool>"
where
	"inv_TUnion3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion3 specification\<close>
		(((case dummy0 of
		 TUnion3.U_TBasic2 dummy0 \<Rightarrow> (inv_TBasic2 dummy0)
		  | TUnion3.U_TUnion2 dummy0 \<Rightarrow> (inv_TUnion2 dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 26:5\<close>
datatype TUnion4 = U_VDMReal "VDMReal"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 27:9\<close>
definition
	inv_TUnion4 :: "TUnion4 \<Rightarrow> \<bool>"
where
	"inv_TUnion4 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion4 specification\<close>
		(((case u of
		 TUnion4.U_VDMReal u \<Rightarrow> (inv_VDMReal u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion4\<close>
		(
		\<comment>\<open>Implicit union type parameters projection conversion\<close>
		case u of
			U_VDMReal u \<Rightarrow> (u > (0::VDMNat))
		 )"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 29:5\<close>
datatype TUnion5 = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 30:9\<close>
definition
	inv_TUnion5 :: "TUnion5 \<Rightarrow> \<bool>"
where
	"inv_TUnion5 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion5 specification\<close>
		(((case u of
		 TUnion5.U_VDMInt u \<Rightarrow> (inv_VDMInt u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion5\<close>
		(
		\<comment>\<open>Implicit union type parameters projection conversion\<close>
		case u of
			U_VDMInt u \<Rightarrow> (u < (0::VDMNat))
		 )"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 34:5\<close>
datatype TUnion6 = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 35:9\<close>
definition
	inv_TUnion6 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"inv_TUnion6 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion6 specification\<close>
		(((case u of
		 TUnion6.U_VDMInt u \<Rightarrow> (inv_VDMInt u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion6\<close>
		(
		\<comment>\<open>Implicit union type parameters projection conversion\<close>
		case u of
			U_VDMInt u \<Rightarrow> ((isTest (u) (inv_VDMNat) \<longrightarrow> (u > (0::VDMNat))) \<and> (isTest (u) (inv_VDMInt) \<longrightarrow> (u < (0::VDMNat))))
		 )"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 38:5\<close>
datatype TUnion6' = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 39:9\<close>
definition
	inv_TUnion6' :: "TUnion6' \<Rightarrow> \<bool>"
where
	"inv_TUnion6' u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion6' specification\<close>
		(((case u of
		 TUnion6'.U_VDMInt u \<Rightarrow> (inv_VDMInt u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion6'\<close>
		(
		\<comment>\<open>Implicit union type parameters projection conversion\<close>
		case u of
			U_VDMInt u \<Rightarrow> ((isTest (u) (inv_VDMInt) \<longrightarrow> (u < (0::VDMNat))) \<and> (isTest (u) inv_TBasic \<longrightarrow> (u > (0::VDMNat))))
		 )"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 43:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 43:5\<close>
definition
	pre_f1 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"pre_f1 u6 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f1 specification\<close>
		((inv_TUnion6 u6))"


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 43:5\<close>
definition
	post_f1 :: "TUnion6\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_f1 u6  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f1 specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_bool RESULT))"

definition
	f1 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"f1 u6 \<equiv> 
	\<comment>\<open>User defined body of f1\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> (u6 > (10::VDMNat1))
		 )"

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 46:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 46:5\<close>
definition
	pre_f2 :: "TUnion2 \<Rightarrow> \<bool>"
where
	"pre_f2 u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f2 specification\<close>
		((inv_TUnion2 u2))"


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 46:5\<close>
definition
	post_f2 :: "TUnion2\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_f2 u2  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f2 specification\<close>
		((inv_TUnion2 u2)  \<and>  (inv_bool RESULT))"

definition
	f2 :: "TUnion2 \<Rightarrow> \<bool>"
where
	"f2 u2 \<equiv> 
	\<comment>\<open>User defined body of f2\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	case u2 of
			TUnion2.U_VDMNat_VDMSeq u2 \<Rightarrow> (isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> ((vdm_card (elems u2)) = (len u2)))
		  | TUnion2.U_VDMReal_VDMSet u2 \<Rightarrow> (isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> ((vdm_card (elems u2)) = (len u2)))
		 )"

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 49:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 49:5\<close>
definition
	pre_f3 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"pre_f3 u6 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f3 specification\<close>
		((inv_TUnion6 u6))"


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 49:5\<close>
definition
	post_f3 :: "TUnion6\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_f3 u6  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f3 specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_bool RESULT))"

definition
	f3 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"f3 u6 \<equiv> 
	\<comment>\<open>User defined body of f3\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> (
		 \<comment>\<open>Isabelle `case` requires types it can deconstruct (e.g. optional, union, etc.) for `\<bool>` VDM type.\<close>)
		 )"

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 57:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 57:5\<close>
definition
	pre_f4 :: "TUnion6\<Rightarrow> TUnion2 \<Rightarrow> \<bool>"
where
	"pre_f4 u6  u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f4 specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2 u2))"


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 57:5\<close>
definition
	post_f4 :: "TUnion6\<Rightarrow> TUnion2\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_f4 u6  u2  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f4 specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2 u2)  \<and>  (inv_bool RESULT))"

definition
	f4 :: "TUnion6\<Rightarrow> TUnion2 \<Rightarrow> \<bool>"
where
	"f4 u6  u2 \<equiv> 
	\<comment>\<open>User defined body of f4\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	case u2 of
			TUnion2.U_VDMNat_VDMSeq u2 \<Rightarrow> ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		  | TUnion2.U_VDMReal_VDMSet u2 \<Rightarrow> ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		 case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		 )"

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 76:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 76:5\<close>
definition
	pre_f4' :: "TUnion6\<Rightarrow> TUnion2' \<Rightarrow> \<bool>"
where
	"pre_f4' u6  u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f4' specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2' u2))"


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 76:5\<close>
definition
	post_f4' :: "TUnion6\<Rightarrow> TUnion2'\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_f4' u6  u2  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f4' specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2' u2)  \<and>  (inv_bool RESULT))"

definition
	f4' :: "TUnion6\<Rightarrow> TUnion2' \<Rightarrow> \<bool>"
where
	"f4' u6  u2 \<equiv> 
	\<comment>\<open>User defined body of f4'\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	case u2 of
			TUnion2'.U_VDMNat_VDMSeq u2 \<Rightarrow> (u6 \<in> (elems u2))
		  | TUnion2'.U_VDMReal_VDMSeq u2 \<Rightarrow> (u6 \<in> (elems u2))
		 case u6 of
			TUnion6.U_VDMInt u6 \<Rightarrow> (u6 \<in> (elems u2))
		 )"

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 80:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 80:5\<close>
definition
	pre_f6 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"pre_f6 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f6 specification\<close>
		((inv_TUnion6 u))"


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 80:5\<close>
definition
	post_f6 :: "TUnion6\<Rightarrow> VDMInt \<Rightarrow> \<bool>"
where
	"post_f6 u  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f6 specification\<close>
		((inv_TUnion6 u)  \<and>  (inv_VDMInt RESULT))"

definition
	f6 :: "TUnion6 \<Rightarrow> VDMInt"
where
	"f6 u \<equiv> 
	\<comment>\<open>User defined body of f6\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	case u of
			TUnion6.U_VDMInt u \<Rightarrow> u
		 )"

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 83:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 83:5\<close>
definition
	pre_f6' :: "TUnion6' \<Rightarrow> \<bool>"
where
	"pre_f6' u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f6' specification\<close>
		((inv_TUnion6' u))"


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 83:5\<close>
definition
	post_f6' :: "TUnion6'\<Rightarrow> VDMInt \<Rightarrow> \<bool>"
where
	"post_f6' u  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f6' specification\<close>
		((inv_TUnion6' u)  \<and>  (inv_VDMInt RESULT))"

definition
	f6' :: "TUnion6' \<Rightarrow> VDMInt"
where
	"f6' u \<equiv> 
	\<comment>\<open>User defined body of f6'\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	case u of
			TUnion6'.U_VDMInt u \<Rightarrow> u
		 )"

end