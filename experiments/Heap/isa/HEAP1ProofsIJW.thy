(* $Id$ *)
theory HEAP1ProofsIJW
imports  HEAP1LemmasIJW HEAP1Lemmas
begin


(* ==================== NEW 1 Feasibility =================== *)
(* THE FOLLOWING 3 LEMMAS AND THEOREM ARE THE PARTS OF NEW1 FSB *)

(* SPECIFIC INVARIANT PROPERTY FOR FEASABILITY PO *)
lemma F1_inv_restr_unionm:
  assumes inv: "F1_inv f" and nat1s: "nat1 s" and l_in_dom: "l \<in> dom f"
  and f_bigger_s: "the(f l) > s" (* Needed for the nat1 property? *)
  shows "F1_inv (({l} -\<triangleleft> f) \<union>m [l + s \<mapsto> the(f l) - s])"
  proof - 
  from inv show ?thesis
  proof  
  assume disjf1: "Disjoint f"
   and sepf1: "sep f" 
   and nat1_mapf1: "nat1_map f" 
   and finitef1: "finite (dom f)"
  (* IMPORTANT FOR THE RULES *)
  have disjoint_dom: "l+s \<notin> dom ({l} -\<triangleleft> f)" 
  proof (rule l_dom_ar_not_in_dom)
    show "l+s \<notin> dom f"
    proof (rule l_plus_s_not_in_f)
      show "F1_inv f" and "l \<in> dom f" and "s < the (f l)" and "nat1 s"
      by (simp_all del: nat1_def add: inv nat1s l_in_dom f_bigger_s)
    qed
  qed
  (* For any element in f, l+s does not abut on the rhs *)
  have noteqls: "\<forall> x \<in> dom f. x + (the (f x)) \<noteq> l + s"
  proof
    fix x assume x_in_dom: "x \<in> dom f"
    show "x + the (f x) \<noteq> l + s"
    proof (cases "x=l")
      assume "x=l"
      then show ?thesis using f_bigger_s by simp
     next
      assume xnotl: "x \<noteq> l"
      from disjf1 have "locs_of x (the (f x)) \<inter> locs_of l (the (f l)) = {}"
       unfolding Disjoint_def disjoint_def Locs_of_def
        by (auto simp: x_in_dom xnotl l_in_dom)
      moreover have "l+s - 1  \<in> locs_of l (the (f l))" 
        by (metis f_bigger_s nat1s top_locs_of2)
      moreover have "x + the (f x) - 1 \<in> locs_of x (the (f x))"
        by (metis nat1_map_def nat1_mapf1 top_locs_of x_in_dom)
      ultimately have "x + the (f x) - 1 \<noteq> l+s - 1" by auto
      thus ?thesis by simp
    qed
  qed
  show ?thesis
  proof
    from disjoint_dom show nat1_conc: "nat1_map ({l} -\<triangleleft> f \<union>m [l + s \<mapsto> the (f l) - s])"
    proof(rule unionm_singleton_nat1_map)
      show "nat1_map ({l} -\<triangleleft> f)" using nat1_mapf1 by (rule dom_ar_nat1_map)
     next
      show "nat1 (the (f l) - s)" using f_bigger_s by simp
    qed
   next
    from disjoint_dom show "finite (dom ({l} -\<triangleleft> f \<union>m [l + s \<mapsto> the (f l) - s]))"
    proof (rule unionm_singleton_finite)
      show "finite (dom ({l} -\<triangleleft> f))"  
        using finitef1 by (rule dom_ar_finite)
    qed
   next
(********* Families of proof: base example **********)
   (* hyp: sep f *) 
    from disjoint_dom show "sep ({l} -\<triangleleft> f \<union>m [l + s \<mapsto> the (f l) - s])"
    proof (rule unionm_singleton_sep)
      show "sep ({l} -\<triangleleft> f)" using sepf1 by (rule dom_ar_sep)
     next
      show "\<forall>la\<in>dom ({l} -\<triangleleft> f). la + the (({l} -\<triangleleft> f) la) \<notin> dom [l + s \<mapsto> the (f l) - s]"
        by (metis dom_eq_singleton_conv f_in_dom_ar_subsume 
            f_in_dom_ar_the_subsume noteqls singletonE)   
     next
      show "l + s + (the (f l) - s) \<notin> dom ({l} -\<triangleleft> f)"
      proof -
        have myfact: "l + the (f l)  \<notin> dom(f)" using l_in_dom sepf1 sep_def by auto
        have "l + the (f l) \<notin> dom({l} -\<triangleleft> f)" by (metis l_dom_ar_not_in_dom myfact)
        then show ?thesis 
by (simp add: f_bigger_s less_imp_le)
      qed
     next
      show "nat1 (the (f l) - s)" 
        using nat1_mapf1 f_bigger_s by auto
    qed
  next
  (************** COMBINATORY SKETCH **************************)
  show "Disjoint ({l} -\<triangleleft> f \<union>m [l + s \<mapsto> the (f l) - s])" (* TOP LEVEL GOAL *)
  proof (rule unionm_singleton_Disjoint)
    show "Disjoint ({l} -\<triangleleft> f)" using disjf1 by (rule dom_ar_Disjoint)
   next
    show "nat1_map ({l} -\<triangleleft> f)"  using nat1_mapf1 by (rule dom_ar_nat1_map)
   next
    show nat1fminuss: "nat1 (the (f l) - s)" by (simp add: f_bigger_s)
   next
    show "l + s \<notin> dom ({l} -\<triangleleft> f)" 
      by (metis f_bigger_s f_in_dom_ar_subsume inv l_in_dom l_plus_s_not_in_f nat1s)
   next
  (*
  Sketch example showing a particular locs_of and locs is disjoint.
  Origin of the goal is the Disjoint part of the invariant
  *) 
(* LF: no longer allowing quick and dirty? 
  (* Occurrence of a proof sketch. Combinatory sketch: uses moreover. *)
  have "disjoint  (locs_of (l + s) (the (f l) - s))    (locs ({l} -\<triangleleft> f))"
    proof -    
      have "(locs_of (l + s) (the (f l) - s)) \<subseteq> locs_of l (the (f l))" (* SKETCH G1 *)
       sorry
      moreover have "locs_of l (the (f l)) \<inter>  (locs ({l} -\<triangleleft> f)) = {}" (* SKETCH G2 *)
       sorry
     ultimately show ?thesis (* SKETCH Conclusion + automation *)
         by (smt Int_absorb1 Int_assoc Int_commute Int_empty_left disjoint_def) 
   qed
*)
  (* FILLED IN SKETCH *)
    show "disjoint (locs_of (l + s) (the (f l) - s)) (locs ({l} -\<triangleleft> f))"
    proof -    
      have "(locs_of (l + s) (the (f l) - s)) \<subseteq> locs_of l (the (f l))" (* SKETCH G1 *)
        by (rule locs_of_subset,simp add: f_bigger_s)
      moreover have "locs_of l (the (f l)) \<inter>  (locs ({l} -\<triangleleft> f)) = {}" (* SKETCH G2 *)
      proof (subst l_locs_of_dom_ar)
        show "nat1_map f" and "Disjoint f" and "l \<in> dom f" (* Package up simple goals *)
          by (simp_all add: l_in_dom nat1_mapf1 disjf1)
        next (* HERE is the one to solve, but still easy *)
        show "locs_of l (the (f l)) \<inter> (locs f - locs_of l (the (f l))) = {}" 
            by simp
      qed
     ultimately show ?thesis (* SKETCH Conclusion + automation *)
        by (smt Int_absorb1 Int_assoc Int_commute Int_empty_left disjoint_def)
    qed
   qed
  qed
 qed 
qed

(* LEMMAS MANUALLY ADDED FOR WALK THROUGH *)

lemma disjoint_munion_ijw:
 assumes ind_hypf: "Disjoint f"
 and ind_hypg: "Disjoint g"
 and disj_dom: "dom f \<inter> dom g = {}"
 and disjointl: "\<forall>x \<in> dom f. \<forall> y \<in> dom g. x\<noteq> y \<longrightarrow> disjoint (locs_of x (the (f x))) (locs_of y (the (g y)))"
 and disjointr: "\<forall>x \<in> dom g. \<forall> y \<in> dom f. x \<noteq> y \<longrightarrow> disjoint (locs_of x (the (g x))) (locs_of y (the (f y)))"
 shows "Disjoint (f \<union>m g)"
unfolding Disjoint_def
proof(intro ballI impI)
  fix a b
  assume aindomfg: "a \<in> dom (f \<union>m g)"
  and bindomfg: "b \<in> dom (f \<union>m g)"
  and anotb: "a \<noteq> b"
  have "disjoint (locs_of a (the ((f \<union>m g) a))) (locs_of b (the ((f \<union>m g) b)))"
  proof (cases "a \<in> dom f")
    assume ainf: "a \<in> dom f"
    then have anoting: "a \<notin> dom g" using aindomfg by (metis disj_dom disjoint_iff_not_equal)
    show ?thesis
    proof(cases "b \<in> dom f")
      assume binf: "b \<in> dom f"
      then have bnoting: "b \<notin> dom g" by (metis disj_dom disjoint_iff_not_equal)
      moreover have "disjoint (locs_of a (the (f a))) (locs_of b (the (f b)))"
        by (metis Disjoint_def ainf anotb binf ind_hypf l_locs_of_Locs_of_iff)
      ultimately show ?thesis by (metis anoting disj_dom l_munion_apply) 
     next
      assume bnotinf: "b \<notin> dom f"
      then have bing: "b \<in> dom g" by (metis bindomfg disj_dom unionm_in_dom_right)
      moreover have  "disjoint (locs_of a (the (f a))) (locs_of b (the (g b)))"
        by (metis ainf anotb bing disjointl)
      ultimately show ?thesis by (metis ainf disj_dom inf_commute l_munion_apply l_munion_commute)
    qed
   next
    assume anotinf: "a \<notin> dom f"
    then have aing: "a \<in> dom g" by (metis aindomfg disj_dom unionm_in_dom_right)
    show ?thesis
    proof (cases "b \<in> dom f")
      assume binf: "b \<in> dom f"
      then have  "disjoint (locs_of a (the (g a))) (locs_of b (the (f b)))"
        by (metis aing anotb disjointr) (* Could use disjointl with comm! *)
      then show ?thesis by (metis aing binf disj_dom l_munion_apply l_the_map_union)
     next
      assume bnotinf: "b \<notin> dom f"
      then have bing: "b \<in> dom g" by (metis bindomfg disj_dom unionm_in_dom_right)
      moreover have  "disjoint (locs_of a (the (g a))) (locs_of b (the (g b)))"
        by (metis Disjoint_def aing anotb bing ind_hypg l_locs_of_Locs_of_iff)
     ultimately show ?thesis by (metis aing disj_dom l_munion_apply) 
    qed
  qed
  thus "disjoint (Locs_of (f \<union>m g) a) (Locs_of (f \<union>m g) b)"
    by (metis aindomfg bindomfg l_locs_of_Locs_of_iff)
qed

(* WALK THROUGH PROOF *)

lemma F1_inv_restr_unionm: (* c1 *)
  "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> l \<in> dom f \<Longrightarrow> the(f l) > s \<Longrightarrow> F1_inv (({l} -\<triangleleft> f) \<union>m [l + s \<mapsto> the(f l) - s])"

(* S1: unfold to the right level (either via user input or emphFns) *)
apply (unfold F1_inv_def)
(* generates c2 *)
(* furthermore: applies auto to c2. Imagine it fails. *)

(* S2: structural breakdown to expose the individual invariant conditions *)
apply (elim conjE,intro conjI)
(* generates c3, c4, c5, c6 *)

