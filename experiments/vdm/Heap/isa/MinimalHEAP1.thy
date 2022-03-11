theory MinimalHEAP1
imports Map List
begin

(*********************************************************************)
section {* Basic Types *}

type_synonym Loc = nat

definition 
  nat1 :: "nat \<Rightarrow> bool"
where
  [iff]: "nat1 n \<equiv> n > 0"

(*********************************************************************)
section {* Things about sets *}

definition 
  disjoint :: "'a set \<Rightarrow> 'a set \<Rightarrow> bool"
where
 "disjoint A B \<equiv> A \<inter> B = {}"

(*********************************************************************)
section {* Things about about VDM maps *}

definition
  dom_restr :: "'a set \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixr "\<triangleleft>" 110)
where
  [intro!]: "s \<triangleleft> m \<equiv> m |` s"

definition
  dom_antirestr :: "'a set \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixr "-\<triangleleft>" 110)
where
  "s -\<triangleleft> m \<equiv> (\<lambda>x. if x : s then None else m x)"

definition
  munion :: "('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixl "\<union>m" 90)
where
  [intro!]: "f \<union>m g \<equiv> (if dom f \<inter> dom g = {} then f ++ g else undefined)"

find_theorems "sorted_list_of_set _"
(*
fun
  map_list :: "('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<times> 'b) list"
where
  "map_list empty = []"
| "map_list f = [(x, (the(f x)) | x \<leftarrow> sorted_list_of_set (dom f), true]"*)

definition 
  nat1_map :: "(Loc \<rightharpoonup> nat) \<Rightarrow> bool"
where
  "nat1_map f \<equiv> (\<forall> x. x \<in> dom f \<longrightarrow> nat1 (the (f x)))"

(*
lemma dom_code [code]:
  "x \<in> dom f \<longleftrightarrow> x mem  \<noteq> None"
sorry
*)

(*********************************************************************)
section {* Things about heap type representation *}

definition 
  locs_of :: "Loc \<Rightarrow> nat \<Rightarrow> (Loc set)"
where
  (* "locs_of l n \<equiv> (if nat1 n then { i. i \<ge> l \<and> i < (l + n) } else undefined)"  *)
  "locs_of l n \<equiv> (if nat1 n then {l..<l+n} else undefined)"

definition 
  locs :: "(Loc \<rightharpoonup> nat) \<Rightarrow> Loc set "
where
  "locs sm \<equiv> (if nat1_map sm then 
                \<Union> s \<in> dom sm. locs_of s (the (sm s)) 
               else 
                 undefined)" (* TODO: or {}?*)

(*********************************************************************)
section {* Things about heap auxiliary functions (DISPOSE-only) *}

definition
   min_loc :: "(Loc \<rightharpoonup> nat) \<Rightarrow> nat"
where
   "min_loc sm = (if sm \<noteq> empty then 
                      Min (dom sm) 
                  else 
                      undefined)" 

definition 
  sum_size :: "(Loc \<rightharpoonup> nat) \<Rightarrow> nat"
where
  "sum_size sm = (if sm \<noteq> empty then 
                      (\<Sum> x\<in>(dom sm) . the (sm x)) 
                  else 
                      undefined)" (*TODO: or 0? *)

(*********************************************************************)
section {* Things about heap L1 invariant *}

type_synonym F1 = "Loc \<rightharpoonup> nat"

definition 
  Disjoint :: "F1 \<Rightarrow> bool"
where
 "Disjoint f \<equiv> 
      (\<forall> a \<in> dom f. \<forall> b \<in> dom f . a \<noteq> b \<longrightarrow> disjoint (locs_of a (the(f a))) (locs_of b (the(f b))))"

definition 
  sep :: "F1 \<Rightarrow> bool" 
where
  "sep f \<equiv> (\<forall> l \<in> dom f . l + the(f l) \<notin> dom f)"

definition 
  F1_inv :: "F1 \<Rightarrow> bool" 
where
  [intro!]:  "F1_inv f \<equiv> Disjoint f \<and> sep f \<and> nat1_map f \<and> finite(dom f)"

(*********************************************************************)
section {* Things about heap L1 operations *}

definition 
  new1_pre :: "F1 \<Rightarrow> nat \<Rightarrow> bool"
