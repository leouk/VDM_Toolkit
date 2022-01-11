theory HEAP01ReifyProofsIJW
imports HEAP01Reify HEAP1ProofsIJW (* Uses HEAP1LemmasIJW considerably *)
begin 


(* Specific induction rules for this problem *)

lemma nat_nonzero_induct0 [case_names base step]:
  assumes base: "P (1::nat)"
  and grzero: "x>0"  
  and step: "\<forall> k . k > 0 \<longrightarrow> P k \<longrightarrow> P(k+1)"
  shows "P x" (* Now have to prove correct *) 
using assms
using [[rule_trace]]
apply (induct x)
apply simp_all
using neq0_conv by blast

lemma nat_nonzero_induct [case_names base step]:
  assumes base: "P (1::nat)"
  and grzero: "x>0"  
  and step: "\<And> k . k > 0 \<Longrightarrow> P k \<Longrightarrow> P(k+1)"
  shows "P x" (* Now have to prove correct *) 
using assms
using [[rule_trace]]
apply (induct x)
apply simp_all
using neq0_conv by blast

(* Induction rule as suggested by Cliff *) 
lemma contig_nonabut_finite_set_induct0 [case_names empty extend, induct set: finite]:
  assumes fin: "finite F" (* Requires a finite set *)
    and empty: "P {}" (* Base case for the empty set *)
    and extend: "\<forall> F F'. finite F \<longrightarrow>
                          finite F' \<longrightarrow>
                          F' \<noteq> {}  \<longrightarrow>
                          contiguous F' \<longrightarrow>
                          non_abutting F F' \<longrightarrow> 
(*  Part of abut_def      F \<inter> F' = {} \<Longrightarrow>   *)
                          P F \<longrightarrow> 
                          P (F \<union> F')"
  shows "P F"
using assms
apply (induct F)
apply simp_all
apply (erule_tac x="F" in allE)
apply (erule impE,simp)
apply (erule_tac x="{x}" in  allE)
apply (elim impE,simp_all)
unfolding contiguous_def
thm b_locs_of_as_set_interval[of l m] 
(*apply (simp add: b_locs_of_as_set_interval)*)
  unfolding locs_of_def
  apply simp
  nitpick
defer
unfolding non_abutting_def
apply (intro ballI)
apply simp
nitpick
oops

lemma contig_nonabut_finite_set_induct [case_names empty extend, induct set: finite]:
  assumes fin: "finite F" (* Requires a finite set *)
    and empty: "P {}" (* Base case for the empty set *)
    and extend: "\<And> F F'. finite F \<Longrightarrow> 
                          finite F' \<Longrightarrow> 
                          F' \<noteq> {} \<Longrightarrow> 
                          contiguous F' \<Longrightarrow>
                          non_abutting F F' \<Longrightarrow> 
(*  Part of abut_def      F \<inter> F' = {} \<Longrightarrow>   *)
                          P F \<Longrightarrow> 
                          P (F \<union> F')"
  shows "P F"
using assms
apply (induct F)
apply simp_all
unfolding contiguous_def non_abutting_def
apply simp
sorry (* Still to prove correct *)


(* Different non_abut from Leo. This is needed because
  abutedness is also interested in disjointedness.
 *)
definition 
  non_abut :: "nat set \<Rightarrow> nat set \<Rightarrow> bool"
  where
  "non_abut s1 s2 \<equiv> 
   disjoint s1 s2  \<and>   (* Nothing equal! *)
     (\<forall> l1\<in>s1. \<forall>l2\<in>s2. (l2 > l1+1) \<or> (l1 > l2+1))"

(****************** Lemmas about non_abut ***************************** *)
lemma non_abut_commute: "non_abut F F' = non_abut F' F"
unfolding non_abut_def disjoint_def by auto

(* Subsets are also non-abuting *)
lemma non_abut_subset: "non_abut F F' \<Longrightarrow> Fsub \<subseteq> F \<Longrightarrow> F'sub \<subseteq> F'
                       \<Longrightarrow> non_abut Fsub F'sub"
unfolding non_abut_def disjoint_def apply auto
apply (erule_tac x="l1" in ballE)
apply (erule_tac x="l2" in ballE)
apply simp
by auto



(********************* Lemmas about retr0 ******************************)

(* Horrid proof *)
lemma (in level1_basic) fin_retrieve: "finite (retr0(f1))"
proof -
from l1_invariant_def have finf1: "finite (dom f1)" 
    by (metis invF1_finite_weaken)
from l1_invariant_def have "(nat1_map f1)" 
    by (metis invF1_nat1_map_weaken)
thus ?thesis unfolding retr0_def locs_def
apply simp
apply (simp add: finf1)
apply (rule ballI)
apply (rule locs_of_finite)
apply (simp add: nat1_map_def)
done
qed

lemma non_abut_sep: 
  assumes non_abutting: "\<forall> l \<in> dom f. \<forall> l' \<in> dom f. l\<noteq>l' \<longrightarrow> non_abut (locs_of l (the (f l)))
      (locs_of l' (the (f l')))"
  and nat1f: "nat1_map f"
 shows "sep f"
unfolding sep_def
proof
  fix l
  assume lindom: "l \<in> dom f"
  show " l + the (f l) \<notin> dom f"
  proof -
    have "l + the (f l) - 1 \<in> locs_of l (the (f l))"
    proof (subst b_locs_of_as_set_interval)
      show " nat1 (the (f l))" by (metis `l \<in> dom f` nat1_map_def nat1f)
     next
      show "(l + the (f l)) - 1 \<in> {l..<l + the (f l)}"
        by (metis `l \<in> dom f` b_locs_of_as_set_interval nat1_map_def nat1f top_locs_of)
    qed
    have "dom f \<noteq> {}" by (metis `l \<in> dom f` empty_iff)
    have flg0: "the (f l) > 0" by (metis `l \<in> dom f` nat1_map_def nat1f nat1_def)
    show ?thesis
    proof (cases "dom f = {l}")
      assume "dom f = {l}" 
      then show "l + the (f l) \<notin> dom f"
       using flg0 by simp
     next
      assume "dom f \<noteq> {l}"
      show ?thesis
      proof
        assume *:"l + the (f l) \<in> dom f"
        then have "\<exists> l' \<in> dom f. l \<noteq> l'" 
using flg0 by force
        then obtain l' where l'indom: "l' \<in> dom f" and l'eq: "l' = l + the (f l)" and noteq: "l\<noteq>l'" 
          using * by (metis add_0_iff flg0 less_not_refl)
        then have "non_abut 
                      (locs_of l                  (the (f    l))) 
                      (locs_of (l + (the (f l)))  (the (f ( (l + (the (f l)))))))"
                    by (metis lindom non_abutting)  
        then have non_abut_rhs: "(\<forall>l1\<in>locs_of l (the (f l)). \<forall>l2\<in>locs_of (l + the (f l)) (the (f (l + the (f l)))). 
            l1 + 1 < l2 \<or> l2 + 1 < l1)" unfolding non_abut_def by simp
        (* Now we choose our witnesses carefully *)
        obtain l1 where l1locs: "l1 \<in> locs_of l (the (f l))" 
                (*          and *)
                          and l1shape: "l1 = l + (the (f l)) - 1"
                (*          and l2shape: "l2 = l + the (f l)" *)
                     by (metis `l + the (f l) - 1 \<in> locs_of l (the (f l))`)
       obtain l2 where l2locs: "l2\<in>locs_of (l + the (f l)) (the (f (l + the (f l))))"
                 and l2shape: "l2 = l + the (f l)"
            using *  by (auto simp: l_dom_in_locs_of nat1f)
       from  non_abut_rhs have "(l+ the (f l) - 1) + 1 < l + the (f l) \<or> l + the (f l) + 1 < (l+ the (f l) - 1)"
       using l1locs apply (erule_tac x="l1" in ballE)
       using l2locs apply (erule_tac x="l2" in ballE)
         by (simp_all add: l1shape l2shape)
       then show "False" by auto
     qed
   qed
  qed
qed

lemma non_abut_Disjoint: 
  assumes non_abutting: "\<forall> l \<in> dom f. \<forall> l' \<in> dom f. l\<noteq>l' \<longrightarrow> non_abut (locs_of l (the (f l)))
      (locs_of l' (the (f l')))"
   shows "Disjoint f"
   unfolding Disjoint_def