(* S3: invariant breakdown - strange because either speculates or applies a lemma *)
find_theorems "Disjoint (_ \<union>m _)"
(* In this case we have a lemma, and apply it *)
apply (rule disjoint_munion_ijw)
(* generates c7,c8,c9,c10,c11 *)

(* now working on c7, say *)
apply simp
(* S4: actually another example of IB *)
apply (rule dom_ar_Disjoint)
(* generates c12 *)

(* automation is tried, and solves c12 *)
apply simp
oops
(* Now working on c8 *)

(* singleton_Disjoint *)

(* NEW 1 FEASIBILITY: Equals case *)
lemma (in level1_new) new1_post_feaseq:
 assumes pre_eq: "\<exists>l \<in> dom f1. the (f1 l) = s1"
 shows "\<exists> r f1new. new1_post_eq f1 s1 f1new r \<and> F1_inv f1new"
proof - 
	from pre_eq obtain l where ind: "l \<in> dom f1" and preinstance: "the (f1 l) = s1" ..
	obtain f1new where f1wit: "f1new = {l} -\<triangleleft> f1" by auto
	from ind and preinstance and f1wit have "l \<in> dom f1 \<and> the (f1 l) = s1 \<and> f1new = {l} -\<triangleleft> f1" by simp
	moreover from l1_invariant_def have "F1_inv f1new" by (simp only: dom_ar_F1_inv f1wit)
	ultimately show ?thesis using new1_post_eq_def by auto
qed



(* NEW 1 FEASIBILITY: greater case *)
lemma (in level1_new) new1_post_feasgr:
 assumes pre_gr: "\<exists>l \<in> dom f1. the (f1 l) > s1"
 shows "\<exists> r f1new. new1_post_gr f1 s1 f1new r \<and> F1_inv f1new"
proof - 
	from pre_gr obtain l where ind: "l \<in> dom f1" and preinstance: "the (f1 l) > s1" ..
	obtain f1new where f1wit: "f1new = ({l} -\<triangleleft> f1) \<union>m [l + s1 \<mapsto> the(f1 l) - s1]" by auto
	from ind and preinstance and f1wit 
	  have "l \<in> dom f1 \<and> the (f1 l) > s1 \<and> f1new = ({l} -\<triangleleft> f1) \<union>m [l + s1 \<mapsto> the(f1 l) - s1]" 
	  by simp
	moreover have "F1_inv f1new"
	proof - 
	have "F1_inv (({l} -\<triangleleft> f1) \<union>m [l + s1 \<mapsto> the(f1 l) - s1])"
	  by (rule F1_inv_restr_unionm, rule l1_invariant_def, rule l1_input_notempty_def, rule ind, rule preinstance) 
then show ?thesis by (simp only: f1wit)
  qed
	ultimately show ?thesis using new1_post_gr_def   by auto
qed


theorem (in level1_new)
  locale1_new_FSB: "PO_new1_feasibility"
unfolding PO_new1_feasibility_def

by (metis le_neq_implies_less 
           
          new1_post_def new1_post_feaseq 
          new1_post_feasgr 
          new1_postcondition_def 
          new1_pre_defs 
          l1_new1_precondition_def)

lemma hiddencase: "(m::nat) \<le> n = (m = n \<or> m < n)"
by (metis le_less)

(* Justif: JNEW1-FEAS-A1 *)
theorem 
  new1_feas_test_a1: "PO_new1_fsb"
apply (unfold PO_new1_fsb_def new1_post_def new1_pre_def new1_post_eq_def new1_post_gr_def)
apply auto
oops

(* Justif: JNEW1-FEAS-A2 *)
theorem 
  new1_feas_test_a2: "PO_new1_fsb"
apply(unfold PO_new1_fsb_def) (* Not a strategy: just getting to the PO *)

(* Strategy 1: structural breakdown *) 
apply(intro allI impI, elim conjE ) 

 (* Strategy 2: unfold to appropriate layer *) 
apply(unfold new1_pre_def new1_post_def new1_post_eq_def new1_post_gr_def)

(* APPLY Strategy 3a: existential witnessing; existential precondition *)
(* RESULT TOOLOP IS *)
apply (erule bexE)
apply (subst ex_comm) (* Swapping the orders *)
apply (rule_tac x=l in exI) 

(* Strategy 4a: existential witnessing; single point *)
apply (rule_tac x="{l} -\<triangleleft> f" in exI)

(* Strategy 5a: Split-Invariant-Post (real strategies would tag here too) *)
apply (rule conjI)

(* Strategy 6a: ? Dealing with disjunctives. What strategy? Assume choose simplest? *)
apply (rule disjI1)
(* Strategy 7a: Split the postconditions *)
apply (intro conjI)
(* We could argue that this would be the same strategy as 5a i.e. one step*)
apply simp (* Strategy: tool automation *)
defer
apply simp (* Strategy: tool automation *)
defer
apply (simp add: le_less)
(* at this point you should fail? (i.e. larger proof? or not fail do it twice? Former) *)
apply (erule disjE)
defer
apply simp
defer
oops

(*
theorem foo: "(\<exists>x. (l \<in> dom f \<and> the (f l) = s \<and> x = {l} -\<triangleleft> f \<and> F1_inv x \<or>
            l \<in> dom f \<and> s < the (f l) \<and> x = {l} -\<triangleleft> f \<union>m [l + s \<mapsto> the (f l) - s] \<and> F1_inv x))

*)
lemma foo: "(\<exists>x. (l \<in> dom f \<and> the (f l) = s \<and> x = {l} -\<triangleleft> f \<or>
            l \<in> dom f \<and> s < the (f l) \<and> x = {l} -\<triangleleft> f \<union>m [l + s \<mapsto> the (f l) - s]) \<and>
           F1_inv x)

=(
(l \<in> dom f \<and> the (f l) = s \<and> F1_inv ({l} -\<triangleleft> f)) \<or> 
(l \<in> dom f \<and> s < the (f l) \<and> F1_inv ({l} -\<triangleleft> f \<union>m [l + s \<mapsto> the (f l) - s])) 
)"
by blast

theorem 
  new1_feas_test_a3: "PO_new1_fsb"
apply(unfold PO_new1_fsb_def) (* Not a strategy: just getting to the PO *)

(* Strategy 1: structural breakdown *) 
apply(intro allI impI, elim conjE ) 

 (* Strategy 2: unfold to appropriate layer *) 
apply(unfold new1_pre_def new1_post_def new1_post_eq_def new1_post_gr_def)

(* APPLY Strategy 3a: existential witnessing; existential precondition *)
(* RESULT TOOLOP IS *)
apply (erule bexE)
apply (subst ex_comm) (* Swapping the orders *)
apply (rule_tac x=l in exI)



apply (subst foo)
    (* matcher: equality for quantified variable *)

