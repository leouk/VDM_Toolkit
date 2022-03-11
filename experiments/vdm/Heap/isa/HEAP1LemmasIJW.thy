theory HEAP1LemmasIJW
imports HEAP1
begin

(* Invariant simplification rules *)

lemma invF1_sep_weaken: "F1_inv f \<Longrightarrow> sep f"
  unfolding F1_inv_def by simp

lemma invF1_Disjoint_weaken: "F1_inv f \<Longrightarrow> Disjoint f"
  unfolding F1_inv_def by simp

lemma invF1_nat1_map_weaken: "F1_inv f \<Longrightarrow> nat1_map f"
  unfolding F1_inv_def by simp

lemma invF1_finite_weaken: "F1_inv f \<Longrightarrow> finite (dom  f)"
  unfolding F1_inv_def by simp

  lemma invF1E[elim!]: "F1_inv f \<Longrightarrow> (sep f \<Longrightarrow> Disjoint f \<Longrightarrow> nat1_map f \<Longrightarrow> finite (dom f) \<Longrightarrow> R) \<Longrightarrow> R"
  unfolding F1_inv_def by simp

lemma invF1I[intro!]: "sep f \<Longrightarrow> Disjoint f \<Longrightarrow> nat1_map f \<Longrightarrow> finite (dom f) \<Longrightarrow> F1_inv f"
unfolding F1_inv_def by simp

lemma invF1_shape: "nat1_map f \<Longrightarrow> finite (dom f) \<Longrightarrow> VDM_F1_inv f\<Longrightarrow> F1_inv f"
unfolding F1_inv_def VDM_F1_inv_def by simp

lemma invVDMF1[intro!]: "sep f \<Longrightarrow> Disjoint f \<Longrightarrow> VDM_F1_inv f"
  unfolding VDM_F1_inv_def by simp

(******************************************************************)

(* GENERAL (OFTEN SET THEORETIC ) LEMMAS *)

(* Elimination rule for dealing with union of quantifiers *)
lemma ballUnE[elim!]: "\<forall>x\<in>f\<union>g. P x \<Longrightarrow> (\<forall>x\<in> f. P x \<Longrightarrow> \<forall>x\<in>g. P x \<Longrightarrow> R) \<Longrightarrow> R"
by auto

lemma ballUnI[intro!]: "\<forall>x\<in>f. P x \<Longrightarrow> \<forall>x\<in>g. P x \<Longrightarrow> \<forall>x\<in>f\<union>g. P x"
by auto


lemma setminus_trans: "X - insert x F = (X - F) - {x}"
by (metis Diff_insert)


lemma UN_minus: "\<forall>x\<in>X-{y}. P x \<inter> P y = {} \<Longrightarrow> (\<Union> x \<in> X-{y}. P x) = (\<Union>x\<in>X. P x) - P y"
by blast

lemma UN_minus_gen:
  "\<forall>x\<in>X. \<forall> y\<in> Y. P x \<inter> P y = {} \<Longrightarrow> (\<Union> x \<in> X-Y. P x) = (\<Union>x\<in>X. P x) - (\<Union>y\<in>Y. P y)"
by blast


lemma union_comp: "{x\<in>A \<union> B. P x} = {x\<in> A. P x} \<union>  {x\<in> B. P x}" 
by auto


lemma nat_min_absorb1: "min ((x::nat) + y) x = x"
  by auto


(******************************************************************)

(* Lemmas about Locs and locs and locs_of *)

(* Not in the locs means not in the domain *)
lemma not_dom_not_locs_weaken: "nat1_map f \<Longrightarrow> x \<notin> locs f \<Longrightarrow> x \<notin> dom f"
apply (unfold locs_def)
apply simp
apply (cases "x\<in> dom f")
prefer 2
apply simp
apply (erule_tac x="x" in ballE)
prefer 2
apply simp
apply (unfold locs_of_def)
apply (subgoal_tac "nat1 (the (f x))")
apply simp
by (metis nat1_map_def)

lemma k_locs_of_arithI:
	"nat1 n \<Longrightarrow> nat1 m \<Longrightarrow> a+n \<le> b \<or> b+m \<le> a \<Longrightarrow> locs_of a n \<inter> locs_of b m = {}"
unfolding locs_of_def
by auto


lemma k_locs_of_arithIff:
	"nat1 n \<Longrightarrow> nat1 m \<Longrightarrow> (locs_of a n \<inter> locs_of b m = {}) = (a+n \<le> b \<or> b+m \<le> a)"
unfolding locs_of_def
apply simp
apply (rule iffI)
apply (erule equalityE)
apply (simp_all add: disjoint_iff_not_equal)
apply (metis (full_types) add_0_iff le_add1 le_neq_implies_less nat_le_linear not_le)
by (metis le_trans not_less)

lemma k_locs_of_arithE:
	"locs_of a n \<inter> locs_of b m = {} \<Longrightarrow> nat1 m \<Longrightarrow> nat1 n \<Longrightarrow> (a+n \<le> b \<or> b+m \<le> a \<Longrightarrow> nat1 n \<Longrightarrow> nat1 m  \<Longrightarrow> R) \<Longrightarrow> R"
by (metis k_locs_of_arithIff)

lemma l_locs_of_Locs_of_iff:
	"l \<in> dom f \<Longrightarrow> Locs_of f l = locs_of l (the (f l))"
unfolding Locs_of_def
by simp

lemma k_inter_locs_iff: "nat1 s \<Longrightarrow> nat1_map f \<Longrightarrow> (locs_of x s \<inter> locs f = {}) = (\<forall> y \<in> dom f . locs_of x s \<inter> locs_of y (the(f y)) = {})"
unfolding locs_def 
by (smt UNION_empty_conv(1) inf_SUP)

lemma k_in_locs_iff: "nat1_map f \<Longrightarrow> (x \<in> locs f) = (\<exists>y \<in> dom f . x \<in> locs_of y (the(f y)))"
unfolding locs_def
by (metis (mono_tags) UN_iff)

lemma l_locs_of_within_locs:
  "nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow> locs_of x (the(f x)) \<subseteq> locs f"
by (metis k_in_locs_iff subsetI)

lemma b_locs_of_as_set_interval:
	"nat1 n \<Longrightarrow> locs_of l n = {l..<l+n}"
unfolding locs_of_def
by (metis Collect_conj_eq atLeastLessThan_def atLeast_def lessThan_def)

lemma locs_of_subset: "nat1 (m - s) \<Longrightarrow> locs_of (l + s) (m - s) \<subseteq> locs_of l m"
apply (subst b_locs_of_as_set_interval, simp)
apply (subst b_locs_of_as_set_interval,simp)
by simp

(*
lemma locs_of_subset_range: "y>0 \<Longrightarrow> z>0 \<Longrightarrow> y < z \<Longrightarrow> locs_of x y \<subseteq> locs_of x z" 
 by(simp add: b_locs_of_as_set_interval)
*)


lemma domf_in_locs: "nat1_map f \<Longrightarrow> dom f \<subseteq> locs f"
unfolding locs_def
apply simp
by (metis locs_def not_dom_not_locs_weaken subsetI)

lemma locs_of_finite: "nat1 s \<Longrightarrow> finite (locs_of l s)"
unfolding locs_of_def by auto



lemma l_dom_in_locs_of:  "nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow>  x \<in> locs_of x (the (f x))"
apply(subst b_locs_of_as_set_interval)
  apply (simp add: nat1_map_def)
apply (simp add: nat1_map_def)
done

lemma locs_of_unique: "nat1 y \<Longrightarrow> nat1 y' \<Longrightarrow> locs_of x y = locs_of x' y' \<Longrightarrow> x = x' \<and> y = y'"
  apply (simp add: b_locs_of_as_set_interval)
by (simp add: atLeastLessThan_eq_iff)

lemma locs_of_uniquerange: "nat1 y \<Longrightarrow> nat1 y' \<Longrightarrow> locs_of x y = locs_of x y' = (y = y')"
  apply (simp add: b_locs_of_as_set_interval)
