(* $Id$ *)
theory HEAP1Proofs
imports HEAP1 HEAP1Lemmas
begin

text \<open> Add lemmas k_in_dom_locs = l_in_dom_locs for when the same lemma (``l\_'') has multiple uses in a theory? \<close>

(* ================================================================= *)
section \<open> NEW 1 proofs \<close>
(* ================================================================= *)

text 
\<open>  As part of the strategy for mechanisation with sledgehammer we 
	rely on a few patterns for ``zooming'', ``witnessing'', ``bridging'',
	and ``weakening''. To easily identify what lemma participate in
	what pattern, we use some name conventions as below. Prefixes can
	be combined to indicate patterns are being combined.
	
\begin{enumerate}
	\item Zooming: lemma mames prefixed with ``z\_''
	
	Pattern that takes into account a (sub-)set of definitions of 
	interest to unfold and tackle at different stages. These are
	problem dependant and require expert annotation (of defs?). 
	
	The pattern is applied by decomposing the goal, top-down, into
	its suggoal parts declared as lemmas with appropriate instantiations.
	
	It achieves separation of concerns given one concentrate at the
	right level of abstraction during a proof.
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	\item Witnessing: lemma mames prefixed with ``w\_''
	
  Type1: strip defs the user tagged to; try and get 1-point-rule to work
  Type2: Type1 where you need an explicit instantiation from user
 
	Most POs involve instantiating some (difficult) existential
	quantifier or interest. With this pattern we instantiate variables
	to uninterpreted constants following by the application of the zooming
	pattern. On many models, this leaves to obvious witness to choose under
	certain conditions, to be added as lemmas for the subcases of interest
	given the model at hand. 
	
	Another approach is to instantiate the quantified after state as simply
	the before state (i.e. as if we were dealing with a SKIP-OP). This is
	clearly wrong, yet after (safe-)simplification often gives insight into
	what the correct (or approximate) instantiation should be. This is 
	useful to when the model does not provide equations for the quantified
	after state.
	

	For instance, we use uninterpreted witnessing for the proof of \textrm{NEW1}
	feasibility. This leads to the instantiations of the suggested lemmas 
	\textsl{zw\_new1\_post} and \textsl{zw\_F1\_inv}.
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	\item Bridges: lemma mames prefixed with ``b\_''
	
	Certain information about types and predicates (e.g. invariant, pre/post)
	are ``obvious'' yet not immediately known/available to Isabelle. The choice
	to what is to be put into the ``goal context'' by default requires some
	practice, yet is pretty deterministic: all the type-related parts of goals
	that keep occurring in the middle of proofs, yet are not the relevant
	goal to be proved.
	
	For these scenarios, we add type or definition ``bridges'' that tell 
	Isabelle to take them (or a variation of them) into account during 
	simplification (i.e. declare some tags to definitions like \textsl{intro}).
	
	For instance, lemmas are needed to prove the feasibility of \textrm{NEW1}.
	They all require some knowledge about the before state invariant and the
	precondition under the appropriate instantiations, or the fact the map f 
  is finite and with a nat1 range. We add these as lemmas
	below to ensure these required information is not hampering automation.
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	\item Weakening: lemma mames prefixed with ``k\_''
	
	One usually do not have enough information about goals function symbols
	in order to directly discharge them. Adding specific lemmas to that effect
	is often unlikely (and leads to lemmas that are too specific to be reused).
	
	Instead, we often need lemmas that much at specific parts of the goal 
	(backward chaining) or at specific part of the hypothesis (forward chaining)
	to weaken the overall task to pieces manageable by the theorem prover.
	
\end{enumerate}

  TODO: explain Naur's N-Queen approach to explaining the problem!
 \<close>

(* ----------------------------------------------------------------- *)
subsection \<open> NEW 1 FSB \<close>
(* ----------------------------------------------------------------- *)

text \<open> These lemmas rely on general (expert) lemmas about maps and 
        Other mathematical toolkit operatos, many of which Isabelle
        already has useful lemmas for. 

        In this development, we need to create these from scratch. 
        Yet, although a bit artificial, we shield the development
        from these general goals/proofs by having them in a separate theory.

        In practice, we antecipate that these lemmas will be reused 
        in other VDM-style map problems. As indeed is already evident
        from the various lemmas ``stolen'' from ZEves' mathematical
        toolkit (i.e. the FM style of model and proof transfer across provers too).
        Or else, we might be having some outcome bias, given authors 
        expertise in this other prover. Either way, it does show that
        proof patterns do exist beyond specific provers and examples.
      \<close>

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> NEW 1 FSB weakening lemmas for equal case \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text \<open> For $new1\_eq$ case lemmas are easier:~we just need to show the
        submap satisfy the various parts of the state invariant. We
        prove a lemma for each such subpart below. They follow directly
        from general lemmas about the involved operators and are all
        sledgehammered.

        To allow for our lemma collection/analysis tool to work, we avoid
        (in X) and explicitly collect the locale-specific lemmas.
      \<close>

context level1_new
begin

(* Weaken: submap is disjoint in locale *)
lemma k_new1_Disjoint_dom_ar:
	"Disjoint ({x} -\<triangleleft> f1)"
by (metis F1_inv_def k_Disjoint_dom_ar l1_invariant_def)
     (* SUGGESTION: CALL EXPERT PLEASE! Separate lemmas from locale *)

(* Weaken: submap is separate in locale *)
lemma k_new1_sep_dom_ar:
   "sep ({r} -\<triangleleft> f1)"
by (metis F1_inv_def k_sep_dom_ar l1_invariant_def)

(* Weaken: submap is nat1 in locale *)
lemma  k_new1_nat1_map_dom_ar:
   "nat1_map ({r} -\<triangleleft> f1)"
by (metis F1_inv_def k_nat1_map_dom_ar l1_invariant_def)

(* Weaken: submap is finite in locale *)
lemma  k_new1_finite_dom_ar:
   "finite (dom ({r} -\<triangleleft> f1))"
by (metis F1_inv_def k_finite_dom_ar l1_invariant_def) 

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> NEW 1 FSB weakening lemmas for greater than case \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text \<open> For $new1\_gr$ case lemmas are not as easy. Our definition of VDM map
        union rely on a side condition about disjointness of map's domains,
        which will feature in all proofs for $new1\_gr$. 

        Historically, we had made a mistake (oops):~we defined the models 
        in Isabelle using a version of VDM dagger (@{text "_ \<dagger> _"} or @{text "_ ++ _"} in Isabelle) 
        instead of map union. After correcting the mistake we had a throve of
        lemmas for dagger, which are useful for proving map union, so we kept both.

        Isabelle does not have map union but (Isabelle) map update (@{text "_ ++ _"}). We define VDM map union
        with map update where domains are disjoint, or undefined otherwise. Thus, 
        having had these lemmas about map update were quite useful for a general
        strategy for proving VDM map union in Isabelle (with this encoding):~prove it
        for dagger then establish the disjointness of domains for the maps involved
        and it does work, in most cases (i.e.~an example where it does not occurs for
        certain algebraic rules about our $locs$ function, see below in ???).

        Given that, as before for $new\_eq$, we show show the submap (@{text "_-\<triangleleft>_"}) 
        updated (@{text "_\<dagger>_"}) or extended (@{text "_ \<union>m _"}) satisfy the various parts of the 
        state invariant. We prove a lemma for each such subpart below. They follow 
        directl from general lemmas about the involved operators and are all
        sledgehammered.
      \<close>

(* unused_thms

(* Weaken: submap updated is disjoint in locale *)
lemmX k_new1_Disjoint_dom_ar_dagger:
	"r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1  \<Longrightarrow> Disjoint ({r} -\<triangleleft> f1 \<dagger> [r + s1 \<mapsto> the (f1 r) - s1])"
by (metis F1_inv_def k_Disjoint_dom_ar_dagger l1_invariant) 

(* Weaken: submap updated is separate in locale *)
lemmX k_new1_sep_dom_ar_dagger:
   "r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1  \<Longrightarrow> sep ({r} -\<triangleleft> f1 \<dagger> [r + s1 \<mapsto> the (f1 r) - s1])"
by (smt F1_inv_def k_sep_dom_ar_dagger l1_input_notempty l1_invariant)

(* Weaken: submap updated is nat1 in locale *)
lemmX k_new1_nat1_map_dom_ar_dagger:
   "r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1  \<Longrightarrow> nat1_map ({r} -\<triangleleft> f1 \<dagger> [r + s1 \<mapsto> the (f1 r) - s1])"
by (metis F1_inv_def k_nat1_map_dom_ar_dagger l1_invariant l1_input_notempty)

(* Weaken: submap updated is finite in locale *)
lemmX k_new1_finite_dom_ar_dagger:
   "r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1  \<Longrightarrow> finite (dom({r} -\<triangleleft> f1 \<dagger> [r + s1 \<mapsto> the (f1 r) - s1]))"
by (metis (full_types) F1_inv_def k_finite_dom_ar_dagger l1_invariant)
*)