(* Here it is possible we went the same path as the previous
   proof, and matched the failure (?) (i.e. we need negative features?)

   But here we have more clarity of information which suggest 
   hidden case analysis on the \<le> (perhaps ask the user if that's what to be done?)
apply (rule disjI1)
apply (intro conjI)
*)

(* taking into account the failure for the(f l) = s in the goal,
   and the success in find(EXP-HC-GE in PRE), the matcher would
   decide in favour as one of the cases gives exactly that failed goal.

   The application of disjE prior to disjIn is PSGraph based? heuristic...
   avoids goal duplication when subgoal numbers are large

   PS: watch out for other HC: \<longrightarrow>, \<longleftrightarrow>, etc in PRE
 *)
apply (simp add: le_less)
apply (erule disjE)
defer

(* reapply the strategy that led to ther(f l) = s it solves the goal *) 
  (* Strategy 6a: ? Dealing with disjunctives. What strategy? Assume choose simplest? *)
apply (rule disjI1)
  (* Strategy 7a: Split the postconditions *)
apply (intro conjI)
apply simp
defer

apply (rule disjI2)
  (* Strategy 7a: Split the postconditions *)
apply (intro conjI)
apply simp


(* Now we can apply the next strategy to split invariant *)
(* First the level of discourse is reached, using the features *)
apply (unfold F1_inv_def)
(* now split *)
apply (intro conjI, elim conjE)    
defer 
defer
defer
defer
apply (intro conjI, elim conjE)
(* invariant breakdown [pattern?] rippling strategy skeleton embeddings generating lemmas *)
oops
  
(* Q: how much do we generalise? i.e. {l}-\<triangleleft>f or S-\<triangleleft>f?*)
lemma
    (*   
     ops = {-\<triangleleft>, \<union>m, \<mapsto>, {_}, [_] }
        P\<^sub>0 = \<lbrakk> 0 < s ; l \<in> dom f ; s < the (f l) \<rbrakk> 
        x =  l + s 
        y = the (f l) - s
        P\<^sub>0 \<Longrightarrow> F1_inv ({l} -\<triangleleft> f) \<Longrightarrow> F1_inv [x \<mapsto> y] \<Longrightarrow>  F1_inv (({l} -\<triangleleft> f) \<union>m [x \<mapsto> y])

     ops = {-\<triangleleft>, \<union>m, {_} }
        P\<^sub>1 = \<lbrakk> 0 < s ; l \<in> dom f ; s < the (f l) \<rbrakk> 
        x =  l + s 
        y = the (f l) - s
        G = [ x \<mapsto> y ]
        P\<^sub>1 \<Longrightarrow> F1_inv ({l} -\<triangleleft> f) \<Longrightarrow> F1_inv G \<Longrightarrow>  F1_inv (({l} -\<triangleleft> f) \<union>m G)

     ops = {-\<triangleleft>, \<union>m }
        P\<^sub>2 = \<lbrakk> 0 < s ; l \<in> dom f ; s < the (f l) \<rbrakk> 
        x =  l + s 
        y = the (f l) - s
        G = [ x \<mapsto> y ]
        S = { l }
        P\<^sub>2 \<Longrightarrow> F1_inv (S -\<triangleleft> f) \<Longrightarrow> F1_inv G \<Longrightarrow>  F1_inv ((S -\<triangleleft> f) \<union>m G)

     ops = { \<union>m }
        P\<^sub>4 = \<lbrakk> 0 < s ; l \<in> dom f ; s < the (f l) \<rbrakk> 
        x =  l + s 
        y = the (f l) - s
        G = [ x \<mapsto> y ]
        S = { l }
        F = (S -\<triangleleft> f)
        P\<^sub>4 \<Longrightarrow> F1_inv F \<Longrightarrow> F1_inv G \<Longrightarrow>  F1_inv (F \<union>m G)

     ops = { \<union>m, \<mapsto>, [_] }
        P\<^sub>5 = \<lbrakk> 0 < s ; l \<in> dom f ; s < the (f l) \<rbrakk> 
        x =  l + s 
        y = the (f l) - s
        S = { l }
        F = (S -\<triangleleft> f)
        P\<^sub>5 \<Longrightarrow> F1_inv F \<Longrightarrow> F1_inv G \<Longrightarrow>  F1_inv (F \<union>m [x \<mapsto> y])

     there are plenty more... which one to choose/generate? TODO: investigate.

     HEURISTICS:?
       generalise only to the level "f" is on? 
       generalise only the lowest leafs on term tree?
       generalise until you have only "discourse" operators (e.g. -\<triangleleft>, \<union>m, say)?
       generalise to max? (i.e. as originally imagined in the liheap paper pattern; nested application)?
       generalise involving the user?
     *) 
    new1_feas_invbd_a1: 
    "F1_inv f \<Longrightarrow>
     F1_inv (({l} -\<triangleleft> f) \<union>m [x \<mapsto> y])"
oops

(* Bring in HEAP1Lemmas to try and sledgehammer this
definition 
  sep0 :: "F1 \<Rightarrow> F1 \<Rightarrow> bool" 
where
  "sep0 f g \<equiv> (\<forall> l \<in> dom f . l + the(f l) \<notin> dom g)"
*)

lemma
    (* P\<^sub>0 = 0 < s ; l \<in> dom f ; s < the (f l)  [from original goal]
       P\<^sub>1 = P\<^sub>0 ;                               
            dom f \<inter> dom g = {}                 [from def of \<union>m]
            disjoint (locs f) (locs g)         [generalisation of pre dispose1 - long shot?]
            sep0 F G ; sep0 G F                [generalisation of sep case - light-year shot!]
     *)
    new1_feas_invbd_a2_max: 
    "F1_inv F \<Longrightarrow> F1_inv G \<Longrightarrow> 
     sep0 F G \<Longrightarrow> sep0 G F \<Longrightarrow>
     dom F \<inter> dom G = {} \<Longrightarrow>
     disjoint (locs F) (locs G) \<Longrightarrow>
     F1_inv (F \<union>m G)"
apply (unfold F1_inv_def)
apply (intro conjI, elim conjE)
defer
(* These lemmas are the next step deeper in the proof process to finish the inv-bd
   obviously, they are the ones bringing in the more complicated side conditions.
 *)
apply (metis l_sep_munion)
apply (metis l_nat1_map_munion)
apply (metis k_finite_munion)
apply (simp add: l_disjoint_munion)
done

lemma
    new1_feas_invbd_a2_mapop_a1: 
    "F1_inv f \<Longrightarrow>
     nat1 y \<Longrightarrow> x \<notin> dom f \<Longrightarrow>
     disjoint (locs_of x y) (locs f) \<Longrightarrow>
     x+y \<notin> dom f \<Longrightarrow> sep0 f [x\<mapsto>y] \<Longrightarrow>
     F1_inv ((S -\<triangleleft> f) \<union>m [x \<mapsto> y])"
apply (unfold F1_inv_def)
apply (intro conjI, elim conjE)
apply (subst l_disjoint_singleton_upd)
  apply (metis k_nat1_map_dom_ar)
  apply (metis l_dom_ar_not_in_dom)
  apply assumption
  apply (metis k_Disjoint_dom_ar)
  defer 
  apply (rule TrueI)
apply (subst l_sep_singleton_upd)
  apply (metis k_nat1_map_dom_ar)
  apply (metis l_dom_ar_not_in_dom)
  apply (metis l_dom_ar_not_in_dom)
  apply assumption
  apply (metis k_sep_dom_ar)
  defer
  apply (rule TrueI)
apply (subst l_nat1_map_singleton_upd)
  apply assumption
  apply (metis l_dom_ar_not_in_dom)
  apply (metis k_nat1_map_dom_ar)
  apply (rule TrueI)
apply (subst l_finite_singleton_upd)
  apply assumption
  apply (metis l_dom_ar_not_in_dom)
  apply (metis k_finite_dom_ar)
  apply (rule TrueI)
find_theorems "locs (_ -\<triangleleft> _)"
apply (subst l_locs_dom_ar_general_iff)
  apply assumption
  apply assumption
  defer
apply (unfold disjoint_def)
  defer
apply (unfold sep0_def)
apply (intro ballI) 
  (* slegehammer failed, but for silly reasons? 
  find_theorems "the ((_ -\<triangleleft> _) _)"
  thm f_in_dom_ar_the_subsume
  apply (simp add : f_in_dom_ar_the_subsume)
  find_theorems "_ \<in> dom(_ -\<triangleleft> _)"
  apply (simp add: f_in_dom_ar_subsume)
  *)
  apply (metis f_in_dom_ar_the_subsume l_dom_ar_not_in_dom)
oops

lemma l_locs_dom_ar_subset: "nat1_map f \<Longrightarrow> locs(S -\<triangleleft> f) \<subseteq> locs f"
unfolding locs_def
by (smt UN_mono equalityD2 f_dom_ar_subset_dom f_in_dom_ar_the_subsume k_nat1_map_dom_ar)

lemma l_disjoint_subset_trans: "disjoint x y \<Longrightarrow> z \<subseteq> y \<Longrightarrow> disjoint x z"
unfolding disjoint_def
by auto

lemma
    new1_feas_invbd_a2_mapop_a2: 
    "F1_inv f \<Longrightarrow>
     nat1 y \<Longrightarrow> x \<notin> dom f \<Longrightarrow>
     disjoint (locs_of x y) (locs f) \<Longrightarrow>
     x+y \<notin> dom f \<Longrightarrow> sep0 f [x\<mapsto>y] \<Longrightarrow>
     F1_inv ((S -\<triangleleft> f) \<union>m [x \<mapsto> y])"
apply (unfold F1_inv_def)
apply (intro conjI, elim conjE)
apply (subst l_disjoint_singleton_upd)
  apply (metis k_nat1_map_dom_ar)
  apply (metis l_dom_ar_not_in_dom)
  apply assumption
  apply (metis k_Disjoint_dom_ar)
  apply (metis l_disjoint_subset_trans l_locs_dom_ar_subset)
  apply (rule TrueI)
apply (subst l_sep_singleton_upd)
  apply (metis k_nat1_map_dom_ar)
  apply (metis l_dom_ar_not_in_dom)
  apply (metis l_dom_ar_not_in_dom)
  apply assumption
  apply (metis k_sep_dom_ar)
    apply (unfold sep0_def)
    apply (intro ballI) 
    apply (metis f_in_dom_ar_the_subsume l_dom_ar_not_in_dom)
    apply (rule TrueI)
apply (subst l_nat1_map_singleton_upd)
  apply assumption
  apply (metis l_dom_ar_not_in_dom)
  apply (metis k_nat1_map_dom_ar)
  apply (rule TrueI)
apply (subst l_finite_singleton_upd)
  apply assumption
  apply (metis l_dom_ar_not_in_dom)
  apply (metis k_finite_dom_ar)
  apply (rule TrueI)
done

thm k_F1_inv_dom_ar
lemma 
   (* maximal happens to be like the map op one *)
    new1_feas_invbd_a4_max_a1: 
    "F1_inv f \<Longrightarrow>
     F1_inv ((S -\<triangleleft> f))"
unfolding F1_inv_def
apply (intro conjI, elim conjE)
apply (metis k_Disjoint_dom_ar)
apply (metis k_sep_dom_ar)
apply (metis k_nat1_map_dom_ar)
by (metis k_finite_dom_ar)

theorem 
  new1_feas_test_a4: "PO_new1_fsb"
apply(unfold PO_new1_fsb_def) (* Not a strategy: just getting to the PO *)

(* Strategy 1: structural breakdown *) 
apply(intro allI impI, elim conjE ) (* EXPOSE-POST *)

 (* Strategy 2: unfold to appropriate layer *) 
apply(unfold new1_pre_def new1_post_def new1_post_eq_def new1_post_gr_def)

(* APPLY Strategy 3a: existential witnessing; existential precondition *)
(* RESULT TOOLOP IS *)
apply (erule bexE)
apply (subst ex_comm) (* Swapping the orders *)
apply (rule_tac x=l in exI)

(* Clever exists_wit_sp (bnormalised)*)
apply (subst foo)
    (* matcher: equality for quantified variable *)

(* Here it is possible we went the same path as the previous
   proof, and matched the failure (?) (i.e. we need negative features?)

   But here we have more clarity of information which suggest 
   hidden case analysis on the \<le> (perhaps ask the user if that's what to be done?)
apply (rule disjI1)
apply (intro conjI)
*)

(* taking into account the failure for the(f l) = s in the goal,
   and the success in find(EXP-HC-GE in PRE), the matcher would
   decide in favour as one of the cases gives exactly that failed goal.

   The application of disjE prior to disjIn is PSGraph based? heuristic...
   avoids goal duplication when subgoal numbers are large

   PS: watch out for other HC: \<longrightarrow>, \<longleftrightarrow>, etc in PRE
 *)
apply (simp add: le_less)
apply (erule disjE)

(* Strategy X : disjunctive post condition splitting *)
apply (rule disjI2)
(* PS: avoid this, which was a previous result not through our PP 
apply (metis k_F1_inv_dom_munion nat1_def) *)

(* Strategy Y: Tool automation *)
apply (intro conjI,assumption)

(* Strategy Z: invariant breakdown *)
apply (rule new1_feas_invbd_a2_mapop_a2)

(* Strategy Y: Tool automation *)
apply (simp,simp)
apply (metis l_plus_s_not_in_f nat1_def)

(*
apply (unfold F1_inv_def Disjoint_def disjoint_def Locs_of_def,simp)
apply (elim conjE, erule_tac x=l in ballE, erule_tac x="l+s" in ballE,simp_all)
*)
defer
defer
defer

apply (rule disjI1)
apply (intro conjI, simp)
(*
apply (metis k_F1_inv_dom_ar)*)
apply (rule  new1_feas_invbd_a4_max_a1,assumption)


sorry

(*
a1 = 1) zooming key concepts
     2) tool automation [auto] (naive attempt)
     [FAILURE]

a2 = 1) structural bd 
     2) zooming
     3) exists_wit_pre
     4) exists_wit_sp
     5) split_inv_post
     6) disjunctive_post
     [FAILURE]

a3 = 1) structural bd 
     2) zooming
     3) exists_wit_pre
     4) normalised exists_wit_sp (foo lemma)
     5) expand_hc_gr (early) + disjE
     6) disjunctive_post
     7) split_inv_post
     8) tool automation
     9) invariant breakdown
     10) zooming
     11) rippling
     [STOP: inv bd lemmas instead? found inv-tags on goal therefore, triggered inv-bd?]

a4 = 1) structural bd 
     2) zooming
     3) exists_wit_pre
     4) normalised exists_wit_sp (foo lemma)
     5) expand_hc_gr (early) + disjE
     6) disjunctive_post
     7) split_inv_post
     8) tool automation      
     9) invariant breakdown new1_feas_invbd_a2_mapop_a2
     10) tool automation      
     X) handle hard side condition cases
     11) invariant breakdown new1_feas_invbd_a4_max_a1
     12) tool automation
     done
*)


(**********************************************************************************)
(************************ DISPOSE 1 FEASIBILITY SPECIFIC LEMMAS *******************)

(* Prove disjointedness of above and below. Nice proof by case analysis and contradiction *)
lemma(in level1_dispose) disjoint_above_below[simp] :
       "dom(dispose1_above f1 d1 s1) \<inter> dom(dispose1_below f1 d1) = {}"
unfolding dispose1_above_def dispose1_below_def
proof(rule l_dom_r_disjoint_weakening) (* Key weakening lemma *)
  show "{x \<in> dom f1. x = d1 + s1} \<inter> {x \<in> dom f1. x + the (f1 x) = d1} = {}"
  proof (cases "{x \<in> dom f1. x = d1 + s1} = {}")
    assume "{x \<in> dom f1. x = d1 + s1} = {}" 
    then show " {x \<in> dom f1. x = d1 + s1} \<inter> {x \<in> dom f1. x + the (f1 x) = d1} = {}" 
      by auto
    next
    assume *: "{x \<in> dom f1. x = d1 + s1} \<noteq> {}"
    show " {x \<in> dom f1. x = d1 + s1} \<inter> {x \<in> dom f1. x + the (f1 x) = d1} = {}" 
    proof (cases " {x \<in> dom f1. x + the (f1 x) = d1} = {}")
    assume "{x \<in> dom f1. x + the (f1 x) = d1} = {}"
    then show  " {x \<in> dom f1. x = d1 + s1} \<inter> {x \<in> dom f1. x + the (f1 x) = d1} = {}" 
      by auto
    next
    assume **: "{x \<in> dom f1. x + the (f1 x) = d1} \<noteq> {}"
    show  "{x \<in> dom f1. x = d1 + s1} \<inter> {x \<in> dom f1. x + the (f1 x) = d1} = {}"
    proof(rule ccontr)
      assume nonempty: "{x \<in> dom f1. x = d1 + s1} \<inter> {x \<in> dom f1. x + the (f1 x) = d1} \<noteq> {}"
      from * ** obtain x where xinter: "x \<in> {x \<in> dom f1. x = d1 + s1} \<inter> {x \<in> dom f1. x + the (f1 x) = d1}"
          by (smt equals0I nonempty)
      from xinter have d1s1: "x = d1 + s1" by auto
      from xinter have d1: "x + the (f1 x) = d1" by auto
      from d1s1 d1 have "d1 + s1 + the (f1 x) = d1" by auto
      then have "s1 + the (f1 x) = 0" by auto
      then have "False" 
          by (metis add_is_0 l1_input_notempty_def less_numeral_extra(3) nat1_def)      
      thus "False" ..
    qed
  qed
 qed
