(* VDM to Isabelle Translation @2021-11-16T12:07:17.794849Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IRecords' (./src/test/resources/TestV2IRecords.vdmsl) at line 7:5
files = [./src/test/resources/TestV2IRecords.vdmsl]
*)
theory TestV2IRecords_PO
imports TestV2IRecords
begin


theorem TRecord_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (r :: TRecord)  . (((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r)))
		 ))) \<longrightarrow> ((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) < (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r))))))"
	
	oops
	
	
	
theorem TRecord_EQUIV_RELATION:
	"(((\<forall> (x :: TRecord)  . (((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x)))
		 ))) \<longrightarrow> (eq_TRecord x  x))) \<and> ((\<forall> (x :: TRecord)  (y :: TRecord)  . (((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x)))
		 ))) \<and>  ((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d y))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d y)))
		 ))) \<longrightarrow> ((eq_TRecord x  y) \<longrightarrow> (eq_TRecord y  x)))) \<and> (\<forall> (x :: TRecord)  (y :: TRecord)  (z :: TRecord)  . (((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x)))
		 ))) \<and>  ((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d y))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d y)))
		 ))) \<and>  ((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d z))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d z)))
		 ))) \<longrightarrow> (((eq_TRecord x  y) \<and> (eq_TRecord y  z)) \<longrightarrow> (eq_TRecord x  z)))))))"
	
	oops
	
	
	
theorem TRecord_STRICT_ORDER:
	"(((\<forall> (x :: TRecord)  . (((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x)))
		 ))) \<longrightarrow> (\<not> (ord_TRecord x  x)))) \<and> (\<forall> (x :: TRecord)  (y :: TRecord)  (z :: TRecord)  . (((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d x)))
		 ))) \<and>  ((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d y))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d y)))
		 ))) \<and>  ((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d z))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d z)))
		 ))) \<longrightarrow> (((ord_TRecord x  y) \<and> (ord_TRecord y  z)) \<longrightarrow> (ord_TRecord x  z))))))"
	
	oops
	
	
	
theorem TRecord3_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (r :: TRecord)  . (((
		 (((inv_VDMNat (x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))) \<and>
		 ((inv_VDMNat (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r)))
		 ))) \<longrightarrow> ((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) > (10::VDMNat1)))))"
	
	oops
	
	
	
theorem TRecord5_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (r :: TRecord2)  . ((((inv_TRecord r))) \<longrightarrow> ((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) > (20::VDMNat1)))))"
	
	oops
	
	
	
theorem TRecord7_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (r :: TRecord5)  . ((((inv_TRecord2 r))) \<longrightarrow> ((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d (r)) > (30::VDMNat1)))))"
	
	oops
	
	
end