(* Weaken: submap extended is disjoint in locale *)
lemma k_new1_Disjoint_dom_ar_munion:
	"r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1  \<Longrightarrow> Disjoint ({r} -\<triangleleft> f1 \<union>m [r + s1 \<mapsto> the (f1 r) - s1])"
by (smt F1_inv_def k_Disjoint_dom_ar_munion l1_input_notempty_def l1_invariant_def)

(* Weaken: submap extended is separate in locale *)
lemma k_new1_sep_dom_ar_munion:
   "r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1 \<Longrightarrow> sep ({r} -\<triangleleft> f1 \<union>m [r + s1 \<mapsto> the (f1 r) - s1])"
by (smt F1_inv_def k_sep_dom_ar_munion l1_input_notempty_def l1_invariant_def)

(* Weaken: submap extended is nat1 in locale *)
lemma k_new1_nat1_map_dom_ar_munion:
   "r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1  \<Longrightarrow> nat1_map ({r} -\<triangleleft> f1 \<union>m [r + s1 \<mapsto> the (f1 r) - s1])"
by (metis F1_inv_def k_nat1_map_dom_ar_munion l1_invariant_def l1_input_notempty_def)

(* Weaken: submap extended is finite in locale *)
lemma k_new1_finite_dom_ar_munion:
   "r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1  \<Longrightarrow> finite (dom({r} -\<triangleleft> f1 \<union>m [r + s1 \<mapsto> the (f1 r) - s1]))"
by (metis (mono_tags) F1_inv_def k_finite_dom_ar_munion l1_input_notempty_def l1_invariant_def)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> NEW 1 FSB goal-splitting lemmas \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text \<open> From the top-down strategy for the feasibility proof, we need to provide
        zooming-weakening lemmas to enable sledgehammer to work for our given witnesses,
        which also determine the key step in the proof:~the splitting of cases for
        exact and surplus memory allocation.

        As it happened for the invariant parts for each case, these lemmas operate on 
        each part of the feasibility proof this time, namely the postcondition, the
        state invariant and the outputs. Obviously, the zooming strategy works well 
        given this setup since the lemmas above are already in the shape needed.

        That is, when working top-down as we did, the unpicking of the various parts
        of the feasibility proof obligation leads to the suggestion of these lemma shapes
        up to the point where available (and general) mathematical toolkit lemmas apply,
        modulo a few new ones needed. That's usually where expert input is needed. 

        Call it what you like, this top-down strategy/pattern/tactic, repeats across problems
        in the formal methods domain, where automation depends on the quality and shape of
        the general lemmas available. Our hope is that, with enough data about expert choices
        regarding specialised versions of general lemmas (as well as new general lemmas themselves),
        AI4FM tools would be able to spot the similarities/features/patterns and suggest them 
        to new/novice users.
      \<close>

lemma zw_new1_post_eq: 
	"r \<in> dom f1 \<Longrightarrow> the (f1 r) = s1 \<Longrightarrow> new1_post_eq f1 s1 ({r} -\<triangleleft> f1) r"
unfolding new1_post_eq_def
by auto
	
lemma zw_F1_inv_new1_eq :
	"r \<in> dom f1 \<Longrightarrow> the (f1 r) = s1  \<Longrightarrow> F1_inv ({r} -\<triangleleft> f1)"
by (metis F1_inv_def k_new1_Disjoint_dom_ar k_new1_finite_dom_ar k_new1_nat1_map_dom_ar k_new1_sep_dom_ar)
				
lemma zw_new1_post_gr: 
	"r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1 \<Longrightarrow> new1_post_gr f1 s1 ({r} -\<triangleleft> f1 \<union>m [r + s1 \<mapsto> the (f1 r) - s1]) r"
unfolding new1_post_gr_def
by auto

lemma zw_F1_inv_new1_gr :
	"r \<in> dom f1 \<Longrightarrow> the (f1 r) > s1  \<Longrightarrow> F1_inv ({r} -\<triangleleft> f1 \<union>m [r + s1 \<mapsto> the (f1 r) - s1])"
by (metis (full_types) F1_inv_def 
				k_new1_Disjoint_dom_ar_munion 
				k_new1_finite_dom_ar_munion 
				k_new1_nat1_map_dom_ar_munion 
				k_new1_sep_dom_ar_munion)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> NEW 1 FSB main theorem \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text \<open> Finally, the top-down strategy applies zomming and weakening patterns,
        once the key point about splitting exact and surplus memory allocation
        is observed\footnote{Oddly enough, we are saying ``finally'' for where 
        usually is the place work begins!}.
      \<close>

theorem locale1_new_FSB: "PO_new1_feasibility"
unfolding PO_new1_feasibility_def new1_postcondition_def
apply (insert l1_new1_precondition_def)
unfolding new1_pre_def new1_post_def
apply (erule bexE)
find_theorems "_ \<le> _ = ((_ < _) \<or> _)" 
apply (simp only: le_eq_less_or_eq)
apply (erule disjE)
apply (metis zw_new1_post_gr zw_F1_inv_new1_gr)
apply (metis zw_new1_post_eq zw_F1_inv_new1_eq)
done

end (* LOCAL CONTEX FOR level1_new *)

(* ================================================================= *)
section \<open> DISPOSE 1 proofs \<close>
(* ================================================================= *)

text \<open> The strategy for the finiteness proof was the first one to be constructed.
        It generated various lemmas in different theories, some general missing lemmas
        about maps, other problem-specific lemmas missing that are useful for other goals.

        We had various attempts and they operate on the main function symbols in different
        order. The bottom line is the case analysis around the DISPOSE1 auxiliary functions
        being empty or not. After finishing the proof, we minimised the number of lemmas needed
        as much as possible by cleaning up / deleting $unused\_thms$. 

        The proofs rely entirely on the ability to distribute  over munion, which requires
        the side condition that domains involved are disjoint. This is the hard part on all
        invariant proofs, which has been extracted as a lemma, namely $l\_dispose1\_munion\_disjoint$.
      \<close>

context level1_dispose
begin

lemma k_dispose_above_ext_dom_disjoint_aux: 
  "d1 \<notin> dom (dispose1_above f1 d1 s1)"
by (metis f_d1_not_dispose_above l1_input_notempty_def)

lemma k_dispose_below_ext_dom_disjoint_aux: 
  "d1 \<notin> dom (dispose1_below f1 d1)"
by (metis f_d1_not_dispose_below l1_invariant_def F1_inv_def l1_input_notempty_def)

lemma k_finite_dispose_above_aux: 
  "finite (dom (dispose1_above f1 d1 s1))"
by (metis f_F1_inv_finite k_finite_dispose_above l1_invariant_def)

lemma k_finite_dispose_below_aux: 
  "finite (dom (dispose1_below f1 d1))"
by (metis f_F1_inv_finite k_finite_dispose_below l1_invariant_def)

text \<open> Now for the *KEY* lemma, which is used on all F1_inv DISPOSE1 proofs! 
        It was discovered during the finiteness proof (the first part of the invariant tackled).
        It was then used for nat1\_map and sep (and possibly Disjoint).

        Still, through the proof for sep, we found that there is an underlying lemma within
        this one, which is about the possible values for min_loc (l_min_loc_dispose1_ext_iff). 
        These values underlie the complicated case analysis here. 

        TODO: we could refactor this proof in terms of the one for min_loc, yet we will keep it as is
              as an example of how these more complex lemmas come to the surface.

        Therefore, this lemma is the weakening rule to enable the application of various operators
        over map union, whereas the one on min_loc performs the appropriate case analysis.
      \<close>

