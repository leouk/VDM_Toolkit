(* VDM to Isabelle Translation @2021-12-02T05:47:12.700929Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesUnion.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesUnion.vdmsl]
*)
theory TestV2ITypesUnion
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 8:5\<close>
datatype TQuoteUnion = U_A  | 
		 U_B  | 
		 U_C 
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 8:5\<close>
definition
	inv_TQuoteUnion :: "TQuoteUnion \<Rightarrow> bool"
where
	"inv_TQuoteUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TQuoteUnion specification\<close>
		((((inv_True dummy0))))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
datatype TBasicUnion = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
definition
	inv_TBasicUnion :: "TBasicUnion \<Rightarrow> bool"
where
	"inv_TBasicUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasicUnion specification\<close>
		(((case dummy0 of
		 TBasicUnion.U_VDMInt dummy0 \<Rightarrow> (inv_VDMInt dummy0)
		 )))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 13:5\<close>
datatype TMixedUnion = U_A  | 
		 U_VDMNat "VDMNat"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 13:5\<close>
definition
	inv_TMixedUnion :: "TMixedUnion \<Rightarrow> bool"
where
	"inv_TMixedUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TMixedUnion specification\<close>
		(((case dummy0 of
		 TMixedUnion.U_A  \<Rightarrow> (inv_True dummy0)
		  | TMixedUnion.U_VDMNat dummy0 \<Rightarrow> (inv_VDMNat dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 16:5\<close>
datatype TBasicQuoteUnion = U_TBasicUnion "TBasicUnion" | 
		 U_TQuoteUnion "TQuoteUnion"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 16:5\<close>
definition
	inv_TBasicQuoteUnion :: "TBasicQuoteUnion \<Rightarrow> bool"
where
	"inv_TBasicQuoteUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasicQuoteUnion specification\<close>
		(((case dummy0 of
		 TBasicQuoteUnion.U_TBasicUnion dummy0 \<Rightarrow> (inv_TBasicUnion dummy0)
		  | TBasicQuoteUnion.U_TQuoteUnion dummy0 \<Rightarrow> (inv_TQuoteUnion dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 18:5\<close>
datatype TMixedQuoteUnion = U_TMixedUnion "TMixedUnion" | 
		 U_TQuoteUnion "TQuoteUnion"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 18:5\<close>
definition
	inv_TMixedQuoteUnion :: "TMixedQuoteUnion \<Rightarrow> bool"
where
	"inv_TMixedQuoteUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TMixedQuoteUnion specification\<close>
		(((case dummy0 of
		 TMixedQuoteUnion.U_TMixedUnion dummy0 \<Rightarrow> (inv_TMixedUnion dummy0)
		  | TMixedQuoteUnion.U_TQuoteUnion dummy0 \<Rightarrow> (inv_TQuoteUnion dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 22:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 22:5\<close>
definition
	pre_f1 :: "TQuoteUnion \<Rightarrow> bool"
where
	"pre_f1 qu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f1 specification\<close>
		((inv_TQuoteUnion qu))"


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 22:5\<close>
definition
	post_f1 :: "TQuoteUnion\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f1 qu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f1 specification\<close>
		((inv_TQuoteUnion qu)  \<and>  (inv_bool RESULT))"

definition
	f1 :: "TQuoteUnion \<Rightarrow> bool"
where
	"f1 qu \<equiv> 
	\<comment>\<open>User defined body of f1\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	((qu \<noteq> TQuoteUnion.U_A )))"

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 25:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 25:5\<close>
definition
	pre_f2 :: "TBasicUnion \<Rightarrow> bool"
where
	"pre_f2 bu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f2 specification\<close>
		((inv_TBasicUnion bu))"


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 25:5\<close>
definition
	post_f2 :: "TBasicUnion\<Rightarrow> VDMInt \<Rightarrow> bool"
where
	"post_f2 bu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f2 specification\<close>
		((inv_TBasicUnion bu)  \<and>  (inv_VDMInt RESULT))"

definition
	f2 :: "TBasicUnion \<Rightarrow> VDMInt"
where
	"f2 bu \<equiv> 
	\<comment>\<open>User defined body of f2\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	(case bu of
			TBasicUnion.U_VDMInt bu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 bu
		 ))"

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 28:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 28:5\<close>
definition
	pre_f3 :: "bool"
where
	"pre_f3  \<equiv> True"


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 28:5\<close>
definition
	post_f3 :: "TMixedUnion \<Rightarrow> bool"
where
	"post_f3 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f3 specification\<close>
		((inv_TMixedUnion RESULT))"

definition
	f3 :: "TMixedUnion"
where
	"f3  \<equiv> 
	\<comment>\<open>User defined body of f3\<close>
	TQuoteUnion.U_A "

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 31:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 31:5\<close>
definition
	pre_f4 :: "bool"
where
	"pre_f4  \<equiv> True"


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 31:5\<close>
definition
	post_f4 :: "TMixedQuoteUnion \<Rightarrow> bool"
where
	"post_f4 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f4 specification\<close>
		((inv_TMixedQuoteUnion RESULT))"

definition
	f4 :: "TMixedQuoteUnion"
where
	"f4  \<equiv> 
	\<comment>\<open>User defined body of f4\<close>
	TQuoteUnion.U_A "

end