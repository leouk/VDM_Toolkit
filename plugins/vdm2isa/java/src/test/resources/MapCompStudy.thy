theory MapCompStudy
imports VDMToolkit
begin

(* { x+y \<mapsto> 10 | x \<in> {1,2,3}, y \<in> {4,5,6} } *)
lemma "(\<lambda> dummy . if (\<exists> x y . x \<in> {1,2,3::nat} \<and> y \<in> {4,5,6::nat} \<and> dummy = x + y) then Some 10 else None) = 
  [5 \<mapsto> 10, 6 \<mapsto> 10, 7 \<mapsto> 10, 8 \<mapsto> 10, 9 \<mapsto> 10]"
  apply rule
  find_theorems "(if _ then _ else _) = _" -name:SMT
  apply (simp split:if_splits)
  apply rule+
        apply (elim exE conjE)
  apply simp  
        apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
(*
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
*)
  oops

(* { x+y \<mapsto> True | x \<in> {1,2,3}, y \<in> {4,5,6} } ; use true so that we can get past the if without the blowup ? *)
lemma "(\<lambda> dummy . if (\<exists> x y . x \<in> {1,2,3::nat} \<and> y \<in> {4,5,6::nat} \<and> dummy = x + y) then Some True else None) = 
  [5 \<mapsto> True, 6 \<mapsto> True, 7 \<mapsto> True, 8 \<mapsto> True, 9 \<mapsto> True]"
  apply rule
  apply (cut_tac if_bool_eq_conj)  
  apply simp
  oops

lemma "(\<lambda> dummy . if (\<exists> x y . x \<in> {1,2,3::nat} \<and> y \<in> {4,5,6::nat} \<and> dummy = x + y) then Some 10 else None) = 
  [5 \<mapsto> 10, 6 \<mapsto> 10, 7 \<mapsto> 10, 8 \<mapsto> 10, 9 \<mapsto> 10]"
  apply rule 
  find_theorems "(if _ then _ else _) = _" -name:SMT
  apply (simp split:if_splits)
  apply (intro conjI impI, elim exE conjE) oops

lemma "(\<lambda> dummy . if (\<exists> x y . x \<in> {1,2::nat} \<and> y \<in> {4,5::nat} \<and> dummy = x + y) then Some 10 else None) = 
  [5 \<mapsto> 10, 6 \<mapsto> 10, 7 \<mapsto> 10]"
  apply rule 
  find_theorems "(if _ then _ else _) = _" -name:SMT
  apply (simp split:if_splits)
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
     apply rule+
     apply (metis One_nat_def Suc_numeral plus_1_eq_Suc semiring_norm(5) semiring_norm(8))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
      apply blast
      apply (metis add_2_eq_Suc eval_nat_numeral(2) eval_nat_numeral(3) semiring_norm(28))
  apply rule+
      apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
    apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
    apply rule+
     apply (metis One_nat_def eval_nat_numeral(2) plus_1_eq_Suc semiring_norm(28))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
   apply rule+
      apply (metis add_2_eq_Suc eval_nat_numeral(2) eval_nat_numeral(3) semiring_norm(28))
  apply rule+
      apply (metis add_2_eq_Suc eval_nat_numeral(2) eval_nat_numeral(3) semiring_norm(28))
    apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
      apply (metis add_2_eq_Suc eval_nat_numeral(2) eval_nat_numeral(3) semiring_norm(28))
  done

type_synonym  Map = "nat \<rightharpoonup> nat"

value "[1::nat \<mapsto> 2::nat, 1 \<mapsto> 3] 1"

(* { d |-> r | d in set {1,2::nat}, r in set {2,4::nat} & r = d*2 } *)
lemma "(\<lambda> dummy::nat . if (\<exists> d r . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2::nat} \<and> r \<in> {2,4::nat} \<and> dummy = d \<and> r = d*2) then 
              Some 10 
          else undefined) = 
  [1 \<mapsto> 10, 2 \<mapsto> 10, 3 \<mapsto> 10]"
    apply rule 
  apply (simp split:if_splits)
  find_theorems "undefined"

  oops

(* { d |-> 10 | d in set {1,2::nat}, r in set {2,4::nat} & r = d*2 } *)
lemma "(\<lambda> dummy::nat . if (\<exists> d r . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2::nat} \<and> r \<in> {2,4::nat} \<and> dummy = d \<and> r = d*2) then 
              Some 10 
          else None) = 
  [1 \<mapsto> 10, 2 \<mapsto> 10]"
  unfolding inv_VDMNat_def
    apply rule 
  by (simp split:if_splits)
  
