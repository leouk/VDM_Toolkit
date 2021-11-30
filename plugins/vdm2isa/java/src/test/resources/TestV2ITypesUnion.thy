(* VDM to Isabelle Translation @2021-11-30T10:20:27.481459Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesUnion.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesUnion.vdmsl]
*)
theory TestV2ITypesUnion
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 7:5\<close>
datatype TQuoteUnion =  | 
		  | 
		 
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 7:5\<close>
definition
	inv_TQuoteUnion :: "TQuoteUnion \<Rightarrow> \<bool>"
where
	"inv_TQuoteUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TQuoteUnion specification\<close>
		(((case dummy0 of
		 dummy0 \<Rightarrow> (inv_True dummy0)
		  | dummy0 \<Rightarrow> (inv_True dummy0)
		  | dummy0 \<Rightarrow> (inv_True dummy0)
		 )))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 10:5\<close>
datatype TBasicUnion = "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 10:5\<close>
definition
	inv_TBasicUnion :: "TBasicUnion \<Rightarrow> \<bool>"
where
	"inv_TBasicUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasicUnion specification\<close>
		(((case dummy0 of
		 dummy0 \<Rightarrow> (inv_VDMInt dummy0)
		 )))"
 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 12:5\<close>
datatype TBasicQuoteUnion = "TBasicUnion" | 
		 "TQuoteUnion"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 12:5\<close>
definition
	inv_TBasicQuoteUnion :: "TBasicQuoteUnion \<Rightarrow> \<bool>"
where
	"inv_TBasicQuoteUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasicQuoteUnion specification\<close>
		(((case dummy0 of
		 dummy0 \<Rightarrow> (inv_TBasicUnion dummy0)
		  | dummy0 \<Rightarrow> (inv_TQuoteUnion dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 16:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 16:5\<close>
definition
	pre_f1 :: "TQuoteUnion \<Rightarrow> \<bool>"
where
	"pre_f1 qu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f1 specification\<close>
		((inv_TQuoteUnion qu))"


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 16:5\<close>
definition
	post_f1 :: "TQuoteUnion\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_f1 qu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f1 specification\<close>
		((inv_TQuoteUnion qu)  \<and>  (inv_bool RESULT))"

definition
	f1 :: "TQuoteUnion \<Rightarrow> \<bool>"
where
	"f1 qu \<equiv> 
	\<comment>\<open>User defined body of f1\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	(case qu of
			qu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (qu \<noteq> A)
		  | qu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (qu \<noteq> A)
		  | qu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (qu \<noteq> A)
		 ))"

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 19:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 19:5\<close>
definition
	pre_f2 :: "TBasicUnion \<Rightarrow> \<bool>"
where
	"pre_f2 bu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f2 specification\<close>
		((inv_TBasicUnion bu))"


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 19:5\<close>
definition
	post_f2 :: "TBasicUnion\<Rightarrow> VDMInt \<Rightarrow> \<bool>"
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
			bu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 bu
		 ))"

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 22:5\<close>

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 22:5\<close>
definition
	pre_f2' :: "TBasicUnion \<Rightarrow> \<bool>"
where
	"pre_f2' bu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f2' specification\<close>
		((inv_TBasicUnion bu))"


\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 22:5\<close>
definition
	post_f2' :: "TBasicUnion\<Rightarrow> VDMNat option \<Rightarrow> \<bool>"
where
	"post_f2' bu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f2' specification\<close>
		((inv_TBasicUnion bu)  \<and>  (inv_Option (inv_VDMNat) RESULT))"

definition
	f2' :: "TBasicUnion \<Rightarrow> VDMNat option"
where
	"f2' bu \<equiv> 
	\<comment>\<open>User defined body of f2'\<close>
	(
	\<comment>\<open>Implicit union type parameters projection conversion\<close>
	(case bu of
			bu \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
		 (
		if (isTest (bu) (inv_VDMNat)) then
		(bu)
		else
		(None))
		 ))"

end