(* TO LOOK AT! Interesting weakening LEMMA *)
lemma l_dispose1_munion_disjoint:
  "dom ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1) \<inter>
    dom [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)] = {}"
  \<comment> \<open>simp would do as well\<close>
  find_theorems "_ \<inter> _ = {}"
apply (simp add: l_dom_dom_ar)
  \<comment> \<open>simp alone already simplified goal; LEMMA about dom_ar improves on result"
unfolding dispose1_ext_def 
apply (rule impI)
apply (cases "dispose1_below f1 d1 = empty")      \<comment> \<open>prefer cases instead of subgoal_tac\<close>
apply (simp_all add: l_munion_empty_rhs)
  apply (cases "dispose1_above f1 d1 s1= empty")
  apply (simp_all add: l_munion_empty_lhs)
  \<comment> \<open>nothing to adjoin: below=above=empty\<close>
    apply (simp add: l_min_loc_singleton)
    apply (insert l1_dispose1_precondition_def)
    unfolding dispose1_pre_def disjoint_def
    apply (insert l1_input_notempty_def)
    apply (insert l1_invariant_def)
    apply (frule f_F1_inv_nat1_map)
    apply (simp add: f_dispose1_pre_not_in_dom)
  \<comment> \<open>above to adjoin: below=empty; not above = empty\<close>
    find_theorems "min_loc (_ \<union>m _)"
    thm k_min_loc_munion_singleton[of "dispose1_above f1 d1 s1" d1 s1]
    find_theorems name:contrapos
        (* TODO: wanted to flip the goal to talk about min_loc instead of the empty for above.
            apply (rule contrapos_np[of 
                            "min_loc (dispose1_above f1 d1 s1 \<union>m [d1 \<mapsto> s1]) \<in> dom f1" 
                            "dispose1_above f1 d1 s1 = Map.empty"])
         *)
    thm k_min_loc_munion_singleton[THEN subst, of "dispose1_above f1 d1 s1" d1 s1 "(\<lambda> x . x \<in> dom f1)"]
    apply (simp add: k_min_loc_munion_singleton[simplified]
                        k_finite_dispose_above_aux
                        k_dispose_above_ext_dom_disjoint_aux
                split: split_if_asm)
    apply (simp add: l_dispose1_sep0_above_empty_iff)
    unfolding sep0_def
    apply (simp add: l_dispose1_above_singleton)
    unfolding min_def
      thm f_dispose1_pre_not_in_dom[of f1 s1 d1]
    apply (simp split: split_if_asm
                add: f_dispose1_pre_not_in_dom
                        f_F1_inv_nat1_map
                          l1_invariant_def)
  \<comment> \<open>below to adjoin: not below = empty; above=empty\<close>
  apply (cases "dispose1_above f1 d1 s1= empty")
  apply (simp_all add: l_munion_empty_lhs)
    thm k_min_loc_munion_singleton[THEN subst, of "dispose1_below f1 d1" d1 s1 "(\<lambda> x . x \<in> dom f1)"]
    apply (simp add: k_min_loc_munion_singleton[simplified]
                        k_finite_dispose_below_aux
                        k_dispose_below_ext_dom_disjoint_aux
                split: split_if_asm)
    apply (simp add: l_dispose1_sep0_above_empty_iff)
    unfolding sep0_def
    apply (simp add: l_dispose1_above_singleton)
    unfolding min_def
      thm f_dispose1_pre_not_in_dom[of f1 s1 d1]
    apply (simp split: split_if_asm
                add: f_dispose1_pre_not_in_dom
                        f_F1_inv_nat1_map
                          l1_invariant_def)
    apply (metis Min_in dom_eq_empty_conv k_finite_dispose_below_aux) \<comment> \<open>TODO: study Min_in interpret proof!\<close>
  \<comment> \<open>both to adjoin: not below = above = empty\<close>
    \<comment> \<open>NOTE: unfortunately, because dispose1_below has a free variable l, we need something different\<close>
    apply (simp add: l_dispose1_sep0_below_empty_iff[of f1 d1 s1])
    apply (frule l_dispose1_nonempty_above_singleton)
    unfolding sep0_def
    apply simp
    unfolding F1_inv_def
    apply (elim conjE bexE)
    thm l_dispose1_below_singleton_useful
    apply (frule l_dispose1_below_singleton_useful)
    apply assumption+
    apply (erule_tac x=l in ballE)
    apply (erule impE)
    apply (simp_all)+ \<comment> \<open>Funny: simp_all doesn't quite work here \<close>
    find_theorems "min_loc(_ \<union>m _)"
    thm k_min_loc_munion_singleton[of "[d1 + s1 \<mapsto> the (f1 (d1 + s1))] \<union>m [l \<mapsto> the (f1 l)]",simplified]
    apply (frule f_dispose1_pre_not_in_dom,simp_all)
    apply (frule f_nat1_map_nat1_elem)
    apply simp
      back
    (*apply (simp add: k_min_loc_munion_singleton[simplified])*)
    unfolding munion_def
    apply (simp add: l_dagger_dom)
    unfolding min_loc_def
    apply (simp add: l_dagger_dom split: split_if_asm)
    (*
      Sledgehammering... 
          "e": Try this: apply (metis (mono_tags) bot_nat_def comm_monoid_add_class.add.right_neutral domIff dom_def inf_absorb1 inf_absorb2 inf_nat_def less_le min_0R min_add_distrib_right min_max.inf_commute not_less) (1.03 s).
          To minimize: sledgehammer min [type_enc = mono_tags] (bot_nat_def comm_monoid_add_class.add.right_neutral domIff dom_def inf_absorb1 inf_absorb2 inf_nat_def less_le min_0R min_add_distrib_right min_max.inf_commute not_less). 
                = apply (metis (mono_tags) inf_absorb1 inf_absorb2 inf_nat_def less_le not_less)
          "remote_vampire": Try this: apply (metis min_0R min_add_distrib_right min_max.inf.commute nat_add_commute nat_add_left_commute plus_nat.add_0) (245 ms). 
          "remote_e_sine": Try this: apply (metis (mono_tags) antisym_conv3 inf_absorb1 inf_absorb2 inf_min less_le_not_le trans_less_add1) (120 ms). 
          "spass": Try this: apply (metis comm_monoid_add_class.add.right_neutral domD dom_def inf_commute inf_left_commute inf_min min_0L min_0R min_add_distrib_right the.simps) (771 ms).
          To minimize: sledgehammer min (comm_monoid_add_class.add.right_neutral domD dom_def inf_commute inf_left_commute inf_min min_0L min_0R min_add_distrib_right the.simps). 
                =     apply (metis comm_monoid_add_class.add.right_neutral inf_left_commute inf_min min_0L min_add_distrib_right)
          "z3": Try this: apply smt (98 ms).
    *)
    (*apply smt*)
    apply (metis (mono_tags) inf_absorb1 inf_absorb2 inf_nat_def less_le not_less)
by (metis l_dagger_not_empty map_upd_nonempty)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~ FINITE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

lemma  z_F1_inv_dispose1_finite:
  "finite (dom ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
                 [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)]))"
                 find_theorems simp:"finite(dom(_ \<union>m _))"
apply (rule k_finite_munion)
apply (metis F1_inv_def finite_Diff l1_invariant_def l_dom_dom_ar)
apply (metis dom_eq_singleton_conv finite.simps) 
by (rule l_dispose1_munion_disjoint)

(*
unused_thms \<comment> \<open>Called to collect the useless theorems from previous attempt. Keep here for history? "

lemmX
  k_dispose_abovebelow_dom_disjoint_aux:
  "dom (dispose1_above f1 d1 s1) \<inter> dom(dispose1_below f1 d1) = {}"
by (metis f_F1_inv_sep k_dispose_abovebelow_dom_disjoint l1_invariant)

lemmX k_finite_dispose_abovebelow_munion_aux: 
  "finite (dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1))"
  thm k_finite_munion[of "dispose1_above f1 d1 s1" "dispose1_below f1 d1"]
by (metis k_dispose_abovebelow_dom_disjoint_aux 
          k_finite_dispose_above_aux k_finite_dispose_below_aux k_finite_munion)

lemmX 
  k_dispose_abovebelow_ext_dom_disjoint_aux: 
  "d1 \<notin> dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1)"
by (metis k_dispose1_abovebelow_ext_disjoint l1_invariant F1_inv_def l1_input_notempty)

lemmX
  k_dispose_abovebelow_munion_dom_aux:
  "dom(dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1) 
    = 
   { x \<in> dom f1 . x + the(f1 x) = d1 \<or> x = d1 + s1 }"
apply (insert l1_invariant)
apply (frule f_F1_inv_sep)
by (rule k_dispose_abovebelow_munion_dom)
 NOTE: sledgehammer manages but gives rather slow proofs 

lemmX k_dispose1_abovebelow_nonempty_aux:
  "d1 + s1 \<in> dom f1 \<or> x \<in> dom f1 \<and> x + the(f1 x) = d1 \<Longrightarrow> 
    dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1 \<noteq> Map.empty"
by (metis f_F1_inv_sep k_dispose1_abovebelow_nonempty l1_invariant)


lemmX z_F1_inv_dispose1_finite_almost_there:
  "finite (dom ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
                 [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)]))"