(* { d |-> r | d in set {1,2::nat}, r in set {2,4::nat} & r = d*2 } *)
lemma "(\<lambda> dummy::nat . if (\<exists> d r . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2::VDMNat} \<and> r \<in> {2,4::VDMNat} \<and> dummy = d \<and> r = d*2) then 
              Some (THE r . (\<exists> d . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2::VDMNat} \<and> r \<in> {2,4::VDMNat} \<and> dummy = d \<and> r = d*2)) 
          else None) = 
  [1 \<mapsto> 2, 2 \<mapsto> 3, 3 \<mapsto> 6]" (* DUH! mistaken input set! *)
  unfolding inv_VDMNat_def
    apply rule 
  apply (simp split:if_splits)
  apply (rule+, simp_all)
  apply rule+ (* THE is not quite right; SOME?! NOOOO 2\<mapsto> 4 dummy! *)
  oops

(* { d |-> r | d in set {1,2,3::nat}, r in set {2,4,6::nat} & r = d*2 } *)
lemma "(\<lambda> dummy::nat . if (\<exists> d r . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2,3::VDMNat} \<and> r \<in> {2,4,6::VDMNat} \<and> dummy = d \<and> r = d*2) then 
              Some (THE r . (\<exists> v . dummy = v \<and> r = v*2)) 
          else None) = 
  [1 \<mapsto> 2, 2 \<mapsto> 4, 3 \<mapsto> 6]"
  unfolding inv_VDMNat_def
    apply rule 
  by (simp split:if_splits) 

(* { d |-> r | d in set {1,2,3::nat}, r in set {2,4,6::nat} & r = d*2 } *)
lemma mapComp1: "(\<lambda> dummy::VDMNat . if (\<exists> d \<in> {1,2,3::VDMNat} . \<exists> r \<in> {2,4,6::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r = d*2) then 
              Some (THE r . (\<exists> d \<in> {1,2,3::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r \<in> {2,4,6::VDMNat} \<and> r = d*2)) 
          else None) = 
  [1 \<mapsto> 2, 2 \<mapsto> 4, 3 \<mapsto> 6]"
  unfolding inv_VDMNat_def
  apply rule
  apply (simp split:if_splits) 
  apply (rule+, simp_all) 
  apply (rule+, simp_all)
  by auto 
  
definition 
  mapComp1 :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "mapComp1 \<equiv> (\<lambda> dummy::VDMNat . if (\<exists> d \<in> {1,2,3::VDMNat} . \<exists> r \<in> {2,4,6::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r = d*2) then
              Some (THE r . (\<exists> d \<in> {1,2::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> r \<in> {2,4,6::VDMNat} \<and> dummy = d \<and> r = d*2)) 
          else None)"

lemma "x \<notin> {1,2,3::VDMNat} \<Longrightarrow>  mapComp1 x = None"
  by (simp add: mapComp1_def inv_VDMNat_def)

lemma "\<not> inv_VDMNat x  \<Longrightarrow> mapComp1  x = None"
  by (simp add: mapComp1_def inv_VDMNat_def)

lemma "x \<in> {1,2,3::VDMNat} \<Longrightarrow> v \<in> {2,4,6::VDMNat} \<Longrightarrow> mapComp1 x = Some v"
  apply (simp add: mapComp1_def inv_VDMNat_def)
  apply (safe, simp_all)
  find_theorems "(THE _ . _) = _"
          apply (rule the1_equality, simp_all)
  find_theorems "(\<exists>! _ . _)" intro 
  apply (rule_tac a=2 in ex1I, safe, simp)
          apply (rule the1_equality, simp_all)
  apply (rule_tac a=2 in ex1I, safe, simp) defer
          apply (rule the1_equality, simp_all)
          apply (rule_tac a=2 in ex1I, safe, simp) defer
          apply (rule the1_equality, simp_all)
          apply (rule_tac a=4 in ex1I, safe, simp) defer
         apply (rule the1_equality) defer defer
          apply (rule the1_equality, simp_all)
  apply (rule_tac a=4 in ex1I, safe, simp)
          apply (rule the1_equality, simp_all)
  apply (rule_tac a=4 in ex1I, safe, simp) defer
          apply (rule the1_equality) defer defer
          apply (rule the1_equality) 
   (* Ah! has to be THE on both domain and range? No: the mapping isn't direct of course! *)
  oops

definition 
  mapComp2 :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "mapComp2 \<equiv> (\<lambda> dummy::VDMNat . if (\<exists> d \<in> {1,2,3::VDMNat} . \<exists> r \<in> {2,4,6::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r = d*2) then
              Some (THE r . (\<exists> d \<in> {1,2, 3::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> r \<in> {2,4,6::VDMNat} \<and> dummy = d \<and> r = d*2)) 
          else None)"

lemma "x \<notin> dom mapComp2  \<Longrightarrow>  mapComp2 x = None"
  by (simp add: domIff mapComp2_def)

lemma "dom mapComp2 = {1,2,3::VDMNat}"
  unfolding dom_def mapComp2_def inv_VDMNat_def
  by (simp split:if_splits, safe)

lemma "rng mapComp2 = {2,4,6::VDMNat}"
  unfolding ran_def rng_def mapComp2_def inv_VDMNat_def
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all)
   apply (elim exE conjE impE)
  (* this will be fiddly! *)
  oops