qed

lemma (in level1_dispose) finite_dispose1_above: "finite ( dom (dispose1_above f1 d1 s1))"
unfolding dispose1_above_def
apply (rule l_dom_r_finite)
by (metis invF1_finite_weaken l1_invariant_def)

lemma (in level1_dispose) finite_dispose1_below: "finite ( dom (dispose1_below f1 d1))"
unfolding dispose1_below_def
apply (rule l_dom_r_finite)
by (metis invF1_finite_weaken l1_invariant_def)


lemma(in level1_dispose)  d1_not_dispose_above: "d1 \<notin> dom (dispose1_above f1 d1 s1)"
unfolding dispose1_above_def
proof (subst l_dom_r_subseteq)
  show "{x \<in> dom f1. x = d1 + s1} \<subseteq> dom f1"
    by auto
  next
  show "d1 \<notin> {x \<in> dom f1. x = d1 + s1}" 
using l1_input_notempty_def by auto
qed

lemma (in level1_dispose) d1_not_dispose_below: "d1 \<notin> dom (dispose1_below f1 d1)"
unfolding dispose1_below_def
proof (subst l_dom_r_subseteq)
  show " {x \<in> dom f1. x + the (f1 x) = d1} \<subseteq> dom f1"
    by auto
  next
  show " d1 \<notin> {x \<in> dom f1. x + the (f1 x) = d1}" 
    by (metis (lifting, mono_tags) invF1_sep_weaken l1_invariant_def mem_Collect_eq sep_def)
qed


lemma (in level1_dispose) d1_not_above_below: "d1 \<notin> dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1)"
unfolding munion_def
  apply simp
  by (metis (full_types) Un_iff d1_not_dispose_above d1_not_dispose_below l_dagger_dom)

lemma (in level1_dispose) dispose1_ext_union: "dom (dispose1_ext f1 d1 s1) =  
    dom (dispose1_above f1 d1 s1) \<union>  dom (dispose1_below f1 d1) \<union> {d1}"
proof -
  have "dom (dispose1_ext f1 d1 s1) = dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1) \<union> dom([d1 \<mapsto> s1])"
  unfolding dispose1_ext_def
  by (rule l_munion_dom, simp add: d1_not_above_below)
  also have "... =  dom( dispose1_above f1 d1 s1 \<dagger> dispose1_below f1 d1) \<union> {d1}" 
    unfolding munion_def by simp
  finally show ?thesis by (simp add: l_dagger_dom) 
qed

lemma (in level1_dispose) dispose1_ext_notempty: " dispose1_ext f1 d1 s1 \<noteq> Map.empty "
   by (metis Un_commute Un_insert_left dispose1_ext_union dom_eq_empty_conv insert_not_empty)

lemma (in level1_dispose) dispose1_ext_dom_notempty: "dom ( dispose1_ext f1 d1 s1) \<noteq> {}" 
by (metis Un_insert_right dispose1_ext_union insert_not_empty)

lemma (in level1_dispose) d1notinf1: "d1 \<notin> dom f1" 
proof - 
  have "dom f1 \<subseteq> locs f1" 
  proof(rule domf_in_locs)
    show "nat1_map f1" by (metis invF1_nat1_map_weaken l1_invariant_def)
  qed
  moreover have "d1 \<in> locs_of d1 s1"
    unfolding locs_of_def apply (simp only: l1_input_notempty_def)
using l1_input_notempty_def by auto
  ultimately show ?thesis by (smt Collect_empty_eq Int_def disjoint_def
                dispose1_pre_def l1_dispose1_precondition_def set_rev_mp)
qed


lemma  (in level1_dispose)  min_loc_unfold: "min_loc (dispose1_ext f1 d1 s1)
   = Min ((dom (dispose1_above f1 d1 s1)) 
       \<union> (dom (dispose1_below f1 d1)) \<union> {d1})"
proof -
   have "min_loc (dispose1_ext f1 d1 s1) = 
   min_loc (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1 \<union>m [d1 \<mapsto> s1])"
   unfolding dispose1_ext_def by simp
 also have "... =  Min (dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1 \<union>m [d1 \<mapsto> s1]))"
   unfolding min_loc_def 
    by (fold dispose1_ext_def, simp add: dispose1_ext_notempty)
 also have  "...= Min ((dom (dispose1_above f1 d1 s1)) \<union> (dom (dispose1_below f1 d1)) \<union> {d1})"
    by (fold dispose1_ext_def,simp add: dispose1_ext_union)
 finally show ?thesis by simp    
qed

lemma above_dom:
  assumes above_notempty: "(dispose1_above f1 d1 s1) \<noteq> empty"
  shows "dom (dispose1_above f1 d1 s1) = {d1 + s1}"
 proof -
  have "dispose1_above f1 d1 s1 = { x \<in> dom f1 . x = d1 + s1 } \<triangleleft> f1" 
    by (metis dispose1_above_def)
  then have " { x \<in> dom f1 . x = d1 + s1 } \<noteq> {}" 
    by (metis above_notempty l_dom_r_nothing)
  moreover have "dom (dispose1_above f1 d1 s1) = {d1 + s1}"
   unfolding dispose1_above_def
  proof (subst l_dom_r_iff)
    show "{x \<in> dom f1. x = d1 + s1} \<inter> dom f1 = {d1 + s1}"
      by (metis Collect_conj_eq Collect_conv_if Collect_mem_eq 
          calculation inf_commute singleton_conv)
  qed  
  thus ?thesis .
qed

lemma above_min_loc: 
assumes above_notempty: "(dispose1_above f1 d1 s1) \<noteq> empty"
shows "min_loc (dispose1_above f1 d1 s1) = d1 + s1" 
    unfolding min_loc_def
    by (metis Min_singleton assms above_dom)

lemma above_d1s1_in_f1:
assumes above_notempty: "(dispose1_above f1 d1 s1) \<noteq> empty"
shows "d1+s1 \<in> dom f1"
proof -
   have "dom (dispose1_above f1 d1 s1) \<subseteq> dom (f1)"
   unfolding dispose1_above_def by (simp add: l_dom_r_dom_subseteq)
   moreover have "{d1+s1} \<subseteq> dom f1" by (metis above_dom assms calculation)
   ultimately show ?thesis by auto
qed

lemma above_sumsize:
assumes above_notempty: "(dispose1_above f1 d1 s1) \<noteq> empty"
shows "sum_size (dispose1_above f1 d1 s1) = the (f1 (d1 + s1))"     
unfolding sum_size_def 
apply (simp add: above_notempty)
apply (subst above_dom)
apply (rule above_notempty)
unfolding dispose1_above_def
apply (subgoal_tac "{x. x = d1 + s1 \<and> x \<in> dom f1} = {d1+s1}") 
apply (simp)
apply (subst f_in_dom_r_apply_elem)
apply simp_all
by (metis Collect_conj_eq Collect_mem_eq Int_empty_left
    Int_insert_left_if1 above_d1s1_in_f1 assms singleton_conv)

(* The value of min_loc in each of the 2 cases - don't care about above as it will never be min *)

lemma (in level1_dispose) d1_above: 
  "\<forall> x\<in> dom (dispose1_above f1 d1 s1). x > d1"
by (metis (mono_tags) above_dom d1_not_dispose_above 
l_map_non_empty_has_elem_conv less_le not_add_less1 not_less singletonE)

lemma (in level1_dispose) min_below_empty:
  assumes below_empty: "dom (dispose1_below f1 d1) = {}"
  shows "min_loc (dispose1_ext f1 d1 s1) = d1"
proof(cases "dom (dispose1_above f1 d1 s1) = {}")
  assume "dom (dispose1_above f1 d1 s1) = {}" 
  then show ?thesis
    by (metis min_loc_unfold Min_singleton below_empty sup_bot_left)
 next
  assume above_notempty: "dom (dispose1_above f1 d1 s1) \<noteq> {}"
  have "min_loc (dispose1_ext f1 d1 s1) = Min (dom (dispose1_above f1 d1 s1) \<union> {d1})"
   by (simp add: below_empty min_loc_unfold)
  also have "... =  min (Min (dom (dispose1_above f1 d1 s1))) (Min({d1}))"
    by (subst Min_Un, simp_all del: dom_eq_empty_conv add: finite_dispose1_above l_map_non_empty_dom_conv above_notempty)
  also have "... = min  (Min (dom (dispose1_above f1 d1 s1))) d1" by simp
  finally show ?thesis 
by (metis Min_singleton above_dom above_notempty 
        l_map_non_empty_dom_conv le_add1 min_absorb1 min.commute)
qed  



lemma dom_ar_disjoint: "(dom f) \<inter> (Y) = {} \<Longrightarrow>(dom (X -\<triangleleft> f)) \<inter> Y = {}"
by (metis Diff_Int_distrib2  empty_Diff l_dom_dom_ar)


lemma (in level1_dispose) min_below_notempty:
  assumes below_notempty: "dom (dispose1_below f1 d1) \<noteq> {}" 
  shows " min_loc (dispose1_ext f1 d1 s1) \<in> dom (dispose1_below f1 d1)"
proof -
  have "Min (dom (dispose1_above f1 d1 s1) \<union> dom (dispose1_below f1 d1) \<union> {d1})
       =Min (dom (dispose1_below f1 d1) \<union> (dom (dispose1_above f1 d1 s1) \<union> {d1}))"
    by (metis Un_insert_left min_loc_unfold sup_bot_left sup_commute)
 also have "... = min  (Min (dom (dispose1_below f1 d1))) 
                       (Min (dom (dispose1_above f1 d1 s1) \<union> {d1}))"
 by (subst Min_Un, simp_all  del: dom_eq_empty_conv  
    add: finite_dispose1_above finite_dispose1_below l_map_non_empty_dom_conv below_notempty)
 also have "... = min (Min (dom (dispose1_below f1 d1)))  d1" 
 proof (cases " dom (dispose1_above f1 d1 s1) = {}")
   assume "dom (dispose1_above f1 d1 s1) = {}" thus ?thesis by simp
  next
   assume  "dom (dispose1_above f1 d1 s1) \<noteq> {}" then
   have "Min (dom (dispose1_above f1 d1 s1) \<union> {d1}) = Min ({d1+s1} \<union> {d1})"
    by (metis above_dom l_map_non_empty_dom_conv)
   thus ?thesis by (simp add: l1_input_notempty_def)
 qed
 also have "... = Min (dom (dispose1_below f1 d1))"
 proof -
  have *: "\<exists> x. x\<in>dom f1 \<and> x + the (f1 x) = d1"
   proof -
     have "dispose1_below f1 d1 \<noteq> empty" by (metis below_notempty dom_eq_empty_conv)
     then have "{ x \<in> dom f1 . x + the(f1 x) = d1 } \<noteq> {}"
      by (metis (full_types) dispose1_below_def l_dom_r_nothing)
     thus ?thesis  by (smt empty_Collect_eq)
   qed  
  then obtain x where xinf1: "x \<in> dom f1" and belowplusf1below: "x + the (f1 x) = d1" by metis
  then have "x < d1" by (metis antisym d1notinf1 leI le_add1)
  moreover  have "x \<in> dom (dispose1_below f1 d1)"
  unfolding dispose1_below_def
  proof (subst l_dom_r_iff)
    show "x \<in> {x \<in> dom f1. x + the (f1 x) = d1} \<inter> dom f1"
     by (smt Int_Collect  belowplusf1below xinf1 inf_commute)
  qed  
  moreover have "Min (dom (dispose1_below f1 d1)) < d1" 
using Min_less_iff calculation(1) calculation(2) finite_dispose1_below by auto
  ultimately show ?thesis by (simp)
 qed
 also have "... \<in> dom (dispose1_below f1 d1)" 
  by (metis Min_in below_notempty finite_dispose1_below)
 finally show ?thesis by (metis min_loc_unfold)
qed  

(* Shorted proof considerably by reducing case analysis to just on empty *)
lemma (in level1_dispose) 
 nonzero_inter_dom: 
   "dom ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1) \<inter>
     dom [min_loc (dispose1_ext f1 d1 s1) \<mapsto> sum_size (dispose1_ext f1 d1 s1)] 
    = {}" 
proof(cases "dom (dispose1_below f1 d1) = {}")
  assume below_empty: "dom (dispose1_below f1 d1) = {}"
  then have min_loc_shape: "min_loc (dispose1_ext f1 d1 s1) = d1" by (rule min_below_empty)
  have dom_inter: "dom f1 \<inter> {d1} = {}" by (metis Int_insert_left_if0 d1notinf1 inf_bot_left inf_commute)
  show ?thesis by (simp add: min_loc_shape dom_inter dom_ar_disjoint)
 next
  assume below_notempty: "dom (dispose1_below f1 d1) \<noteq> {}"
  let ?S = "(dom (dispose1_below f1 d1))"  
  let ?x = "min_loc (dispose1_ext f1 d1 s1)"
  have "?S \<subseteq> dom f1"
    unfolding dispose1_below_def 
    by (simp add: l_dom_r_dom_subseteq)
  moreover have "?x \<in> ?S" by (metis below_notempty min_below_notempty)
  moreover have "?x \<notin> dom (?S -\<triangleleft> f1)"  
    by (metis calculation(2) l_dom_ar_notin_dom_or)
  moreover have "?x \<notin> dom ((?S \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1)"
    by (metis Un_iff calculation(2) l_dom_ar_not_in_dom2)
thus ?thesis by (metis Collect_conj_eq Collect_conv_if2 Int_commute dom_def
                  dom_eq_singleton_conv mem_Collect_eq singleton_conv2)
qed

lemma (in level1_dispose) nat1_dispose1_ext:  "nat1 (sum_size (dispose1_ext f1 d1 s1))"
 unfolding dispose1_ext_def
           apply (subst l_munion_upd)
           apply (simp add: l_munion_dom)
          apply (rule conjI)
          apply (rule d1_not_dispose_above)
          apply (rule d1_not_dispose_below)
          apply (unfold nat1_def)
          apply (rule sumsize2_weakening)
          apply (simp add: l_munion_dom)
          apply (rule conjI)
          apply (rule d1_not_dispose_above)
          apply (rule d1_not_dispose_below)
          apply (metis disjoint_above_below finite_Un finite_dispose1_above finite_dispose1_below l_munion_dom)
           by (metis l1_input_notempty_def nat1_def)



(******************* DISPOSE FEASIBILITY PROOF ************************)

lemma (in level1_dispose) F1_inv_dispose:
  assumes f1inv: "F1_inv f1"
  shows "F1_inv ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
              [min_loc (dispose1_ext f1 d1 s1) \<mapsto> sum_size (dispose1_ext f1 d1 s1)])"