where
  "new1_pre f s \<equiv> (\<exists> l \<in> dom f . the(f l) \<ge> s)"

definition
   new1_post_eq :: "F1 \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> Loc \<Rightarrow> bool"
where
   "new1_post_eq f s f' r \<equiv> r \<in> dom f \<and> the(f r) = s \<and> f' = {r} -\<triangleleft> f"

definition
   new1_post_gr :: "F1 \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> Loc \<Rightarrow> bool"
where
   "new1_post_gr f s f' r \<equiv> r \<in> dom f \<and> the(f r) > s \<and> 
                            f' = ({r} -\<triangleleft> f) \<union>m [r + s \<mapsto> the(f r) - s]"

definition
   new1_post :: "F1 \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> Loc \<Rightarrow> bool"
where
   "new1_post f s f' r \<equiv> new1_post_eq f s f' r \<or> new1_post_gr f s f' r"


definition 
   dispose1_pre :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> bool"
where
  "dispose1_pre f d s \<equiv> disjoint (locs_of d s) (locs f)"

definition 
   dispose1_post :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> bool"
where
   "dispose1_post f d s f' \<equiv> 
      (\<exists> below above ext . 
        below = { x \<in> dom f . x + the(f x) = d } \<triangleleft> f \<and>
        above = { x \<in> dom f . x = d + s } \<triangleleft> f \<and>
        ext   = (above \<union>m below) \<union>m [d \<mapsto> s] \<and>
        f' = ((dom below \<union> dom above) -\<triangleleft> f) \<union>m ([min_loc(ext) \<mapsto> sum_size(ext)]))
      "
       
definition 
  dispose1_below :: "F1 \<Rightarrow> Loc \<Rightarrow> F1"
where
  "dispose1_below f d \<equiv>  { x \<in> dom f . x + the(f x) = d } \<triangleleft> f" 

definition 
  dispose1_above :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F1"
where
  "dispose1_above f d s \<equiv>  { x \<in> dom f . x = d + s } \<triangleleft> f" 

definition 
  dispose1_ext :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F1"
where
  "dispose1_ext f d s \<equiv>  (dispose1_above f d s  \<union>m dispose1_below f d) \<union>m [d \<mapsto> s] "

definition 
   dispose1_post2 :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> bool"
where
   "dispose1_post2 f d s f' \<equiv> 
        (f' = ((dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) -\<triangleleft> f) 
        \<union>m ([min_loc(dispose1_ext f d s) \<mapsto> sum_size(dispose1_ext f d s)]))"
                  
(*********************************************************************)
section {* Things about heap L1 definition-sets to be expanded *}

lemmas F1_inv_defs = F1_inv_def Disjoint_def nat1_def
                     sep_def nat1_map_def
                        disjoint_def locs_of_def

lemmas new1_pre_defs      = new1_pre_def 
lemmas new1_post_defs     = new1_post_def new1_post_eq_def new1_post_gr_def
lemmas dispose1_pre_defs  = dispose1_pre_def disjoint_def nat1_def
                            locs_def nat1_map_def locs_of_def
lemmas dispose1_post_defs = dispose1_post_def 

lemmas dispose1_post2_defs = dispose1_post2_def dispose1_below_def 
							 dispose1_above_def dispose1_ext_def

lemma dispose1_equiv:
	"dispose1_post f d s f' = dispose1_post2 f d s f'"
unfolding dispose1_post_defs dispose1_post2_defs
by auto

(*********************************************************************)
section {* Things about heap L1 proof satisfiability obligations *}

definition 
  PO_new1_fsb :: "bool"
where
  "PO_new1_fsb \<equiv> (\<forall> f s . F1_inv f \<and> nat1 s \<and> new1_pre f s \<longrightarrow> 
                        (\<exists> f' r' . new1_post f s f' r' \<and> F1_inv f'))"

definition
  PO_dispose1_fsb :: "bool"
where
  "PO_dispose1_fsb \<equiv> (\<forall> f d s . F1_inv f \<and> nat1 s \<and> dispose1_pre f d s \<longrightarrow> 
                        (\<exists> f' . dispose1_post f d s f' \<and> F1_inv f'))"

(*********************************************************************)
section {* Voila! Translate to Haskell please! *}

export_code locs_of nat1  in Haskell module_name VDMMaps file "haskell/"

end