lemma "rng mapComp2 = {2,4,6::VDMNat}"
  unfolding ran_def rng_def mapComp2_def inv_VDMNat_def
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all)
   apply (elim exE conjE disjE, simp_all)
     apply fastforce
  apply fastforce
   apply fastforce
  by (smt (z3) semiring_norm(83) the_equality verit_eq_simplify(14) zero_le_numeral)

definition
  mapComp :: "'a set \<Rightarrow> 'b set \<Rightarrow> ('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'a) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b)"
  where
  "mapComp S T inv_S inv_T domexpr rngexpr\<equiv> 
        (\<lambda> dummy::'a . 
            if (\<exists> d \<in> S . \<exists> r \<in> T . inv_S d \<and> inv_T r \<and> dummy = (domexpr d) \<and> r = (rngexpr d r)) then
                Some (THE r . (\<exists> d \<in> S . inv_S d \<and> r \<in> T \<and> inv_T r \<and> dummy = (domexpr d) \<and> r = (rngexpr d r))) 
            else 
                None
        )"

text \<open>Isabelle maps are similar to VDMs, but with some significant differences worth observing. 
 
      If the filtering is not unique (i.e. result is not a function), then the @{term "THE x . P x"} expression
      might lead to (undefined) unexpected results. In Isabelle maps, repetitions is equivalent to overriding,
      so that @{lemma "[1::nat \<mapsto> 2, 1 \<mapsto> 3] 1 = Some 3" by simp}. 

      In various VDMToolkit definitions, we default to @{term undefined} in case where the situation is out of hand,
      hence, proofs will fail, and users will know that @{term undefined} being reached means some earlier problem has
      occurred.  
    \<close>

text \<open>Type bound map comprehension cannot filter for type invariants, hence won't have @{term undefined} results.
      This corresponds to the VDMSL expression
      %
      \begin{vdmssl}
        { domexpr(d) |-> rngexpr(d, r) | d:S, r: T & P(d, r) }
      \end{vdmsl}
      % 
      where the maplet expression can be just variables or functions over the domain/range input(s). 

      VDM also issues a proof obligation for type bound maps (i.e. avoid it please!) to ensure the resulting map is finite.
      Concretely, the example below generates the corresponding proof obligation:
      %
      \begin{vdmsl}
      	ex: () -> map nat to nat
	      ex() == { x+y |-> 10 | x: nat, y in set {4,5,6} & x < 10 };

        exists finmap1: map nat to (map (nat1) to (nat1)) & 
            forall x:nat, y in set {4, 5, 6} & (x < 10) => 
              exists findex2 in set dom finmap1 & 
                finmap1(findex2) = {(x + y) |-> 10}
      \end{vdmsl}
     \<close>
definition 
  mapCompTypeBound :: "('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'a) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'b) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b)"
  where
  "mapCompTypeBound inv_S inv_T domexpr rngexpr pred \<equiv> 
        (\<lambda> dummy::'a . 
            if (\<exists> d r . inv_S d \<and> inv_T r \<and> dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r) then
                Some (THE r . inv_T r \<and> (\<exists> d . dummy = domexpr d r \<and> r = rngexpr d r)) 
              else 
                None
        )"

