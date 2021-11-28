(* VDM to Isabelle Translation @2021-11-28T06:52:58.803162Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesRecords.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesRecords.vdmsl]
*)
theory TestV2ITypesRecords
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 7:5\<close>
record TRecord = 
	x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d :: "VDMNat"
		 y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d :: "VDMNat"
	

\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 10:9\<close>
definition
	inv_TRecord :: "TRecord \<Rightarrow> \<bool>"
where
	"inv_TRecord r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TRecord specification\<close>
		( (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))) \<and> 
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) < (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)))"
 

\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 11:24\<close>
definition
	eq_TRecord :: "TRecord\<Rightarrow> TRecord \<Rightarrow> \<bool>"
where
	"eq_TRecord r1  r2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TRecord specification\<close>
		(inv_TRecord r1  \<and>  inv_TRecord r2)  \<and> 
		\<comment>\<open>User defined body of eq_TRecord\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r1)) = (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r2)))"
 

\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 12:25\<close>
definition
	ord_TRecord :: "TRecord\<Rightarrow> TRecord \<Rightarrow> \<bool>"
where
	"ord_TRecord r1  r2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for ord_TRecord specification\<close>
		(inv_TRecord r1  \<and>  inv_TRecord r2)  \<and> 
		\<comment>\<open>User defined body of ord_TRecord\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r1)) < (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r2)))"
 

	
\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 15:5\<close>
type_synonym TRecord2 = "TRecord"
	

\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 15:5\<close>
definition
	inv_TRecord2 :: "TRecord2 \<Rightarrow> \<bool>"
where
	"inv_TRecord2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TRecord2 specification\<close>
		((inv_TRecord dummy0))"
 

	
\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 19:5\<close>
type_synonym TRecord3 = "TRecord"
	

\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 20:9\<close>
definition
	inv_TRecord3 :: "TRecord3 \<Rightarrow> \<bool>"
where
	"inv_TRecord3 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TRecord3 specification\<close>
		((inv_TRecord r))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord3\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) > (10::VDMNat1))"

		 

	
\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 24:5\<close>
type_synonym TRecord4 = "TRecord2"
	

\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 24:5\<close>
definition
	inv_TRecord4 :: "TRecord4 \<Rightarrow> \<bool>"
where
	"inv_TRecord4 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TRecord4 specification\<close>
		((inv_TRecord2 dummy0))"

		 

	
\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 28:5\<close>
type_synonym TRecord5 = "TRecord2"
	

\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 29:9\<close>
definition
	inv_TRecord5 :: "TRecord5 \<Rightarrow> \<bool>"
where
	"inv_TRecord5 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TRecord5 specification\<close>
		((inv_TRecord2 r))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord5\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) > (20::VDMNat1))"
 

	
\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 33:5\<close>
type_synonym TRecord6 = "TRecord3"
	

\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 33:5\<close>
definition
	inv_TRecord6 :: "TRecord6 \<Rightarrow> \<bool>"
where
	"inv_TRecord6 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TRecord6 specification\<close>
		((inv_TRecord3 dummy0))"

		 

	
\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 37:5\<close>
type_synonym TRecord7 = "TRecord5"
	

\<comment>\<open>in 'TestV2ITypesRecords' (./src/test/resources/TestV2ITypesRecords.vdmsl) at line 38:9\<close>
definition
	inv_TRecord7 :: "TRecord7 \<Rightarrow> \<bool>"
where
	"inv_TRecord7 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TRecord7 specification\<close>
		((inv_TRecord5 r))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord7\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) > (30::VDMNat1))"

		 

end