theory VDMOrderNotExample
imports Main
begin

record R = 
  x :: nat 
  y :: nat  

definition 
  R_eq :: "R \<Rightarrow> R \<Rightarrow> bool" (infix "=\<^sub>R" 50)
  where
  [simp]: "r1 =\<^sub>R r2 \<equiv> (x r1) \<noteq> (x r2)"

definition 
  R_ord :: "R \<Rightarrow> R \<Rightarrow> bool" (infix "<\<^sub>R" 50)
  where
  [simp]: "r1 <\<^sub>R r2 \<equiv> (x r1) < (x r2) \<or> ((x r1) = (x r2) \<and> (y r1) < (y r2))"

definition 
  R_tord :: "R \<Rightarrow> R \<Rightarrow> bool" (infix "\<le>\<^sub>R" 50)
  where
  [simp]: "r1 \<le>\<^sub>R r2 \<equiv> r1 <\<^sub>R r2 \<or> R_eq r1 r2"

lemma vdm_ord_irrefl: "\<forall> r . \<not> r <\<^sub>R r"
  by simp

lemma vdm_ord_trans: "\<forall> r1 r2 r3 . r1 <\<^sub>R r2 \<and> r2 <\<^sub>R r3 \<longrightarrow> r1 <\<^sub>R r3"
  by fastforce

lemma vdm_ord_asym: "\<forall> x y . x <\<^sub>R y \<longrightarrow> \<not> y <\<^sub>R x"
  by simp

lemma vdm_ord_implies_totality:
  "\<forall> x y z . x \<le>\<^sub>R y \<or> y \<le>\<^sub>R x"
  (*
Auto Quickcheck found a counterexample:
  x = \<lparr>x = 0, y = 0\<rparr>
  y = \<lparr>x = 0, y = 0\<rparr>
   *)
  oops

lemma PO2:  
  "\<forall> r . r =\<^sub>R r"
  "\<forall> r1 r2 . r1 =\<^sub>R r2 \<longrightarrow> r2 =\<^sub>R r1" 
  \<open>\<forall> r1 r2 r3 . r1 =\<^sub>R r2 \<and> r2 =\<^sub>R r3 \<longrightarrow> r1 =\<^sub>R r3\<close>
  oops

lemma PO4: 
  \<open>\<forall> r . \<not> r <\<^sub>R r\<close>
  \<open>\<forall> r1 r2 r3 . r1 <\<^sub>R r2 \<and> r2 <\<^sub>R r3 \<longrightarrow> r1 <\<^sub>R r3\<close>
  by fastforce+

lemma PO5: 
  \<open>\<forall> r1 r2 . r1 \<le>\<^sub>R r2 \<or> r2 \<le>\<^sub>R r1\<close>
  quickcheck
  nitpick
  oops

end