proof -
  from f1inv show ?thesis
  proof  
  assume disjf1: "Disjoint f1"
   and sepf1: "sep f1" 
   and nat1_mapf1: "nat1_map f1" 
   and finitef1: "finite (dom f1)"
 show ?thesis (* I want to unfold the invariant and split into the two simple components
                 and the complex part. The simple components do not require case analysis...
              *)
proof(rule invF1_shape)
  from nonzero_inter_dom show "nat1_map  ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 
    \<union>m [min_loc (dispose1_ext f1 d1 s1) \<mapsto> sum_size (dispose1_ext f1 d1 s1)])"
  proof (rule unionm_nat1_map)
    show "nat1_map ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1)"
     using nat1_mapf1 by (rule dom_ar_nat1_map)
   next
    show "nat1_map [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)]"
    by (metis dom_empty empty_iff l_munion_empty_lhs nat1_dispose1_ext nat1_map_def unionm_singleton_nat1_map)
  qed  (* END OF THE NAT1 PART OF THE PROOF! *)
 next
  from nonzero_inter_dom show "finite (dom ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
                 [min_loc (dispose1_ext f1 d1 s1) \<mapsto> sum_size (dispose1_ext f1 d1 s1)]))"
  proof (rule unionm_finite)
    show "finite (dom ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1))"
     by (metis dom_ar_finite finitef1)
   next
    show "finite (dom [min_loc (dispose1_ext f1 d1 s1) \<mapsto> sum_size (dispose1_ext f1 d1 s1)])"
     by (metis dom_empty dom_fun_upd finite.emptyI finite_insert option.distinct(1))
  qed (* END OF THE FINITE PART OF THE PROOF! *)
next  (*********** SEP AND DISJOINT ******************)
  show "VDM_F1_inv
     ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
      [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)])"
  proof (cases "dispose1_below f1 d1 = empty")
    assume below_empty: "dispose1_below f1 d1 = empty"
    then show ?thesis
    proof (cases "dispose1_above f1 d1 s1 = empty")
      assume above_empty:  "dispose1_above f1 d1 s1 = empty"
      then show ?thesis
        unfolding dispose1_ext_def
      proof (simp add: below_empty l_munion_empty_rhs l_munion_empty_lhs l_dom_ar_empty_lhs min_loc_singleton sum_size_singleton)
      show "VDM_F1_inv (f1 \<union>m [d1 \<mapsto> s1])"
      proof 
        show "sep (f1 \<union>m [d1 \<mapsto> s1])"
        proof (rule unionm_singleton_sep) (* DAGGER SEP FIRST USE *)
          show "sep f1" by (rule sepf1)
         next
          show "\<forall>l\<in>dom f1. l + the (f1 l) \<notin> dom [d1 \<mapsto> s1]"
          proof
            fix l
            assume "l \<in> dom f1"
            have "l + the (f1 l) \<noteq> d1" 
            proof - 
              have "dispose1_below f1 d1 = { x \<in> dom f1 . x + the(f1 x) = d1 } \<triangleleft> f1"
               unfolding dispose1_below_def by simp
              then have  "{ x \<in> dom f1 . x + the(f1 x) = d1 } = {}"                   
                by (smt IntI below_empty dom_def dom_eq_empty_conv 
                      empty_Collect_eq l_dom_r_iff mem_Collect_eq)
              thus ?thesis by (smt `l \<in> dom f1` empty_Collect_eq)
            qed
            then show "l + the (f1 l) \<notin> dom [d1 \<mapsto> s1]"
             by simp
          qed
         next
          show "d1 + s1 \<notin> dom f1"
          proof -
            have "dispose1_above f1 d1 s1 =  { x \<in> dom f1 . x = d1 + s1 } \<triangleleft> f1"
              unfolding dispose1_above_def by simp
            then have " { x \<in> dom f1 . x = d1 + s1 } = {}" 
              by (smt Collect_empty_eq above_empty disjoint_iff_not_equal 
                  dom_def l_dom_r_iff mem_Collect_eq)
            thus ?thesis by (smt empty_Collect_eq)
          qed
         next
          show "d1 \<notin> dom f1" by (rule d1notinf1)
         next
          show "nat1 s1" by (simp only: l1_input_notempty_def)
        qed
       next
        show "Disjoint (f1 \<union>m [d1 \<mapsto> s1])" 
        proof (rule unionm_singleton_Disjoint)
          show "Disjoint f1" by (rule disjf1)
         next
          show "nat1_map f1" by (rule nat1_mapf1)
         next
          show "d1 \<notin> dom f1" by (rule d1notinf1)
         next
          show "nat1 s1" by (rule l1_input_notempty_def)
         next (* The tough goal. In this case it directly matches the precondition! *)
          from l1_dispose1_precondition_def show "disjoint (locs_of d1 s1) (locs f1)" 
          unfolding dispose1_pre_def by assumption
        qed
      qed
    qed (* END OF BOTH EMPTY *)
   next
    assume above_notempty: "dispose1_above f1 d1 s1 \<noteq> Map.empty"
    (* Now break down the goal. SHAPING EXAMPLES!!! FIRST EXAMPLE. Also family of proofs complicated *)
    have abovebelowshape: "(dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) = {d1+s1}"
     by (simp add: below_empty l_munion_empty_rhs l_munion_empty_lhs l_dom_ar_empty_lhs d1notinf1
      d1_not_dispose_above d1_not_dispose_below above_dom above_notempty)
    have min_loc_shape: "min_loc (dispose1_ext f1 d1 s1) = d1" 
     by (metis below_empty l_map_non_empty_dom_conv min_below_empty)
    have "sum_size (dispose1_ext f1 d1 s1) = sum_size (dispose1_above f1 d1 s1) + s1"
      by (simp add: dispose1_ext_def below_empty l_munion_empty_rhs 
          l_munion_empty_lhs l_dom_ar_empty_lhs d1notinf1
          d1_not_dispose_above d1_not_dispose_below sum_size_munion
          finite_dispose1_above above_notempty sum_size_singleton)
    then have sum_size_shape: "sum_size (dispose1_ext f1 d1 s1) = the(f1 (d1+s1)) + s1"
      by (simp add: above_sumsize above_notempty)
    show ?thesis
    proof (simp add: sum_size_shape min_loc_shape abovebelowshape)
      show "VDM_F1_inv ({d1 + s1} -\<triangleleft> f1 \<union>m [d1 \<mapsto> the (f1 (d1 + s1)) + s1])"
      proof
        thm sepf1 (*asm*)
        show "sep ({d1 + s1} -\<triangleleft> f1 \<union>m [d1 \<mapsto> the (f1 (d1 + s1)) + s1])"
        proof (rule unionm_singleton_sep) (* The work is here!!! *)
          show "sep ({d1 + s1} -\<triangleleft> f1)"  using sepf1 by (rule dom_ar_sep)
         next
          show " d1 \<notin> dom ({d1 + s1} -\<triangleleft> f1)"
          proof -
            have "d1 \<notin> dom f1" by (rule d1notinf1)
            thus ?thesis by (metis l_dom_ar_notin_dom_or)
          qed
         next (* First tough goal *)
          show " \<forall>l\<in>dom ({d1 + s1} -\<triangleleft> f1). 
                      l + the (({d1 + s1} -\<triangleleft> f1) l) 
                        \<notin> dom [d1 \<mapsto> the (f1 (d1 + s1)) + s1]" 
          proof
            fix l assume lindom: "l\<in>dom ({d1 + s1} -\<triangleleft> f1)"
            then have linf: "l\<in> dom f1" by (metis l_dom_ar_notin_dom_or)
            have "l + the (f1 l) \<noteq> d1" 
            proof - 
              have "dispose1_below f1 d1 = { x \<in> dom f1 . x + the(f1 x) = d1 } \<triangleleft> f1"
               unfolding dispose1_below_def by simp
              then have  "{ x \<in> dom f1 . x + the(f1 x) = d1 } = {}"                   
                by (smt IntI below_empty dom_def dom_eq_empty_conv 
                          empty_Collect_eq l_dom_r_iff mem_Collect_eq)
              thus ?thesis by (smt linf empty_Collect_eq)
            qed
            then have "l + the (({d1 + s1} -\<triangleleft> f1) l) \<noteq> d1" 
              by (metis f_in_dom_ar_apply_subsume lindom)
            thus " l + the (({d1 + s1} -\<triangleleft> f1) l) \<notin> dom [d1 \<mapsto> the (f1 (d1 + s1)) + s1]" by auto
          qed
         next (* Second tough goal *)
          show "d1 + (the (f1 (d1 + s1)) + s1) \<notin> dom ({d1 + s1} -\<triangleleft> f1)"
          proof -
            have "sep f1" by (rule sepf1)
            then have "\<forall>l\<in> dom f1. l + the (f1 l) \<notin> dom f1" 
              using sep_def by auto
            moreover have "(d1+s1) \<in> dom f1" using above_notempty by (rule above_d1s1_in_f1)
            moreover have "(d1 + s1) + the (f1 (d1+s1)) \<notin> dom f1" 
                by (metis calculation(1) calculation(2))
            ultimately show "d1 + (the (f1 (d1 + s1)) + s1) \<notin> dom ({d1 + s1} -\<triangleleft> f1)" 
