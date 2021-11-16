(* VDM to Isabelle Translation @2021-11-16T12:07:21.918762Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IRecords.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IRecords.vdmsl]
*)
theory TestV2IRecords
imports VDMToolkit
begin


record TRecord = 
	x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d :: "VDMNat"
		 y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d :: "VDMNat"
	

definition
	inv_TRecord :: "TRecord \<Rightarrow> \<bool>"
where
	"inv_TRecord r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TRecord specification\<close>
		( (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) < (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)))"
 

definition
	eq_TRecord :: "TRecord\<Rightarrow> TRecord \<Rightarrow> \<bool>"
where
	"eq_TRecord r1 r2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TRecord specification\<close>
		( (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r1))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r1))) )  \<and>   (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r2))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r2))) ))  \<and> 
		\<comment>\<open>User defined body of eq_TRecord\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r1)) = (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r2)))"
 

definition
	ord_TRecord :: "TRecord\<Rightarrow> TRecord \<Rightarrow> \<bool>"
where
	"ord_TRecord r1 r2 \<equiv> 
		\<comment>\<open>User defined body of ord_TRecord\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r1)) < (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r2)))"
 

	
type_synonym TRecord2 = "TRecord"
	

definition
	inv_TRecord2 :: "TRecord2 \<Rightarrow> \<bool>"
where
	"inv_TRecord2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TRecord2 specification\<close>
		((inv_TRecord dummy0))"
 

	
type_synonym TRecord3 = "TRecord"
	

definition
	inv_TRecord3 :: "TRecord3 \<Rightarrow> \<bool>"
where
	"inv_TRecord3 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TRecord3 specification\<close>
		((inv_TRecord r))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord3\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) > (10::VDMNat1))"

		 

	
type_synonym TRecord4 = "TRecord2"
	

definition
	inv_TRecord4 :: "TRecord4 \<Rightarrow> \<bool>"
where
	"inv_TRecord4 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TRecord4 specification\<close>
		((inv_TRecord2 dummy0))"

		 

	
type_synonym TRecord5 = "TRecord2"
	

definition
	inv_TRecord5 :: "TRecord5 \<Rightarrow> \<bool>"
where
	"inv_TRecord5 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TRecord5 specification\<close>
		((inv_TRecord2 r))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord5\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) > (20::VDMNat1))"
 

	
type_synonym TRecord6 = "TRecord3"
	

definition
	inv_TRecord6 :: "TRecord6 \<Rightarrow> \<bool>"
where
	"inv_TRecord6 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TRecord6 specification\<close>
		((inv_TRecord3 dummy0))"

		 

	
type_synonym TRecord7 = "TRecord5"
	

definition
	inv_TRecord7 :: "TRecord7 \<Rightarrow> \<bool>"
where
	"inv_TRecord7 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TRecord7 specification\<close>
		((inv_TRecord5 r))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord7\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) > (30::VDMNat1))"

		 

end