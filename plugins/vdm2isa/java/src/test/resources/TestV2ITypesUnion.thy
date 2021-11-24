(* VDM to Isabelle Translation @2021-11-24T10:33:48.520728Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesUnion.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesUnion.vdmsl]
*)
theory TestV2ITypesUnion
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 7:5\<close>
datatype TUnion = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 7:5\<close>
definition
	inv_TUnion :: "TUnion \<Rightarrow> \<bool>"
where
	"inv_TUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion specification\<close>
		(((case dummy0 of
		 (U_VDMInt dummy0 \<Rightarrow>((inv_VDMInt dummy0))
		 ))))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 8:5\<close>
datatype TUnion' = U_VDMReal "VDMReal"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 8:5\<close>
definition
	inv_TUnion' :: "TUnion' \<Rightarrow> \<bool>"
where
	"inv_TUnion' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion' specification\<close>
		(((case dummy0 of
		 (U_VDMReal dummy0 \<Rightarrow>((inv_VDMReal dummy0))
		 ))))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
datatype TUnion2 = U_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 U_VDMReal_VDMSet "VDMReal VDMSet"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
definition
	inv_TUnion2 :: "TUnion2 \<Rightarrow> \<bool>"
where
	"inv_TUnion2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2 specification\<close>
		(((case dummy0 of
		 (U_VDMNat_VDMSeq dummy0 \<Rightarrow>((inv_VDMSeq' (inv_VDMNat) dummy0))
		  \<and> U_VDMReal_VDMSet dummy0 \<Rightarrow>((inv_VDMSet' (inv_VDMReal) dummy0))
		 ))))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 12:5\<close>
datatype TUnion2' = U_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 U_VDMReal_VDMSeq "VDMReal VDMSeq"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 12:5\<close>
definition
	inv_TUnion2' :: "TUnion2' \<Rightarrow> \<bool>"
where
	"inv_TUnion2' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2' specification\<close>
		(((case dummy0 of
		 (U_VDMNat_VDMSeq dummy0 \<Rightarrow>((inv_VDMSeq' (inv_VDMNat) dummy0))
		  \<and> U_VDMReal_VDMSeq dummy0 \<Rightarrow>((inv_VDMSeq' (inv_VDMReal) dummy0))
		 ))))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 14:5\<close>
type_synonym TBasic = "VDMNat"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 14:5\<close>
definition
	inv_TBasic :: "TBasic \<Rightarrow> \<bool>"
where
	"inv_TBasic dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasic specification\<close>
		(((inv_VDMNat dummy0)))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 16:5\<close>
type_synonym TBasic2 = "TBasic"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 17:9\<close>
definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> \<bool>"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TBasic2 specification\<close>
		((inv_TBasic t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2\<close>
		(t > (10::VDMNat1))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 19:5\<close>
datatype TUnion3 = U_TBasic2 "TBasic2" | 
		 U_TUnion2 "TUnion2"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 19:5\<close>
definition
	inv_TUnion3 :: "TUnion3 \<Rightarrow> \<bool>"
where
	"inv_TUnion3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion3 specification\<close>
		(((case dummy0 of
		 (U_TBasic2 dummy0 \<Rightarrow>((inv_TBasic2 | dummy0))
		  \<and> U_TUnion2 dummy0 \<Rightarrow>((inv_TUnion2 | dummy0))
		 ))))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 21:5\<close>
datatype TUnion4 = U_VDMReal "VDMReal"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 22:9\<close>
definition
	inv_TUnion4 :: "TUnion4 \<Rightarrow> \<bool>"
where
	"inv_TUnion4 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion4 specification\<close>
		(((case u of
		 (U_VDMReal u \<Rightarrow>((inv_VDMReal u))
		 ))))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion4\<close>
		(u > (0::VDMNat))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 24:5\<close>
datatype TUnion5 = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 25:9\<close>
definition
	inv_TUnion5 :: "TUnion5 \<Rightarrow> \<bool>"
where
	"inv_TUnion5 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion5 specification\<close>
		(((case u of
		 (U_VDMInt u \<Rightarrow>((inv_VDMInt u))
		 ))))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion5\<close>
		(u < (0::VDMNat))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 27:5\<close>
datatype TUnion6 = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 28:9\<close>
definition
	inv_TUnion6 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"inv_TUnion6 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion6 specification\<close>
		(((case u of
		 (U_VDMInt u \<Rightarrow>((inv_VDMInt u))
		 ))))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion6\<close>
		((not yet \<longrightarrow> (u > (0::VDMNat))) \<and> (not yet \<longrightarrow> (u < (0::VDMNat))))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 30:5\<close>
datatype TUnion6' = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 31:9\<close>
definition
	inv_TUnion6' :: "TUnion6' \<Rightarrow> \<bool>"
where
	"inv_TUnion6' u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion6' specification\<close>
		(((case u of
		 (U_VDMInt u \<Rightarrow>((inv_VDMInt u))
		 ))))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion6'\<close>
		((not yet \<longrightarrow> (u < (0::VDMNat))) \<and> (not yet \<longrightarrow> (u > (0::VDMNat))))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 34:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 34:5\<close>
definition
	pre_f6 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"pre_f6 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f6 specification\<close>
		(((case u of (U_VDMInt u \<Rightarrow>((inv_VDMInt u))
		 ))))"


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 34:5\<close>
definition
	post_f6 :: "TUnion6\<Rightarrow> VDMInt \<Rightarrow> \<bool>"
where
	"post_f6 u  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f6 specification\<close>
		(((case u of
		 (U_VDMInt u \<Rightarrow>((inv_VDMInt u))
		 )))  \<and>  (inv_VDMInt RESULT))"

definition
	f6 :: "TUnion6 \<Rightarrow> VDMInt"
where
	"f6 u \<equiv> 
	\<comment>\<open>User defined body of f6\<close>
	u"

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 37:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 37:5\<close>
definition
	pre_f6' :: "TUnion6' \<Rightarrow> \<bool>"
where
	"pre_f6' u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f6' specification\<close>
		(((case u of (U_VDMInt u \<Rightarrow>((inv_VDMInt u))
		 ))))"


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 37:5\<close>
definition
	post_f6' :: "TUnion6'\<Rightarrow> VDMInt \<Rightarrow> \<bool>"
where
	"post_f6' u  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f6' specification\<close>
		(((case u of
		 (U_VDMInt u \<Rightarrow>((inv_VDMInt u))
		 )))  \<and>  (inv_VDMInt RESULT))"

definition
	f6' :: "TUnion6' \<Rightarrow> VDMInt"
where
	"f6' u \<equiv> 
	\<comment>\<open>User defined body of f6'\<close>
	u"

end