by (metis add_diff_cancel_left' card_atLeastLessThan)

lemma locs_of_uniquedom: "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> x\<in> dom f \<Longrightarrow> x'\<in> dom g \<Longrightarrow> locs_of x (the (f x)) = locs_of x' (the (g x')) \<Longrightarrow> x = x'"
unfolding nat1_map_def
apply (erule_tac x=x in allE)
apply (erule_tac x=x' in allE)
apply (erule impE) apply simp
apply (erule impE) apply simp
by (metis locs_of_unique )


lemma locs_of_edge: "x - 1  \<in> locs_of a b \<Longrightarrow> x \<notin> locs_of a b \<Longrightarrow> nat1 b \<Longrightarrow> x = a+b"
   by (auto simp add: b_locs_of_as_set_interval)


lemma locs_empty: "locs empty = {}" unfolding locs_def 
by (metis SUP_empty dom_empty empty_iff nat1_map_def)

lemma empty_locs_empty_map: "nat1_map f \<Longrightarrow> locs f = {} \<Longrightarrow> f = empty"
  unfolding locs_def apply simp
  by (metis domIff empty_iff l_dom_in_locs_of)

lemma locs_of_pred: "x\<noteq>a \<Longrightarrow> nat1 b \<Longrightarrow> x \<in> locs_of a b 
        \<Longrightarrow> x - 1 \<in> locs_of a b" 
        apply (simp add: b_locs_of_as_set_interval) by auto

(* Name?? *)
lemma locs_of_pred2: assumes xgr0: "x>0" and nat1f: "nat1_map f"
      and minusone: "x - 1 \<in> locs_of a (the (f a))"
      and xindom: "x \<in> dom f" and aindom: "a \<in> dom f"
      and Disj: "Disjoint f"
      shows "x \<notin> locs_of a (the (f a))"
proof -
 have "x\<in> locs_of x (the (f x))" by (metis l_dom_in_locs_of nat1f xindom)
 from Disj have "locs_of x (the (f x)) \<inter>  locs_of a (the (f a)) = {}"
 unfolding Disjoint_def disjoint_def Locs_of_def apply simp
 apply (erule_tac x = x in ballE)
 apply (erule_tac x = a in ballE)
 apply (erule impE)
 apply (rule notI)
 proof -
 assume "x=a"
 then have *: "x - 1 \<in> locs_of x (the (f x))" by (metis minusone)
 have **: "x - 1 \<notin> locs_of x (the (f x))"
  apply (subst b_locs_of_as_set_interval)
  apply (metis nat1_map_def nat1f xindom)
 using xgr0 by auto
 from * ** show "False" by auto
next
  assume " locs_of x (the (f x)) \<inter> locs_of a (the (f a)) = {}"
  then show "locs_of x (the (f x)) \<inter> locs_of a (the (f a)) = {}"
  by simp
next
  assume "a \<notin> dom f"
  then show "locs_of x (the (f x)) \<inter> locs_of a (the (f a)) = {}" using aindom by auto
next
  assume "x \<notin> dom f" then show " locs_of x (the (f x)) \<inter> locs_of a (the (f a)) = {}"
  using xindom by simp
qed
then show "x \<notin> locs_of a (the (f a))"
   by (metis `x \<in> locs_of x (the (f x))` disjoint_iff_not_equal)  
qed

lemma locs_of_extended: "\<exists>y\<in>locs_of x a. y \<notin> locs_of x b \<Longrightarrow> nat1 a \<Longrightarrow> nat1 b \<Longrightarrow> a > b"
apply (erule bexE)
 by (simp add: b_locs_of_as_set_interval)

(* If the invariant holds, then a value l+s will
   not be in the domain if l is in the domain and
   s is within its range 
*)
lemma l_plus_s_not_in_f:
assumes  inv: "F1_inv f" and lindom: "l \<in> dom f" 
  and f1biggers: "the(f l) > s"and nat1s: "nat1 s" 
  shows "l+s \<notin> dom f"
proof
  assume lsindom: "l + s \<in> dom f"
  then obtain y where "the (f (l+s)) = y" by auto
   have *: "nat1 (the(f(l+s)))" by (metis inv invF1_nat1_map_weaken lsindom nat1_map_def)
  from f1biggers have "l+ the(f l) > l+s" by auto
  from inv have inlocs:"l+s \<in> locs_of l (the(f l))" 
  proof
   have "nat1 (the(f l))" by (metis inv invF1_nat1_map_weaken lindom nat1_map_def)
   then show ?thesis 
    unfolding locs_of_def     
    by (simp add: f1biggers)    
  qed
  have notl: "l+s \<noteq> l" using nat1s by auto
  have notinlocs: "l+s \<notin> locs_of l (the(f l))"
  proof -
    have "locs_of (l+s) (the(f(l+s))) \<inter>   locs_of l (the(f l)) = {}"
      by (metis (full_types) Disjoint_def F1_inv_def Locs_of_def
        disjoint_def inv lindom lsindom notl)
      moreover have "l+s \<in> locs_of (l+s) (the(f(l+s)))"
        unfolding locs_of_def using * by simp
      ultimately show ?thesis  by auto
    qed
    from inlocs notinlocs show "False" by auto
qed

lemma top_locs_of: "nat1 y \<Longrightarrow> x + y - 1 \<in> locs_of x y"
unfolding locs_of_def
by simp

lemma  top_locs_of2: "(the (f l)) > s \<Longrightarrow> nat1 s \<Longrightarrow>  l + s - 1 \<in> locs_of l (the (f l))"
unfolding locs_of_def
  by auto

lemma minor_sep_prop: "x \<in> dom f \<Longrightarrow> l \<in> dom f\<Longrightarrow> l<x \<Longrightarrow> F1_inv f\<Longrightarrow>  l + the (f l) \<le> x" 
apply(erule invF1E)
 apply (unfold Disjoint_def)
apply(erule_tac x="x" in ballE)
apply(erule_tac x="l" in ballE)
apply (erule impE)
apply simp
apply (unfold disjoint_def)
apply (unfold Locs_of_def)
apply simp
apply (erule k_locs_of_arithE)
apply (metis nat1_map_def)
apply (metis nat1_map_def)
apply (metis add_leE not_less)
apply metis
by metis


(* Fairly large result. Says that under the invariant, if the locs are unique, then the maps are
   identical. Difficult proof 
*)

theorem locs_unique:
  assumes locs_eq: "locs f = locs g"
  and invf: "F1_inv f"
  and invg: "F1_inv g"
  and notempf: "f \<noteq> empty" and notempg: "g \<noteq> empty"
  shows "f = g"
proof - (* Idea of the proof: show domains are identical; then show that each range is equal *) 
  have dom_eq: "dom f = dom g"
  proof (rule ccontr)
   
    assume doms_not_equal: "dom f \<noteq> dom g"
    have elem_in_fnotg_or_gnotf: "(\<exists> x \<in> dom f. x \<notin> dom g) \<or> (\<exists> x \<in> dom g. x \<notin> dom f)" 
      by (metis (full_types) doms_not_equal subsetI subset_antisym)
    then show "False"
    proof(elim bexE disjE)
      fix x
      assume xinf: "x \<in> dom f" and xnoting: "x \<notin> dom g"
      show "False"
      proof (cases "x>0") (* We need to ensure it's not the first possible item *)
        assume xgr0: "x>0"
        have "x \<in> locs_of x (the (f x))" 
          by (metis invF1_nat1_map_weaken invf l_dom_in_locs_of xinf)
        then have "x\<in> locs f" 
          by (metis invF1_nat1_map_weaken invf not_dom_not_locs_weaken xinf)
        then have "x \<in> locs g" 
          by (metis locs_eq)  
        then have "\<exists>y \<in> dom g. x\<in> locs_of y (the (g y))"
          by (metis invF1_nat1_map_weaken invg k_in_locs_iff)
        then obtain y where ying: "y\<in> dom g" and xlocsofy: "x\<in> locs_of y (the (g y))" 
          by auto
        from  ying xlocsofy have "x \<noteq> y" by (metis xnoting)
        then have "x - 1 \<in> locs_of y (the (g y))" 
          by (metis invF1_nat1_map_weaken invg locs_of_pred nat1_map_def xlocsofy ying)
        then have "x - 1 \<in> locs g" by (metis invF1_nat1_map_weaken invg k_in_locs_iff ying)
        then have xminus1_in_locsf: "x - 1 \<in> locs f" by (metis locs_eq) (* By contradiction: FIRST ITEM *)
        (* Now show from sepa and disjoint that this cannot be the case *)
        from invf have sepf: "sep f" by (rule invF1_sep_weaken)
        from invf have Disjf: "Disjoint f" by (rule invF1_Disjoint_weaken)
        have "x - 1 \<notin> locs f"
        proof
          let ?x' = "x - 1"
          assume xminusinlocs: "?x' \<in> locs f"
          then have "\<exists> below \<in> dom f. ?x' \<in> locs_of below (the (f below))"
            by (metis invF1_nat1_map_weaken invf k_in_locs_iff)
          then obtain below where belowinf: "below\<in> dom f"  
              and locsofbelow: "?x' \<in> locs_of below (the (f below))"
                by auto
          have "x\<in> dom f" by (metis xinf)
          have notlocsofx: "x \<notin> locs_of below (the (f below))"
            by (metis invF1E belowinf invf locs_of_pred2 locsofbelow xgr0 xinf)
          from locsofbelow notlocsofx have "x = below + the (f below)" 
            using belowinf invf locs_of_edge nat1_map_def by blast
          thus "False" by (metis belowinf sep_def sepf xinf)
        qed
        thus "False" by (metis xminus1_in_locsf)
       next (* if x is zero, things are simpler *)
        assume "\<not> x >0"
        then have xzero: "x = 0" by (metis neq0_conv)
        have "x \<in> locs_of x (the (f x))" 
            by (metis invF1_nat1_map_weaken invf l_dom_in_locs_of xinf)
        then have "x\<in> locs f" 
          by (metis invF1_nat1_map_weaken invf not_dom_not_locs_weaken xinf)
        then have "x \<in> locs g" by (metis locs_eq)  
        then have "\<exists>y \<in> dom g. x\<in> locs_of y (the (g y))" by (metis invF1_nat1_map_weaken invg k_in_locs_iff)
        then obtain y where ying: "y\<in> dom g" and xlocsofy: "x\<in> locs_of y (the (g y))" 
        by auto
        have ynoteqx: "y \<noteq> x" by (metis xnoting ying) (* ONE PART OF CONTRADICTION *)
        (* NEXT PART *)
        have "locs_of y (the (g y)) =  {y..<y + (the (g y))}"
          by (metis b_locs_of_as_set_interval invF1_nat1_map_weaken invg nat1_map_def ying)
        then have "x \<in> {y..<y + (the (g y))}" by (metis xlocsofy)
        then have xeqy: "x = y" using xzero by auto
        from ynoteqx and xeqy show "False" by simp
      qed
     next (* Second case in disjunction for contradiction *)
      fix x 
      assume xing: "x \<in> dom g"
      and xnotinf: "x\<notin> dom f" 
      show "False" 
      proof (cases "x>0")
        assume xgr0: "x>0"
        have "x \<in> locs_of x (the (g x))" 
        by (metis invF1_nat1_map_weaken xing invg l_dom_in_locs_of)     
        then have "x\<in> locs g" 
          by (metis invF1_nat1_map_weaken invg not_dom_not_locs_weaken xing)
        then have "x \<in> locs f" by (metis locs_eq)  
        then have "\<exists>y \<in> dom f. x\<in> locs_of y (the (f y))" by (metis invF1_nat1_map_weaken invf k_in_locs_iff)
        then obtain y where ying: "y\<in> dom f" and xlocsofy: "x\<in> locs_of y (the (f y))" 
          by auto
        from  ying xlocsofy have "x \<noteq> y" by (metis xnotinf)
        then have "x - 1 \<in> locs_of y (the (f y))"
         by (metis invF1_nat1_map_weaken invf locs_of_pred nat1_map_def xlocsofy ying) 
        then have "x - 1 \<in> locs f" by (metis invF1_nat1_map_weaken invf k_in_locs_iff ying)
        then have xminus1ing: "x - 1 \<in> locs g" by (metis locs_eq) (* By contradiction: FIRST ITEM *)
        (* Now show from sepa and disjoint that this cannot be the case *)
        from invg have sepg: "sep g" by (rule invF1_sep_weaken)
        from invg have Disjg: "Disjoint g" by (rule invF1_Disjoint_weaken)
        have "x - 1 \<notin> locs g"
        proof
          let ?x' = "x - 1"
          assume xminusinlocs: "?x' \<in> locs g"
          then have "\<exists> below \<in> dom g. ?x' \<in> locs_of below (the (g below))"
             by (metis invF1_nat1_map_weaken invg k_in_locs_iff)
          then obtain below where belowing: "below\<in> dom g"  
                 and locsofbelow: "?x' \<in> locs_of below (the (g below))"
            by auto
          have "x\<in> dom g" by (metis xing)
          have notlocsofx: "x \<notin> locs_of below (the (g below))"
           by (metis Disjg HEAP1LemmasIJW.invF1_nat1_map_weaken 
               belowing invg locs_of_pred2 locsofbelow xgr0 xing)
          from locsofbelow notlocsofx have "x = below + the (g below)" 
           by (metis invF1_nat1_map_weaken belowing invg locs_of_edge nat1_map_def)
          thus "False" by (metis belowing sep_def sepg xing)
        qed
        thus "False" by (metis xminus1ing)
       next (* if x is zero, things are simpler *)
        assume "\<not> x >0"
        then have xzero: "x = 0" by (metis neq0_conv)
        have "x \<in> locs_of x (the (g x))" 
          by (metis invF1_nat1_map_weaken invg l_dom_in_locs_of xing)
        then have "x\<in> locs g" 
           by (metis invF1_nat1_map_weaken invg not_dom_not_locs_weaken xing)
        then have "x \<in> locs f" by (metis locs_eq)  
        then have "\<exists>y \<in> dom f. x\<in> locs_of y (the (f y))" by (metis invF1_nat1_map_weaken invf k_in_locs_iff)
        then obtain y where yinf: "y\<in> dom f" and xlocsofy: "x\<in> locs_of y (the (f y))" 
          by auto
        have ynotx: "y \<noteq> x" by (metis xnotinf yinf) (* ONE PART OF CONTRADICTION *)
         (* NEXT PART *)
        have " locs_of y (the (f y)) =  {y..<y + (the (f y))}" 
         by (metis b_locs_of_as_set_interval invF1_nat1_map_weaken invf nat1_map_def yinf)
        then have "x \<in> {y..<y + (the (f y))}" by (metis xlocsofy)
        then have xeqy: "x = y" using xzero by auto
        from ynotx and xeqy show "False" by simp
      qed
    qed
  qed (* End of lemma *)
  show ?thesis
  proof
    fix x
    show "f x = g x" (* Now a case analysis on dom f and dom g*)
    proof (cases "x \<in> dom f")
      assume xinf: "x \<in> dom f"
      show ?thesis
      proof (cases "x \<in> dom g")
        assume xing: "x\<in> dom g" (* this is the real case *)
        have "(the ( f x)) = (the (g x))"
        proof -
          have nat1fx:  "nat1 (the ( f x))" by (metis invF1_nat1_map_weaken dom_eq invf nat1_map_def xing)
          have nat1gx: "nat1 (the ( g x))" by (metis invF1_nat1_map_weaken dom_eq invg nat1_map_def xing)
          have "locs_of x (the (f x)) = locs_of x (the (g x))"
          proof(rule ccontr)
            assume locs_of_f_not_g:"locs_of x (the (f x)) \<noteq> locs_of x (the (g x))"
            then have "(\<exists> y \<in> locs_of x (the (f x)). y \<notin>  locs_of x (the (g x)))
                      \<or> (\<exists> y \<in> locs_of x (the (g x)). y \<notin>  locs_of x (the (f x)))"
               by auto
            from this show "False"
            proof
              assume "\<exists>y\<in>locs_of x (the (f x)). y \<notin> locs_of x (the (g x))"
              then have fgrg: "the (f x) > the (g x)"
                by (metis locs_of_extended nat1fx nat1gx)
 (* ***** *)  have firstpartcontr: "x + the (g x) \<notin> dom g" 
                  by (metis invF1_sep_weaken invg sep_def xing)
              then have "x + the (g x) \<in> locs_of x (the (f x))"
                by (metis b_locs_of_as_set_interval nat1fx nat1gx  locs_of_f_not_g
                   fgrg locs_of_edge top_locs_of2)
              then have "x + the (g x) \<in> locs f" 
                by (metis invF1_nat1_map_weaken invf k_in_locs_iff xinf)
              then have " x + the (g x) \<in> locs g" by (metis locs_eq)
              then have "\<exists>loc \<in> dom g . x + the (g x) \<in> locs_of loc (the (g loc))"
                by (metis invF1_nat1_map_weaken invg k_in_locs_iff)
              then obtain loc where locing: "loc \<in> dom g" and "x+ the (g x) \<in> locs_of loc (the (g loc))" 
                by auto
              have "x + the (g x) - 1 \<in> locs_of x (the (g x))"
                by (metis nat1gx top_locs_of)
              have locnotg: "loc \<noteq> x"
              proof
                assume loceqx: "loc = x"
                then have "loc+ the (g loc) \<in> locs_of loc (the (g loc))" 
                  by (metis `x + the (g x) \<in> locs_of loc (the (g loc))`)
                moreover have "loc+ the (g loc) \<notin> locs_of loc (the (g loc))"
                  using b_locs_of_as_set_interval by (simp del: nat1_def add: nat1_map_def nat1gx loceqx)
                ultimately show "False" by simp 
              qed
              from invg have "Disjoint g" by (rule invF1_Disjoint_weaken)
              then have " locs_of loc (the (g loc)) \<inter>  locs_of x (the (g x)) = {}"
               unfolding Disjoint_def Locs_of_def (* Tidy proof: basically universal instantiations *)
               apply (simp add: locing)
               apply (erule_tac x="loc" in ballE)
               apply (erule_tac x="x" in ballE)
               apply (erule impE)
               apply (rule locnotg)
               apply (metis disjoint_def)
               apply (simp add: xing)
               by (simp add: locing)    
              have "loc = x + the (g x)" 
               (* SLOW PROOF  *)
               by (metis invF1_nat1_map_weaken 
                         IntI `locs_of loc (the (g loc)) \<inter> locs_of x (the (g x)) = {}` 
                              `x + the (g x) - 1 \<in> locs_of x (the (g x))` 
                              `x + the (g x) \<in> locs_of loc (the (g loc))` 
                         emptyE invg locing locs_of_pred nat1_map_def)
               
             then have "x + the (g x) \<in> dom g" by (metis locing)
             thus "False" using firstpartcontr by auto
            next
             assume "\<exists>y\<in>locs_of x (the (g x)). y \<notin> locs_of x (the (f x))"
             then have ggrf: "the (g x) > the (f x)" by (metis (full_types) locs_of_extended nat1fx nat1gx)
 (* ***** *) have firstpartcontr: "x + the (f x) \<notin> dom f" 
                by (metis invF1_sep_weaken dom_eq invf sep_def xing)
             then have "x + the (f x) \<in> locs_of x (the (g x))"
                by (metis ggrf b_locs_of_as_set_interval locs_of_edge 
                    locs_of_f_not_g nat1fx nat1gx top_locs_of2)
             then have "x + the (f x) \<in> locs g" 
              by (metis invF1_nat1_map_weaken invg k_in_locs_iff xing)
             then have " x + the (f x) \<in> locs f" by (metis locs_eq)
             then have "\<exists>loc \<in> dom f . x + the (f x) \<in> locs_of loc (the (f loc))"
               by (metis invF1_nat1_map_weaken invf k_in_locs_iff)
             then obtain loc where locinf: "loc \<in> dom f" and "x+ the (f x) \<in> locs_of loc (the (f loc))" 
              by auto
             have "x + the (f x) - 1 \<in> locs_of x (the (f x))"
              by (metis nat1fx top_locs_of)
             have locnotg: "loc \<noteq> x"
             proof (* Contradiction *)
               assume loceqx: "loc = x"
               then have "loc+ the (f loc) \<in> locs_of loc (the (f loc))" 
                by (metis `x + the (f x) \<in> locs_of loc (the (f loc))`)
               moreover have "loc+ the (f loc) \<notin> locs_of loc (the (f loc))"
                by (simp del: nat1_def add:  b_locs_of_as_set_interval nat1fx loceqx)
               ultimately show "False" by simp 
             qed
             from invf have "Disjoint f" by (metis invF1_Disjoint_weaken)
             then have " locs_of loc (the (f loc)) \<inter>  locs_of x (the (f x)) = {}"
              unfolding Disjoint_def Locs_of_def
              apply (simp add: locinf)
              apply (erule_tac x="loc" in ballE)
              apply (erule_tac x="x" in ballE)
              apply (erule impE)
              apply (rule locnotg)
              apply (metis disjoint_def)
              apply (simp add: xinf)
              by (simp add: locinf)    
             have "loc = x + the (f x)"  
(* SLOW PROOF  *)
              by (metis invF1_nat1_map_weaken 
                        IntI `locs_of loc (the (f loc)) \<inter> locs_of x (the (f x)) = {}` 
                             `x + the (f x) - 1 \<in> locs_of x (the (f x))` 
                             `x + the (f x) \<in> locs_of loc (the (f loc))` 
                        emptyE invf locinf locs_of_pred nat1_map_def)
             then have "x + the (f x) \<in> dom f" by (metis locinf)
             thus "False" using firstpartcontr by auto
           qed
         qed
         then show ?thesis by (metis (full_types) locs_of_unique nat1fx nat1gx)
       qed
       thus ?thesis
        using xinf xing by auto
      next (* Next 2 conditions are trivial contradictions from the dom equals theorem *)
       assume notg: "x \<notin> dom g" then have notf:"x \<notin> dom f"
         using dom_eq by simp
       from notg notf show ?thesis by auto
     qed
    next
     assume xnotf: "x \<notin> dom f" (* Don't need a nested case analysis here *)
     then have "x\<notin> dom g" using dom_eq by simp
     thus ?thesis using xnotf by auto
   qed
 qed
qed

lemma locs_singleton:
    assumes *: "nat1 y"
    shows "locs [x \<mapsto> y] = locs_of x y"
proof -
  from * have "nat1_map [x \<mapsto> y]"
    by (simp add: nat1_map_def)
  then show ?thesis unfolding locs_def by simp
qed


lemma locs_of_subset_range: "x > 0 \<Longrightarrow> y > 0 \<Longrightarrow> locs_of l x \<subseteq> locs_of l y \<Longrightarrow> y \<ge> x"
 by(simp add: b_locs_of_as_set_interval)

lemma locs_of_subset_range_gr:
    shows "x>0 \<Longrightarrow> y > 0  \<Longrightarrow> l > l' \<Longrightarrow> locs_of l x \<subseteq> locs_of l' y \<Longrightarrow> y \<ge> x"
by (simp add: b_locs_of_as_set_interval)

lemma locs_of_subset_top_bottom: "b > 0 \<Longrightarrow> y > 0 \<Longrightarrow> a \<in> locs_of x y \<Longrightarrow> a + b - 1 \<in> locs_of x y \<Longrightarrow> locs_of a b \<subseteq> locs_of x y"
apply (simp add: b_locs_of_as_set_interval)
by auto

lemma less_a_not_in_locs_of: "b>0 \<Longrightarrow> a > l \<Longrightarrow> l \<notin> locs_of a b"
  apply (subst b_locs_of_as_set_interval)
  apply simp
  by simp

lemma edge_not_in_locs_of: "b>0 \<Longrightarrow> a+b \<notin> locs_of a b"
  apply (subst b_locs_of_as_set_interval)
  apply simp
  by simp


lemma after_locs_of_not_in_locs: assumes invf: "F1_inv f1"
  and mindom: "m\<in> dom f1"
shows "m + (the (f1 m)) \<notin> locs f1"
proof
  assume " m + the (f1 m) \<in> locs f1"
  then have "\<exists>n \<in> dom f1.  m + the (f1 m) \<in> locs_of n (the (f1 n))"
  by (metis invF1_nat1_map_weaken invf k_in_locs_iff)
  then obtain n where nindom: "n\<in> dom f1" and   
          locsofn: "m + the (f1 m) \<in> locs_of n (the (f1 n))"
            by auto
  have " m + the (f1 m) \<notin> locs_of m (the (f1 m))" 
  apply (rule edge_not_in_locs_of) 
by (metis invF1_sep_weaken add_0_iff gr0I invf mindom sep_def)  
  then have "m \<noteq> n" by (metis locsofn) 
  have "sep f1" by (metis invF1_sep_weaken invf)
  then have " m + the (f1 m) \<notin> dom f1" by (metis mindom sep_def)
  moreover have "m + the (f1 m) \<in> dom f1"
  proof (rule ccontr)
    assume "m + the (f1 m) \<notin> dom f1"
   have "m + the (f1 m) \<in> locs_of n (the (f1 n))" by (metis locsofn)
   then have "m + the (f1 m) - 1 \<in> locs_of n (the (f1 n))" 
    by (metis invF1_nat1_map_weaken `m + the (f1 m) \<notin> dom f1` invf locs_of_pred nat1_map_def nindom)
   moreover have "m + the (f1 m) - 1 \<in> locs_of m (the (f1 m))"  
      by (metis invF1_nat1_map_weaken invf mindom nat1_map_def top_locs_of)
   moreover have "Disjoint f1" by (metis invF1_Disjoint_weaken invf)
   moreover  have "locs_of n (the (f1 n)) \<inter> locs_of m (the (f1 m)) = {}"  
        by (metis Disjoint_def `m \<noteq> n`  calculation(3) disjoint_def 
                l_locs_of_Locs_of_iff mindom nindom)
   ultimately show "False" by auto
   qed
   ultimately show "False" by auto
qed

lemma locs_of_boundaries: "b > 0 \<Longrightarrow> l\<in> locs_of a b \<Longrightarrow> l\<ge> a \<and> l < a+b"
    by (simp add: b_locs_of_as_set_interval)

lemma locs_locs_of_subset:
  assumes subset: "locs_of l s1 \<subseteq> locs f1"
  and invf: "F1_inv f1"
  and nat1s1: "nat1 s1"
  shows " \<exists>m \<in> dom f1. locs_of l s1 \<subseteq> locs_of m (the (f1 m))"
proof -
  have "l \<in> locs_of l s1" using nat1s1 
    by (simp add: b_locs_of_as_set_interval)
   then  have "l \<in> locs f1" using subset by auto
   then have "l \<in>(\<Union>s\<in>dom f1. locs_of s (the (f1 s)))"
    unfolding locs_def Locs_of_def 
     by (simp add: invf invF1_nat1_map_weaken)    
    have "\<exists> m\<in> dom f1. l \<in> locs_of m (the (f1 m))"
     by (metis invF1_nat1_map_weaken `l \<in> locs f1` invf k_in_locs_iff)    
   then obtain m where mindom: "m\<in>dom f1" and (* First thing I need *)
               linlocsof: "l \<in> locs_of m (the (f1 m))"
     by auto
   (* First step done *)
   have "l+s1 - 1 \<in> locs_of l s1"
     by (metis nat1s1 top_locs_of)
   then have "l+s1 - 1 \<in> locs f1" (* Do I need? *)
     by (metis set_mp subset)
   then have "\<exists> n\<in> dom f1. l+s1 - 1 \<in> locs_of n (the (f1 n))"
     by (metis invF1_nat1_map_weaken invf k_in_locs_iff)    
   then obtain n where nindom: "n\<in>dom f1" and (* First thing I need *)
             lplusinlocsof: "l+s1 - 1  \<in> locs_of n (the (f1 n))"
     by auto    
   (* Second step done*)
   have meqn: "m = n"
   proof (rule ccontr)
     assume noteq: "m\<noteq>n"
     then have "m + (the (f1 m)) \<in> locs_of l s1"
     proof -
       have "m \<le> l" 
       
by (meson invF1_nat1_map_weaken invf linlocsof locs_of_boundaries mindom nat1_def nat1_map_def)
       moreover have "l < m + the (f1 m)" by (metis invF1_nat1_map_weaken invf linlocsof locs_of_boundaries mindom nat1_def nat1_map_def)
       moreover have "n \<le> l + s1 - 1" 
by (meson invF1_nat1_map_weaken invf leI less_a_not_in_locs_of lplusinlocsof nat1_def nat1_map_def nindom)
       moreover have "l+s1 - 1 < n + the (f1 n)" 
by (metis invF1_nat1_map_weaken add.right_neutral after_locs_of_not_in_locs gr0I invf locs_of_boundaries lplusinlocsof nindom not_dom_not_locs_weaken)
       moreover have "m+the(f1 m) \<le> n"
       proof(rule ccontr)
         assume *: " \<not> m + the (f1 m) \<le> n"
         then  have **: "n < m + the (f1 m)" by (metis not_less)
         moreover have "n \<ge> m"  (* HERE!!! need mior sep prop...*)
           using `l + s1 - 1 < n + the (f1 n)` `m \<le> l`
                 invf mindom minor_sep_prop  nat1s1 nindom
by (meson `l + s1 - 1 \<in> locs_of l s1` leD leI le_trans locs_of_boundaries nat1_def)
         moreover have ***: "n \<in> locs_of m (the (f1 m))"
using "*" calculation(2) invf mindom minor_sep_prop nindom noteq by auto
         moreover have "Disjoint f1" by (metis invF1_Disjoint_weaken invf)
         moreover have "locs_of n (the (f1 n)) \<inter> locs_of m (the (f1 m)) = {}"
using "*" calculation(2) invf mindom minor_sep_prop nindom noteq by auto
         moreover have "n \<in> locs_of n (the (f1 n))" 
             by (metis invF1_nat1_map_weaken invf l_dom_in_locs_of nindom)
         ultimately show "False"
           by auto
       qed  
       ultimately show ?thesis by (auto simp: b_locs_of_as_set_interval nat1s1)
     qed
     moreover have "m + (the (f1 m)) \<notin> locs f1"
         by (metis after_locs_of_not_in_locs invf mindom)
     ultimately show "False" by (metis in_mono subset)
   qed
   have "locs_of l s1 \<subseteq> locs_of m (the (f1 m))"
   proof (rule locs_of_subset_top_bottom)
     show "0 <s1" by (metis nat1_def nat1s1)
    next
     show " 0 < the (f1 m)" by (metis invF1_sep_weaken invf mindom 
               monoid_add_class.add.right_neutral neq0_conv sep_def)
    next 
     show "l \<in> locs_of m (the (f1 m))"  by (rule linlocsof)
    next 
     show " l + s1 - 1 \<in> locs_of m (the (f1 m))" by (metis lplusinlocsof meqn)
   qed
   thus ?thesis by (metis meqn nindom)
qed



(******************************************************************)

(* Lemmas about nat1 and nat1_map  *)


lemma nat1_map_empty: "nat1_map empty" 
    by (metis dom_empty empty_iff nat1_map_def)


(* Domain antirestriction preserves nat1ness *)
lemma dom_ar_nat1_map:
  assumes *: "nat1_map f"
  shows "nat1_map  (s -\<triangleleft> f)"
unfolding nat1_map_def dom_antirestr_def
using * nat1_map_def by (simp add: domIff)


(* Nat1 holds over daggering *)
lemma dagger_nat1_map:
 "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> nat1_map (f \<dagger> g)"
unfolding nat1_map_def dagger_def by (metis (full_types) Un_iff dom_map_add map_add_dom_app_simps(1) map_add_dom_app_simps(3))

(* Furthermore, it holds for munion! *)
lemma unionm_nat1_map:
 "dom f \<inter> dom g = {} \<Longrightarrow> nat1_map f \<Longrightarrow> nat1_map g  \<Longrightarrow> nat1_map (f \<union>m g)"
unfolding munion_def
 by (simp add: dagger_nat1_map)

(* Specific variation for munion with a singleton - using a different condition *)
lemma unionm_singleton_nat1_map:
  assumes disjdom: "a \<notin> dom f"   
  and nat1f: "nat1_map f"
  and nat1b: "nat1 b"
shows "nat1_map (f \<union>m [a \<mapsto> b])"
proof (rule unionm_nat1_map)
 show "nat1_map f" by (rule nat1f)
next
 show "nat1_map [a \<mapsto> b]" 
   using nat1b by (simp add: nat1_map_def)
next
  show "dom f \<inter> dom [a \<mapsto> b] = {}"
    using disjdom by simp
qed


lemma locs_of_sum_range: "nat1 y \<Longrightarrow> nat1 z \<Longrightarrow> locs_of x (y+z) = (locs_of x y) \<union> (locs_of (x+y) z)"
apply (subst b_locs_of_as_set_interval)
apply simp
apply (subst b_locs_of_as_set_interval, simp)
apply (subst b_locs_of_as_set_interval, simp)
by auto

(******************************************************************)

(* Lemmas about finiteness  *)

(* Domain antirestriction preserves finiteness *)
lemma dom_ar_finite:
 assumes *: "finite (dom f)"
 shows "finite  (dom (s -\<triangleleft> f))"
proof(rule finite_subset)
 show "dom (s -\<triangleleft> f) \<subseteq> dom f" by (rule f_dom_ar_subset_dom)
 show "finite (dom f)" by (rule *)
qed

(* Dagger is finite *)
lemma dagger_finite:
 assumes *: "finite (dom f)" "finite (dom g)"
 shows "finite  (dom (f \<dagger> g))"
 by (simp add: l_dagger_dom *)

lemma dagger_singleton_finite:
 assumes *: "finite (dom f)"
 shows "finite  (dom (f \<dagger> [a \<mapsto> b]))"
 by (simp add: l_dagger_dom *)

(* munion is finite *)
lemma unionm_finite:
 assumes disjdom: "dom f \<inter> dom g = {}" and *: "finite (dom f)" "finite (dom g)"
 shows "finite  (dom (f \<union>m g))"
by (metis * l_dagger_dom disjdom finite_UnI munion_def)

(* Specific variation to aid isabelle simplification *)
lemma unionm_singleton_finite:
 assumes disjdom: "a \<notin> dom f"
 and *: "finite (dom f)"
 shows "finite (dom (f \<union>m [a \<mapsto> b]))"
by (simp add: unionm_finite * disjdom)




(******************************************************************)

(* Lemmas about separability  *)


(* Domain antirestriction preserves sep *)
lemma dom_ar_sep:
  assumes *:"sep f"
  shows " sep (s -\<triangleleft> f)"
  by (smt * f_in_dom_ar_subsume sep_def f_in_dom_ar_the_subsume)

lemma singleton_sep: "nat1 b \<Longrightarrow> sep [a \<mapsto> b]"
  unfolding sep_def by simp

(* TODO: Refactor this to use Leo's sep0 conccept?! *)
lemma dagger_singleton_sep:
  assumes *: "sep f"
  and ***: "\<forall>l\<in> dom f. l+the (f l) \<notin> dom ([a \<mapsto> b])" (* Leo's sep0 *)
  and ****: "a+b \<notin> dom f" 
  and anotinf: "a \<notin> dom f"
  and nat1b: "nat1 b" (* New condition replacing sep single! *)
  shows "sep (f \<dagger> [a \<mapsto> b])"
unfolding sep_def 
proof(subst l_dagger_dom, rule ballUnI)
  show " \<forall>l\<in>dom f. l + the ((f \<dagger> [a \<mapsto> b]) l) \<notin> dom (f \<dagger> [a \<mapsto> b])" 
    by (metis "*" "***" anotinf dagger_def domIff fun_upd_apply map_add_empty map_add_upd sep_def)
  next 
  show "\<forall>l\<in>dom [a \<mapsto> b]. l + the ((f \<dagger> [a \<mapsto> b]) l) \<notin> dom (f \<dagger> [a \<mapsto> b])" 
proof -
  { fix nn :: nat
    have "nn \<notin> dom [a \<mapsto> b] \<or> nn + the ((f \<dagger> [a \<mapsto> b]) nn) \<notin> dom (f \<dagger> [a \<mapsto> b])"
      by (metis (no_types) "****" UnE add_0_iff dagger_def dom_eq_singleton_conv l_dagger_dom less_irrefl_nat map_add_def map_upd_Some_unfold nat1_def nat1b option.sel option.simps(5) singletonD) }
  thus ?thesis
    by (metis (no_types))
qed
qed

lemma unionm_singleton_sep:
  assumes disjoint_dom:  "a \<notin> dom f"
  and *: "sep f"
  and ***: "\<forall>l\<in> dom f. l+the (f l) \<notin> dom ([a \<mapsto> b])"
  and ****: "a+b \<notin> dom f" (* \<forall> l \<in> dom ([a \<mapsto>b]). l+ the (([a \<mapsto>b])(l) \<notin> dom f *)
  and nat1b: "nat1 b"
  shows "sep (f \<union>m [a \<mapsto> b])"
unfolding munion_def 
apply (simp add: disjoint_dom, rule dagger_singleton_sep)
using assms by simp_all


lemma sep_singleton: "y>0 \<Longrightarrow> sep [x \<mapsto> y]"
  unfolding sep_def by auto

(******************************************************************)

(* Lemmas about Disjoint  *)

lemma dom_ar_Disjoint:
    assumes "Disjoint f"
    shows "Disjoint (s -\<triangleleft> f)" 
unfolding Disjoint_def
by (metis Disjoint_def Locs_of_def assms f_in_dom_ar_subsume f_in_dom_ar_the_subsume)


lemma singleton_Disjoint: "Disjoint [a \<mapsto> b]" 
      by (metis Disjoint_def dom_empty empty_iff l_inmapupd_dom_iff)


lemma disjoint_locs_locs_of_weaken:
    assumes ab_f_disj: "disjoint (locs_of a b) (locs f)" 
    and yinf: "y \<in> dom f"
    and nat1f: "nat1_map f" 
    shows "disjoint (locs_of a b) (locs_of y (the (f y)))"
proof -
  have *: " (locs_of y (the (f y))) \<subseteq> locs f" 
  unfolding locs_def apply (simp add: nat1f)
  proof
   fix x assume "x \<in> locs_of y (the (f y))"
   then show " x \<in> (\<Union>s\<in>dom f. locs_of s (the (f s)))"
   using yinf by auto
  qed
  thus ?thesis by (metis Int_empty_right Int_left_commute 
                  ab_f_disj disjoint_def le_iff_inf)
qed

lemma disjoint_comm: "disjoint X Y = disjoint Y X" 
  unfolding disjoint_def by auto
    
(* LEMMA THAT EXPERT PROVIDES
lemma unionm_singleton_sep:
  assumes disjoint_dom:  "a \<notin> dom f"
  and *: "sep f"
  and ***: "\<forall>l\<in> dom f. l+the (f l) \<notin> dom ([a \<mapsto> b])"
  and ****: "a+b \<notin> dom f"
  and nat1b: "nat1 b"
  shows "sep (f \<union>m [a \<mapsto> b])"
unfolding munion_def 
apply (simp add: disjoint_dom, rule dagger_singleton_sep)
using assms by simp_all
*)

(* EQUIVALANT DISJOINT LEMMA *)
lemma unionm_singleton_Disjoint:
 assumes anotinf: "a \<notin> dom f" (* \<equiv> dom ([a \<mapsto> b]) \<inter> dom f = {}  i.e. \<union>m condition *)
  and disjf: "Disjoint f" (* ind hyp *)
  and nat1f: "nat1_map f"
  and nat1b: "nat1 b"
  and disj: "disjoint (locs_of a b) (locs f)" (* Magic! *)
  shows "Disjoint (f \<union>m [a \<mapsto> b])"



unfolding Disjoint_def 
proof (intro ballI impI)
 fix x y
 assume xindom: "x \<in> dom (f \<union>m [a \<mapsto> b])" 
 and yindom: "y \<in> dom (f \<union>m [a \<mapsto> b])" 
 and xnoty:  "x \<noteq> y"
 (* Main goal to solve *)
 have "disjoint (locs_of x (the ((f \<union>m [a \<mapsto> b]) x))) (locs_of y (the ((f \<union>m [a \<mapsto> b]) y)))"
 (* Rather than Leo's approach, here I introduce case analysis explicitly *)
 proof (cases "x=a")
   assume xeqa: "x = a"
   then show ?thesis
   proof (cases "y = a") (* Contradiction *)
     assume yeqa: "y = a"
     then have "False" using xnoty xeqa by simp
     thus ?thesis ..
    next
    assume ynoteqa: "y \<noteq> a"
    (* The real thing we prove. What is this strategy. I do it quite a lot here. Cleaning the goal? *)
    have yinf: "y \<in> dom f"
       by (rule_tac g="[a \<mapsto>b]" in unionm_in_dom_left, rule yindom, simp add: disj anotinf, simp add: ynoteqa)    
    from disj have "disjoint (locs_of a b) (locs_of y (the (f y)))"
    proof(rule disjoint_locs_locs_of_weaken)
      show "y \<in> dom f" by (rule yinf)
    next
      show "nat1_map f" by (rule nat1f)
    qed
    moreover have " (locs_of x (the ((f \<union>m [a \<mapsto> b]) x))) = locs_of a b"
      by (subst l_the_map_union_right, simp_all add: xeqa anotinf)
    moreover have "(locs_of y (the ((f \<union>m [a \<mapsto> b]) y))) = (locs_of y (the (f y)))"
          by (subst l_the_map_union_left, simp_all add: ynoteqa yinf anotinf)
    ultimately show ?thesis by simp
  qed
 next
  assume xnoteqa: "x \<noteq> a"
  then show ?thesis
  proof (cases "y = a") (* Some degree of repetition here. But is this a result of a strategy. Or
                           something else. Could it be unified? in a nice way? 
                           That makes clear the proof strategy? *) 
    assume yeqa: "y = a"
    have xinf: "x \<in> dom f"
      by (rule_tac g="[a \<mapsto>b]" in unionm_in_dom_left, rule xindom, 
         simp add: disj anotinf, simp add: xnoteqa) 
    from disj have "disjoint (locs_of x (the (f x))) (locs_of a b)"
     proof(subst disjoint_comm, rule disjoint_locs_locs_of_weaken)
      show "x \<in> dom f" by (rule xinf)
    next
      show "nat1_map f" by (rule nat1f)
    qed
    moreover have " (locs_of x (the ((f \<union>m [a \<mapsto> b]) x))) =  (locs_of x (the (f x)))"
        by (subst l_the_map_union_left, simp_all add: xnoteqa xinf anotinf)
    moreover have " (locs_of y (the ((f \<union>m [a \<mapsto> b]) y))) = locs_of a b"
      by (subst l_the_map_union_right, simp_all add: yeqa anotinf)
    ultimately show ?thesis by simp
   next
    assume ynoteqa: "y \<noteq> a"
    then show ?thesis
    proof -    
      have xinf: "x \<in> dom f" 
         by (rule_tac g="[a \<mapsto>b]" in unionm_in_dom_left, 
                rule xindom, simp add: disj anotinf, simp add: xnoteqa)
      have yinf: "y \<in> dom f" 
         by (rule_tac g="[a \<mapsto>b]" in unionm_in_dom_left, 
                rule yindom, simp add: disj anotinf, simp add: ynoteqa)   
      have "disjoint (locs_of x (the (f x))) (locs_of y (the (f y)))" 
        by (metis Disjoint_def xinf yinf disjf l_locs_of_Locs_of_iff xnoty)
      moreover have " (locs_of x (the ((f \<union>m [a \<mapsto> b]) x))) =  (locs_of x (the (f x)))"
        by (subst l_the_map_union_left, simp_all add: xnoteqa xinf anotinf)
      moreover have "(locs_of y (the ((f \<union>m [a \<mapsto> b]) y))) = (locs_of y (the (f y)))"
          by (subst l_the_map_union_left, simp_all add: ynoteqa yinf anotinf)
      ultimately show ?thesis by simp
    qed
  qed
 qed
thus "disjoint (Locs_of (f \<union>m [a \<mapsto> b]) x) (Locs_of (f \<union>m [a \<mapsto> b]) y)"
 unfolding Locs_of_def by (simp add: xindom yindom)
qed

(* Behaviour of locs_of under Disjoint for anti-restriction *)
lemma l_locs_of_dom_ar:
  assumes nat1f: "nat1_map f"
  and disj: "Disjoint f"
  and rinf: "r \<in> dom f"
  shows "locs({r} -\<triangleleft> f) = locs f - locs_of r (the(f r))"
proof -
   have nat1_ar: "nat1_map ({r} -\<triangleleft> f)" using nat1f by (rule dom_ar_nat1_map)
   have " (\<Union>s\<in>dom ({r} -\<triangleleft> f). locs_of s (the (({r} -\<triangleleft> f) s))) =  
          (\<Union>s\<in>dom ({r} -\<triangleleft> f). locs_of s (the (f s)))"
     by (simp add: f_in_dom_ar_the_subsume)
   also have "... =  (\<Union>s\<in>(dom f - {r}). locs_of s (the (f s)))"
    by (metis l_dom_dom_ar)
   also have "... =  (\<Union>s\<in>(dom f). locs_of s (the (f s))) - locs_of r (the (f r))"
   proof (rule UN_minus)
    show "\<forall>x\<in>dom f - {r}. locs_of x (the (f x)) \<inter> locs_of r (the (f r)) = {}"
    proof  (* Here is the subgoal that requires Disjoint *)
      fix x assume xdom: "x \<in> dom f - {r}"
      then have xnotr: "x \<noteq> r" by blast
      have xinf: "x\<in> dom f" using xdom by simp      
      from disj show "locs_of x (the (f x)) \<inter> locs_of r (the (f r)) = {}"
        unfolding Disjoint_def disjoint_def Locs_of_def
        by (auto simp: xdom xnotr xinf rinf) 
    qed
   qed
   also have "... = locs f - locs_of r (the (f r))" by (simp add: locs_def nat1f)
   finally show ?thesis by (simp add: locs_def nat1f nat1_ar)
qed    
   
(******************************************************************)

(* Lemmas about Invariant F1  *)

lemma F1_inv_empty: "F1_inv empty"
unfolding F1_inv_def Disjoint_def sep_def nat1_map_def
by auto

lemma dom_ar_F1_inv:
  assumes inv: "F1_inv f1"
  shows "F1_inv ({l} -\<triangleleft> f1)"
proof -
  from inv show ?thesis
  proof  (* unpacking nvariant as elimination rule *)
    assume  disjf1: "Disjoint f1" 
    and sepf1: "sep f1"
    and nat1_mapf1: "nat1_map f1"  
    and finitef1: "finite (dom f1)"
    show ?thesis (* Packaged into an introduction rule *)
    proof 
      show nat1_conc: "nat1_map ({l} -\<triangleleft> f1)" using nat1_mapf1 by (rule dom_ar_nat1_map)
      show finite_conc: "finite (dom ({l} -\<triangleleft> f1))" using finitef1 by (rule dom_ar_finite)
      show "sep ({l} -\<triangleleft> f1)" using sepf1 by (rule dom_ar_sep)
      show "Disjoint ({l} -\<triangleleft> f1)" using disjf1 by (rule dom_ar_Disjoint)
    qed
  qed
qed

(* Locs of domain antirestriction under the invariant *)
lemma dom_ar_locs: 
  assumes "finite(dom f)"
  and nat1f: "nat1_map f"
  and disj: "Disjoint f"
  and lindom: "l\<in>dom f" 
  shows "locs ({l} -\<triangleleft> f) = (locs f) - locs_of l (the (f l))"
proof -
  have "locs ({l} -\<triangleleft> f) = (\<Union>s\<in>dom ({l} -\<triangleleft> f). locs_of s (the ( ({l} -\<triangleleft> f) s)))"
  proof -
    have "nat1_map ({l} -\<triangleleft> f)" using nat1f by (rule dom_ar_nat1_map) 
    thus ?thesis unfolding locs_def by simp
  qed
  also have "... =  (\<Union>s\<in>dom ({l} -\<triangleleft> f). locs_of s (the (f s)))" (* dom_ar behaves identical to f *)
     by (simp  add: f_in_dom_ar_the_subsume)  
  also have "...= (\<Union>s\<in>(dom f - {l}). locs_of s (the (f s)))" 
    by (simp add: l_dom_dom_ar)
  also have "... = (\<Union>s\<in>dom f. locs_of s (the (( f) s))) - locs_of l (the(f l))"
  proof (rule UN_minus)
    show "\<forall>s\<in>dom f - {l}. locs_of s (the (f s)) \<inter> locs_of l (the (f l)) = {}"
    proof  (* Here is the subgoal that requires Disjoint *)
      fix s assume sdom: "s \<in> dom f - {l}"
      then have snotl: "s \<noteq> l" by blast
      have sinf: "s\<in> dom f" using sdom by simp      
      from disj show "locs_of s (the (f s)) \<inter> locs_of l (the (f l)) = {}"
        unfolding Disjoint_def disjoint_def Locs_of_def
        by (auto simp: sdom snotl sinf lindom) (* Brought all the right preconditions to crunch the
                                                  three layer definition unfolding. ZOOM? 
                                                  Q: what was the strategy employed here? *)
    qed
  qed
  finally show ?thesis by (simp add: locs_def nat1f)
qed





lemma nat1_map_upd: "nat1_map f \<Longrightarrow> nat1 y \<Longrightarrow> nat1_map ( f(x \<mapsto> y))"
  unfolding  nat1_def nat1_map_def by auto

lemma finite_map_upd: "finite (dom f)  \<Longrightarrow> finite (dom ( f(x \<mapsto> y)))"
 by auto


(*****************************************************************)

(**** GENERAL AUX LEMMAS FOR DISPOSE *****)

lemma min_or: "min x y = x \<or> min x y = y"  by (metis min_def)


(*************** LEMMAS ABOUT SUM_SIZE **************************)

lemma sumsize2_mapupd: "finite (dom f) \<Longrightarrow>x \<notin> dom f \<Longrightarrow> f \<noteq> empty \<Longrightarrow> sum_size (f(x \<mapsto>y)) = (sum_size f) + y "
unfolding sum_size_def apply simp
by (smt setsum.cong)
(*
proof -
  assume a1: "x \<notin> dom f"
  have f2: "\<forall>N Na f fa. (N \<noteq> Na \<or> (\<exists>n. (n\<Colon>nat) \<in> Na \<and> (f n\<Colon>nat) \<noteq> fa n)) \<or> setsum f N = setsum fa Na"
    by (meson setsum.cong)
  obtain nn :: "(nat \<Rightarrow> nat) \<Rightarrow> (nat \<Rightarrow> nat) \<Rightarrow> nat set \<Rightarrow> nat" where
    "\<forall>x0 x1 x2. (\<exists>v4. v4 \<in> x2 \<and> x1 v4 \<noteq> x0 v4) = (nn x0 x1 x2 \<in> x2 \<and> x1 (nn x0 x1 x2) \<noteq> x0 (nn x0 x1 x2))"
    by moura
  hence f3: "\<forall>N Na f fa. N \<noteq> Na \<or> nn fa f Na \<in> Na \<and> f (nn fa f Na) \<noteq> fa (nn fa f Na) \<or> setsum f N = setsum fa Na"
    using f2 by presburger
  have f4: "(nn (\<lambda>uu. the (f uu)) (\<lambda>uu. the (if uu = x then Some y else f uu)) (dom f) \<in> dom f \<and> the (if nn (\<lambda>uu. the (f uu)) (\<lambda>uu. the (if uu = x then Some y else f uu)) (dom f) = x then Some y else f (nn (\<lambda>uu. the (f uu)) (\<lambda>uu. the (if uu = x then Some y else f uu)) (dom f))) \<noteq> the (f (nn (\<lambda>uu. the (f uu)) (\<lambda>uu. the (if uu = x then Some y else f uu)) (dom f))) \<or> (\<Sum>uu\<in>dom f. the (if uu = x then Some y else f uu)) = (\<Sum>uu\<in>dom f. the (f uu))) = (nn (\<lambda>uu. the (f uu)) (\<lambda>uu. the (if uu = x then Some y else f uu)) (dom f) \<in> dom f \<and> the (if nn (\<lambda>uu. the (f uu)) (\<lambda>uu. the (if uu = x then Some y else f uu)) (dom f) = x then Some y else f (nn (\<lambda>uu. the (f uu)) (\<lambda>uu. the (if uu = x then Some y else f uu)) (dom f))) \<noteq> the (f (nn (\<lambda>uu. the (f uu)) (\<lambda>uu. the (if uu = x then Some y else f uu)) (dom f))) \<or> (\<Sum>uu\<in>dom f. the (if uu = x then Some y else f uu)) = (\<Sum>uu\<in>dom f. the (f uu)))"
    by meson
  { assume "nn (\<lambda>n. the (f n)) (\<lambda>n. the (if n = x then Some y else f n)) (dom f) \<in> dom f"
    have "nn (\<lambda>n. the (f n)) (\<lambda>n. the (if n = x then Some y else f n)) (dom f) \<notin> dom f \<or> the (if nn (\<lambda>n. the (f n)) (\<lambda>n. the (if n = x then Some y else f n)) (dom f) = x then Some y else f (nn (\<lambda>n. the (f n)) (\<lambda>n. the (if n = x then Some y else f n)) (dom f))) = the (f (nn (\<lambda>n. the (f n)) (\<lambda>n. the (if n = x then Some y else f n)) (dom f)))"
      using a1 by presburger
    hence "(\<Sum>n\<in>dom f. the (if n = x then Some y else f n)) = (\<Sum>n\<in>dom f. the (f n))"
      using f3 f4 
by meson
        }
  thus "(\<Sum>n\<in>dom f. the (if n = x then Some y else f n)) = (\<Sum>n\<in>dom f. the (f n))"
    using f3 by (metis (no_types))
qed
*)
lemma setsum_mapupd: "finite (dom fa) \<Longrightarrow> e \<notin> dom fa \<Longrightarrow> fa \<noteq> empty \<Longrightarrow>(\<Sum>x\<in>dom (fa(e \<mapsto> r)). the ((fa(e \<mapsto> r)) x)) =  (\<Sum>x\<in>dom fa. the (fa x)) + r"
apply simp 
apply (subst add.commute)
find_theorems name:cong name:setsum
by (smt setsum.cong)
(*
proof -
  assume a1: "e \<notin> dom fa"
  obtain aa :: "('a \<Rightarrow> 'b) \<Rightarrow> ('a \<Rightarrow> 'b) \<Rightarrow> 'a set \<Rightarrow> 'a" where
    "\<forall>x0 x1 x2. (\<exists>v4. v4 \<in> x2 \<and> x1 v4 \<noteq> x0 v4) = (aa x0 x1 x2 \<in> x2 \<and> x1 (aa x0 x1 x2) \<noteq> x0 (aa x0 x1 x2))"
    by moura
  hence f2: "\<forall>A Aa f fa. A \<noteq> Aa \<or> aa fa f Aa \<in> Aa \<and> f (aa fa f Aa) \<noteq> fa (aa fa f Aa) \<or> setsum f A = setsum fa Aa"
    by (meson setsum.cong)
  have "(aa (\<lambda>uu. the (fa uu)) (\<lambda>uu. the (if uu = e then Some r else fa uu)) (dom fa) \<in> dom fa \<and> the (if aa (\<lambda>uu. the (fa uu)) (\<lambda>uu. the (if uu = e then Some r else fa uu)) (dom fa) = e then Some r else fa (aa (\<lambda>uu. the (fa uu)) (\<lambda>uu. the (if uu = e then Some r else fa uu)) (dom fa))) \<noteq> the (fa (aa (\<lambda>uu. the (fa uu)) (\<lambda>uu. the (if uu = e then Some r else fa uu)) (dom fa))) \<or> (\<Sum>uu\<in>dom fa. the (if uu = e then Some r else fa uu)) = (\<Sum>uu\<in>dom fa. the (fa uu))) = (aa (\<lambda>uu. the (fa uu)) (\<lambda>uu. the (if uu = e then Some r else fa uu)) (dom fa) \<in> dom fa \<and> the (if aa (\<lambda>uu. the (fa uu)) (\<lambda>uu. the (if uu = e then Some r else fa uu)) (dom fa) = e then Some r else fa (aa (\<lambda>uu. the (fa uu)) (\<lambda>uu. the (if uu = e then Some r else fa uu)) (dom fa))) \<noteq> the (fa (aa (\<lambda>uu. the (fa uu)) (\<lambda>uu. the (if uu = e then Some r else fa uu)) (dom fa))) \<or> (\<Sum>uu\<in>dom fa. the (if uu = e then Some r else fa uu)) = (\<Sum>uu\<in>dom fa. the (fa uu)))"
    by fastforce
  hence f3: "aa (\<lambda>a. the (fa a)) (\<lambda>a. the (if a = e then Some r else fa a)) (dom fa) \<in> dom fa \<and> the (if aa (\<lambda>a. the (fa a)) (\<lambda>a. the (if a = e then Some r else fa a)) (dom fa) = e then Some r else fa (aa (\<lambda>a. the (fa a)) (\<lambda>a. the (if a = e then Some r else fa a)) (dom fa))) \<noteq> the (fa (aa (\<lambda>a. the (fa a)) (\<lambda>a. the (if a = e then Some r else fa a)) (dom fa))) \<or> (\<Sum>a\<in>dom fa. the (if a = e then Some r else fa a)) = (\<Sum>a\<in>dom fa. the (fa a))"
    using f2 by meson (* > 1.0 s, timed out *)
  have "aa (\<lambda>a. the (fa a)) (\<lambda>a. the (if a = e then Some r else fa a)) (dom fa) \<notin> dom fa \<or> the (if aa (\<lambda>a. the (fa a)) (\<lambda>a. the (if a = e then Some r else fa a)) (dom fa) = e then Some r else fa (aa (\<lambda>a. the (fa a)) (\<lambda>a. the (if a = e then Some r else fa a)) (dom fa))) = the (fa (aa (\<lambda>a. the (fa a)) (\<lambda>a. the (if a = e then Some r else fa a)) (dom fa)))"
    using a1 by presburger
  thus "(\<Sum>a\<in>dom fa. the (if a = e then Some r else fa a)) + r = (\<Sum>a\<in>dom fa. the (fa a)) + r"
    using f3 by fastforce
qed
*)

lemma sumsize2_weakening: "x \<notin> dom f \<Longrightarrow> finite (dom f) \<Longrightarrow> y>0 \<Longrightarrow> sum_size (f(x \<mapsto> y)) > 0" 
  unfolding sum_size_def
 by simp

lemma sum_size_singleton: "sum_size [x \<mapsto> y] = y"
  unfolding sum_size_def
by simp

lemma setsum_dagger: "dom f \<inter> dom g = {} \<Longrightarrow>finite (dom f) \<Longrightarrow> (\<Sum>x\<in>dom f. the ((f \<dagger> g) x)) =  (\<Sum>x\<in>dom f. the (f x))"
apply (rule setsum.cong)
apply simp
apply (subst l_dagger_apply)
by auto

lemma sum_size_dagger_single: "finite (dom f) \<Longrightarrow> f \<noteq> empty \<Longrightarrow> x \<notin> dom f \<Longrightarrow>sum_size (f \<dagger> [x \<mapsto> y]) 
                  = (sum_size f) + y"
unfolding sum_size_def
apply (simp add: dagger_notemptyL)
apply (subst l_dagger_dom)
apply (subst setsum.union_disjoint)
apply (simp)
apply simp
apply simp
apply simp
apply (subst setsum_dagger)
apply simp
apply simp
by (metis dagger_upd_dist map_upd_Some_unfold option.sel)


lemma sum_size_munion:  "finite (dom f) \<Longrightarrow> finite (dom g) \<Longrightarrow> f \<noteq> empty \<Longrightarrow> g \<noteq> empty \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow>sum_size (f \<union>m g) 
                  = (sum_size f) + (sum_size g)"
unfolding sum_size_def
apply(simp add: munion_notempty_left)
apply (unfold munion_def)
apply simp
apply (subst l_dagger_dom)
apply (subst setsum.union_disjoint)
apply (simp)
apply simp
apply simp
apply (simp add: setsum_dagger )
apply (subst l_dagger_commute)
apply simp
apply (subst setsum_dagger)
by auto



(*************** LEMMAS ABOUT MIN AND MIN_LOC **************************)

lemma dagger_min: "finite (dom f) \<Longrightarrow> finite (dom g) \<Longrightarrow> f  \<noteq> empty \<Longrightarrow> 
                   g \<noteq> empty \<Longrightarrow> Min (dom (f \<dagger> g)) \<in> dom f \<or> Min (dom (f \<dagger> g)) \<in> dom g"
apply (simp add: l_dagger_dom)
apply (subst Min_Un)
apply simp_all
apply (subst Min_Un)
apply simp_all
by (metis (mono_tags) Min_in domIff emptyE less_imp_le min.absorb2 min.absorb_iff1 not_le)


lemma min_loc_munion: "finite (dom f) \<Longrightarrow> finite (dom g) \<Longrightarrow> f\<noteq>empty \<Longrightarrow>
 g \<noteq> empty \<Longrightarrow> dom f \<inter> dom g = {}  \<Longrightarrow> (min_loc (f \<union>m g)) \<in> dom f \<or> (min_loc (f \<union>m g)) \<in> dom g"
proof -
    assume finf: "finite (dom f)" and fing: "finite (dom g)" and
    fnotemp: "f\<noteq>empty" and gnotemp: "g \<noteq> empty" and disjoint_dom: "dom f \<inter> dom g = {}" 
  have " Min (dom (f \<union>m g)) \<in> dom f \<or>  Min (dom (f \<union>m g)) \<in> dom g"
      unfolding munion_def
      apply (simp add: disjoint_dom)
      apply  (rule dagger_min)
      by (simp_all add:  finf fing fnotemp gnotemp )
  then show "min_loc (f \<union>m g) \<in> dom f \<or> min_loc (f \<union>m g) \<in> dom g" 
    unfolding min_loc_def
    by (metis dagger_def dagger_notemp_munion disjoint_dom fnotemp map_add_None)
qed

(* Lemmas required for case-analysis on dispose1_ext *)
lemma munion_min_loc_nonempty: "dom f1 \<inter> dom f2 = {} \<Longrightarrow> finite (dom f1) \<Longrightarrow> finite (dom f2) \<Longrightarrow> f1 \<noteq> empty \<Longrightarrow> f2 \<noteq> empty \<Longrightarrow> min_loc (f1 \<union>m f2) = min (min_loc f1) (min_loc f2)"
unfolding min_loc_def munion_def apply (simp add: dagger_notemptyL)
by (simp add: Min.union l_dagger_dom)
(*by (metis Min.union_idem l_dagger_dom dom_eq_empty_conv)*)

lemma munion_min_loc_emptyf2: "f2 = empty \<Longrightarrow>  min_loc (f1 \<union>m f2) = min_loc f1"
by (metis Int_empty_right equals0D l_map_non_empty_dom_conv l_munion_apply)

lemma munion_min_loc_emptyf1: "f1 = empty \<Longrightarrow>  min_loc (f1 \<union>m f2) = min_loc f2"
by (metis (full_types) domIff dom_eq_empty_conv inf_bot_left l_dagger_apply munion_def)

lemma dagger_min_loc_nonempty: "dom f1 \<inter> dom f2 = {} \<Longrightarrow> finite (dom f1) \<Longrightarrow> finite (dom f2) \<Longrightarrow> f1 \<noteq> empty \<Longrightarrow> f2 \<noteq> empty \<Longrightarrow> min_loc (f1 \<dagger> f2) = min (min_loc f1) (min_loc f2)"
unfolding min_loc_def apply (simp add: dagger_notemptyL)
by (simp add: Min.union l_dagger_dom)

lemma dagger_min_loc_emptyf2: "f2 = empty \<Longrightarrow>  min_loc (f1 \<dagger> f2) = min_loc f1"
 by (metis dom_eq_empty_conv empty_iff l_dagger_apply)

lemma dagger_min_loc_emptyf1: "f1 = empty \<Longrightarrow>  min_loc (f1 \<dagger> f2) = min_loc f2"
by (metis (full_types) domIff l_dagger_apply)

lemma min_loc_singleton: "min_loc [x \<mapsto> y] = x"
  unfolding min_loc_def
by simp

lemma min_loc_dagger:  "finite (dom f) \<Longrightarrow> finite (dom g) \<Longrightarrow> f \<noteq> empty \<Longrightarrow> g \<noteq> empty \<Longrightarrow>min_loc (f \<dagger> g) 
                  = min (min_loc f) (min_loc g)"
unfolding min_loc_def
apply(simp add: dagger_notemptyL)
apply (subst l_dagger_dom)
apply (subgoal_tac "dom f \<noteq> {}")
apply (subgoal_tac "dom g \<noteq> {}")
apply (rule Min_Un)
apply (simp_all)
done


(* Further proofs about locs *)

lemma UN_cong: "[|A = B; !!x. x:B ==> C(x) = D(x)|] ==> (UN x:A. C(x)) = (UN x:B. D(x))"
oops

(* Union locs lemma needed for uniqueness *)
lemma locs_unionm_singleton:
  assumes nat1y: "nat1 y"
  and nat1f: "nat1_map f"
  and xnotf: "x \<notin> dom f"
  shows "locs(f \<union>m [x \<mapsto> y]) = locs f \<union> locs_of x y"
proof -
  have "locs(f \<union>m [x \<mapsto> y]) = (\<Union>s\<in>dom (f \<union>m [x \<mapsto> y]). locs_of s (the ((f \<union>m [x \<mapsto> y]) s)))"
    unfolding locs_def 
    apply (subst unionm_singleton_nat1_map)
    apply (simp_all del: nat1_def add: nat1y nat1f xnotf )
    done
  also have "... = (\<Union>s\<in>dom (f)  \<union> {x}. locs_of s (the ((f \<union>m [x \<mapsto> y]) s)))"
    apply (subst l_munion_dom)
    apply (simp add: xnotf)
    by (simp)
    also have "... = (\<Union>s\<in> insert x (dom (f)). locs_of s (the ((f \<union>m [x \<mapsto> y]) s)))"
      by simp
  also have "... = (locs_of x (the ((f \<union>m [x \<mapsto> y]) x))) 
            \<union> (\<Union>s\<in>dom (f). locs_of s (the ((f \<union>m [x \<mapsto> y]) s)))"
  by (rule UN_insert)
  also have "... = (locs_of x y) 
            \<union> (\<Union>s\<in>dom (f). locs_of s (the ((f \<union>m [x \<mapsto> y]) s)))"
    apply (subst l_munion_apply)
    apply (simp add: xnotf)
    by auto
  also have "... =  (locs_of x y) 
            \<union> (\<Union>s\<in>dom (f). locs_of s (the(f s)))"
  proof -
    have "(\<Union>s\<in>dom f. locs_of s (the ((f \<union>m [x \<mapsto> y]) s))) =
         (\<Union>s\<in>dom (f). locs_of s (the(f s)))"
         find_theorems "(\<Union> _ \<in> _ ._)"                        
    (*proof (rule UN_cong, rule refl)*)
    thm SUP_cong
    proof (rule SUP_cong, rule refl)
    fix s
    assume *: "s \<in> dom f"
    then show  "locs_of s (the ((f \<union>m [x \<mapsto> y]) s)) = locs_of s (the (f s))"
    proof (subst l_munion_apply, (simp add: xnotf))
     have "s \<notin> dom [x \<mapsto> y]" by (metis "*" dom_empty empty_iff l_inmapupd_dom_iff xnotf)
     then show "locs_of s (the (if s \<in> dom [x \<mapsto> y] then [x \<mapsto> y] s else f s)) = locs_of s (the (f s))"
      by simp
   qed
 qed
 thus ?thesis by simp
qed
 also have "... =  locs_of x y  \<union> locs f"
 unfolding locs_def by (simp add: nat1f)
 finally show ?thesis  by auto
qed

lemma locs_of_minus:
"b>0 \<Longrightarrow> c > 0 \<Longrightarrow> b<c \<Longrightarrow> locs_of a b =  (locs_of a c) - (locs_of (a+b) (c-b))"
apply (simp add: b_locs_of_as_set_interval) by auto

end
