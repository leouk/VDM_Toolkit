theory MinimalHEAPLemmas
imports MinimalHEAP1
begin

text {* First we start with just one function symbol (foreground; even if with more in background).
        Next, we add some side conditiosn that are "obvious" (inferrable/knownable from context).
        Finally, we have some lemmas that don't have trivial conditions, yet QuickSpec already find them
        (without the conditions).
      *}

(*========== Map domain anti-restriction related lemmas (Zoom0) ==============*)

text {* Foreground symbol: @{text "_ -\<triangleleft> _"} *}

(******************************************************************************)
section {* These lemmas are side-condition free *}

lemma l_dom_dom_ar:
	"dom(S -\<triangleleft> f) = dom f - S"
oops

lemma l_dom_ar_accum:
	"S -\<triangleleft> (T -\<triangleleft> f) = (S \<union> T) -\<triangleleft> f"
oops

lemma l_dom_ar_empty_lhs:
  "{} -\<triangleleft> f = f"
oops

lemma l_dom_ar_empty_rhs:
  "S -\<triangleleft> empty = empty"
oops

lemma l_map_dom_ar_subset: 
  "S -\<triangleleft> f \<subseteq>\<^sub>m f"
oops

lemma l_dom_ar_none: 
  "{} -\<triangleleft> f = f"
oops

(******************************************************************************)
section {* These lemmas require side conditions (from known context) *}

lemma f_in_dom_ar_subsume: 
  "l \<in> dom (S -\<triangleleft> f) \<Longrightarrow>  l \<in> dom f"
oops

lemma f_in_dom_ar_the_subsume: 
  "l \<in> dom (S -\<triangleleft> f) \<Longrightarrow> the ((S -\<triangleleft> f) l) = the (f l)"
oops

lemma f_in_dom_ar_apply_subsume: 
  "l \<in> dom (S -\<triangleleft> f) \<Longrightarrow> ((S -\<triangleleft> f) l) = (f l)"
oops

lemma f_in_dom_ar_apply_not_elem: 
  "l \<notin> S \<Longrightarrow> (S -\<triangleleft> f) l = f l"
oops

lemma f_in_dom_ar_notelem: 
  "l \<in> dom ({r} -\<triangleleft> f) \<Longrightarrow> l \<noteq> r"
oops

(******************************************************************************)
section {* These lemmas require some side conditions (beyond just context) *}

lemma l_dom_ar_nothing:
	"S \<inter> dom f = {} \<Longrightarrow> S -\<triangleleft> f = f"
oops

lemma l_dom_ar_everything:
  "dom f \<subseteq> S \<Longrightarrow> S -\<triangleleft> f = empty"
oops

lemma l_map_dom_ar_neq: 
  "S \<subseteq> dom f \<Longrightarrow> S \<noteq> {} \<Longrightarrow> S -\<triangleleft> f \<noteq> f"
oops

(*================== Map Union Related Lemmas (Zoom1) ========================*)

text {* Foreground symbol: @{text "_ \<union>m _"}; maybe  @{text "_ -\<triangleleft> _"} *}

(******************************************************************************)
section {* These lemmas are side-condition free *}

lemma b_dagger_munion_aux:
	"dom(dom g -\<triangleleft> f) \<inter> dom g = {}"
oops

(* ++ is like haskel union for maps but prefers g for f in case of duplicates in the domain *)
lemma b_dagger_munion:
	"(f ++ g) = (dom g -\<triangleleft> f) \<union>m g"
oops

lemma l_munion_empty_rhs: 
  "(f \<union>m empty) = f"
oops

lemma l_munion_empty_lhs: 
  "(empty \<union>m f) = f"
oops

(******************************************************************************)
section {* These lemmas require side conditions (from known context) *}

(* from the context/definition of m_union: "dom f \<inter> dom g = {}" *)
lemma l_munion_apply:
	"dom f \<inter> dom g = {} \<Longrightarrow> (f \<union>m g) x = (if x \<in> dom g then (g x) else (f x))"
oops

lemma l_munion_dom:
	"dom f \<inter> dom g = {} \<Longrightarrow> dom(f \<union>m g) = dom f \<union> dom g"
oops

lemma l_munion_commute: 
  "dom f \<inter> dom g = {} \<Longrightarrow> f \<union>m g = g \<union>m f"