apply (rule k_finite_munion)
apply (metis F1_inv_def finite_Diff l1_invariant l_dom_dom_ar)
apply (metis dom_eq_singleton_conv finite.simps) 
  \<comment> \<open>simp would do as well\<close>
  find_theorems "_ \<inter> _ = {}"
apply (simp add: l_dom_dom_ar)
  \<comment> \<open>simp alone already simplified goal; LEMMA about dom_ar improves on result\<close>
unfolding dispose1_ext_def 
apply (rule impI)
apply (subgoal_tac "dispose1_below f1 d1 = empty")
apply (simp_all add: l_munion_empty_rhs)
apply (subgoal_tac "dispose1_above f1 d1 s1 = empty")
apply (simp_all add: l_munion_empty_lhs)
\<comment> \<open>nothing to adjoin: below=above=empty"
  apply (simp add: l_min_loc_singleton)
  apply (insert dispose1_precondition)
  unfolding dispose1_pre_def disjoint_def
  apply (insert l1_input_notempty)
  apply (insert l1_invariant)
  apply (frule f_F1_inv_nat1_map)
  apply (simp add: f_dispose1_pre_not_in_dom)
\<comment> \<open>above to adjoin: below=empty"
  find_theorems "min_loc (_ \<union>m _)"
  thm k_min_loc_munion_singleton[of "dispose1_above f1 d1 s1" d1 s1]
  find_theorems name:contrapos
       TODO: wanted to flip the goal to talk about min_loc instead of the empty for above.
          apply (rule contrapos_np[of 
                          "min_loc (dispose1_above f1 d1 s1 \<union>m [d1 \<mapsto> s1]) \<in> dom f1" 
                          "dispose1_above f1 d1 s1 = Map.empty"])
       
  thm k_min_loc_munion_singleton[THEN subst, of "dispose1_above f1 d1 s1" d1 s1 "(\<lambda> x . x \<in> dom f1)"]
  apply (simp add: k_min_loc_munion_singleton[simplified]
                      k_finite_dispose_above_aux
                      k_dispose_above_ext_dom_disjoint_aux
              split: split_if_asm)
  apply (simp add: l_dispose1_sep0_above_empty_iff)
  unfolding sep0_def
  apply (simp add: l_dispose1_above_singleton)
  unfolding min_def
    thm f_dispose1_pre_not_in_dom[of f1 s1 d1]
  apply (simp split: split_if_asm
              add: f_dispose1_pre_not_in_dom
                      f_F1_inv_nat1_map
                        l1_invariant)
\<comment> \<open>below to adjoin: above=empty"
  thm k_min_loc_munion_singleton[THEN subst, of "dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1" d1 s1 "(\<lambda> x . x \<in> dom f1)",simplified]
        k_finite_dispose_abovebelow_munion_aux
        k_dispose_abovebelow_ext_dom_disjoint_aux
  apply (simp add: k_min_loc_munion_singleton[simplified]
                      k_finite_dispose_abovebelow_munion_aux
                      k_dispose_abovebelow_ext_dom_disjoint_aux
              split: split_if_asm)
  
  apply (metis k_dispose_abovebelow_dom_disjoint_aux l_munion_empty_iff)       \<comment> \<open>proof through prop of above/below"
  \<comment> \<open>apply (metis f_F1_inv_nat1_map f_dispose1_pre_not_in_dom l1_input_notempty)"  \<comment> \<open>proof through precondition" 
  
  apply (simp add: l_dispose1_sep0_below_empty_iff[of f1 d1 s1])
  unfolding sep0_def
  apply (rule ballI)
  apply simp 
  apply (rule notI)
  unfolding min_def
  apply (simp split: split_if_asm)
  defer
  apply (simp add: f_dispose1_pre_not_in_dom
                    f_F1_inv_nat1_map
                        l1_invariant)
  apply (simp)

  thm l_munion_empty_iff[of "dispose1_above f1 d1 s1" "dispose1_below f1 d1"]
      k_dispose_abovebelow_dom_disjoint_aux
  apply (simp add: l_munion_empty_iff 
                      k_dispose_abovebelow_dom_disjoint_aux)
  apply (simp only: imp_conv_disj)
  apply (erule disjE)
  apply (simp_all)
  apply (erule impCE)
  apply (rule contrapos_np[of " dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1 = Map.empty" "dispose1_below f1 d1 = Map.empty"],simp_all)
  



apply (insert f_dispose1_pre_not_in_dom[of f1 s1 d1])
apply (simp add: k_dispose1_sep0_above_empty)
apply (insert k_min_loc_munion_singleton[THEN subst, of "dispose1_above f1 d1 s1" d1 s1 "(\<lambda> x . x \<in> dom f1)",simplified])

apply (simp add: l_dispose1_sep0_below_empty_iff[of f1 d1 s1]
                  l_dispose1_sep0_above_empty_iff)
apply (insert k_min_loc_munion_singleton[of "dispose1_above f1 d1 s1" d1 s1])

unfolding sep0_def
apply simp
oops

lemmX z_F1_inv_dispose1_finite_old:
  "finite (dom ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
                 [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)]))"
apply (rule k_finite_munion)
apply (metis F1_inv_def finite_Diff l1_invariant l_dom_dom_ar)
apply (metis dom_eq_singleton_conv finite.simps) 
  \<comment> \<open>simp would do as well"
  find_theorems "_ \<inter> _ = {}"
apply (simp add: l_dom_dom_ar)
  \<comment> \<open>simp alone already simplified goal; LEMMA about dom_ar improves on result"
unfolding dispose1_ext_def 
apply (rule impI)
thm k_min_loc_munion_singleton[of "dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1" d1 s1]
apply (subst k_min_loc_munion_singleton)
apply (metis k_finite_dispose_abovebelow_munion_aux)
apply (subst disjoint_iff_not_equal)
apply (subst k_dispose_abovebelow_munion_dom_aux)
apply (intro ballI)
apply simp
apply (elim conjE disjE)
apply (metis F1_inv_def l1_invariant sep_def)
 too slow:
  apply (metis (mono_tags) dom_eq_singleton_conv empty_Collect_eq inf.idem insert_def k_sep_dom_ar_dagger_aux2 l1_input_notempty sup.commute sup_bot_left)

apply (insert l1_input_notempty,simp)
apply (subgoal_tac "dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1 = empty")
find_theorems "empty \<union>m _"
find_theorems "min_loc [_ \<mapsto> _]"
apply (simp_all add: l_munion_empty_lhs l_min_loc_singleton)
  \<comment> \<open>
  apply (simp only: dom_eq_empty_conv[symmetric])
  apply (simp add: l_munion_dom 
                      k_dispose_abovebelow_dom_disjoint 
                         f_F1_inv_sep
                            l1_invariant)
      \<comment> \<open>
      apply (insert l1_invariant)
      apply (frule f_F1_inv_sep)
      apply (frule k_dispose_abovebelow_dom_disjoint[of f1 d1 s1])
      thm l_munion_dom[of "dispose1_above f1 d1 s1" "dispose1_below f1 d1"]
      apply (frule l_munion_dom)
      apply simp\<close>
      
  apply (erule conjE)
  apply (simp add: l_dispose1_sep0_above_empty_iff)
  apply (simp add: l_dispose1_sep0_below_empty_iff[of f1 d1 s1])
  unfolding sep0_def
  apply simp
  apply (erule_tac x=d1 in ballE)
  apply simp_all
  \<close>
  apply (insert dispose1_precondition)
  unfolding dispose1_pre_def disjoint_def
  apply (simp add: f_dispose1_pre_not_in_dom
                      f_F1_inv_nat1_map
                          l1_invariant)
