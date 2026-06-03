theory Sigma 
  imports VDMToolkit
begin

record Sigma =  x\<^sub>S\<^sub>i\<^sub>g\<^sub>m\<^sub>a :: "VDMNat"

definition
	inv_Sigma :: \<open>Sigma \<Rightarrow> \<bool>\<close>
where
	\<open>inv_Sigma s \<equiv> inv_VDMNat (x\<^sub>S\<^sub>i\<^sub>g\<^sub>m\<^sub>a s)\<close>

definition 
  PO1_hiding :: "\<bool>" 
  where
"PO1_hiding \<equiv>
  \<forall> (a::VDMNat) (s::Sigma) . inv_VDMNat a \<and> inv_Sigma s \<longrightarrow>
      (let sv = (x\<^sub>S\<^sub>i\<^sub>g\<^sub>m\<^sub>a s);
           (local::VDMNat) = 0;
           sv' = a in 
        sv' + local = a
      )"

definition 
  PO1_no_hiding :: "\<bool>"
  where 
  "PO1_no_hiding ==
     \<forall> (a::VDMNat) (s::Sigma) . inv_VDMNat a \<and> inv_Sigma s \<longrightarrow>
      (let sv = (x\<^sub>S\<^sub>i\<^sub>g\<^sub>m\<^sub>a s);
           (local::VDMNat) = 0;
           sv' = a in 
        sv + local = a
      )"

definition 
  PO2 :: "\<bool>" 
  where 
  "PO2 \<equiv> 
  \<forall> (a::VDMNat) (s::Sigma) . inv_VDMNat a \<and> inv_Sigma s \<longrightarrow>
      (let sv = (x\<^sub>S\<^sub>i\<^sub>g\<^sub>m\<^sub>a s);
           (local::VDMNat) = 0;
           sv' = a in 
        inv_VDMNat local \<longrightarrow> 
        ((sv' > 0) \<longrightarrow> ((sv' + local) = a))
      )"

definition 
  PO3 :: \<bool>
  where
  "PO3 \<equiv> 
  \<forall> (a::VDMNat) (s::Sigma) . inv_VDMNat a \<and> inv_Sigma s \<longrightarrow>
      (let sv = (x\<^sub>S\<^sub>i\<^sub>g\<^sub>m\<^sub>a s);
           (local::VDMNat) = 0;
           sv' = a in 
        inv_VDMNat local \<longrightarrow> 
        ((sv' > 0) \<longrightarrow> 
          (\<forall> local' sv'' . inv_VDMNat local' \<and> inv_VDMNat sv'' \<longrightarrow> 
              ((sv'' + local') = a) \<and> (sv'' > 0) \<longrightarrow> (sv'' - 1 \<ge> 0) 
          )
        )
      )"

definition 
  PO4 :: \<bool>
  where
  "PO4 \<equiv> 
  \<forall> (a::VDMNat) (s::Sigma) . inv_VDMNat a \<and> inv_Sigma s \<longrightarrow>
      (let sv = (x\<^sub>S\<^sub>i\<^sub>g\<^sub>m\<^sub>a s);
           (local::VDMNat) = 0;
           sv' = a in 
        inv_VDMNat local \<longrightarrow> 
        ((sv' > 0) \<longrightarrow> 
          (\<forall> local' sv'' . inv_VDMNat local' \<and> inv_VDMNat sv'' \<longrightarrow> 
              ((sv'' + local') = a) \<and> (sv'' > 0) \<longrightarrow> 
              (let sv''' = sv'' - 1; 
                   local'' = local' + 1
                in 
                  inv_VDMNat sv''' \<and> inv_VDMNat local''  \<longrightarrow> (sv''' + local'' = a)
              ) 
          )
        )
      )"

definition 
  PO5 :: \<bool>
  where
  "PO5 \<equiv> 
  \<forall> (a::VDMNat) (s::Sigma) . inv_VDMNat a \<and> inv_Sigma s \<longrightarrow>
      (let sv = (x\<^sub>S\<^sub>i\<^sub>g\<^sub>m\<^sub>a s);
           (local::VDMNat) = 0;
           sv' = a in 
        inv_VDMNat local \<longrightarrow> 
        ((sv' > 0) \<longrightarrow> 
          (\<forall> local' sv'' . inv_VDMNat local' \<and> inv_VDMNat sv'' \<longrightarrow> 
              ((sv'' + local') = a) \<and> (sv'' > 0) \<longrightarrow> 
              (a - 1 \<ge> 0)
          )
        )
      )"

definition 
  PO6 :: \<bool>
  where
  "PO6 \<equiv> 
  \<forall> (a::VDMNat) (s::Sigma) . inv_VDMNat a \<and> inv_Sigma s \<longrightarrow>
      (let sv = (x\<^sub>S\<^sub>i\<^sub>g\<^sub>m\<^sub>a s);
           (local::VDMNat) = 0;
           sv' = a in 
        inv_VDMNat local \<longrightarrow> 
        (\<not> (sv' > 0) \<longrightarrow> (sv' + local) = a \<longrightarrow> a - 1 \<ge> 0)
      )"

lemma "PO1_hiding" unfolding PO1_hiding_def Let_def by simp

lemma "PO1_no_hiding" unfolding PO1_no_hiding_def Let_def 
  apply simp  nitpick
    \<comment> \<open>Nitpick found a counterexample a = 0 and xsigma = 1\<close>
  oops

lemma "PO2" unfolding PO2_def Let_def by simp

lemma PO1_entails_PO2: "PO1_no_hiding \<longrightarrow> PO2" 
  unfolding PO1_no_hiding_def PO2_def by simp 

lemma PO1_not_spurious: "PO2 \<longrightarrow> PO1_no_hiding"
  unfolding PO1_no_hiding_def PO2_def
  apply simp nitpick
\<comment> \<open>Nitpick found a counterexample a = 0 and xsigma = 1\<close>
   oops

lemma "PO3" unfolding PO3_def Let_def by simp
  
lemma PO3_equiv_PO2: "PO3 \<longleftrightarrow> PO2" unfolding PO3_def PO2_def by simp

lemma "PO4" unfolding PO4_def Let_def by simp

lemma PO4_equiv_PO3: "PO4 \<longleftrightarrow> PO3" unfolding PO4_def PO3_def by simp

lemma PO5_equiv_PO4: "PO5 \<longleftrightarrow> PO4" unfolding PO5_def PO4_def by simp

lemma PO6_entails_PO5: "PO6 \<longrightarrow> PO5" unfolding PO6_def PO5_def by simp 
lemma PO6_equiv_PO5: "PO5 \<longrightarrow> PO6" unfolding PO6_def PO5_def inv_Sigma_def 
  apply (safe,simp) nitpick
\<comment> \<open>Nitpick found a counterexample: a = 0\<close>
    oops

end