by (simp add: add.assoc add.commute l_dom_ar_not_in_dom)
          qed
         next
          show "nat1 (the (f1 (d1 + s1)) + s1)" 
           by (simp, rule disjI2, metis l1_input_notempty_def nat1_def) (*SURELY NOT THAT TOUGH! *)
        qed
       next
       show "Disjoint ({d1 + s1} -\<triangleleft> f1 \<union>m [d1 \<mapsto> the (f1 (d1 + s1)) + s1])"
        proof (rule unionm_singleton_Disjoint)
          show "Disjoint ({d1 + s1} -\<triangleleft> f1)" using disjf1 by (rule dom_ar_Disjoint)
         next
          show "d1 \<notin> dom ({d1 + s1} -\<triangleleft> f1)" using d1notinf1 by (simp add: l_dom_ar_notin_dom_or)
         next
          show "nat1_map ({d1 + s1} -\<triangleleft> f1)" using nat1_mapf1 by (rule dom_ar_nat1_map)
         next
          show "nat1 (the (f1 (d1 + s1)) + s1)" 
            by (metis (mono_tags) add_eq_if l1_input_notempty_def nat1_def zero_less_Suc)
         next
          show "disjoint (locs_of d1 (the (f1 (d1 + s1)) + s1)) (locs ({d1 + s1} -\<triangleleft> f1))"
          (* This proof is really nice. And is another example of a sketch! *)
          proof -
            from l1_dispose1_precondition_def have "disjoint (locs_of d1 s1) (locs f1)" 
              by (simp add: dispose1_pre_def)
            moreover have "(locs ({d1 + s1} -\<triangleleft> f1)) = locs f1 - locs_of (d1+s1) (the (f1 (d1+s1)))"
             by (rule dom_ar_locs, simp_all add: disjf1 finitef1 nat1_mapf1 above_d1s1_in_f1 above_notempty)
            moreover have "locs_of d1 (the (f1 (d1 + s1)) + s1) =
                         locs_of d1 s1
                           \<union>   locs_of (d1+s1) ((the (f1 (d1 + s1))))"
            proof (subst add.commute, rule locs_of_sum_range)
              show "nat1 (the (f1 (d1 + s1)))" 
               by (metis (full_types) above_d1s1_in_f1 above_notempty nat1_map_def nat1_mapf1)
             next
              show "nat1 s1" by (metis l1_input_notempty_def)
            qed
            ultimately show ?thesis unfolding disjoint_def by auto 
          qed 
        qed
      qed
    qed
  qed (* END OF CASE. END OF SHAPING *)
 next (* CASE WHERE BELOW IS NOT EMPTY!!! HALFWAY THERE. *) 
  assume below_notempty: "dispose1_below f1 d1 \<noteq> empty"
  (* WE NOW FIND OUR WITNESS FOR BELOW *)
  from below_notempty have "\<exists>x. x\<in>dom f1 \<and> x + the (f1 x) = d1"
  proof -
    have "dispose1_below f1 d1 \<noteq> empty" by (rule below_notempty)
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
        have nat1below: " nat1 (the (f1 below))" by (metis nat1_map_def nat1_mapf1 belowinf1)            
        have nat1x: " nat1 (the (f1 x))" by (metis nat1_map_def nat1_mapf1 xinf)            
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
  (* Now do case analysis on above *)
  show ?thesis
  proof (cases "dispose1_above f1 d1 s1 = empty")
    assume above_empty:  "dispose1_above f1 d1 s1 = empty"  
    have abovebelow_shape: "(dom (dispose1_below f1 d1)) \<union> (dom (dispose1_above f1 d1 s1)) 
                              = {below}"
      by (simp add: above_empty dom_below)
    have min_loc_shape: "min_loc (dispose1_ext f1 d1 s1) = below"
      by (metis dom_below insert_not_empty min_below_notempty singleton_iff)
    have sum_size_shape: "sum_size (dispose1_ext f1 d1 s1) = the (f1 below) + s1"
     unfolding dispose1_ext_def 
      by (simp add: above_empty l_munion_empty_lhs sum_size_munion sum_size_singleton 
                finite_dispose1_below below_notempty d1_not_dispose_below sum_size_below)
    show ?thesis
    proof (simp add: sum_size_shape min_loc_shape abovebelow_shape)
    show "VDM_F1_inv ({below} -\<triangleleft> f1 \<union>m [below \<mapsto> the (f1 below) + s1])"
    proof
    show "sep ({below} -\<triangleleft> f1 \<union>m [below \<mapsto> the (f1 below) + s1])"
      proof (rule unionm_singleton_sep)
        show "sep ({below} -\<triangleleft> f1)" using sepf1 by (rule dom_ar_sep)
       next 
        show " below \<notin> dom ({below} -\<triangleleft> f1)" by (metis f_in_dom_ar_notelem)
       next
        show "\<forall>l\<in>dom ({below} -\<triangleleft> f1). 
            l + the (({below} -\<triangleleft> f1) l) \<notin> dom [below \<mapsto> the (f1 below) + s1]"
        proof
          fix l assume lin_restr_dom:"l \<in> dom ({below} -\<triangleleft> f1)"
          have "l \<in> dom f1" using lin_restr_dom by (metis l_dom_ar_not_in_dom)
          have "l + the (({below} -\<triangleleft> f1) l) \<noteq> below"
             by (metis `l \<in> dom f1` belowinf1 f_in_dom_ar_apply_subsume 
               lin_restr_dom sep_def sepf1)
          thus "l + the (({below} -\<triangleleft> f1) l) \<notin> dom [below \<mapsto> the (f1 below) + s1]"
            by (metis dom_empty empty_iff l_inmapupd_dom_iff)
        qed
       next
        show " below + (the (f1 below) + s1) \<notin> dom ({below} -\<triangleleft> f1)"
        proof -
          have "below + (the (f1 below)) = d1"
           by (metis belowplusf1below)
          then have "d1 +s1 \<notin> dom ({below} -\<triangleleft> f1)"
          proof -
            have "dispose1_above f1 d1 s1 =  { x \<in> dom f1 . x = d1 + s1 } \<triangleleft> f1"
              unfolding dispose1_above_def by simp
            then have " { x \<in> dom f1 . x = d1 + s1 } = {}" 
              by (smt Collect_empty_eq above_empty disjoint_iff_not_equal 
                dom_def l_dom_r_iff mem_Collect_eq)
            thus ?thesis by (metis Collect_conj_eq Collect_mem_eq 
                 Un_empty_left f_in_dom_ar_apply_not_elem l_dom_ar_nothing 
                 domIff l_dom_ar_not_in_dom2 f_in_dom_ar_notelem inf_commute 
                 insert_def sup_commute)
          qed
          thus ?thesis by (metis belowplusf1below add.commute add.left_commute)
        qed
       next
        show "nat1 (the (f1 below) + s1)" by (metis nat1_dispose1_ext sum_size_shape) 
      qed
     next
      show "Disjoint ({below} -\<triangleleft> f1 \<union>m [below \<mapsto> the (f1 below) + s1])"
      proof(rule unionm_singleton_Disjoint)
        show "below \<notin> dom ({below} -\<triangleleft> f1)" 
          by (simp add: below_in_dom dom_below l_dom_ar_notin_dom_or) 
       next
        show "Disjoint ({below} -\<triangleleft> f1)" using disjf1 by (rule dom_ar_Disjoint)
       next
        show "nat1_map ({below} -\<triangleleft> f1)" using nat1_mapf1 by (rule dom_ar_nat1_map)
       next
        show " nat1 (the (f1 below) + s1)" by (metis nat1_dispose1_ext sum_size_shape) 
       next 
        (* Similar sketch/rippling to previous one *)
        show "disjoint (locs_of below (the (f1 below) + s1)) (locs ({below} -\<triangleleft> f1))"
        proof -
        from l1_dispose1_precondition_def have "disjoint (locs_of d1 s1) (locs f1)" 
           by (simp add: dispose1_pre_def)
        moreover have "(locs ({below} -\<triangleleft> f1)) = locs f1 - locs_of below (the (f1 (below)))"
         by (rule dom_ar_locs, simp_all add: disjf1 finitef1 nat1_mapf1 belowinf1)
        moreover have "locs_of below (the (f1 below) + s1) =
                       locs_of below  (the (f1 below))
                       \<union> locs_of (below +  (the (f1 below))) s1"
        proof (rule locs_of_sum_range)
          show "nat1 (the (f1 below))" by (metis belowinf1 nat1_map_def nat1_mapf1)
         next
          show "nat1 s1" by (rule l1_input_notempty_def)
        qed
        moreover have " locs_of (below +  (the (f1 below))) s1 = locs_of d1 s1"
         by (metis belowplusf1below)
                 
              thm belowplusf1below
        ultimately show ?thesis unfolding disjoint_def by auto
     qed
   qed
 qed