find_theorems "dom(dispose1_above _ _ _) \<inter> _"
apply (simp add: l_munion_empty_iff 
                    k_dispose_abovebelow_dom_disjoint
                        f_F1_inv_sep
                          l1_invariant
                 l_dispose1_sep0_above_empty_iff
                 l_dispose1_sep0_below_empty_iff[of f1 d1 s1])
apply (rule conjI)
unfolding sep0_def
apply (insert l1_invariant)
apply (frule f_F1_inv_nat1_map)
apply (frule f_dispose1_pre_not_in_dom[of f1 s1 d1],simp_all)
defer

apply (rule contrapos_np)
apply (simp add: fun_eq_iff)
unfolding dispose1_below_def dispose1_above_def
find_theorems "(_ \<triangleleft> _) _"
apply (simp add: f_in_dom_r_apply_elem)
apply (insert dispose1_precondition)
unfolding dispose1_pre_def disjoint_def
find_theorems "locs_of _ _ \<inter> locs _ = {}"
apply (simp add: k_inter_locs_iff
                  l1_invariant
                  f_F1_inv_nat1_map)
find_theorems simp:"_ \<or> _" intro
apply (rule disjCI)
apply (erule notE)
apply (simp add: k_dispose_abovebelow_munion_dom_aux)
apply (intro conjI impI)
apply (simp add: l_munion_empty_lhs l_min_loc_singleton)
unfolding dispose1_above_def
  find_theorems "dom(_ \<triangleleft> _)"
apply (simp_all add: l_dom_r_iff)
defer
apply (subgoal_tac "d1 + s1 \<in> dom f1")
apply (simp add: k_dispose1_abovebelow_nonempty_aux)
unfolding dispose1_above_def
find_theorems simp: "if _ then _ else _"
apply (simp add: if_bool_eq_conj)
  find_theorems " _ \<noteq> empty"
  thm k_nonempty_dispose_above 
      k_min_loc_munion_singleton[of "dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1" d1 s1]
apply (rule k_dispose1_abovebelow_nonempty_aux)
apply (simp) 
*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~ NAT1_MAP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~ LOCALE ~~~~*)

(* SNEAK: nonzero_enter_dom ; special: look at line 1593 "GOAL TO SOLVE" line. real goal; LF: IJW giving too large steps *)
lemma z_F1_inv_dispose1_nat1_map:
  "nat1_map
     ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
      [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)])"
    find_theorems simp: "_ \<union>m _"
    find_theorems "nat1_map (_ \<union>m _)"
      thm l_munion_dom_ar_assoc[of "(dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1))" f1
                                   "[min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)]"]
    find_theorems simp: "nat1_map(_ -\<triangleleft> _)"
    find_theorems "nat1_map [_ \<mapsto> _]"
apply (rule l_nat1_map_munion)
apply (metis f_F1_inv_nat1_map k_nat1_map_dom_ar l1_invariant_def)
apply (metis F1_inv_def l1_input_notempty_def l1_invariant_def l_nat1_map_singleton l_nat1_sum_size_dispose1_ext)
by (metis l_dispose1_munion_disjoint)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~ SEP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

lemma z_F1_inv_dispose1_sep:
    "sep ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
         [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)])"
find_theorems "sep (_ \<union>m _)"
apply (rule l_sep_munion)
apply (metis l_dispose1_munion_disjoint)
apply (metis f_F1_inv_sep k_sep_dom_ar l1_invariant_def)
apply (metis F1_inv_def l1_input_notempty_def l1_invariant_def l_nat1_sum_size_dispose1_ext l_sep_singleton)
apply (insert l1_invariant_def)
apply (insert l1_input_notempty_def)
apply (frule_tac [1-2] f_F1_inv_finite)
apply (frule_tac [1-2] f_F1_inv_nat1_map)
apply (frule_tac [1-2] f_F1_inv_disjoint)
apply (frule_tac [1-2] f_F1_inv_sep)
by (simp_all add: l_sep0_dispose1_abovebelow_ext l_sep0_dispose1_ext_abovebelow)
  (*
  apply (rule l_sep0_dispose1_abovebelow_ext)
    apply (metis f_F1_inv_finite l1_invariant)
    apply (metis f_F1_inv_nat1_map l1_invariant)
    apply (metis f_F1_inv_disjoint l1_invariant)
    apply (metis f_F1_inv_sep l1_invariant)
    apply (metis l1_input_notempty)
  
  apply (simp add: l_sep0_dispose1_abovebelow_ext 
                      f_F1_inv_finite
                      f_F1_inv_nat1_map
                      f_F1_inv_disjoint
                      f_F1_inv_sep
                        l1_invariant
                      l1_input_notempty)
  
  apply (rule l_sep0_dispose1_ext_abovebelow)
done
*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~ DISJOINT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(* NOTE: This LEMMA is very neat! All coming to place now all others have been proved! *)
lemma z_F1_inv_dispose1_Disjoint:
  "Disjoint
     ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
      [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)])"
      find_theorems simp:"Disjoint(_ \<union>m _)"
      (* min_loc (dispose1_ext f1 d1 s1) \<notin> dom((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1) *)
apply (rule l_disjoint_singleton_upd)
apply (metis f_F1_inv_nat1_map k_nat1_map_dom_ar l1_invariant_def)
apply (smt Collect_empty_eq Un_empty_left dom_eq_singleton_conv inf_commute 
            inf_sup_absorb insert_absorb insert_def l_dispose1_munion_disjoint singleton_conv2 sup_commute)
apply (metis F1_inv_def l1_input_notempty_def l1_invariant_def l_nat1_sum_size_dispose1_ext)
apply (metis f_F1_inv_disjoint k_Disjoint_dom_ar l1_invariant_def)
by (metis F1_inv_def l1_dispose1_precondition_def l1_input_notempty_def l1_invariant_def l_disjoint_dispose1_ext)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~ F1_inv ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

lemma z_F1_inv_dispose1_post :
	"F1_inv ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1 \<union>m
            [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)])"
by (metis F1_inv_def 
          z_F1_inv_dispose1_Disjoint 
          z_F1_inv_dispose1_finite 
          z_F1_inv_dispose1_nat1_map 
          z_F1_inv_dispose1_sep)

theorem locale1_dispose_FSB: "PO_dispose1_feasibility"
unfolding PO_dispose1_feasibility_def dispose1_postcondition_def \<comment> \<open>dispose1_post_def"
apply (simp add: dispose1_equiv)
  \<comment> \<open>Apply equivalence LEMMA to tame the proof \<close>
unfolding dispose1_post2_def
by (simp add: z_F1_inv_dispose1_post)

end  (* LOCALE CONTEXT FOR LEMMA COLLECTION *)

(*<*)
unused_thms

(* ================================================================= *)
section \<open> Discussion \<close>
(* ================================================================= *)

(* ================================================================= *)
section \<open> Introduction \<close>
(* ================================================================= *)

text 
\<open>
   Identifiable proof patterns. I am deliberately avoiding the 
   term strategy or plan, given these have rather overloaded (and mixed)
   meaning (e.g.~part of an algorithmic procedure to solve a goal as a series
   of tactic applications;~or a graphical representation of a final proof). 

   Instead, the idea of a proof pattern is, like in code design patterns\cite{gof-book,Abrial08}, a
   guideline (as precise as possible, yet not necessarily prescriptive or fixed).
   In what follows, we aim to describe most commonly used patterns from our 
   experience in the proof of rather specific goals, namely those involve in
   refinement and consistency proofs of formal methods specifications. 

   It is tempting to try and think of the use of these patterns in sequential manner,
   almost as if it could be done in batch. Perhaps true for final (finished) proofs,
   it is certainly not the case for the process of proof discovery, which is what
   we are interested in.

   Proof discovery is a difficult and time consuming process that can require 
   considerable creativity. In formal methods proof, however, luckily, there are
   common and repetive enough patterns that can afford the user some releif by
   the help of tools, which we are trying to develop. 

   I prefer to think about the proof patterns we are about to describe as a
   kaleidoscopic view of the proof process, instead of a layered one. That is
   simply because we are not trying to capture data/information about a final
   proof, but the process leading to a final proof, in the hope to be able to
   mechanically tweak it in order to solve (the very many) similar goals born
   out of formal developments like the HEAP. 

