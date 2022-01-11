theory RGToolkit
imports VDMToolkit
begin

(*================================================================*)

(* TODO: 
1. generalise op with a ('a \<Rightarrow> 'a) list?
2. generalise it to have I/O? 
3. how to 'inherit' the type 'a so that we can 
   have the fixes across different locales under same type? 
*)

class VDM = 
  fixes st_inv :: "'a \<Rightarrow> \<bool>"
  assumes st_valid: "st_inv s"

class Op = VDM +
  fixes pre :: "('a::VDM) \<Rightarrow> \<bool>"
  and   post:: "('a::VDM) \<Rightarrow> 'a \<Rightarrow> \<bool>"

class Op_VCG = Op +
 assumes t_op_fsb: "\<forall> s . pre s \<longrightarrow> (\<exists> s' . post s s')"

class RG = Op +
fixes  rely:: "('a::VDM) \<Rightarrow> 'a \<Rightarrow> \<bool>"
  and  guar:: "('a::VDM) \<Rightarrow> 'a \<Rightarrow> \<bool>"
begin

subclass VDM ..
end
  
class RG_closure = RG +
assumes
    t_refl_rely : "\<forall> s . rely s s"
and t_refl_guar : "\<forall> s . guar s s"
and t_trans_rely: "\<forall> s t u. rely s t \<and> rely t u \<longrightarrow> rely s u"
and t_trans_guar: "\<forall> s t u. guar s t \<and> guar t u \<longrightarrow> guar s u"

class RG_coherence = RG +
assumes
     t_coherence: "\<forall> s s' . guar s s' \<longrightarrow> rely s s'"

inductive spec_comp  :: "(('a::VDM) \<Rightarrow> 'a \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'a \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'a \<Rightarrow> \<bool>)"  (infixr ";;" 75)
  for P :: "('a \<Rightarrow> 'a \<Rightarrow> \<bool>)" 
  and Q :: "('a \<Rightarrow> 'a \<Rightarrow> \<bool>)"
where relcompI [intro]: "P s s0 \<Longrightarrow> Q s0 s' \<Longrightarrow> (P ;; Q) s s'"

inductive_cases spec_compE: "(P ;; Q) s s'"  

definition
  spec_comp2:: "('a \<Rightarrow> 'a \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'a \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'a \<Rightarrow> \<bool>)" (infixl ";:" 55)
where
  "(P ;: Q) \<equiv> \<lambda> s s' . (\<exists> s0 . (P s s0) \<and> (Q s0 s'))"    

lemma l_spec_comp_eq: "(P ;; Q) = (P ;: Q)"
apply rule+
unfolding spec_comp2_def
 apply safe
  apply (erule spec_compE, blast)
  by (simp add: relcompI)
     
class RG_stability = RG +
assumes
     t_pre_rely : "\<forall> s s' . pre s \<and> (rely s s') \<longrightarrow> pre s'" 
and  t_rely_post: "\<forall> s s' . pre s \<and> (rely ;; post) s s' \<longrightarrow> post s s'"
and  t_post_rely: "\<forall> s s' . (post ;; rely) s s' \<longrightarrow> post s s'"     

class RG_feasibility = RG +
assumes
        t_rg_fsb: "\<forall> s . pre s \<longrightarrow> (\<exists>s' . post s s' \<and> guar s s')"

class RG_VCG = Op_VCG + RG_closure + RG_stability + RG_feasibility (* RG_coherence *)
begin
subclass VDM ..

lemma False nitpick [show_all] oops  
end

locale Silly =
   assumes "(x::nat) \<noteq> x"
begin
lemma "False" nitpick [show_all] oops
end
  
end