proof(intro ballI impI)
  fix l l'
  assume lindom: "l \<in> dom f" and l'indom: "l' \<in> dom f" and noteq: "l \<noteq> l'"
  show "disjoint (Locs_of f l) (Locs_of f l')"
  proof -  
    from non_abutting
    have "non_abut (locs_of l (the (f l))) (locs_of l' (the (f l')))" 
      using lindom l'indom noteq by (auto)
    then show ?thesis unfolding non_abut_def Locs_of_def
     by (simp add: lindom l'indom)
  qed
qed
(* Takes two sets. Shows none of the elements map *)


lemma non_abut_VDM_inv: 
 assumes non_abutting: "\<forall> l \<in> dom f. \<forall> l' \<in> dom f. l\<noteq>l' \<longrightarrow> non_abut (locs_of l (the (f l)))
      (locs_of l' (the (f l')))"
  and nat1f: "nat1_map f"
 shows "VDM_F1_inv f"
 unfolding VDM_F1_inv_def
  by (metis nat1f non_abut_Disjoint non_abut_sep non_abutting)


 
(****************** Lemmas about contig ***************************** *)
lemma min_contig: 
fixes m l :: nat
assumes atleastone: "l>0" (* Assumption needed *)
shows "Min {i\<Colon>nat. m \<le> i \<and> i < m + l} = m"
proof (induct l rule: nat_nonzero_induct)
  have "{i\<Colon>nat. m \<le> i \<and> i < m + (1\<Colon>nat)} = {m}" by auto
  then show "Min {i. m \<le> i \<and> i < m + 1} = m" by simp 
  next
  show "0 < l" by (rule atleastone)
 next
  fix x
  assume *: "0<x"
  and  ind_hyp: "Min {i\<Colon>nat. m \<le> i \<and> i < m + x} = m"
  show "Min {i\<Colon>nat. m \<le> i \<and> i < (m + (x+  1))} = m" 
  proof -
    have **: "{i\<Colon>nat. m \<le> i \<and> i < (m + (x + 1))} = {i\<Colon>nat. m \<le> i \<and> i < m + x} \<union> {m+x}"
      by auto
    then have "Min {i\<Colon>nat. m \<le> i \<and> i < Suc (m + x)} =
     Min ({i\<Colon>nat. m \<le> i \<and> i < m + x} \<union> {m+x})" by auto
    also have "...=  min (m+x) (Min {i\<Colon>nat. m \<le> i \<and> i < m + x})"
     by (subst Min_insert [symmetric], auto simp add: *)
    also have "...= min (m+x) m" using ind_hyp by auto
    finally show ?thesis using * by auto
  qed
qed

(* Same idea - induction - easier as we do not have to assume nonzeroness *)
lemma card_contig: "card {i\<Colon>nat. m \<le> i \<and> i < m + l} = l"
proof (induct l)
  show base:  "card {i\<Colon>nat. m \<le> i \<and> i < m + (0\<Colon>nat)} = (0\<Colon>nat)"
   by simp
 next
  fix l
  assume ind_hyp: "card {i\<Colon>nat. m \<le> i \<and> i < m + l} = l"
  show "card {i\<Colon>nat. m \<le> i \<and> i < m + Suc l} = Suc l"
  proof -
    have  "{i\<Colon>nat. m \<le> i \<and> i < m + Suc l} =  {i\<Colon>nat. m \<le> i \<and> i < m + l} \<union> {m+l}"
     by auto
    from this ind_hyp show ?thesis by auto
  qed
qed


(* Lemmas for adaquecy *)

(* The retrieve function on the empty map is the empty set *)
lemma retr0_empty: "retr0 empty = {}"
unfolding retr0_def locs_def nat1_map_def
by auto

lemma empty_retr0: "nat1_map x \<Longrightarrow> retr0 x = {} \<Longrightarrow> x = empty"
unfolding retr0_def locs_def apply simp 
by (metis empty_iff k_in_locs_iff l_map_non_empty_has_elem_conv 
  not_dom_not_locs_weaken) 


lemma mapdom_in_retr: "x\<in>dom f \<Longrightarrow> the (f x) > 0 \<Longrightarrow>
                     nat1_map f \<Longrightarrow> x \<in> (retr0 f)"
unfolding retr0_def locs_def locs_of_def by auto

lemma non_empty_nat1_card: "finite F \<Longrightarrow> F \<noteq> {} \<Longrightarrow> card F > 0" 
  by auto

(* HERE:  FIX ME *)
lemma eq_locs: (* Same lemma? *)
 assumes finF: "finite F'"
  and nonempF: " F' \<noteq> {}"
  and contig: "contiguous F'"  
 shows "locs_of (Min F') (card F') = F'"
proof - 
  from finF nonempF have "nat1 (card F')" unfolding nat1_def
   by (rule non_empty_nat1_card)
  from contig obtain m l where  F'shape: "F' = locs_of m l" and lgrzero: "l >0"
   unfolding contiguous_def by auto
  then have "m = Min (F')"
     by (simp add: locs_of_def F'shape min_contig lgrzero)
  moreover have "l = card F'"
    by (simp add: F'shape locs_of_def lgrzero card_contig)
  ultimately show ?thesis using F'shape by blast 
qed

(**************************** MAIN THEOREM ***********************************)

(*
 * Questions:
 * 1) Should this be packed up first as a def? 
 * 2) Why the exists unique?
 * Note: in level 0 basic as this is a theorem about the state only...
 *)