\<close>

(* ================================================================= *)
section \<open> Proof patterns \<close>
(* ================================================================= *)

text 
\<open>
   So far, I have encountered four kinds of proof pattern:~static,
   dynamic, combined, automation. In what follows, we will detail 
   their characteristics by instantiating them as much as possible
   to the HEAP problem given above.

   It is worth emphasising that many of these patterns would not 
   apply to mathematically involved proofs, or indeed for small
   enough (even if mathematically complex) problems. They are typical
   of formal methods proofs, which tend to be large and considerably
   structured, if in multiple layers and various operators, many of
   which are new to the user and theorem prover.

   Like known criticism for design patterns (see Paul Graham's 
   article\footnote{See \url{http://www.paulgraham.com/icad.html}}), the need of proof patterns
   could arguably be said to be either from weakness of the prover's
   script language exprssivity (i.e.~like a missing feature that would
   otherwise mitigate the need of such patterns; see Dylan wiki or 
   design patterns wiki) or indeed lack of user experience. The former
   argument is rather debatable, given proof is inheriantly undecidable
   and complex task (i.e.~such an expressive language is inviable). Yet, 
   the latter argument can e taken pragmatically:~the use of formal methods 
   by industry is hampered by the complexity of the proof task, which limits
   its wider application on financial grounds. Thus, deskilling and increasing
   automation of a necessarily interactive process is crucial.  

   Remember Alan's criticism: why the need for thm tags?  
\<close>

(* ================================================================= *)
subsection \<open> Proof patterns language (or glossary) \<close>
(* ================================================================= *)

text
\<open>
   Both in software and pedagogical patterns, the use of a so-called
   pattern language serves to structure the description of the pattern
   itself in abstract terms, yet with specific instantiation to realistic
   scenarios and examples, which I plan to create for proof patterns.
   Nevertheless, proof patterns in the formal methods context necessitate
   a realistic example, which are often involved and complex. We try to
   address this as succintly as possible. 

   Albeit important, accurate examples are hard to provide, given this
   dependency to complex/large problems. It is important to convey at
   least new meaning and intent by the description of the pattern. For
   example, ``proof by induction'' brings the reader to focus on three
   features:~what's the inductive variable, base and step cases;~and that
   is irrespective of the actual induction principle used or regards to
   its complexity/intricacy. What we want to acheive is something similar,
   namely an extended vocabulary to discuss issues in the formal methods
   proof process.

   Tentative features of pattern languages features / structures are 
   described below. These are not mandatory and might vary across patterns.

   TODO: look at Iain chapter 9 for a pattern language? 
   Martin Fowler (Refactoring: Improving Design of Existing Code)

   \begin{enumerate}
    \item Name --- single name or short phrase describing the pattern's meaning.
      This should enable rapid association and retrieval of intent.

    \item Intent/Why --- brief desription of intent behind usage (see Motivation).

    \item Problem --- symptoms commonly found in the scenarios where the 
      patterns is to be applied, possibly with a desired outcome description.

    \item Motivation --- description of intent's interactions with the problem
      and context. For example, a blind (automatic) proof (i.e. by sledgehammer or auto) 
      is desirable if elusive, whereas an algebraic proof (i.e. a distributive law
      about new operators of a given problem) is usually associated/shaped according
      to a prior specific motivation (i.e. some prior, more complex, goal).

    \item Trigger/Shape/Structure/Scenario --- description of the shape involved in the scenario where 
      the pattern applies. For example, when applying associative laws certain provers
      require the lemmas to be left-associative in order to avoid rewrite loops;~or
      when defining equivalence lemmas the matching goal often appears on the LHS to
      be substituted. If possible a graphical representation of the pattern shape would be useful
      (see hi-proofs?)

    \item Applicability/Context/Features --- problem preconditions and/or identifiable features.
      When problems (and preconditions) conflicts, the resolution/dirction
      often come from some key identifiable feature, which leads to deciding
      the appropriate direction. 

    \item Solution --- instruction of how to apply the pattern in the given context
      to solve the problem and its variants (if applicable). It might include pictures,
      or other high-level explanatory device. If possible, it might include ``proof script sketch''
      or skeleton. Yet, for dynamic patterns this is harder to do(?). 

    \item Outcome --- a resulting context after the pattern is applied, including 
      postconditions and side effects to goals involved. It could also include new
      resuting problems, hence suggesting further patterns. 

    \item Collaboration/Dependencies --- relationship with other patterns applicable alongside or 
      after this one;~predecessor/successor of what pattern, etc;~description of differences
      among similar pattern plus rationale of choice.

    \item Siblings --- sibling pattern [keep at all?]

    \item Examples --- description of known usage scenarios across different problems.
      These examples needn't be detailed, yet should enable the user to identify the
      pattern's problem, context and scenario to another situation. Given the complexity/size
      of som formal methods problems, it might not be possible to provide succint examples. 

    \item Rationale --- a short description of the though process involved in selecting
      and instantiating this pattern, which is often associated with the examples chosen.
      It should include an explanation of the necessary context and motivations in order 
      for this pattern to resolve the given problem. [PERHAPS REDUNDANT WITH SOLUTION? DIFF TAC?]
   
   \end{enumerate}

   TODO[IJW/LF]: discuss the use/capture of failure? Add failure mode to pattern language? 

   TODO[IJW]: review/improve with knowledge/ideas from his PhD
\<close>

(* ================================================================= *)
subsection \<open> Static proof patterns \<close>
(* ================================================================= *)

text 
\<open>
   Static proof patterns address frequent and mundane issues of formal methods
   proofs. They require little if any interaction. They are usually the first 
   set of patterns to try and identify with the problem, which is a top-level
   proof obligation generated by the formal method used.
\<close>

(* ================================================================= *)
subsection \<open> Feasibility \<close>
(* ================================================================= *)

text
\<open>
   \begin{enumerate}
    \item Name: FSB_PO

    \item Intent(?): Discharge feasibility proof oblgation. This is a top-level goal generated
                    by some FM method tools

    \item Problem(?): 
      Formal methods models usually describe state as a complext type (i.e. datatype or record)
      alongside a predicate characterising the invariant properties of interest. Operations are
      defined in terms of a before/after version of the state including inputs and outputs that
      ought to satisfy both the state invaiant and the design decision the operation specify.

      Feasibility resolves the problem of finding an adequate value of the after state such that
      the state invariant and operation post condition hold.

    \item Motivation: 
      The FSB pattern aim is to find an instance of the after state and output of an operation that
      satisfy the state invariant and postcondition in the presence of the precondition over the 
      before state and inputs.

      When proving feasibility it is often necessary to find witnesses for values involved (see FW pattern).
      This can be also be performed after moving layers of abstraction (i.e. expading / simplifying definitions)
      prior to insantiation (see ZOOM pattern and other dynamic patterns). Moreover, when the assumptions
      are two weak or have hidden cases one migt need to strengthen then prio to insantiation (see HCA pattern).

    \item Trigger/Shape? [NOTE: schematic variables given for unknowns to be described]

        ``theorem $PO\_[OP]\_FSB$: @{text "\<forall> ?s ?i . ?inv ?s \<and> ?pre ?s ?i \<longrightarrow> \<exists> s' o' . ?inv s' \<and> ?post ?s ?i s' o"}''

        The suggestion for the name theorem is to show this is a top-level goal generated by some
        FM tool for the given operation [OP].
      
    \item Context: [NOTE: we do not call these features to avoid confusion with terminology]
    
        \begin{itemize}
          \item before state (@{text "?s \<in> state"})
          \item input (@{text "?i \<in> input-type"})
          \item state invariant (@{text "?inv :: state \<Rightarrow> bool"})
          \item operation precodition (@{text "?pre :: state \<Rightarrow> input-type \<Rightarrow> bool"})
          \item operation postcondition (@{text "?post :: stat \<Rightarrow> input-type \<Rightarrow> state \<Rightarrow> bool"})
        \end{itemize}

    \item Solution:

        TODO[IJW]: Bring in the isar/proc proof script templates? add tip that ?x might be variable vector
        TODO[LF/IJW]: Bring in a "hiproof"/"psgraph" style diagram for this pattern 

        TODO[LF]: maybe delete/extend list  below?
        \begin{enumerate}
          \item apply any necessary pattern/step to the goal prior to instantiation
          \item perform witnessing (pattern)
          \item simplify/rewrite
          \item [create new zoom level / rearrange definition categories/layers] 
                  [user feature: tag lemmas, defs; create new (layering) defs]
          \item bring in zoom N-1 (i.e. solve the goal at the level below current to enable bringing it in for finishing goal)
          \item simplify/rewrite finishing goal
        \end{enumerate}

    \item Outcome: [NOTE: we remove schematic variables for ground variables to emphasise contextual choices]

        Expected outcome is a witness for the existentially quantified variables, which often 
        rely on some lemma helping to stablish the postcondition and invariant.

        \begin{itemize}
          \item grounded schematic variables to specific problem (@{text "s, i, inv, pre, post"})
          \item after state witness (@{text "s' \<in> state"})
          \item output witness (@{text "o \<in> output-type"})
          \item lemma solving invariant predicate for given witness (@{text "inv s'"})
          \item lemma solving operation postcondition for given witnesses (@{text "post s i s' o"}) 
        \end{itemize}

        Two suggested lemmas serve to break the prolem into its constituent parts. These lemmas
        usually have the following shape:

        [NOTE: how to bring in an 'isabelle' lemma definition verbatim next?]
        \begin{itemize}
          \item @{text "\<lbrakk> lemma l_[OP]_fsb_inv:"} @{text "inv s \<Longrightarrow> inv s'"} @{text "\<rbrakk>"}
          \item @{text "\<lbrakk> lemma l_[OP]_fsb_post:"} @{text "inv s \<Longrightarrow> pre s i \<Longrightarrow> post s i s' o"} @{text "\<rbrakk>"}
        \end{itemize}

        Notice that the first lemma can be used to help the proof of the second,
        in case the after state invariant is useful within the postcondition. Other patterns 
        are to be used and are at the user discretion.
    
    \item Collaboration:

        \begin{itemize}
          \item HCA: to identify asumptions enabling finding witnesses 
          \item ZOOM: to expand defs and move layers of abstractions prior to finding witnesses
          \item FW: to identify output and after state
          \item other patterns: to solve the two lemmas in the outcome
        \end{itemize}

    \item Siblings:
    
        \begin{itemize}
           \item $PO_A$ (refinement adequacy PO)
           \item $PO_WP$ (refinement widening precondition PO)
           \item $PO_NP$ (refinement narrowing postcondition PO)
        \end{itemize}

    \item Examples: see theorems $locale1_new_FSB, locale1_dispose_FSB$ in \textsf{HEAP/HEAP1Proofs.thy}

        HEAP1-dispose uses @{text "FW[\<exists>-1p]"}, which is always the case when 
        the postcondition enables the direct application of the @{text "\<exists>"}-1-point rule.

        HEAP1-new uses @{text "HCA[\<le>]"} to split the precondition into different assumptions
        that enable the appropriate @{text "FW[\<exists>-1p]"} instantiation. 

    \item Rationale: TODO[LF]: worth keeping at all?

   \end{enumerate}
\<close>

(* ================================================================= *)
subsection \<open> Find Witness \<close>
(* ================================================================= *)

text
\<open>
   \begin{enumerate}
    \item Name: FW

    \item Intent(?): find a suitable value for a existentially quantified variable

    \item Problem(?): 

      Various foral methods proof obligations involve discovering an existential 
      witness that solves a particular predicate withn a context 
      (e.g. pred=post,context=feasibility; inv,adequacy; pre,widen; post,narrowing, etc).

    \item Motivation: 
      The find witness (static) pattern aim is to eliminate an existentially quantified variable.
      The trivial case is by the @{text "\<exists>"}-1-point-rule, which provide the witness from an equality involving
      the quantified variable on the left hand side. For the non-trivial case, the user needs to
      paticipate with a suggested value. A ``wicked'' variation of this pattern also helps this
      suggestion by guessing a value that, albeit not being satisfactory/valid, help the user 
      discover what a correct value could be. 

      For instance, in feasibility proofs (see $PO\_FSB$ pattern) we need to find an after state (@{text "s'"}) 
      satisfying the invariant (@{text "inv"}) and postcondition in the context of the invariant and before state (@{text "s"}). 
      One ``wicked'' guess witness is to make @{text "s'=s"}. That followed by the most powerful/adequate
      rewrite/simplification step by the prover (e.g. auto/blast/simp) leads to a residual (often
      unsatisfiable/false) goal. This residual goal can then be taken by the user for inspiration 
      about a proper witness for @{text "s'"}.

      In the wicked or general case, it possible to use other patterns (see dynamic patterns family)
      to simplify the goal prior to any actual instantiation.

    \item Trigger/Shape?:

        \begin{itemize}
          \item trivial (@{text "\<exists>-1p"}): @{text "\<exists> ?x\<^sup>n . ?x\<^sup>n = ?P\<^sup>m"}
          \item general            : @{text "\<exists> ?x\<^sup>n . ?P\<^sup>k ?x\<^sup>n"}
        \end{itemize}

        We use @{text "?x\<^sup>n"} referring to a vector of variables, wih the appropriate adjustment
        for the conjoined equalities involved on the RHS. Also note we might have a situation
        where we have m equations for n variables (@{text "n > m"}), which leads to a combination of 
        each kind. 
      
    \item Context: 
    
        \begin{itemize}
          \item non-empty vector of variables (@{text "?x\<^sup>n, n > 0"})
          \item possibly empty vector of equalities (@{text "?P\<^sup>m, n > m \<ge> 0"})
          \item non-empty vector of non-equality predicates (@{text "?P\<^sup>k, k > 0"})
        \end{itemize}

    \item Solution:

        TODO[IJW]: Bring in the isar/proc proof script templates? add tip that @{text "?x"} might be variable vector
        TODO[LF/IJW]: Bring in a "hiproof"/"psgraph" style diagram for this pattern 

        TODO[LF]: maybe delete/extend list  below?
        \begin{enumerate}
          \item simplify the goal (i.e. exI)
          \item apply any necessary pattern/step to the goal prior to instantiation
          \item perform witnessing (pattern)
          \item simplify/rewrite
        \end{enumerate}

    \item Outcome: 

        Expected outcome is a witness for the existentially quantified variable.

        \begin{itemize}
          \item grounded schematic variable (@{text "x\<^sub>n"})
        \end{itemize}
    
    \item Collaboration:

        \begin{itemize}
          \item WEAKENING: weakening can be used to simplify @{text "?P\<^sup>n"} prior to instantiation
          \item PO_FSB: find witness is often used by $PO_FSB$
        \end{itemize}

    \item Siblings: none
     
    \item Examples: see theorems $locale1_new_FSB, locale1_dispose_FSB$ in \textsf{HEAP/HEAP1Proofs.thy}

    \item Rationale: TODO[LF]: worth keeping at all?

   \end{enumerate}
\<close>

(* ================================================================= *)
subsection \<open> ????? \<close>
(* ================================================================= *)

text
\<open>
   \begin{enumerate}
    \item Name: 

    \item Intent(?): 
    \item Problem(?): 

    \item Motivation: 

    \item Trigger/Shape?: 
        
      
    \item Context: 

        The pattern preconditions require ?
        \begin{itemize}
          \item bla
        \end{itemize}


    \item Solution:

         \begin{enumerate}
            \item bla
        \end{enumerate}

    \item Outcome: 
        \begin{itemize}
          \item bla
        \end{itemize}

        Two suggested lemmas serve to break the prolem into its constituent parts. These lemmas
        usually have the following shape:

        [NOTE: how to bring in an 'isabelle' lemma definition verbatim next?]
        \begin{itemize}
          \item @{text "\<lbrakk> lemma l_[OP]_??:  ?? \<rbrakk>"}
        \end{itemize}

    
    \item Collaboration:

        \begin{itemize}
          \item bla
        \end{itemize}

    \item Siblings:
    
        \begin{itemize}
          \item bla
        \end{itemize}

    \item Examples: 
    \item Rationale: TODO[LF]: worth keeping at all?

   \end{enumerate}

TODO
\begin{itemize} 
   \item definition categorisation: conceptual layers (i.e. zoom levels)
     
   \item ranking: hypothesis + definitions 

   \item finding-assumptions
      
      start with @{text "True \<Longrightarrow> x \<in> dom(f \<union>m g)"} and try to find what would finish this? 
\end{itemize} 
\<close>

(* ================================================================= *)
subsection \<open> Dyanmic proof patterns \<close>
(* ================================================================= *)

text 
\<open>
\begin{itemize}
    \item  zooming: expand zoom N upto M (i.e. @{text "N < M"}; layers of intrest to expand, 1 min, @{text "M-N > 0"} max) 
       \begin{itemize}
          \item compartimentalise (stay at zoom level)
          \item bridging (or anti-zooming) (i.e. @{text "locs_of \<longrightarrow>  non-linear-arithmetic"}) [user feature: zoom jump source-target]
       \end{itemize}
    \item  weakening: guided by complexity-score ordering (high-to-low score; True=lowest=backward-proof; False=highest=contradictory-proof)
       \begin{itemize}
       \item main operators [user feature: ops set per zoom level]
       \item chaining [user feature: direction of travel]
         \begin{itemize}
            \item forward: increase asumptions complexity-score or assumption number to enable backward step or find contradictory proof
            \item backward: matches the goal to weaken / lower its complexity score / numer of main operators per zoom level 
                  or find direct proof
         \end{itemize}
       \item creative [user feature: provide new concept]
        \begin{itemize}
          \item equality: redefine/reorganise concepts (i.e. @{text "dom s \<subseteq> 1 .. MAX"} for @{text "#s < MAX"}; mondex BetweenWorld layers; etc)  
          \item refinement: pick one side (i.e. @{text "x \<sqsubseteq> y"} is enough in UTP fix point; POSIX ordering @{text "f(i)/f(i+1)"} for 
            @{text "f(i)/f(j), i<j"} is more deterministic)
          \item novel: invent new (intermediary) concepts (i.e. J's permutation for quicksort=insertionsort; HEAP sep0; Flash Bulk promotion)
         \end{itemize}
        \end{itemize}   
    \item chasing bindings of interest

    \item  see thoughts on why pattern language .pdf in SVN
\end{itemize}
\<close>

(* ================================================================= *)
subsection \<open> Combined proof patterns (strategical/tactical style patterns?) \<close>
(* ================================================================= *)

text 
\<open>
\begin{verbatim} 
    * bridge > weakening
    * zooming > witnessing
    * chaining forward > chaining backward
\end{verbatim} 
\<close>

(* ================================================================= *)
subsection \<open> Automation proof patterns \<close>
(* ================================================================= *)

text
\<open>

\begin{verbatim} 
    * type judgements
    * lemma tagging
    * congruence rules
    * transitive rules 
\end{verbatim} 
\<close>

(*------ LIBRARY --------*)

(* LF high *)
thm ext fun_eq_iff (* in bridging lemmas *)

(* IJW high *)
thm Collect_mem_eq (* in shaping lemmas *)

(* LF/IJW high *)
thm disjoint_iff_not_equal (* IJW much lower [4]; LF=31! *)
    (* NOTE: IJW uses of lemma is via SH only (i.e. the bridge the latest possible (via smt)) 
             (i.e. filling the sketch with automation by first shaping things up)

             LF uses the lemma both in SH (8) and in explicit goal/assumption massaging tasks (23)
             (i.e. bridge the assumptions to have a explicit witness; jump to logic from set theory in goal)
     *)

thm domIff dom_eq_empty_conv dom_eq_singleton_conv dom_empty
    inf_commute (*x \<inter> y*)

(*------ VDM Libraries --------*)

(* NOTE: LF uses much more l_munion_dom (29) times for IJW's (18) times. That's to do with history of development
        (i.e. at first model had \<dagger> then got to have \<union>m). LF uses l_munion_apply (19) times whereas IJW hasn't use it.
        IJW had dagger proofs for the \<union>m and get through via that. (i.e. IJW \<dagger>+\<union>m dom = 27 ! gotcha).

        That's to do with fun_eq_iff usage by LF (15). So let's compare the next ones. LF uses l_munion_dom mostly 
        for assumption case analysis and occasional goal weakening. IJW's use is ?

   NEXT: look into next VDM lemmas
 *)

(* LF high *)
thm l_munion_apply 

(* IJW high *)
thm dagger_notemptyL (* kind of trivial *)
    l_inmapupd_dom_iff (* LF doesn't like/use map updates; instead \<union>m [_ \<mapsto> _] *)

(* LF/IJW high *)
thm f_in_dom_ar_subsume l_dom_dom_ar l_dom_r_iff
    l_dagger_apply

(* Not exclusive reasons...

   LF(H);IJW(H) \<Rightarrow> Isa/VDM lib lemma \<Rightarrow> important lemma for the level of discourse (i.e. general / useful?)
   LF(H);IJW(L) \<Rightarrow> [and vice-versa]: \<Rightarrow> style-specific 
   LF(L);IJW(L) \<Rightarrow> 
*)

(* nat1 y \<Longrightarrow> nat1_map [x \<mapsto> y] : example of zooming done wrongly !!! 1st case jumps via f_nat1_map_extends_map_le? quirky... *)
thm fun_upd_triv map_add_empty map_add_upd map_le_map_add nat1_map_def f_nat1_map_extends_map_le option.sel
thm dom_empty empty_iff fun_upd_same l_inmapupd_dom_iff nat1_map_def option.sel

thm l_munion_dom l_munion_apply
(*
1) nat1(the(_ \<union>m _)_)

2) locs(_ \<union>m _)

3) (the(_ \<union>m _) _) \<notin> dom(_ \<union>m [_ \<mapsto> _])

4) locs_of _ (the (_ \<union>m _) _)

5) finite ( dom ( _ \<union>m _ ) )

6) dom ( _ \<union>m _) \<inter> _ = {}