text \<open>Set bound map comprehension can filter bound set for their elements invariants.
      This corresponds to the VDMSL expression
      %
      \begin{vdmssl}
        { domexpr(d) |-> rngexpr(d, r) | d in set S, r in set T & P(d, r) }
      \end{vdmsl}
      % 
      If the filtering is not unique (i.e. result is not a function), then the @{term "THE x . P x"} expression
      might lead to (undefined) unexpected results. In Isabelle maps, repetitions is equivalent to overriding,
      so that @{lemma "[1::nat \<mapsto> 2, 1 \<mapsto> 3] 1 = Some 3" by simp}. 
     \<close>
definition 
  mapCompSetBind :: "'a set \<Rightarrow> 'b set \<Rightarrow> ('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'a) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'b) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b)"
  where
  "mapCompSetBind S T inv_S inv_T domexpr rngexpr pred \<equiv> 
        (\<lambda> dummy::'a . 
            if inv_VDMSet' inv_S S \<and> inv_VDMSet' inv_T T then
              if (\<exists> d \<in> S . \<exists> r \<in> T . dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r) then
                Some (THE r . r \<in> T \<and> (\<exists> d \<in> S . dummy = domexpr d r \<and> r = rngexpr d r)) 
              else 
                None
            else
              undefined
        )"

lemmas mapCompSetBind_defs = mapCompSetBind_def inv_VDMSet'_def inv_VDMSet_def 
lemmas rng_defs = rng_def ran_def

text \<open>Identity functions to be used for the dom/rng expression functions for the case they are variables.\<close>
definition 
  domid :: "'a \<Rightarrow> 'b \<Rightarrow> 'a"
  where
  "domid \<equiv> (\<lambda> d . (\<lambda> r . d))"

definition
  rngid :: "'a \<Rightarrow> 'b \<Rightarrow> 'b"
  where
  "rngid \<equiv> (\<lambda> d . id)"

lemma domidI[simp]: "domid d r = d"
  by (simp add: domid_def)

lemma rngidI[simp]: "rngid d r = r"
  by (simp add: rngid_def)

text \<open>Constant function to be used for the rng expression function for the case they are constants.\<close>
definition
  rngcnst :: "'b \<Rightarrow> 'a \<Rightarrow> 'b \<Rightarrow> 'b"
  where
  "rngcnst v \<equiv> (\<lambda> d . (\<lambda> r . v))"

lemma rngcnstI[simp]: "rngcnst v d r = v"
  by (simp add: rngcnst_def)

(*On the explicit (narrower/declared) type, add inv_VDMNat1 
  v98: map nat to nat1 = { d \<mapsto> r | d in set {1,2,3}, r in set {2,4,6} & r = d*2 } *)
definition
  ex1 :: "VDMNat \<rightharpoonup> VDMNat1"
  where
  "ex1 \<equiv> mapCompSetBind {1,2,3::VDMNat} {2,4,6::VDMNat} inv_VDMNat inv_VDMNat1 domid rngid (\<lambda> d r . r = d*2)"

lemmas ex1_defs = ex1_def mapCompSetBind_defs inv_VDMNat1_def inv_VDMNat_def 

(*On the implicit (wider/presumed) type, add inv_VDMNat 
  v98 = { x+y |-> 10 | x in set {1,2,3}, y in set {4,5,6} } *)
definition
  ex2 :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "ex2 \<equiv> mapCompSetBind {1,2,3::VDMNat} {2,4,6::VDMNat} inv_VDMNat inv_VDMNat (\<lambda> d . (\<lambda> r . d+r)) (rngcnst 10) (\<lambda> d r . r = d*2)"

lemmas ex2_defs = ex2_def mapCompSetBind_defs inv_VDMNat1_def inv_VDMNat_def 

lemma ex1_none: "x \<notin> dom ex1  \<Longrightarrow> ex1 x = None"
  by (simp add: domIff)

lemma ex1_dom: "dom ex1 = {1,2,3}"
  unfolding dom_def ex1_defs
  by (simp split:if_splits, safe)

lemma "mapComp2 = ex1"
  unfolding ex1_defs mapComp2_def 
  apply simp

lemma ex1_rng:"rng ex1 = {2,4,6}"
  unfolding rng_defs ex1_defs
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all)
  (* apply (elim exE conjE impE)*)
  (* this will be fiddly! *)
  apply (elim exE conjE disjE, simp_all)
     apply fastforce
  apply fastforce
   apply fastforce
  by (smt (z3) semiring_norm(83) the_equality verit_eq_simplify(14) zero_le_numeral)

end