qed
 next
  assume above_notempty: " dispose1_above f1 d1 s1 \<noteq> Map.empty "
  have above_below_shape: "(dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1))
                           = {below,d1+s1}"
   by (metis Un_insert_left above_dom above_notempty dom_below sup_bot_left)
  have min_loc_shape:  "min_loc (dispose1_ext f1 d1 s1)  = below"
    by (metis dom_below insert_not_empty min_below_notempty singleton_iff)
  have sum_size_shape: "sum_size  (dispose1_ext f1 d1 s1)
                                  =   the (f1 (d1 + s1)) + the (f1 below) + s1"
  proof -  
    have sum_size_above_below: "sum_size (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1)
                                =  the (f1 (d1 + s1)) + the (f1 below)"
     by (simp add: sum_size_munion  finite_dispose1_above finite_dispose1_below above_notempty
         below_notempty above_sumsize sum_size_below)
    then show ?thesis unfolding dispose1_ext_def
    proof (subst sum_size_munion)
      show "finite (dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1))" and
          " finite (dom [d1 \<mapsto> s1])" 
       by (simp_all add:  finite_dispose1_above finite_dispose1_below k_finite_munion)
     next
      show " dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1 \<noteq> empty"
       and "[d1 \<mapsto> s1] \<noteq> empty"
        by (auto simp: munion_notempty_right below_notempty) 
     next 
      from d1_not_above_below show "dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1) \<inter> dom [d1 \<mapsto> s1] = {}"
       by simp
     next  
      show "sum_size (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1) + sum_size [d1 \<mapsto> s1] 
            = the (f1 (d1 + s1)) + the (f1 below) + s1"
         by (simp add:  sum_size_above_below sum_size_singleton)
    qed
  qed
  show ?thesis
  proof (simp add: sum_size_shape min_loc_shape above_below_shape)
    show "VDM_F1_inv ({below, d1 + s1} -\<triangleleft> f1 \<union>m [below \<mapsto> the (f1 (d1 + s1)) + the (f1 below) + s1])"
    proof     
      show "sep ({below, d1 + s1} -\<triangleleft> f1 \<union>m [below \<mapsto> the (f1 (d1 + s1)) + the (f1 below) + s1])"
      proof (rule unionm_singleton_sep)
        show " sep ({below, d1 + s1} -\<triangleleft> f1)" using sepf1 by (rule dom_ar_sep)
       next
        show " below \<notin> dom ({below, d1 + s1} -\<triangleleft> f1)" 
         by (metis insertI1 l_dom_ar_notin_dom_or)
       next
        show "\<forall>l\<in>dom ({below, d1 + s1} -\<triangleleft> f1).
              l + the (({below, d1 + s1} -\<triangleleft> f1) l) 
             \<notin> dom [below \<mapsto> the (f1 (d1 + s1)) + the (f1 below) + s1]"
         proof (* COPY PASTE FROM PREVIOUS! *)
           fix l assume lin_restr_dom:" l \<in> dom ({below, d1 + s1} -\<triangleleft> f1)"
           have "l \<in> dom f1" using lin_restr_dom by (metis l_dom_ar_not_in_dom)
           have "l + the (({below, d1 + s1} -\<triangleleft> f1) l) \<noteq> below"
            by (metis `l \<in> dom f1` belowinf1 f_in_dom_ar_apply_subsume 
               lin_restr_dom sep_def sepf1)
           thus "l + the (({below,d1+s1} -\<triangleleft> f1) l) \<notin> dom [below \<mapsto> the (f1 (d1 + s1)) + the (f1 below) + s1]"
            by (metis dom_empty empty_iff l_inmapupd_dom_iff)
         qed
        next
         show "below + (the (f1 (d1 + s1)) + the (f1 below) + s1) \<notin> dom ({below, d1 + s1} -\<triangleleft> f1)"
         proof -
           have "below + (the (f1 below)) = d1"
            by (metis belowplusf1below) 
           then have "(d1 +s1) + (the (f1 (d1 + s1))) \<notin> dom ({below,d1+s1} -\<triangleleft> f1)"
             by (metis above_d1s1_in_f1 above_notempty l_dom_ar_notin_dom_or sep_def sepf1)
           thus ?thesis 
by (metis add.assoc add.commute belowplusf1below) 
         qed
        next
         show "nat1 (the (f1 (d1 + s1)) + the (f1 below) + s1)" 
           by (metis nat1_dispose1_ext sum_size_shape)
       qed  
      next
       show "Disjoint ({below, d1 + s1} -\<triangleleft> f1 \<union>m [below \<mapsto> the (f1 (d1 + s1)) + the (f1 below) + s1])"
       proof (rule unionm_singleton_Disjoint)
         show "below \<notin> dom ({below, d1 + s1} -\<triangleleft> f1)"
          by (metis insertI1 l_dom_ar_notin_dom_or)
        next
         show "Disjoint ({below, d1 + s1} -\<triangleleft> f1)" using disjf1 by (rule dom_ar_Disjoint) 
        next
         show "nat1_map ({below, d1 + s1} -\<triangleleft> f1)" using nat1_mapf1 by (rule dom_ar_nat1_map)
        next
         show "nat1 (the (f1 (d1 + s1)) + the (f1 below) + s1)" 
          by (metis nat1_dispose1_ext sum_size_shape)
        next (* BY FAR THE MOST COMPLICATED OF THESE GOALS *)

         show 
        "disjoint (locs_of below   (the (f1 (d1 + s1)) +  the (f1 below) + s1)) 
                (locs ( {below, d1 + s1} -\<triangleleft> f1))"
         proof -
          have "(locs ({below, d1 + s1} -\<triangleleft> f1)) = locs ( {below} -\<triangleleft> ({d1 + s1} -\<triangleleft> f1))"
            by (metis Un_empty_left Un_insert_left l_dom_ar_accum)
          also have "... = 
              locs ({d1 + s1} -\<triangleleft> f1) - locs_of below (the (({d1 + s1} -\<triangleleft> f1) below))"  
          proof (rule dom_ar_locs) 
            show "finite (dom ({d1 + s1} -\<triangleleft> f1))" by (metis dom_ar_finite finitef1)
           next
            show "nat1_map ({d1 + s1} -\<triangleleft> f1)" by (metis dom_ar_nat1_map nat1_mapf1)
           next
            show "Disjoint ({d1 + s1} -\<triangleleft> f1)" by (metis disjf1 dom_ar_Disjoint)
           next
            show  "below \<in> dom ({d1 + s1} -\<triangleleft> f1)" by (metis belowinf1 belowplusf1below d1notinf1 
                                                      inf_commute inf_min l_in_dom_ar nat_min_absorb1 
                                                      singletonE)
          qed
          also have "... = locs ({d1 + s1} -\<triangleleft> f1) - locs_of below (the (f1 below))"
          proof (subst f_in_dom_ar_apply_not_elem)  
            show "below \<notin> {d1 + s1}"
              by (metis belowinf1 belowplusf1below d1notinf1 empty_iff insert_iff nat_neq_iff not_add_less1)          
          qed (rule refl)
          also have "... = locs(f1) - locs_of (d1+s1) (the (f1 (d1+s1))) - locs_of below (the (f1 below)) "
           by(subst dom_ar_locs, simp_all add: disjf1 finitef1 nat1_mapf1 belowinf1 above_d1s1_in_f1 above_notempty )
          finally have *: "(locs ({below, d1 + s1} -\<triangleleft> f1)) 
                      =  locs(f1) - locs_of (d1+s1) (the (f1 (d1+s1))) 
                        - locs_of below (the (f1 below))" by simp


          have "locs_of below (the (f1 (d1 + s1)) + the (f1 below) + s1) =
                locs_of below (the (f1 below) + ((the (f1 (d1 + s1))) + s1))"
           by (metis add.commute add.left_commute)
          also have "...  = (locs_of below (the (f1 below))) \<union> 
                       (locs_of (below + (the (f1 below))) (the (f1 (d1 + s1)) + s1))"
          proof (rule locs_of_sum_range)   
            show "nat1 (the (f1 below))" by (metis belowinf1 nat1_map_def nat1_mapf1)
           next
            show "nat1 (the (f1 (d1 + s1)) + s1)" 
                by (metis (full_types) l1_input_notempty_def nat1_def trans_less_add2)
          qed
          also have "... = (locs_of below (the (f1 below))) \<union> 
                          (locs_of d1 (the (f1 (d1 + s1)) + s1))" 
            by (metis belowplusf1below)
          also have "... =  (locs_of below (the (f1 below))) \<union> 
                          locs_of d1 (s1+ (the (f1 (d1 + s1))))" 
            by (metis add.commute)
          also have "... =  (locs_of below (the (f1 below)))
                          \<union> locs_of d1 s1
                          \<union> locs_of (d1+s1) (the (f1 (d1 + s1)))"
          proof (subst locs_of_sum_range)
            show "nat1 s1" by (metis l1_input_notempty_def)
           next
            show "nat1 (the (f1 (d1 + s1)))" 
              by (metis above_d1s1_in_f1 above_notempty nat1_map_def nat1_mapf1)
         qed (metis sup_commute sup_left_commute) (* Deal with the effective refl goal from subst*)
         finally have **: "locs_of below (the (f1 (d1 + s1)) + the (f1 below) + s1) 
                        =(locs_of below (the (f1 below)))
                          \<union> locs_of d1 s1
                          \<union> locs_of (d1+s1) (the (f1 (d1 + s1)))"
           by simp 
         from l1_dispose1_precondition_def have ***: "disjoint (locs_of d1 s1) (locs f1)" 
              by (simp add: dispose1_pre_def)
         from * ** *** show ?thesis unfolding disjoint_def  by auto
         (* Thank goodness that auto crunches this! :-) *)
       qed
     qed    
   qed
 qed
qed
qed
qed
qed
 qed 

(* Main theorem *)
theorem (in level1_dispose)
  locale1_dispose_FSB: "PO_dispose1_feasibility"
unfolding PO_dispose1_feasibility_def dispose1_postcondition_def 
proof(subst dispose1_equiv)
 obtain f1new where f1wit: "f1new = (dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
              [min_loc (dispose1_ext f1 d1 s1) \<mapsto> sum_size (dispose1_ext f1 d1 s1)] "
 by auto
  from f1wit F1_inv_dispose show " \<exists>f'. dispose1_post2 f1 d1 s1 f' \<and> F1_inv f'" 
  using dispose1_post2_def  by (metis l1_invariant_def)
qed


(* Strategy version in MWhy *)
definition
  PO_dispose1_fsbmwhy :: "bool"
where
  "PO_dispose1_fsbmwhy \<equiv> (\<forall> f d s . F1_inv f \<and> nat1 s \<and> dispose1_pre f d s \<longrightarrow> 
                        (\<exists> f' . dispose1_post2 f d s f' \<and> F1_inv f'))"

theorem "PO_dispose1_fsbmwhy"
apply (unfold PO_dispose1_fsbmwhy_def)
(* Strategy 1: Structural Bd *)
apply (intro allI impI, elim conjE)
(* Strategy 2: Zoom (i.e. dispose pre/post and artificial ext *)
apply (unfold dispose1_pre_def dispose1_post2_def dispose1_ext_def)
(* Strategy 3. Single point ex wit *)
apply (rule_tac x= "(dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) -\<triangleleft> f \<union>m
            [min_loc (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s]) \<mapsto>
             HEAP1.sum_size (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s])]" in exI)
  
(* Strategy 4: Split-Invariant-Postcond *)
apply (rule conjI)
(* Strategy 5: tool automation *)
apply (simp)

(* Strategy 6: Invariant Zoom 
    OPTION 1: dispose based definitions for above and below before inv
                and argument for OPTION1 is to try and reuse the inv-bd
                from NEW1 in dipose, if only there were no dispose1-realted fcn symbols?

                another argument: the overal goal complexity is much higher in OPTION2?

                another: NEW1 strategy deals wih F1_inv over \<union>m and -\<triangleleft>, which is what is
                         needed here (i.e. reuse)

                         Rippling if applied to this would generate lemmas in terms of these
                         top symbols

                         the case analysis on above/below will come from the side conditions
                         of \<union>m needing disjoint domains, which will entail investigating the
                         nature and relationship between above and below, hence the hidden case

                         this will lead to the next set of justifications (attempts). TO BE SEEN...

               apply (unfold dispose1_above_def dispose1_below_def)

    OPTION 2: after the invariant?
      apply (unfold F1_inv_def)
      apply simp
      Strategy: Zoom - unfold the invariant x getting lemmas to pass the invariant over \<union>m 

    OPTION3: expand neither, and use the liheap pattern that create a lemma for invariant update/breakdown [section 3.2]
 *)
oops
thm  new1_feas_invbd_a4_max_a1
      l_disjoint_subset_trans  
      new1_feas_invbd_a2_max 
      l_locs_dom_ar_subset 
      new1_feas_invbd_a2_mapop_a2

lemma dispose1_feas_invbd_a2: " F1_inv f \<Longrightarrow>
       nat1 s \<Longrightarrow>
       disjoint (locs_of d s) (locs f) \<Longrightarrow>
       F1_inv
       (((dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) -\<triangleleft> f) \<union>m
         [min_loc (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s]) \<mapsto>
          HEAP1.sum_size (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s])])"