7) Min (dom (_ \<union>m _))

8) dom((_ -\<triangleleft> _) \<union>m _)

9) the((_ -\<triangleleft> _) \<union>m _) _

Key ones: 6, 8, direct
L1 = 29
L2 = 18 (only 1 not within 29)
*)

thm f_in_dom_ar_subsume
    f_in_dom_ar_the_subsume
    l_dom_dom_ar
(*
1) nat1_map (_ -\<triangleleft> _)

2) _ \<in> locs_of _ (the (_ -\<triangleleft> _) _)

3) sep (_ -\<triangleleft> _)

4) finite( dom (_ -\<triangleleft> _) )

5) _ \<in> dom( (_ -\<triangleleft> _) \<union>m _ )

6) dom (_ -\<triangleleft> _) \<inter> _ = {}

Key ones: direct
L1 = 23
L2 = 13 (always within L1)
L3 = 13
*)

thm b_locs_of_as_set_interval
(*
1) finite( locs_of _ _)
2) card( locs_of _ _)
3) _ \<in> locs_of _ _

7
*)

thm f_nat1_map_nat1_elem
(*
1) min_loc( _ \<union>m _ ) \<in> dom _
2) _ \<in> dom (_ -\<triangleleft> _)
19
*)

find_theorems name:k_dispose
thm k_dispose_abovebelow_dom_disjoint
(*
1) dom(_ \<union>m )

2) finte(dom (_ \<union>m _))

3) dom (_ \<union>m _) \<inter> _ = {}

4) sum_size (_ \<union>m _)

5) dom ((_ -\<triangleleft> _) \<union>m _ )

11
*)

find_theorems name:k_min_loc
thm k_min_loc_munion_singleton
(*
1) min_loc(_ \<union>m [_ \<mapsto> _])

2) locs_of ( min_loc (_ \<union>m [_ \<mapsto> _]) ) _

11
*)

thm l_disjoint_mapupd_keep_sep
(*
1) _ \<in> dom _

2) _ \<in> dom(_ -\<triangleleft> _)

12
*)

find_theorems "locs (_ -\<triangleleft> _)"
thm l_locs_dom_ar_iff
(*
1) locs_of _ _ \<inter> locs(_ -\<triangleleft> _) = {}

6
*)

find_theorems name:min_loc
thm l_min_loc_dispose1_ext_absorb_above
(*
5
*)

find_theorems name:disjoint name:munion
thm HEAP1Proofs.level1_dispose.l_dispose1_munion_disjoint
(* 
4
*)

(*>*)

end