oops

lemma k_finite_munion:
  "finite (dom f) \<Longrightarrow> finite(dom g) \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> finite(dom(f \<union>m g))" 
oops

lemma l_munion_singleton_not_empty:
  "x \<notin> dom f \<Longrightarrow> f \<union>m [x \<mapsto> y] \<noteq> empty"
oops

lemma l_munion_empty_iff: 
  "dom f \<inter> dom g = {} \<Longrightarrow> (f \<union>m g = empty) \<longleftrightarrow> (f = empty \<and> g = empty)"
oops

(******************************************************************************)
section {* These lemmas require some side conditions (beyond just context) *}

(* it's the dom g \<inter> dom h = {} is the difficult one *)
lemma l_munion_assoc:
  "dom f \<inter> dom g = {} \<Longrightarrow> dom g \<inter> dom h = {} \<Longrightarrow> (f \<union>m g) \<union>m h = f \<union>m (g \<union>m h)"
oops

(* a bit of combined operators as well *)
lemma l_munion_dom_ar_singleton_subsume: 
    "x \<notin> dom f \<Longrightarrow> {x} -\<triangleleft> (f \<union>m [x \<mapsto> y]) = f"
oops

lemma l_munion_dom_ar_assoc:
	"S \<subseteq> dom f \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> (S -\<triangleleft> f) \<union>m g = S -\<triangleleft> (f \<union>m g)"
oops

lemma l_munion_subsume:
	"x \<in> dom f \<Longrightarrow> the(f x) = y \<Longrightarrow> f = ({x} -\<triangleleft> f) \<union>m [x \<mapsto> y]"
oops

(*================== Invariant Related Lemmas (Zoom2) ========================*)

text {* For the invariant, there are various "levels" within. Say, with just auxiliary functions
        like @{text "locs _"} and @{text "locs_of _ _"}, and those filtering conditions of the 
        invariant across these and the former function symbols.

        Foreground symbol: @{text "_ \<union>m _"}; maybe  @{text "_ -\<triangleleft> _"} 
      *}

(******************************************************************************)
section {* These lemmas are side-condition free *}

lemma l_nat1_map_empty: 
  "nat1_map empty"
oops

lemma l_sep_empty:
  "sep empty"
oops

lemma l_disjoint_singleton: 
  "Disjoint([x \<mapsto> y])"
oops

(******************************************************************************)
section {* These lemmas require side conditions (from known context) *}

lemma l_nat1_map_singleton: 
  "nat1 y \<Longrightarrow> nat1_map([x \<mapsto> y])"
oops

lemma l_sep_singleton: 
  "nat1 y \<Longrightarrow> sep([x \<mapsto> y])"
oops

(******************************************************************************)
section {* These lemmas require some side conditions (beyond just context) *}

lemma l_nat1_map_singleton_upd: 
  "nat1 y \<Longrightarrow> x \<notin> dom f \<Longrightarrow> nat1_map f \<Longrightarrow> nat1_map(f \<union>m [x \<mapsto> y])"
oops

lemma k_Disjoint_dom_ar:
	"Disjoint f \<Longrightarrow> Disjoint (S -\<triangleleft> f)"
oops

lemma k_F1_inv_dom_ar: 
   "F1_inv f \<Longrightarrow> F1_inv(S -\<triangleleft> f)"
oops

(* Weaken: separatedness subsumes dom_ar *)
lemma k_sep_dom_ar:
   "sep f \<Longrightarrow> sep (S -\<triangleleft> f)"
oops

(* example where concept generalisation is needed -- probably the most difficult one *)
(* wacky: would some "semingly useless" lemma help/hint to the concept? *)
definition 
  sep0 :: "F1 \<Rightarrow> F1 \<Rightarrow> bool" 
where
  "sep0 f g \<equiv> (\<forall> l \<in> dom f . l + the(f l) \<notin> dom g)"

thm sep_def sep0_def

lemma l_sep_munion:
    "dom f \<inter> dom g = {} \<Longrightarrow> sep f \<Longrightarrow> sep g \<Longrightarrow> sep0 f g \<Longrightarrow> sep0 g f \<Longrightarrow> sep(f \<union>m g)"
oops

lemma l_disjoint_munion: 
  "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> Disjoint f \<Longrightarrow> Disjoint g \<Longrightarrow> 
      dom f \<inter> dom g = {} \<Longrightarrow> disjoint (locs f) (locs g) \<Longrightarrow> sep0 f g \<Longrightarrow> sep0 g f \<Longrightarrow> Disjoint (f \<union>m g)"
oops

lemma l_disjoint_mapupd_keep_sep:
	"nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r \<in> dom f \<Longrightarrow> nat1 s \<Longrightarrow> the(f r) > s \<Longrightarrow> (r+s) \<notin> dom f"
oops

lemma k_new1_gr_dom_ar_dagger_aux:
	"nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r \<in> dom f \<Longrightarrow> nat1 s \<Longrightarrow> the(f r) > s \<Longrightarrow> dom ({r} -\<triangleleft> f) \<inter> dom [r + s \<mapsto> the (f r) - s] = {}"
oops

lemma k_nat1_map_dom_ar:
   "nat1_map f \<Longrightarrow> nat1_map (S -\<triangleleft> f)"
oops

lemma l_nat1_map_munion: 
  "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> nat1_map(f \<union>m g)"
oops



lemma l_locs_singleton_iff:
  "nat1 y \<Longrightarrow> locs [x \<mapsto> y] = locs_of x y"
oops

lemma f_in_dom_locs: 
  "nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow> x \<in> locs f"
oops

lemma l_locs_munion_iff:
  "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> locs(f \<union>m g) = locs f \<union> locs g"
oops

lemma f_dom_locs_of: 
  "nat1_map f \<Longrightarrow> (x \<in> dom f) \<Longrightarrow> (x \<in> locs_of x (the (f x)))"
oops

lemma l_locs_of_within_locs:
  "nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow> locs_of x (the(f x)) \<subseteq> locs f"
oops

lemma f_dispose1_pre_not_in_dom: 
  "nat1_map f \<Longrightarrow> nat1 s \<Longrightarrow> locs_of d s \<inter> locs f = {} \<Longrightarrow> d \<notin> dom f"
oops

lemma l_locs_dom_ar_iff:
  "nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r \<in> dom f \<Longrightarrow> locs({r} -\<triangleleft> f) = locs f - locs_of r (the(f r))"
oops


lemma k_nat1_map_dom_ar_munion:
   "nat1 s \<Longrightarrow> r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> Disjoint f \<Longrightarrow> nat1_map f \<Longrightarrow> nat1_map ({r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s])"
oops

lemma k_Disjoint_dom_ar_munion:
	"r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1 s \<Longrightarrow> nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> Disjoint (({r} -\<triangleleft> f) \<union>m [r + s \<mapsto> the (f r) - s])"
oops

lemma k_sep_dom_ar_munion:
   "nat1_map f \<Longrightarrow> r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1 s \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow> sep ({r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s])"
oops

lemma k_F1_inv_dom_munion: 
   "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> r \<in> dom f \<Longrightarrow> the(f r) > s \<Longrightarrow> F1_inv({r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s])"
oops

lemma l_dispose1_sep0_above_empty_iff:
  "(dispose1_above f1 d1 s1 = empty) = sep0 [d1 \<mapsto> s1] f1"
oops

lemma l_dispose1_sep0_below_empty_iff:
  "(dispose1_below f1 d1 = empty) = sep0 f1 [d1 \<mapsto> s1]"
oops

lemma l_dispose1_below_singleton_useless:
  "l \<in> dom f \<Longrightarrow>  l+the(f l) = d \<Longrightarrow> nat1_map f \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow> dispose1_below f d = [l \<mapsto> the(f l)]"
oops

(*================== Map Union Related Lemmas (Zoom1) ========================*)

(******************************************************************************)
section {* These lemmas are side-condition free *}

(******************************************************************************)
section {* These lemmas require side conditions (from known context) *}

(******************************************************************************)
section {* These lemmas require some side conditions (beyond just context) *}



lemma k_locs_of_arithIff:
	"nat1 n \<Longrightarrow> nat1 m \<Longrightarrow> (locs_of a n \<inter> locs_of b m = {}) = (a+n \<le> b \<or> b+m \<le> a)"
oops




(*
------ key message:

* theory exploration can decrease the proof effort in formal methods proofs (i.e. WD / FSB / Reify)
  by suggesting (key?) useful lemmas for involved function symbols

  -> this's despite not necessarily being over induction or complicated maths
  -> it relies on prior structural decomposition of the goal together with user guidance

* in our context (of a reasonably complex proof about a reasonably simple problem), the process did
  find lemmas used during the actual proofs. 

* discuss statistics on used lemmas distribution in general and how would the process help
  (i.e. 20% are usually library lemmas; context dependant lemmas 10-20% as well)

* arguably invariant proofs are like induction step cases (???)

* we should include in the perl script (e.g. heapanalysis.pl) a counter for function symbols? 
  (e.g. correlate function symbol -fore/background- with useful(ess) lemmas generated)? 
  [guiding light to how much decomposition is necessary prior to using the tool]

* in the end, we are shifting/deskilling the interaction process needed [**** AI4FM MESSAGE ****]

- without "whym"-like (meta-)data, the search is unyelding/intracable 
  (e.g. say something about what happened for findP)

- also dependant on the test set data generated for ensuring higher quality lemmas

-/+ tools were tailored for focusing on induction proofs (as where "interesting"-lies?)   [???] 
    quickspec = not; hipspec = yes. yet, wasn't too bad to make it transferable to a inv-style proof 

------ qeustions 
would we find all these? [already found some]
if not, why not? [need for better "generators" / "sig"s / reasoning-techniques / increased search space / etc ??? ]

how could we also filter out the negative examples?
how would WhyM be useful on this?

first versions already found some of the (condition-free; or even conditional lemmas, without the conditon) lemmas above

------ NOTES

* context based side conditions are to be encoded in the (QuickCheck)
  arbitrary generators; their "quality" determines the success of the outcome
    [TO DO?: could overture test case generation expresions help?]

* apparently meaningless lemmas suggested by quick spec could still be useful
  to the engineer staring at the problem
  (e.g. (locs f) -\<triangleleft> f = (locs g) -\<triangleleft> g  leads to the thought that  dom f \<subseteq> locs f for this to be true!)

* before proceeding to more complext goals we need to handle function symbols per "zoom layer"
  (i.e. lemmas will be found "per zoom level" (i.e. prop-logic -> sets -> maps -> heap-op (Locs/LocsOf) -> heap-inv (Disj / Sep)
        (argument on taming the search: to tame the search)

* we need different signatures to frame where the focus (of search) 
  should be (could also be informed by zoom layers?)

* test data determines the quality of the suggestions given by quick spec. we need to improve test set data
  (e.g. after generalisation of (_ -\<triangleleft> _) to sets (on LHS) we got this weird lemma: "(locs f) -\<triangleleft> (xs -\<triangleleft> f) = (locs f) -\<triangleleft> f")
      (this lemma is akin to saying locs f is maximal set on the domain of f for whatever xs; it's the case that dom f \<subset> locs f! 

* by adding other map symbols (e.g. { \<mapsto> }, {}) we got more sensible lemmas, yet the question is could 
  the focus be given to only the elements of interest
   -> yes with the "backgroun" signature staff. 

* adding more symbols hasn't completely deteriorated the match/usefulness of lemmas found.
  Is that true in general? (under the context of FM; i.e. user guided search to a degree).
  Add then carefuly (e.g. backgrond x foreground symbols)

* fidlding with the number of operators () to some 

----- things to test / check 

* could we add "basic information" (i.e. known lemmas + known equivalence classes) to aid reasoning?
  (i.e. given foreground information about locs/locs_of/-\<triangleleft> what would it need to find the lemma of interest?
          e.g. locs({r} -\<triangleleft> f) = locs f - locs_of r (the(f r))  

          -> quickspec not; 
          -> hipspec would find "set_different"/map_application?  [hipspec generate signatures]?
          -> then the suggestion would be likely, even for this complex lemma? 
          -> i.e. make use of known theories / lemmas to aid the shape of the background signature? 

          -> TODO: that (use of hipspec/quickspec) would require making non-inductive things "interesting" as well.

* wacky: would it be case that what is in the foreground in zoom_n will be in the background in zoom_n+1

* precompiled (Haskell) libraries (definitions) won't affect/influence HipSpec search
  (i.e. this will/could hamper proving that suggested lemmas are true; won't prevent the suggestion)
*)

end
