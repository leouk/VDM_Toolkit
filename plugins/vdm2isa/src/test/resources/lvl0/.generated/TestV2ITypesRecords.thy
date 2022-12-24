(* VDM to Isabelle Translation @2022-12-24T08:19:59.967Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypesRecords
   in './lvl0/TestV2ITypesRecords.vdmsl' at line 1:8
   files = [./lvl0/TestV2ITypesRecords.vdmsl]
*)
theory TestV2ITypesRecords
imports VDMToolkit 
begin


\<comment>\<open>VDM source: TRecord = compose TRecord of x:nat, y:nat end
	inv r == ((r.x) < (r.y))
	eq r1 = r2 == ((r1.x) = (r2.x))
	ord r1 < r2 == ((r1.x) < (r2.x))\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 7:5\<close>
record TRecord =  x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d :: "VDMNat"
		 
		 y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d :: "VDMNat" 
\<comment>\<open>VDM source: inv_TRecord: (TRecord +> bool)
	inv_TRecord(r) ==
((r.x) < (r.y))\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 10:18\<close>
definition
	inv_TRecord :: \<open>TRecord \<Rightarrow> bool\<close>
where
	\<open>inv_TRecord r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TRecord` specification.\<close>
		( (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))) \<and> 
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord.\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r) < (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))\<close>
 
\<comment>\<open>VDM source: eq_TRecord: (TRecord * TRecord +> bool)
	eq_TRecord(r1, r2) ==
((r1.x) = (r2.x))\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 11:8\<close>
definition
	eq_TRecord :: \<open>TRecord \<Rightarrow> TRecord \<Rightarrow> bool\<close>
where
	\<open>eq_TRecord r1   r2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TRecord` specification.\<close>
		(inv_TRecord r1  \<and>  inv_TRecord r2)  \<and> 
		\<comment>\<open>User defined body of eq_TRecord.\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r1) = (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r2))\<close>
 
\<comment>\<open>VDM source: ord_TRecord: (TRecord * TRecord +> bool)
	ord_TRecord(r1, r2) ==
((r1.x) < (r2.x))\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 12:9\<close>
definition
	ord_TRecord :: \<open>TRecord \<Rightarrow> TRecord \<Rightarrow> bool\<close>
where
	\<open>ord_TRecord r1   r2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TRecord` specification.\<close>
		(inv_TRecord r1  \<and>  inv_TRecord r2)  \<and> 
		\<comment>\<open>User defined body of ord_TRecord.\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r1) < (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r2))\<close>
 
lemmas inv_TRecord_defs = inv_TRecord_def inv_VDMNat_def 



\<comment>\<open>VDM source: TRecord2 = TRecord\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 15:5\<close>
type_synonym TRecord2 = \<open>TRecord\<close>
	
\<comment>\<open>VDM source: inv_TRecord2: (TRecord2 +> bool)
	inv_TRecord2(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 15:5\<close>
definition
	inv_TRecord2 :: \<open>TRecord2 \<Rightarrow> bool\<close>
where
	\<open>inv_TRecord2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TRecord2` specification.\<close>
		((inv_TRecord dummy0))\<close>
 
lemmas inv_TRecord2_defs = inv_TRecord_def inv_TRecord2_def inv_VDMNat_def 



\<comment>\<open>VDM source: TRecord3 = TRecord
	inv r == ((r.x) > 10)\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 19:5\<close>
type_synonym TRecord3 = \<open>TRecord\<close>
	
\<comment>\<open>VDM source: inv_TRecord3: (TRecord +> bool)
	inv_TRecord3(r) ==
((r.x) > 10)\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 20:18\<close>
definition
	inv_TRecord3 :: \<open>TRecord3 \<Rightarrow> bool\<close>
where
	\<open>inv_TRecord3 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TRecord3` specification.\<close>
		((inv_TRecord r))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord3.\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r) > (10::VDMNat1))\<close>

		 
lemmas inv_TRecord3_defs = inv_TRecord_def inv_TRecord3_def inv_VDMNat_def 



\<comment>\<open>VDM source: TRecord4 = TRecord2\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 24:5\<close>
type_synonym TRecord4 = \<open>TRecord2\<close>
	
\<comment>\<open>VDM source: inv_TRecord4: (TRecord4 +> bool)
	inv_TRecord4(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 24:5\<close>
definition
	inv_TRecord4 :: \<open>TRecord4 \<Rightarrow> bool\<close>
where
	\<open>inv_TRecord4 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TRecord4` specification.\<close>
		((inv_TRecord2 dummy0))\<close>

		 
lemmas inv_TRecord4_defs = inv_TRecord_def inv_TRecord2_def inv_TRecord4_def inv_VDMNat_def 



\<comment>\<open>VDM source: TRecord5 = TRecord2
	inv r == ((r.x) > 20)\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 28:5\<close>
type_synonym TRecord5 = \<open>TRecord2\<close>
	
\<comment>\<open>VDM source: inv_TRecord5: (TRecord2 +> bool)
	inv_TRecord5(r) ==
((r.x) > 20)\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 29:18\<close>
definition
	inv_TRecord5 :: \<open>TRecord5 \<Rightarrow> bool\<close>
where
	\<open>inv_TRecord5 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TRecord5` specification.\<close>
		((inv_TRecord2 r))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord5.\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r) > (20::VDMNat1))\<close>
 
lemmas inv_TRecord5_defs = inv_TRecord_def inv_TRecord2_def inv_TRecord5_def inv_VDMNat_def 



\<comment>\<open>VDM source: TRecord6 = TRecord3\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 33:5\<close>
type_synonym TRecord6 = \<open>TRecord3\<close>
	
\<comment>\<open>VDM source: inv_TRecord6: (TRecord6 +> bool)
	inv_TRecord6(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 33:5\<close>
definition
	inv_TRecord6 :: \<open>TRecord6 \<Rightarrow> bool\<close>
where
	\<open>inv_TRecord6 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TRecord6` specification.\<close>
		((inv_TRecord3 dummy0))\<close>

		 
lemmas inv_TRecord6_defs = inv_TRecord_def inv_TRecord3_def inv_TRecord6_def inv_VDMNat_def 



\<comment>\<open>VDM source: TRecord7 = TRecord5
	inv r == ((r.x) > 30)\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 37:5\<close>
type_synonym TRecord7 = \<open>TRecord5\<close>
	
\<comment>\<open>VDM source: inv_TRecord7: (TRecord5 +> bool)
	inv_TRecord7(r) ==
((r.x) > 30)\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (./lvl0/TestV2ITypesRecords.vdmsl) at line 38:18\<close>
definition
	inv_TRecord7 :: \<open>TRecord7 \<Rightarrow> bool\<close>
where
	\<open>inv_TRecord7 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TRecord7` specification.\<close>
		((inv_TRecord5 r))  \<and> 
		\<comment>\<open>User defined body of inv_TRecord7.\<close>
		((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r) > (30::VDMNat1))\<close>

		 
lemmas inv_TRecord7_defs = inv_TRecord_def inv_TRecord2_def inv_TRecord5_def inv_TRecord7_def inv_VDMNat_def 


 

end 