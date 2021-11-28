(* VDM to Isabelle Translation @2021-11-28T10:01:52.588Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl]
*)
theory TestV2ITypesUnion
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 6:5\<close>
datatype TUnion2 = U_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 U_VDMReal_VDMSet "VDMReal VDMSet"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 6:5\<close>
definition
	inv_TUnion2 :: "TUnion2 \<Rightarrow> \<bool>"
where
	"inv_TUnion2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2 specification\<close>
		(((case dummy0 of
		 TUnion2.U_VDMNat_VDMSeq dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy0)
		  | TUnion2.U_VDMReal_VDMSet dummy0 \<Rightarrow> (inv_VDMSet' (inv_VDMReal) dummy0)
		 )))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 7:5\<close>
datatype TUnion2' = U_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 U_VDMReal_VDMSeq "VDMReal VDMSeq"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 7:5\<close>
definition
	inv_TUnion2' :: "TUnion2' \<Rightarrow> \<bool>"
where
	"inv_TUnion2' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2' specification\<close>
		(((case dummy0 of
		 TUnion2'.U_VDMNat_VDMSeq dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy0)
		  | TUnion2'.U_VDMReal_VDMSeq dummy0 \<Rightarrow> (inv_VDMSeq' (inv_VDMReal) dummy0)
		 )))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 8:5\<close>
datatype TUnion6 = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 9:9\<close>
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
			U_VDMInt u \<Rightarrow> ((isTest (u) (inv_VDMNat) \<longrightarrow> (u > 0)) \<and> (isTest (u) (inv_VDMInt) \<longrightarrow> (u < 0)))
		 )"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 13:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 13:5\<close>
definition
	pre_f4 :: "TUnion6\<Rightarrow> TUnion2 \<Rightarrow> \<bool>"
where
	"pre_f4 u6  u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f4 specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2 u2))"


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 13:5\<close>
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
			TUnion2.U_VDMNat_VDMSeq u2 \<Rightarrow> ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) 
      \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) 
          \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		  | TUnion2.U_VDMReal_VDMSet u2 \<Rightarrow> ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) 
      \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) 
          \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		 case u6 of
	        		TUnion6.U_VDMInt u6 \<Rightarrow> ((isTest (u6) (inv_VDMInt) \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) 
      \<longrightarrow> (u6 \<in> (elems u2))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (u6 \<in> u2)))) \<and> (isTest (u6) (inv_VDMNat) 
          \<longrightarrow> ((isTest (u2) (inv_VDMSeq' (inv_VDMNat)) \<longrightarrow> (\<not> (u6 \<in> (elems u2)))) \<and> (isTest (u2) (inv_VDMSet' (inv_VDMReal)) \<longrightarrow> (\<not> (u6 \<in> u2))))))
		 )"

	
\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 32:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 32:5\<close>
definition
	pre_f4' :: "TUnion6\<Rightarrow> TUnion2' \<Rightarrow> \<bool>"
where
	"pre_f4' u6  u2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f4' specification\<close>
		((inv_TUnion6 u6)  \<and>  (inv_TUnion2' u2))"


\<comment>\<open>in 'TestV2ITypesUnion' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl) at line 32:5\<close>
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

end