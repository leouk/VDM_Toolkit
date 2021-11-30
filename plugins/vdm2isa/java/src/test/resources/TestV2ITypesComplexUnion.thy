(* VDM to Isabelle Translation @2021-11-30T10:20:27.476651Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesComplexUnion.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesComplexUnion.vdmsl]
*)
theory TestV2ITypesComplexUnion
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 8:5\<close>
datatype TUnion = "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 8:5\<close>
definition
	inv_TUnion :: "TUnion \<Rightarrow> \<bool>"
where
	"inv_TUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion specification\<close>
		(((case dummy0 of
		 dummy0 \<Rightarrow> (inv_VDMInt dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 9:5\<close>
datatype TUnion' = "VDMReal"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 9:5\<close>
definition
	inv_TUnion' :: "TUnion' \<Rightarrow> \<bool>"
where
	"inv_TUnion' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion' specification\<close>
		(((case dummy0 of
		 dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 12:5\<close>
datatype TUnion2 = "VDMNat VDMSeq" | 
		 "VDMReal VDMSet"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 12:5\<close>
definition
	inv_TUnion2 :: "TUnion2 \<Rightarrow> \<bool>"
where
	"inv_TUnion2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2 specification\<close>
		(((case dummy0 of
		 dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy0)
		  | dummy0 \<Rightarrow> (inv_VDMSet' (inv_VDMReal) dummy0)
		 )))"
 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 13:5\<close>
datatype TUnion2' = "VDMNat VDMSeq" | 
		 "VDMReal VDMSeq"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 13:5\<close>
definition
	inv_TUnion2' :: "TUnion2' \<Rightarrow> \<bool>"
where
	"inv_TUnion2' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2' specification\<close>
		(((case dummy0 of
		 dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy0)
		  | dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMReal) dummy0)
		 )))"
 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 15:5\<close>
datatype TUnion21 = "VDMReal"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 15:5\<close>
definition
	inv_TUnion21 :: "TUnion21 \<Rightarrow> \<bool>"
where
	"inv_TUnion21 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion21 specification\<close>
		(((case dummy0 of
		 dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 16:5\<close>
type_synonym TUnion21' = "TUnion21 VDMSet"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 16:5\<close>
definition
	inv_TUnion21' :: "TUnion21' \<Rightarrow> \<bool>"
where
	"inv_TUnion21' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion21' specification\<close>
		(((inv_VDMSet' (inv_TUnion21) dummy0)))"

		 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 18:5\<close>
type_synonym TBasic = "VDMNat"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 18:5\<close>
definition
	inv_TBasic :: "TBasic \<Rightarrow> \<bool>"
where
	"inv_TBasic dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasic specification\<close>
		(((inv_VDMNat dummy0)))"
 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 20:5\<close>
type_synonym TBasic2 = "TBasic"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 21:9\<close>
definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> \<bool>"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TBasic2 specification\<close>
		((inv_TBasic t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2\<close>
		(t > 10)"

		 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 23:5\<close>
datatype TUnion3 = "TBasic2" | 
		 "TUnion2"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 23:5\<close>
definition
	inv_TUnion3 :: "TUnion3 \<Rightarrow> \<bool>"
where
	"inv_TUnion3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion3 specification\<close>
		(((case dummy0 of
		 dummy0 \<Rightarrow> (inv_TBasic2 dummy0)
		  | dummy0 \<Rightarrow> (inv_TUnion2 dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 27:5\<close>
datatype TUnion4 = "VDMReal"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 28:9\<close>
definition
	inv_TUnion4 :: "TUnion4 \<Rightarrow> \<bool>"
where
	"inv_TUnion4 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion4 specification\<close>
		(((case u of
		 u \<Rightarrow> (inv_VDMReal u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion4\<close>
		(
		\<comment>\<open>Implicit union type parameters projection conversion\<close>
		(case u of
			u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u > 0)
		 ))"

		 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 30:5\<close>
datatype TUnion5 = "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 31:9\<close>
definition
	inv_TUnion5 :: "TUnion5 \<Rightarrow> \<bool>"
where
	"inv_TUnion5 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion5 specification\<close>
		(((case u of
		 u \<Rightarrow> (inv_VDMInt u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion5\<close>
		(
		\<comment>\<open>Implicit union type parameters projection conversion\<close>
		(case u of
			u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u < 0)
		 ))"

		 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 35:5\<close>
datatype TUnion6 = "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 36:9\<close>
definition
	inv_TUnion6 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"inv_TUnion6 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion6 specification\<close>
		(((case u of
		 u \<Rightarrow> (inv_VDMInt u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion6\<close>
		(
		\<comment>\<open>Implicit union type parameters projection conversion\<close>
		(case u of
			u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 ((isTest (u) (inv_VDMNat) \<longrightarrow> (u > 0)) \<and> (isTest (u) (inv_VDMInt) \<longrightarrow> (u < 0)))
		 ))"
 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 39:5\<close>
datatype TUnion6' = "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 40:9\<close>
definition
	inv_TUnion6' :: "TUnion6' \<Rightarrow> \<bool>"
where
	"inv_TUnion6' u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion6' specification\<close>
		(((case u of
		 u \<Rightarrow> (inv_VDMInt u)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion6'\<close>
		(
		\<comment>\<open>Implicit union type parameters projection conversion\<close>
		(case u of
			u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 ((isTest (u) (inv_VDMInt) \<longrightarrow> (u < 0)) \<and> (isTest (u) inv_TBasic \<longrightarrow> (u > 0)))
		 ))"
 

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 44:5\<close>

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 44:5\<close>
definition
	pre_f1 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"pre_f1 u6 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f1 specification\<close>
		((inv_TUnion6 u6))"


\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 44:5\<close>
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
	(case u6 of
			u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u6 > 10)
		 ))"

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 47:5\<close>

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 47:5\<close>
definition
	pre_f2 :: "TUnion2 \<Rightarrow> \<bool>"
where
	"pre_f2 u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f2 specification\<close>
		((inv_TUnion2 u2))"


\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 47:5\<close>
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
	(case u2 of
			u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> ((vdm_card (elems u2)) = (len u2)))
		  | u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> ((vdm_card (elems u2)) = (len u2)))
		 ))"

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 50:5\<close>

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 50:5\<close>
definition
	pre_f3 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"pre_f3 u6 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f3 specification\<close>
		((inv_TUnion6 u6))"


\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 50:5\<close>
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
	(case u6 of
			u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (
		 \<comment>\<open>`cases true` expressions are translated as an and-chain of implications or others\<close>
		 ((isTest (u6) (inv_VDMNat)) \<longrightarrow> (u6 > 10)) \<and> 
			 ((isTest (u6) (inv_VDMInt)) \<longrightarrow> (u6 < 10))
		  \<or> (u6>100))
		 ))"

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 59:5\<close>

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 59:5\<close>
definition
	pre_f4 :: "TUnion6\<Rightarrow> TUnion2 \<Rightarrow> \<bool>"
where
	"pre_f4 u6  u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f4 specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2 u2))"


\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 59:5\<close>
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
	(case u2 of
			u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 
		 (case u6 of
			u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		 )
		  | u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 
		 (case u6 of
			u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		 )
		 ))"

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 92:5\<close>

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 92:5\<close>
definition
	pre_f4' :: "TUnion6\<Rightarrow> TUnion2' \<Rightarrow> \<bool>"
where
	"pre_f4' u6  u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f4' specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2' u2))"


\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 92:5\<close>
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
	(case u2 of
			u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 
		 (case u6 of
			u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u6 \<in> (elems u2))
		 )
		  | u2 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 
		 (case u6 of
			u6 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (u6 \<in> (elems u2))
		 )
		 ))"

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 96:5\<close>

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 96:5\<close>
definition
	pre_f6 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"pre_f6 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f6 specification\<close>
		((inv_TUnion6 u))"


\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 96:5\<close>
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
	(case u of
			u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 u
		 ))"

	
\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 99:5\<close>

\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 99:5\<close>
definition
	pre_f6' :: "TUnion6' \<Rightarrow> \<bool>"
where
	"pre_f6' u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f6' specification\<close>
		((inv_TUnion6' u))"


\<comment>\<open>in 'TestV2ITypesComplexUnion' (./src/test/resources/TestV2ITypesComplexUnion.vdmsl) at line 99:5\<close>
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
	(case u of
			u \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 u
		 ))"

end