(* Strategy 1: apply rippling - see also heap_rippling = should we generalise this lemma? 

    = rippling will make progress and suggest stuff (we need some help?)
    = we will simply use our invariant breakdown pattern which is a small subset of rippling
    = in this case, rather than in NEW 1 (above), we hope that invariant breakdown will be able
      to reuse lemmas instead of the speculation, saving us some work. Only the preconditions
      would then be needed.
*)
(* Strategy 2: use the 'map types' generalisation of IB to get a suggestion 
   to use new1_feas_invbd_a2_mapop_a2
*)
apply (rule new1_feas_invbd_a2_mapop_a2)
(* Strategy 3: hypothesis frm IB (tool automation) *)
apply assumption
apply (metis F1_inv_def dispose1_ext_def l_nat1_sum_size_dispose1_ext)
oops

lemma l_above_below_munion_dom_disjoint: "dom (dispose1_above f d s) \<inter> dom (dispose1_below f d) = {}" oops

(* Now using the general (max) version of IB *)
lemma dispose1_feas_invbd_a3: " F1_inv f \<Longrightarrow>
       nat1 s \<Longrightarrow>
       disjoint (locs_of d s) (locs f) \<Longrightarrow>
       F1_inv
       (((dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) -\<triangleleft> f) \<union>m
         [min_loc (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s]) \<mapsto>
          HEAP1.sum_size (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s])])"
apply (rule  new1_feas_invbd_a2_max)
apply (metis new1_feas_invbd_a4_max_a1) (* But actually, we should use IB patter for this *)
apply (metis HEAP1LemmasIJW.invF1I HEAP1LemmasIJW.invF1_finite_weaken HEAP1LemmasIJW.invF1_nat1_map_weaken HEAP1LemmasIJW.invF1_sep_weaken dispose1_ext_def finite_singleton l_nat1_map_singleton l_nat1_sum_size_dispose1_ext l_sep_singleton singleton_Disjoint)
defer defer
(*
find_theorems name:iff name:disjoint 
apply (subst disjoint_iff_not_equal)
apply (intro ballI)
*)
apply (simp)
find_theorems "dom(_ -\<triangleleft> _)"
apply (subst l_dom_dom_ar)
find_theorems "min_loc _"
thm k_min_loc_munion k_min_loc_munion_singleton
  (* Assuming we have these lemma about maps over min loc that an expert creates? *)
apply (subst k_min_loc_munion)
apply (metis HEAP1LemmasIJW.invF1_finite_weaken k_finite_dispose_abovebelow_munion nat1_def)
apply (metis finite_singleton)
apply (metis map_upd_nonempty)
find_theorems "dom(_ \<union>m _)"
find_theorems name:iff name:disjoint
(*apply (simp add: f_d1_not_dispose_abovebelow_ext) TODO: avoid simp? *)
apply simp
apply (subst f_d1_not_dispose_abovebelow_ext)
  apply (metis HEAP1LemmasIJW.invF1E)
  apply (metis HEAP1LemmasIJW.invF1E)
  apply (metis nat1_def)
  apply metis
  apply(split split_if, intro impI conjI)
find_theorems "min_loc [ _ \<mapsto> _ ]"
(*
  apply (cases "dispose1_above f d s \<union>m dispose1_below f d = Map.empty") (* 'not hidden' case analysis *)
  find_theorems  "(if _ then _ else _)" name:split
*)
apply (subst min_loc_singleton)
apply (subgoal_tac "d \<notin> dom f") (* We can deal with set minus easily *)
apply (metis Diff_iff)
find_theorems "locs _"
apply (simp add:  disjoint_def)
apply (subst f_dispose1_pre_not_in_dom)
  apply (metis HEAP1LemmasIJW.invF1E)
  apply simp
  apply assumption
  apply metis
thm k_min_loc_munion
apply (subst k_min_loc_munion)
  apply (metis (full_types) HEAP1LemmasIJW.invF1_finite_weaken k_finite_dispose_above)
  apply (metis HEAP1LemmasIJW.invF1E k_finite_dispose_below)
  
apply (unfold disjoint_def)
defer
thm l_disjoint_dispose1_ext
oops

lemma k_min_loc_munion_gen_a1:
  "finite (dom f) \<Longrightarrow> finite (dom g) \<Longrightarrow> 
    f \<union>m g \<noteq> empty \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> 
        min_loc(f \<union>m g) = (if f = empty then min_loc g else min (min_loc f) (min_loc g))"
unfolding min_loc_def 
apply (split split_if, intro impI conjI)+
  apply (metis Int_commute Min_in domIff l_munion_commute l_munion_dom sup_inf_absorb)
  apply metis
  apply (metis l_munion_empty_iff)
apply (split split_if, intro impI conjI)+
  find_theorems "dom(_ \<union>m_)"
  apply (subst l_munion_dom)
  apply assumption
apply (simp add: Min.union)
  apply metis
apply (split split_if, intro impI conjI)+
  apply (subst l_munion_dom)
  apply assumption
  apply auto
  unfolding min_def
  apply auto
oops  
  
lemma k_min_loc_munion_gen_a2:
  "finite (dom f) \<Longrightarrow> finite (dom g) \<Longrightarrow> 
    f \<union>m g \<noteq> empty \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> 
        min_loc(f \<union>m g) = (if f = empty then min_loc g else (if g = empty then min_loc f else min (min_loc f) (min_loc g)))"
apply (cases "f = empty")
apply simp
  apply (metis l_munion_empty_lhs)

apply simp
apply (cases "g = empty")
apply (metis l_munion_empty_rhs)
by (metis k_min_loc_munion)

(* Now using the general (max) version of IB = now using generalised form of k_min_loc_munion *)
lemma dispose1_feas_invbd_a4: "F1_inv f \<Longrightarrow>
       nat1 s \<Longrightarrow>
       disjoint (locs_of d s) (locs f) \<Longrightarrow>
       F1_inv
       (((dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) -\<triangleleft> f) \<union>m
         [min_loc (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s]) \<mapsto>
          HEAP1.sum_size (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s])])"
apply (rule  new1_feas_invbd_a2_max)
apply (metis new1_feas_invbd_a4_max_a1) (* But actually, we should use IB patter for this *)
apply (metis HEAP1LemmasIJW.invF1I HEAP1LemmasIJW.invF1_finite_weaken HEAP1LemmasIJW.invF1_nat1_map_weaken HEAP1LemmasIJW.invF1_sep_weaken dispose1_ext_def finite_singleton l_nat1_map_singleton l_nat1_sum_size_dispose1_ext l_sep_singleton singleton_Disjoint)
defer defer
(*
find_theorems name:iff name:disjoint 
apply (subst disjoint_iff_not_equal)
apply (intro ballI)
*)
apply (simp)
apply (subst l_dom_dom_ar)
find_theorems "min_loc _"
thm k_min_loc_munion k_min_loc_munion_singleton
  (* Assuming we have these lemma about maps over min loc that an expert creates? *)
apply (subst k_min_loc_munion_gen_a2)
apply (metis HEAP1LemmasIJW.invF1_finite_weaken k_finite_dispose_abovebelow_munion nat1_def)
apply (metis finite_singleton)
find_theorems "dom(_ \<union>m _)"
find_theorems name:iff name:disjoint
defer
(*apply (simp add: f_d1_not_dispose_abovebelow_ext) TODO: avoid simp? *)
apply simp
apply (subst f_d1_not_dispose_abovebelow_ext)
  apply (metis HEAP1LemmasIJW.invF1E)
  apply (metis HEAP1LemmasIJW.invF1E)
  apply (metis nat1_def)
  apply metis
  apply(split split_if, intro impI conjI)
find_theorems "min_loc [ _ \<mapsto> _ ]"
(*
  apply (cases "dispose1_above f d s \<union>m dispose1_below f d = Map.empty") (* 'not hidden' case analysis *)
  find_theorems  "(if _ then _ else _)" name:split
*)
apply (subst min_loc_singleton)
apply (subgoal_tac "d \<notin> dom f") (* We can deal with set minus easily *)
apply (metis Diff_iff)
find_theorems "locs _"
apply (simp add:  disjoint_def)
apply (subst f_dispose1_pre_not_in_dom)
  apply (metis HEAP1LemmasIJW.invF1E)
  apply simp
  apply assumption
  apply metis
thm k_min_loc_munion
apply (subst k_min_loc_munion_gen_a2)
  apply (metis (full_types) HEAP1LemmasIJW.invF1_finite_weaken k_finite_dispose_above)
  apply (metis HEAP1LemmasIJW.invF1E k_finite_dispose_below)
  apply assumption
  defer
  apply (split split_if, intro impI conjI)
    apply (metis map_upd_nonempty)
    find_theorems "min_loc [_ \<mapsto> _]"
    apply (subst l_min_loc_singleton)
    apply (subst k_min_loc_munion_gen_a2)
      apply (metis HEAP1LemmasIJW.invF1E k_finite_dispose_above)
      apply (metis HEAP1LemmasIJW.invF1E k_finite_dispose_below)
      apply assumption
      defer
      apply (split split_if, intro conjI impI)
          unfolding min_def        
          apply (split split_if, intro conjI impI)
          find_theorems  name:min_loc name:dom         

      apply (subst Diff_iff)
apply (unfold disjoint_def)
oops

(* OBS: We don't need the case analysis on above and below explicitly, yet 
        without it, the proof becomes quite involved. 

        The case analysis is explicit from the way min_loc is defined.
        Our hunch is that despite that, doing case analysis on above/below
        is a better approach (from user perception), which we could say comes
        from this attempt for IB?
 *)

theorem "PO_dispose1_fsbmwhy"
apply (unfold PO_dispose1_fsbmwhy_def)
(* Strategy 1: Structural Bd *)
apply (intro allI impI, elim conjE)
(* Strategy 2: Zoom (i.e. dispose pre/post and artificial ext *)
apply (unfold dispose1_pre_def dispose1_post2_def dispose1_ext_def)
(* Strategy 3. Single point ex wit *)
apply (rule_tac x= "(dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) -\<triangleleft> f \<union>m
            [min_loc (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s]) \<mapsto>
             HEAP1.sum_size (dispose1_above f d s \<union>m dispose1_below f d \<union>m [d \<mapsto> s])]" in exI)
  
(* Strategy 4: Split-Invariant-Postcond *)
apply (rule conjI)
(* Strategy 5: tool automation *)
apply (simp)

(* Strategy 6: Invariant breakdown - generating a top-level lemma (possibly generalised?) - bar *)
(*by (metis dispose1_feas_invbd_a4)*)
oops

(*
So after a black medicine session, we got deep down in proving the IB
sideconditions for DISPOSE and the case analysis on above and below 
appeared explicitly in if statements from a min-loc lemma.

However, things were really messy at that point.

We stopped.

We then decided to concentrate on something else. Here are the options:

*1) Write some of the NEW and DISPOSE strategies in PSGraph.
*2) Explicitly construct the Heap in MWhy
3) Go to Narrow Post
4) Explore the expert intervention of case analysis in DISPOSE
*5) Explore the matcher and features more concretely
 


*)


lemma "PO_dispose1_fsb"
unfolding PO_dispose1_fsb_def(* UNFOLD *)

apply (subst dispose1_equiv) (* LEMMA AT THAT LEVEL *)

apply (intro allI impI) (* SB *)
apply(elim conjE)

unfolding dispose1_pre_def dispose1_post2_def (* UNFOLD *) 


apply (rule_tac x="(dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) -\<triangleleft> f \<union>m
                 [min_loc (dispose1_ext f d s) \<mapsto> HEAP1.sum_size (dispose1_ext f d s)]" in exI)

apply (rule conjI) (* POST/INV SPLIT *)
defer
unfolding F1_inv_def
apply (intro conjI)
apply(elim conjE)
defer
apply (elim conjE)
defer
apply (elim conjE)
defer
apply (elim conjE)
defer
apply (elim conjE)
(* End split inv post *)

apply (metis) (* AUTOMATION *)

unfolding dispose1_ext_def

apply (rule unionm_singleton_Disjoint)
oops

end