(* Proving in the locale to get the assumptions: *)
lemma (in level0_basic) free1_adequacy:
shows "\<exists>! f1. (f0 = retr0 f1 \<and> F1_inv f1)"
proof -
  (* First grab the assumptions *)
  from  l0_invariant_def have finf0: "finite f0" by (metis F0_inv_defs)
  from l0_input_notempty_def have nat1s1: "nat1 s0" by metis
  from finf0 show ?thesis
  proof (induct rule: contig_nonabut_finite_set_induct)
    case empty  (* BASE CASE *)
    (* Here's my witness: f1 = the empty map *)
    show "\<exists>!f1. {} = retr0 f1 \<and> F1_inv f1"  
    proof(rule_tac a="empty" in ex1I, rule conjI)
      show "{} = retr0 Map.empty"  by (simp only: retr0_empty)
     next
      show "F1_inv Map.empty"  by (simp only: F1_inv_empty)
     next
      fix x
      assume "{} = retr0 x \<and> F1_inv x"
      then show "x = empty" 
        by (metis empty_retr0 invF1_nat1_map_weaken)
    qed
   next
    fix F F'
    assume F'_finite: "finite F'"
    and notemp: "F' \<noteq> {}"
    and F'_contig: "contiguous F'"
    and F'_nonabut: "non_abut F F'"
    and exist_hyp: "\<exists>!f1. F = retr0 f1 \<and> F1_inv f1"
    from exist_hyp obtain f1hook  (* Instantiate the induction hypothesis *)
    where ind_hyp_retr: "F = retr0 f1hook"
     and ind_hyp_inv: "F1_inv f1hook"
     and ind_hyp_nat1: "nat1_map f1hook" by auto
   show "\<exists>!f1. F \<union> F' = retr0 f1 \<and> F1_inv f1" 
   proof(rule_tac a="(f1hook \<union>m [Min(F') \<mapsto> card F'])" in ex1I, rule conjI)
     (* General facts *)
     have nonzerorange: "\<forall>l \<in> dom f1hook. (the (f1hook l)) > 0"
         by (metis nat1_def nat1_map_def ind_hyp_nat1)
       have non_intersect: "F \<inter> F' = {}" 
          by (metis F'_nonabut non_abut_def disjoint_def)
       have domsubsetretr: "dom f1hook \<subseteq> retr0 f1hook"
       proof
         fix x assume indom: "x \<in> dom f1hook" 
         then show "x \<in> retr0 f1hook"
         proof (rule mapdom_in_retr)
           show "0 < (the (f1hook x))"
              using nonzerorange indom by auto (* First INSTANCE of nat1*)
          next
           show "nat1_map f1hook" by (rule ind_hyp_nat1)
         qed
       qed
     then have subsetF: "dom f1hook \<subseteq> F" using ind_hyp_retr by auto
     have min_notin_f1hook: "Min F' \<notin> dom f1hook" 
     proof -
       have "Min F' \<in> F'" 
        using notemp F'_finite by auto
       then have *: "Min F' \<notin> F" 
        using non_intersect by auto
       have "Min F' \<notin> dom (f1hook)" using  subsetF  * by auto (* Add here *)
       thus ?thesis by simp
     qed
     have nat1_card_F': "nat1 (card F')"
        by (metis F'_finite bot_less bot_nat_def card_eq_0_iff nat1_def notemp)
     show "F \<union> F' = retr0 (f1hook \<union>m [Min F' \<mapsto> card F'])"
     (* Part 1 of the proof. Show the shape of the retrieve function *)  
     (* Auxiliary lemmas *)
     proof -  
       have "F \<union> F' = retr0 (f1hook \<union>m [Min(F') \<mapsto> card F'])"
       proof -
         have dom_extend: "dom (f1hook \<union>m [Min(F') \<mapsto> card F']) 
                          = insert (Min(F')) (dom f1hook)"
            by (simp add: l_munion_dom min_notin_f1hook)
         have nat1_upd_state: "nat1_map (f1hook \<union>m [Min(F') \<mapsto> card F'])"
         by(rule unionm_singleton_nat1_map, 
                  simp_all add: ind_hyp_nat1 min_notin_f1hook nat1_card_F' del: nat1_def)
         then have "retr0 (f1hook \<union>m  [Min(F') \<mapsto> card F'])
                = (\<Union>s\<Colon>nat\<in>dom (f1hook \<union>m [Min F' \<mapsto> card F']).
               locs_of s (the ((f1hook \<union>m [Min F' \<mapsto> card F']) s)))"
            unfolding retr0_def locs_def by simp
         also have "(\<Union>s\<Colon>nat\<in>dom (f1hook \<union>m [Min F' \<mapsto> card F']). 
                        locs_of s (the ((f1hook \<union>m [Min F' \<mapsto> card F']) s)))
               =  (\<Union>s\<Colon>nat\<in>insert (Min F') (dom f1hook). 
                        locs_of s (the ((f1hook \<union>m [Min F' \<mapsto> card F']) s)))"
          by (simp only: dom_extend)
         also have "... =  locs_of (Min F') (the ((f1hook \<union>m [Min F' \<mapsto> card F']) (Min F'))) 
                    \<union> (\<Union>s\<Colon>nat\<in>dom f1hook. locs_of s (the ((f1hook \<union>m [Min F' \<mapsto> card F']) s)))"
            by (simp only: UN_insert)
         also have "... = F' \<union> (\<Union>s\<Colon>nat\<in>dom f1hook. locs_of s (the ((f1hook \<union>m [Min F' \<mapsto> card F']) s)))"
         (* Equational reasoning on the retrive function *)
         proof -
           (* Characterisation of F' *)
           have "F' = locs_of (Min F')  (card F')"
            by (metis F'_contig F'_finite eq_locs notemp)
           moreover have "the ((f1hook \<union>m [Min F' \<mapsto> card F']) (Min F')) = card F'"
           apply (subst l_munion_apply)
           apply (simp add: min_notin_f1hook)
           by simp
           ultimately show ?thesis by auto 
         qed (* Commuting the results *)
         also have "... =(\<Union>s\<Colon>nat\<in>dom f1hook. locs_of s (the ((f1hook \<union>m [Min F' \<mapsto> card F']) s))) \<union>  F'"  
          by blast
         also have "... = F \<union> F'"  (* Now showing the LHS above = F. *)
         proof -
           have "(\<Union>s\<in>dom f1hook. locs_of s (the ((f1hook \<union>m [Min F' \<mapsto> card F']) s))) = F"
           proof -
             have "\<forall>s \<in> dom f1hook.  
             locs_of s (the (f1hook s)) =  
             locs_of s (the ((f1hook \<union>m [Min F' \<mapsto> card F']) s))"
             apply (subst l_munion_apply)
             apply (metis Int_insert_right_if0 dom_eq_singleton_conv inf_bot_right min_notin_f1hook)
             by (smt domIff l_inmapupd_dom_iff min_notin_f1hook)
           (* This is the crucial lemma
              Though, really it should be an external AND more general lemma!!
          *) 
           thus ?thesis using ind_hyp_retr retr0_def locs_def nat1_upd_state ind_hyp_nat1
            by auto
         qed
         thus ?thesis by simp
       qed
       finally show ?thesis ..
     qed
     thus ?thesis .
   qed
   (* END FIRST PART!! *)
   from ind_hyp_inv show upd_inv: "F1_inv (f1hook \<union>m [Min F' \<mapsto> card F'])"
   proof   
    assume ind_sep: "sep f1hook" and ind_Disjoint: "Disjoint f1hook"
    and ind_finite: "finite (dom (f1hook))" and ind_nat1_map: "nat1_map f1hook"
    show ?thesis
    proof(rule invF1_shape)
    (* NAT 1 PART *)
     from min_notin_f1hook ind_hyp_nat1 nat1_card_F' 
      show nat1_ext: "nat1_map (f1hook \<union>m [Min F' \<mapsto> card F'])" 
      by (rule unionm_singleton_nat1_map)
    (* FINITE PART *)
     from min_notin_f1hook ind_finite show "finite (dom (f1hook \<union>m [Min F' \<mapsto> card F']))"
      by (rule unionm_singleton_finite ) 
      (* Main goals: SPE AND DISJOINT! Handled unformly by the lemma*)
    show "VDM_F1_inv (f1hook \<union>m [Min F' \<mapsto> card F'])"
    proof
     from min_notin_f1hook ind_sep show "sep (f1hook \<union>m [Min F' \<mapsto> card F'])"
      proof (rule unionm_singleton_sep)
        show "\<forall>l\<in>dom f1hook. l + the (f1hook l) \<notin> dom [Min F' \<mapsto> card F']"
        proof
          fix l assume lindom: "l \<in> dom f1hook"
          show "l + the (f1hook l) \<notin> dom [Min F' \<mapsto> card F']"
          proof
            assume *:  "l + the (f1hook l) \<in> dom [Min F' \<mapsto> card F']"
            have "l + (the (f1hook l)) = Min F'" 
              by (metis "*" l_inmapupd_dom_iff l_map_non_empty_has_elem_conv)
            then have "l + (the (f1hook l)) \<in> F'" 
              by (metis F'_finite Min_in notemp)
            obtain l1 where l1shape: "l1 = l + (the (f1hook l)) - 1" by simp
            have l1inF: "l1 \<in> F" apply (subst ind_hyp_retr)
            unfolding retr0_def locs_def using ind_nat1_map apply simp
            apply (rule_tac x="l" in bexI)
            apply (metis `l1 = l + the (f1hook l) - 1` lindom nat1_map_def top_locs_of)
            apply (rule lindom)
            done
            obtain l2 where l2shape: "l2 = l + the (f1hook l)" by simp
            have l2inF': "l2 \<in> F'" 
                by (metis `l + the (f1hook l) \<in> F'` `l2 = l + the (f1hook l)`)
           from F'_nonabut  have contra: "l1 + 1 < l2 \<or> l2 + 1 < l1" 
            unfolding non_abut_def using l1inF l2inF' by simp
           from contra l1shape l2shape show "False"
            by auto
         qed
         qed
        show "Min F' + card F' \<notin> dom f1hook"
          proof
            assume *:  "Min F' + card F' \<in> dom f1hook"
            have "Min F' + card F' - 1 \<in> F'" 
                by (metis F'_contig all_not_in_conv contiguous_def eq_locs locs_of_finite nat1_card_F' top_locs_of)
            obtain l1 where l1shape: "l1 = Min F' + card F'" by simp
            have l1inF: "l1 \<in> F" by (metis "*" `l1 = Min F' + card F'` set_mp subsetF)
            obtain l2 where l2shape: "l2 = Min F' + card F' - 1" by simp
            have l2inF': "l2 \<in> F'" by (metis `Min F' + card F' - 1 \<in> F'` `l2 = Min F' + card F' - 1`)
            from F'_nonabut have contra: "l1 + 1 < l2 \<or> l2 + 1 < l1" 
            unfolding non_abut_def using l1inF l2inF' by simp
           from contra l1shape l2shape show "False" by auto
           qed
      next
        show "nat1 (card F')" by (rule nat1_card_F')
    qed
       from min_notin_f1hook ind_Disjoint ind_nat1_map
       show "Disjoint (f1hook \<union>m [Min F' \<mapsto> card F'])"
      proof (rule unionm_singleton_Disjoint)
        show "nat1 (card F')" by (rule nat1_card_F')
        next
        show "disjoint (locs_of (Min F') (card F')) (locs f1hook)"
        by (metis F'_contig F'_finite disjoint_def eq_locs ind_hyp_retr 
            inf_commute non_intersect notemp retr0_def)
      qed
     qed
    qed
   qed
  (* Uniqueness! *)
   fix x assume *: "F \<union> F' = retr0 x \<and> F1_inv x"
   show "x = f1hook \<union>m [Min F' \<mapsto> card F']"
   proof (rule locs_unique)
     show "locs x = locs (f1hook \<union>m [Min F' \<mapsto> card F'])"
       by (metis "*" 
            `F \<union> F' = retr0 (f1hook \<union>m [Min F' \<mapsto> card F'])` retr0_def)
    next
     show "F1_inv x" using * by simp
    next
     show "F1_inv (f1hook \<union>m [Min F' \<mapsto> card F'])" by (rule upd_inv)
    next
     show "x \<noteq> Map.empty"
            by (metis (full_types) "*" empty_subsetI notemp retr0_empty
                sup.right_idem sup_absorb1 sup_commute)
    next
     show "f1hook \<union>m [Min F' \<mapsto> card F'] \<noteq> Map.empty" 
        by (metis l_munion_singleton_not_empty min_notin_f1hook)
   qed
  qed
 qed
qed
oops



theorem r_free01_widen_pre: 
  "PO_l01_new_widen_pre"
  unfolding PO_l01_new_widen_pre_def 
            new1_pre_def new0_pre_def
proof(intro allI conjI impI, elim conjE exE)
  fix f1 s1 l
  assume invf1: "F1_inv f1"
  and nat1s1: "nat1 s1"
  and new0pre: "is_block l s1 (retr0 f1)"
  have locs_subset: "locs_of l s1 \<subseteq> locs f1"
    by (metis is_block_def new0pre retr0_def)
  moreover have "l \<in> locs_of l s1" using nat1s1 
   by (simp add: b_locs_of_as_set_interval)
  ultimately have "l \<in> locs f1" by auto
  then have "l \<in>  (\<Union>s\<in>dom f1. locs_of s (the (f1 s)))"
   unfolding locs_def Locs_of_def 
    by (simp add: invf1 invF1_nat1_map_weaken)
  from locs_subset invf1 nat1s1 
  have "\<exists> m\<in> dom f1. locs_of l s1 \<subseteq> locs_of m (the (f1 m))"
    by (rule locs_locs_of_subset)  
  then obtain m where mindom: "m\<in>dom f1" and (* First thing I need *)
              locssubm: "locs_of l s1 \<subseteq> locs_of m (the (f1 m))"
    by auto
  then have mgrs1: "s1 \<le> the (f1 m)" (* Second thing I need *)  
  proof (cases "l=m")
    assume "l = m"
    then have "locs_of l s1 \<subseteq> locs_of l (the (f1 l))" by (metis locssubm)
    show ?thesis 
    proof (rule locs_of_subset_range)
      show " 0 < s1" by (metis nat1_def nat1s1) 
      show "0 < the (f1 m)" 
by (simp add: HEAP1LemmasIJW.invF1_nat1_map_weaken f_nat1_map_nat1_elem invf1 mindom)
      show "locs_of l s1 \<subseteq> locs_of l (the (f1 m))"
       by (metis `l = m` `locs_of l s1 \<subseteq> locs_of l (the (f1 l))`)
    qed
   next
    assume lnotm: "l \<noteq> m"
    have  "m < l"
    proof(rule ccontr)
      assume "\<not> m < l"  
      then have *: "m > l" by (metis lnotm nat_neq_iff)
      have "l \<notin> locs_of m (the (f1 m))" 
      apply (rule less_a_not_in_locs_of)
apply (simp add: HEAP1LemmasIJW.invF1_nat1_map_weaken f_nat1_map_nat1_elem invf1 mindom)
      by (simp add: *)
      thus "False" by (metis `l \<in> locs_of l s1` locssubm set_mp)
    qed
    show ?thesis
    proof (rule locs_of_subset_range_gr)
      show " 0 < s1" by (metis nat1_def nat1s1) 
      show "0 < the (f1 m)" 
by (simp add: HEAP1LemmasIJW.invF1_nat1_map_weaken f_nat1_map_nat1_elem invf1 mindom)
      show "locs_of l s1 \<subseteq> locs_of m (the (f1 m))"
       by (metis locssubm)
      show "m < l" by (metis `m < l`)   
    qed
  qed
  thus "\<exists>l\<in>dom f1. s1 \<le> the (f1 l)"
   by (metis mindom)
qed


(* Can I delete? *)
lemma strangesets: "B \<subseteq> A \<Longrightarrow> D \<subseteq> B \<Longrightarrow> (A - B) \<union> (B-D) = A-D"
by auto

theorem r_free01_narrow_post: 
  assumes invf1: "F1_inv f1"
  and invf1': "F1_inv f1'"
  and nat1s1: "nat1 s1" 
  and new0pre: "new0_pre (retr0 f1) s1"
  and new1post: "new1_post f1 s1 f1' r"
  shows "new0_post (retr0 f1) s1 (retr0 f1') r"
proof -
  from  new0pre new1post show ?thesis
   unfolding new0_post_def new1_post_def new0_pre_def new1_post_eq_def new1_post_gr_def retr0_def
  proof(elim disjE exE conjE, intro conjI)
    assume f1r: "the (f1 r) = s1" and rindom: "r \<in> dom f1"
    show "is_block r s1 (locs f1)"
     unfolding is_block_def
    proof
      show "nat1 s1" by (rule nat1s1)
     next
      show "locs_of r s1 \<subseteq> locs f1"
       by (metis invF1_nat1_map_weaken rindom f1r invf1 l_locs_of_within_locs)
    qed
   next
    assume *: "f1' = {r} -\<triangleleft> f1 " and rindom: "r \<in> dom f1" and f1r: "the (f1 r) = s1"
    show "locs f1' = locs f1 - locs_of r s1" 
    proof (subst *, subst dom_ar_locs)
      show "finite (dom f1)" by (metis invF1_finite_weaken invf1)
     next
      show " nat1_map f1" by (metis invF1_nat1_map_weaken invf1)
     next
      show "Disjoint f1"  by (metis invF1_Disjoint_weaken invf1)
     next
      show "r \<in> dom f1" by (rule rindom)
     next
      show "locs f1 - locs_of r (the (f1 r)) = locs f1 - locs_of r s1"
       by (simp add: f1r)
    qed
   next
    fix l
    assume  isblockl: "is_block l s1 (locs f1)" 
          and rindom: "r \<in> dom f1 "
          and s1less: "s1 < the (f1 r)" 
          and f1'shape: "f1' = {r} -\<triangleleft> f1 \<union>m [r + s1 \<mapsto> the (f1 r) - s1]"
    show "is_block r s1 (locs f1) \<and> locs f1' = locs f1 - locs_of r s1"
    proof
      show "is_block r s1 (locs f1)"
       unfolding is_block_def
      proof
        show "nat1 s1" by (rule nat1s1)
       next
        show " locs_of r s1 \<subseteq> locs f1"
        proof -
          have " locs_of r s1 \<subseteq> locs_of r (the (f1 r))" 
            by (metis Diff_subset less_trans locs_of_minus nat1_def nat1s1 s1less)   
          moreover have "locs_of r (the (f1 r)) \<subseteq> locs f1" 
            by (metis invF1_nat1_map_weaken `r \<in> dom f1` invf1 l_locs_of_within_locs)
          ultimately show ?thesis by simp
        qed
      qed
     next
      show "locs f1' = locs f1 - locs_of r s1"
      proof (subst f1'shape)
      show  "locs ({r} -\<triangleleft> f1 \<union>m [r + s1 \<mapsto> the (f1 r) - s1]) = locs f1 - locs_of r s1"
      proof (subst locs_unionm_singleton)
        show "nat1 (the (f1 r) - s1)" by (metis diff_is_0_eq nat1_def neq0_conv not_le s1less)
       next
        show "nat1_map ({r} -\<triangleleft> f1)" by (metis invF1_nat1_map_weaken dom_ar_nat1_map invf1)
       next
        show " r + s1 \<notin> dom ({r} -\<triangleleft> f1)" by (metis invf1 l_dom_ar_notin_dom_or l_plus_s_not_in_f nat1s1 rindom s1less)
       next
        show " locs ({r} -\<triangleleft> f1) \<union> locs_of (r + s1) (the (f1 r) - s1) = locs f1 - locs_of r s1"     
        proof (subst dom_ar_locs)
          show "finite (dom f1)" by (metis invF1_finite_weaken invf1)
         next
          show " nat1_map f1" by (metis invF1_nat1_map_weaken invf1)
         next
          show "Disjoint f1"  by (metis invF1_Disjoint_weaken invf1)
         next
          show "r \<in> dom f1" by (rule rindom)
         next (* Difficult goal *)
          show "locs f1 - locs_of r (the (f1 r)) \<union> locs_of (r + s1) (the (f1 r) - s1) = locs f1 - locs_of r s1"
          proof -
            have " locs_of r s1 =  locs_of r (the (f1 r)) - locs_of (r+s1) ((the (f1 r)) - s1)"
             by (metis add_0_iff invf1 l_plus_s_not_in_f less_trans locs_of_minus nat1s1 neq0_conv rindom s1less)
            have **: " locs_of (r+s1) ((the (f1 r)) - s1) = locs_of r (the (f1 r)) -  locs_of r s1 "
              by (metis `locs_of r s1 = locs_of r (the (f1 r)) - locs_of (r + s1) (the (f1 r) - s1)` double_diff locs_of_subset nat1_def s1less subset_refl zero_less_diff)         
            show ?thesis 
            proof (subst **,subst strangesets)
              show "locs_of r (the (f1 r)) \<subseteq> locs f1" 
                by (metis invF1_nat1_map_weaken invf1 l_locs_of_within_locs rindom)
             next
              show " locs_of r s1 \<subseteq> locs_of r (the (f1 r))" 
                by (metis Diff_subset `locs_of r s1 = locs_of r (the (f1 r)) - locs_of (r + s1) (the (f1 r) - s1)`)
             next
              show " locs f1 - locs_of r s1 = locs f1 - locs_of r s1"
              by (rule refl)
            qed
          qed
        qed
      qed
    qed
  qed
qed (* Way too much nesting here! *)
qed

lemma "PO_l01_new_narrow_post"
  by (metis PO_l01_new_narrow_post_def r_free01_narrow_post)

lemma g2_subset: " B \<subseteq> A \<Longrightarrow> (A - B) \<union> (B \<union> C) = A \<union> C" by auto

lemma g3_lemma: "Y \<subseteq> X \<Longrightarrow> Z \<subseteq> X \<Longrightarrow> (X - Y - Z) \<union> (Z \<union> Y \<union> A) = X \<union> A"  
  by auto

(* DISPOSE REIFICATION *)
theorem r_free01_dispose_widen_pre: 
    "PO_l01_dispose_widen_pre"
    unfolding PO_l01_dispose_widen_pre_def 
              dispose1_pre_def
              disjoint_def retr0_def dispose0_pre_def
by simp (* Trivial! *)

(* Package in definition ?*)
lemma (in level1_dispose) r_free01_dispose_narrow_post: 
  assumes invf1: "F1_inv f1"
  and invf1': "F1_inv f1'"
  and nat1s1: "nat1 s1" 
  and dis0pre: "dispose0_pre (retr0 f1) d1 s1"
  and dis1post: "dispose1_post2 f1 d1 s1 f1'"
  shows "dispose0_post (retr0 f1) d1 s1 (retr0 f1')"
proof -
  from invf1 show ?thesis
  proof
    assume sepf1: " sep f1" and disjf1: "Disjoint f1" 
    and nat1f1: "nat1_map f1" and finitef1: "finite (dom f1)" 
    from invf1' show ?thesis
    proof
      assume sepf1': " sep f1'" and disjf1': "Disjoint f1'" 
      and nat1f1': "nat1_map f1'" and finitef1': "finite (dom f1')" 
      from dis1post show ?thesis
        unfolding dispose0_post_def
                  dispose1_post2_def
      proof -
        assume *: "f1' = (dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
           [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)]"
        show "retr0 f1' = retr0 f1 \<union> locs_of d1 s1"
        proof (subst *)
          from dis0pre have "locs_of d1 s1 \<inter> retr0 f1 = {}" by (metis dispose0_pre_def)
          then have d1notf1: "d1 \<notin> dom f1"
           by (metis IntI empty_iff l_locs_of_within_locs locs_of_extended 
            nat1_map_def nat1f1 nat1s1 retr0_def set_rev_mp top_locs_of top_locs_of2)
          show "retr0 ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
               [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)]) =
               retr0 f1 \<union> locs_of d1 s1"
          proof (cases "dispose1_below f1 d1 = empty")
            assume belowempty: "dispose1_below f1 d1 = Map.empty"
            show ?thesis
            proof  (cases "dispose1_above f1 d1 s1 = empty")
              assume aboveempty: "dispose1_above f1 d1 s1 = Map.empty"
              then show ?thesis         unfolding dispose1_ext_def retr0_def
              proof (simp add: aboveempty belowempty l_munion_empty_rhs l_munion_empty_lhs l_dom_ar_empty_lhs min_loc_singleton sum_size_singleton)
                show " locs (f1 \<union>m [d1 \<mapsto> s1]) = locs f1 \<union> locs_of d1 s1"
                proof (rule locs_unionm_singleton) 
                  show " nat1 s1" by (metis nat1s1)
                  show "nat1_map f1" by (metis nat1f1)
                  show "d1 \<notin> dom f1" by (rule d1notf1)
                qed
              qed
             next
              assume abovenotempty: " dispose1_above f1 d1 s1 \<noteq> Map.empty"
              have abovebelowshape: "(dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) = {d1+s1}"
               by (simp add: belowempty l_munion_empty_rhs l_munion_empty_lhs l_dom_ar_empty_lhs d1notf1
                 d1_not_dispose_above d1_not_dispose_below above_dom abovenotempty)
               have min_loc_shape: "min_loc (dispose1_ext f1 d1 s1) = d1" 
                by (metis belowempty l_map_non_empty_dom_conv min_below_empty)
               have "sum_size (dispose1_ext f1 d1 s1) = sum_size (dispose1_above f1 d1 s1) + s1"
                by (simp add: dispose1_ext_def belowempty l_munion_empty_rhs 
                  l_munion_empty_lhs l_dom_ar_empty_lhs d1notf1
                  d1_not_dispose_above d1_not_dispose_below sum_size_munion
                  finite_dispose1_above abovenotempty sum_size_singleton)
               then have sum_size_shape: "sum_size (dispose1_ext f1 d1 s1) = the(f1 (d1+s1)) + s1"
                by (simp add: above_sumsize abovenotempty)
               show ?thesis unfolding retr0_def
               proof (simp add: sum_size_shape min_loc_shape abovebelowshape)
                 show "locs ({d1 + s1} -\<triangleleft> f1 \<union>m [d1 \<mapsto> the (f1 (d1 + s1)) + s1]) = locs f1 \<union> locs_of d1 s1"
                 proof (subst locs_unionm_singleton)
                   show "nat1 (the (f1 (d1 + s1)) + s1)" by (metis nat1_dispose1_ext sum_size_shape)
                  next
                   show "nat1_map ({d1 + s1} -\<triangleleft> f1)" by (metis dom_ar_nat1_map nat1f1)
                  next
                   show " d1 \<notin> dom ({d1 + s1} -\<triangleleft> f1)" by (metis d1notinf1 l_dom_ar_notin_dom_or)
                  next
                   show " locs ({d1 + s1} -\<triangleleft> f1) \<union> locs_of d1 (the (f1 (d1 + s1)) + s1) = locs f1 \<union> locs_of d1 s1"
                   proof (subst dom_ar_locs, rule finitef1,rule nat1f1,rule disjf1)
                     show "d1 + s1 \<in> dom f1" by (metis above_d1s1_in_f1 abovenotempty) 
                    next (* Ah-ha! We've seen this goal before, well almost... we have a union on rhs instead of minus! *)
                     show " locs f1 - locs_of (d1 + s1) (the (f1 (d1 + s1))) \<union> locs_of d1 (the (f1 (d1 + s1)) + s1) 
                              = locs f1 \<union> locs_of d1 s1"
                     proof -  (* Using the fact that B subset A --> A \<union> (B \<union> C) = A \<union> C *)
                       have "locs_of (d1 + s1) (the (f1 (d1 + s1))) \<subseteq> locs f1" by (metis above_d1s1_in_f1 abovenotempty k_in_locs_iff nat1f1 subsetI)
                       moreover have  " locs_of d1 (the (f1 (d1 + s1)) + s1) =  
                         locs_of (d1 + s1) (the (f1 (d1 + s1))) \<union> locs_of d1 s1"
                       proof - 
                         have  " locs_of d1 (the (f1 (d1 + s1)) + s1) =  locs_of d1 (s1 + the (f1 (d1 + s1)))"
                          by (metis add.commute)
                         also have "... =  locs_of d1 s1 \<union> locs_of (d1 + s1) (the (f1 (d1 + s1)))"
                           by (metis above_d1s1_in_f1 abovenotempty locs_of_sum_range nat1_map_def nat1f1 nat1s1)
                         finally show ?thesis by auto
                       qed
                       ultimately show ?thesis by (simp add: g2_subset)
                     qed
                   qed
                 qed
               qed
             qed
        next
         assume belownotempty: "dispose1_below f1 d1 \<noteq> Map.empty"
         from belownotempty have "\<exists>x. x\<in>dom f1 \<and> x + the (f1 x) = d1"
         proof -
           have "dispose1_below f1 d1 \<noteq> empty" by (rule belownotempty)
           then have "{ x \<in> dom f1 . x + the(f1 x) = d1 } \<noteq> {}"
             by (metis (full_types) dispose1_below_def l_dom_r_nothing)
           thus ?thesis  by (smt empty_Collect_eq)
         qed  
         then obtain below where belowinf1: "below\<in>dom f1" 
                  and belowplusf1below: "below + the (f1 below) = d1"
               by metis
         then have below_in_dom: "below \<in> dom(dispose1_below f1 d1)"
           unfolding dispose1_below_def
         proof (subst l_dom_r_iff)
           show "below \<in> {x \<in> dom f1. x + the (f1 x) = d1} \<inter> dom f1"
            by (smt Int_Collect belowinf1 belowplusf1below inf_commute)
         qed
         have below_shape: "dispose1_below f1 d1 = [below \<mapsto> the (f1 below)]"
         proof
           fix x
           show "dispose1_below f1 d1 x = [below \<mapsto> the (f1 below)] x"
           proof (simp, intro allI impI conjI)
             from below_in_dom 
             show "dispose1_below f1 d1 below = Some (the (f1 below))"
              unfolding dispose1_below_def
             proof (subst f_in_dom_r_apply_the_elem)
               show "below \<in> dom f1" by (rule belowinf1)
              next
               show "below \<in> {x \<in> dom f1. x + the (f1 x) = d1}" 
                by (smt belowinf1 belowplusf1below mem_Collect_eq)
             qed(rule refl) (* Solve the silly goal from subst *)
            next
             assume xnoteqbelow: "x \<noteq> below" 
             show "dispose1_below f1 d1 x = None" (* NEed to show x \<notin> dom below *)
             proof(rule ccontr)
               assume "dispose1_below f1 d1 x \<noteq> None" then
               have con: "x \<in> dom (dispose1_below f1 d1)"
                 by auto
               from con have xindomrset: "x \<in> {x \<in> dom f1. x + the (f1 x) = d1}"
                 unfolding dispose1_below_def 
                 by (metis (full_types) l_in_dom_dom_r)
               then have xinf: "x\<in> dom f1" by (simp add: xindomrset)
               have xeqd1: "x + the (f1 x) = d1" 
                 by (metis (lifting, mono_tags) mem_Collect_eq xindomrset)
               (* Now I have below and x with the same properties belowplusf1below and belowinf1 *)
               from disjf1 have *: "locs_of x (the (f1 x)) \<inter>  locs_of below (the (f1 below)) = {}"
                 by (metis xnoteqbelow belowinf1 Disjoint_def 
                   disjoint_def l_locs_of_Locs_of_iff xinf)          
               have nat1below: " nat1 (the (f1 below))" by (metis nat1_map_def nat1f1 belowinf1)            
               have nat1x: " nat1 (the (f1 x))" by (metis nat1_map_def nat1f1 xinf)            
               from xinf xeqd1 belowplusf1below belowinf1 nat1x nat1below
               have **: "locs_of x (the (f1 x)) \<inter>  locs_of below (the (f1 below)) \<noteq> {}"
               by (metis IntI ex_in_conv top_locs_of)
               from * ** show "False" by simp (* Final proof by contradiction *)
             qed
           qed
         qed
         then have dom_below: "dom (dispose1_below f1 d1) = {below}" by simp
         have sum_size_below: "sum_size (dispose1_below f1 d1) = the (f1 below)"
           by (simp add: sum_size_singleton below_shape)
         show ?thesis
         proof (cases "dispose1_above f1 d1 s1 = empty")
           assume aboveempty: " dispose1_above f1 d1 s1 = Map.empty"
           have abovebelow_shape: "(dom (dispose1_below f1 d1)) \<union> (dom (dispose1_above f1 d1 s1)) 
                          = {below}"
                         by (simp add: aboveempty dom_below)
           have min_loc_shape: "min_loc (dispose1_ext f1 d1 s1) = below"
             by (metis dom_below insert_not_empty min_below_notempty singleton_iff)
           have sum_size_shape: "sum_size (dispose1_ext f1 d1 s1) = the (f1 below) + s1"
             unfolding dispose1_ext_def 
             by (simp add: aboveempty l_munion_empty_lhs sum_size_munion sum_size_singleton 
            finite_dispose1_below belownotempty d1_not_dispose_below sum_size_below)
           show ?thesis unfolding retr0_def
           proof (simp add: sum_size_shape min_loc_shape abovebelow_shape)
         

           show " locs ({below} -\<triangleleft> f1 \<union>m [below \<mapsto> the (f1 below) + s1]) = locs f1 \<union> locs_of d1 s1"
             proof (subst locs_unionm_singleton)
               show "nat1 (the (f1 below) + s1)" by (metis nat1_dispose1_ext sum_size_shape)
              next
               show "nat1_map ({below} -\<triangleleft> f1)" by (metis dom_ar_nat1_map nat1f1)
              next
               show "below \<notin> dom ({below} -\<triangleleft> f1)" by (metis f_in_dom_ar_notelem)
              next
               show " locs ({below} -\<triangleleft> f1) \<union> locs_of below (the (f1 below) + s1) = locs f1 \<union> locs_of d1 s1"
               proof (subst dom_ar_locs, rule finitef1, rule nat1f1, rule disjf1)
                show " below \<in> dom f1" by (metis belowinf1)
               next
                show "locs f1 - locs_of below (the (f1 below)) \<union> locs_of below (the (f1 below) + s1) = locs f1 \<union> locs_of d1 s1"
                proof -
                  have "locs_of below (the (f1 below)) \<subseteq> locs f1"
                    by (metis belowinf1 l_locs_of_within_locs nat1f1)
                  moreover have *: "below + the (f1 below) = d1" by (metis belowplusf1below)
                  moreover have "locs_of below (the (f1 below) + s1) = locs_of below (the (f1 below)) \<union>  locs_of d1 s1"
                  proof -
                    have "locs_of below ((the (f1 below)) + s1) = (locs_of below (the (f1 below))) \<union>  (locs_of (below + (the (f1 below)))) s1"
                     by (metis locs_of_sum_range belowinf1 nat1_map_def nat1f1 nat1s1)
                    also have "... = (locs_of below (the (f1 below))) \<union> locs_of d1 s1"
                      by (simp add: *)
                    finally show ?thesis .
                  qed
                  ultimately show ?thesis by (simp add: g2_subset)
                qed
              qed
            qed
          qed
         next
           assume abovenotempty: "dispose1_above f1 d1 s1 \<noteq> Map.empty"
           have above_below_shape: "(dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1))
                       = {below,d1+s1}"
             by (metis Un_insert_left above_dom abovenotempty dom_below sup_bot_left)
           have min_loc_shape:  "min_loc (dispose1_ext f1 d1 s1)  = below"
             by (metis dom_below insert_not_empty min_below_notempty singleton_iff)
           have sum_size_shape: "sum_size  (dispose1_ext f1 d1 s1)
                              =   the (f1 (d1 + s1)) + the (f1 below) + s1"
           proof -  
             have sum_size_above_below: "sum_size (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1)
                            =  the (f1 (d1 + s1)) + the (f1 below)"
              by (simp add: sum_size_munion  finite_dispose1_above finite_dispose1_below abovenotempty
                belownotempty above_sumsize sum_size_below)
             then show ?thesis unfolding dispose1_ext_def
             proof (subst sum_size_munion)
               show "finite (dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1))" and
                 "finite (dom [d1 \<mapsto> s1])" 
               by (simp_all add:  finite_dispose1_above finite_dispose1_below k_finite_munion)
              next
               show " dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1 \<noteq> empty"
                and "[d1 \<mapsto> s1] \<noteq> empty"
                by (auto simp: munion_notempty_right belownotempty) 
              next 
               from d1_not_above_below show "dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1) \<inter> dom [d1 \<mapsto> s1] = {}"
                by simp
              next  
               show "sum_size (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1) + sum_size [d1 \<mapsto> s1] 
                     = the (f1 (d1 + s1)) + the (f1 below) + s1"
                   by (simp add:  sum_size_above_below sum_size_singleton)
             qed
           qed
           show ?thesis unfolding retr0_def
           proof (simp add: sum_size_shape min_loc_shape above_below_shape, subst locs_unionm_singleton)
             show " nat1 (the (f1 (d1 + s1)) + the (f1 below) + s1)" by (metis nat1_dispose1_ext sum_size_shape)
            next
             show "nat1_map ({below, d1 + s1} -\<triangleleft> f1)" by (metis dom_ar_nat1_map nat1f1)
            next
             show "below \<notin> dom ({below, d1 + s1} -\<triangleleft> f1)" by (metis insertI1 l_dom_ar_notin_dom_or)
            next


             show "locs ({below, d1 + s1} -\<triangleleft> f1) 
                \<union> locs_of below (the (f1 (d1 + s1)) + the (f1 below) + s1) 
                                              = locs f1 \<union> locs_of d1 s1"
             proof -
               have *: "(locs ({below, d1 + s1} -\<triangleleft> f1)) = locs ( {below} -\<triangleleft> ({d1 + s1} -\<triangleleft> f1))"
                 by (metis Un_empty_left Un_insert_left l_dom_ar_accum)
               show ?thesis 
                proof (subst *, subst dom_ar_locs)
                  show " finite (dom ({d1 + s1} -\<triangleleft> f1))" by (metis finite_Diff finitef1 l_dom_dom_ar)
                 next
                  show "nat1_map ({d1 + s1} -\<triangleleft> f1)" by (metis dom_ar_nat1_map nat1f1)
                 next
                  show "Disjoint ({d1 + s1} -\<triangleleft> f1)" by (metis disjf1 dom_ar_Disjoint)
                 next
                  show "below \<in> dom ({d1 + s1} -\<triangleleft> f1)"
                    by (metis (mono_tags) after_locs_of_not_in_locs belowinf1 belowplusf1below 
                      inf.commute inf_nat_def l1_invariant_def l_in_dom_ar nat1f1 nat_min_absorb1 
                      not_dom_not_locs_weaken singletonE)
                 next
                  show " locs ({d1 + s1} -\<triangleleft> f1) - locs_of below (the (({d1 + s1} -\<triangleleft> f1) below)) \<union> 
                          locs_of below (the (f1 (d1 + s1)) + the (f1 below) + s1)
                          =  locs f1 \<union> locs_of d1 s1"
                  proof (subst dom_ar_locs, rule finitef1, rule nat1f1, rule disjf1)
                    show "d1 + s1 \<in> dom f1" by (metis above_d1s1_in_f1 abovenotempty)
                   next
                    (* Final, complicated goal *)
                     have *: "the (({d1 + s1} -\<triangleleft> f1) below) = the (f1 below)" 
                      by (metis belowplusf1below d1notinf1 domIff dom_antirestr_def inf.commute inf_nat_def nat_min_absorb1 singletonE)
                     show "locs f1 - locs_of (d1 + s1) (the (f1 (d1 + s1)))
                        - locs_of below (the (({d1 + s1} -\<triangleleft> f1) below))
                        \<union>  locs_of below (the (f1 (d1 + s1)) + the (f1 below) + s1)
                         =  locs f1 \<union> locs_of d1 s1"
                     proof(subst *)
                       have "locs_of below (the (f1 (d1 + s1)) + the (f1 below) + s1)
                            = locs_of below  (the (f1 below) + (the (f1 (d1 + s1)) + s1))"
                         by (metis add.commute add.left_commute)
                       also have "... =  (locs_of below (the (f1 below))) \<union> 
                        (locs_of (below + (the (f1 below)))  (the (f1 (d1 + s1)) + s1))"
                                apply (subst locs_of_sum_range)
                                apply (metis belowinf1 nat1_map_def nat1f1)
                                apply (simp add: nat1s1)
                                apply (rule disjI2)
                                apply (metis nat1_def nat1s1)
                                by simp
                        also have "... = (locs_of below (the (f1 below)))
                                  \<union> (locs_of d1  (s1 + the (f1 (d1 + s1))))"
                          by (metis belowplusf1below add.commute)
                        also have "... = (locs_of below (the (f1 below)))
                          \<union> (locs_of d1 s1) \<union> (locs_of (d1+s1) (the (f1 (d1 + s1))))"
                          apply (subst locs_of_sum_range)
                          apply (metis nat1s1)  
                          apply (metis above_d1s1_in_f1 abovenotempty nat1_map_def nat1f1)
                          by auto
                        finally have ***: "locs_of below (the (f1 (d1 + s1)) + the (f1 below) + s1)
                            = (locs_of below (the (f1 below)))
                              \<union> (locs_of (d1+s1) (the (f1 (d1 + s1))))  \<union> (locs_of d1 s1)"
                          by auto
                        show "locs f1 - locs_of (d1 + s1) (the (f1 (d1 + s1))) - locs_of below (the (f1 below)) \<union> locs_of below (the (f1 (d1 + s1)) + the (f1 below) + s1) =
                          locs f1 \<union> locs_of d1 s1"
                        proof (subst ***)
                          show "locs f1 - locs_of (d1 + s1) (the (f1 (d1 + s1))) - locs_of below (the (f1 below)) \<union>
                              (locs_of below (the (f1 below)) \<union> 
                                locs_of (d1 + s1) (the (f1 (d1 + s1))) \<union> locs_of d1 s1) =
                                locs f1 \<union> locs_of d1 s1"
                          proof(subst g3_lemma)
                            show " locs_of (d1 + s1) (the (f1 (d1 + s1))) \<subseteq> locs f1" by (metis above_d1s1_in_f1 abovenotempty l_locs_of_within_locs nat1f1)
                           next
                            show "locs_of below (the (f1 below)) \<subseteq> locs f1" by (metis belowinf1 l_locs_of_within_locs nat1f1)
                           next
                            show " locs f1 \<union> locs_of d1 s1 = locs f1 \<union> locs_of d1 s1" by (rule refl)
                          qed
                        qed
                      qed
                    qed
                  qed
                qed
              qed
            qed
          qed
        qed
      qed
    qed
  qed
qed



end

