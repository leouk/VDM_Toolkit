(* VDM to Isabelle Translation @2022-02-18T09:36:47.769Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesRecordOrdering.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesRecordOrdering.vdmsl]
*)
theory TestV2ITypesRecordOrdering
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: Time' = compose Time' of r:real, i:nat end
	inv mk_Time'(r, -) == (r >= 0)
	eq mk_Time'(r1, i1) = mk_Time'(r2, i2) == ((r1 = r2) and (i1 = i2))
	ord a < b == (((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 7:5\<close>
record Time' = 
	r\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' :: "VDMReal"
		 
		 i\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' :: "VDMNat"
	

\<comment>\<open>VDM source: inv_Time': (Time' +> bool)
	inv_Time'(mk_Time'(r, -)) ==
(r >= 0)\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 10:9\<close>
definition
	inv_Time' :: "Time' \<Rightarrow> bool"
where
	"inv_Time' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Time'` specification.\<close>
		( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' dummy0))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let r = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' dummy0); dummy0_ignore = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' dummy0) in 
		\<comment>\<open>User defined body of inv_Time'.\<close>
		(r \<ge> (0::VDMNat)))"

		

\<comment>\<open>VDM source: eq_Time': (Time' * Time' +> bool)
	eq_Time'(mk_Time'(r1, i1), mk_Time'(r2, i2)) ==
((r1 = r2) and (i1 = i2))\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 11:8\<close>
definition
	eq_Time' :: "Time' \<Rightarrow> Time' \<Rightarrow> bool"
where
	"eq_Time' dummy0 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_Time'` specification.\<close>
		(inv_Time' dummy0  \<and>  inv_Time' dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let r1 = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' dummy0); i1 = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' dummy0); 
			r1 = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' dummy0); i1 = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' dummy0) in 
		\<comment>\<open>User defined body of eq_Time'.\<close>
		((r1 = r2) \<and> (i1 = i2)))"

		

\<comment>\<open>VDM source: ord_Time': (Time' * Time' +> bool)
	ord_Time'(a, b) ==
(((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 12:9\<close>
definition
	ord_Time' :: "Time' \<Rightarrow> Time' \<Rightarrow> bool"
where
	"ord_Time' a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Time'` specification.\<close>
		(inv_Time' a  \<and>  inv_Time' b)  \<and> 
		\<comment>\<open>User defined body of ord_Time'.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' a) < (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' b)) \<or> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' a) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' b)) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' a) < (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>' b))))"

		
lemmas inv_Time'_defs = inv_Time'_def inv_VDMNat_def inv_VDMReal_def 


end