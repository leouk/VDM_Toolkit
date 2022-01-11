(* $Id$ *)
(*<*)
theory HEAP1Sanity
imports HEAP1
begin
(*>*)
(* ================================================================= *)
section {* Proof of some properties of interest *}
(* ================================================================= *)

text {* In this section we prove some properties about the state invariant
        and operations that should hold. These kind of properties are problem
        specific and are useful to test the usefulness of the model (i.e. it's pragmatics).
        They are quite important, since we could prove something useless that
        is feasible and sound\footnote{This has actually happened in a first version
        of the (wrong) model. That is we build the model right, but we didn't build the right model!}!
      *}

(*------------------------------------------------------------------------*)
subsection {* Invariant testing *}
(*------------------------------------------------------------------------*)

text {* First, we test the Isabelle maps are good enough for our need to represent
        VDM maps in Isabelle. It would be useful to use the Isabelle value feature
        wrapping values with predicates like the invariant or the post condition.
        
        Unfortunately, they are not enumerable (? TODO: Or just code not proved yet?).
        Instead, we prove that the invariant holds (and fails to hold) for certain
        values. This performs both positive and negative testing on the invariant.
        Proofs are automatic by auto.
      *}


value "[0 \<mapsto> 4, 6 \<mapsto> 11]"

definition 
  F1_ex :: "F1"
where
  "F1_ex \<equiv> [0 \<mapsto> 4, 6 \<mapsto> 11]"

definition
  F1_ex_inv :: "F1 \<Rightarrow> bool"
where
  "F1_ex_inv f \<equiv> F1_inv f"

lemmas F1_ex_inv_defs = F1_ex_inv_def F1_inv_defs F1_ex_def

(*------------------------------------------------------------------------*)
subsection {* Operations properties *}
(*------------------------------------------------------------------------*)

text {* Next, we prove some useful properties that operators at level 1 must
        satisfy. Incidentally, the proof of these properties helped hightlight 
        various (general) lemmas about VDM maps missing in Isabelle. 
      *}

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* NEW 1 shrinks the memory  *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text {* Upon memory allocation the resulting available memory \textbf{must} shrink.
        At first we tried something hard that often happens during proof:~to prove a non-theorem (!)
        That is, to show that @{text "f1' \<subseteq>\<^sub>m f1"}, which is of course false for the greater case.
        Nonetheless, this was useful to identify key missing lemmas for VDM maps, which
        were added to our library in theory VDMMaps. 

        In normal practice, it's important to use nitpick and quickcheck to try and invalidate
        our theorem by finding counter examples:~these tools are much better at spotting non-theorems
        (with complicated assumptions) than normal users.
        
        Our current version states that the resulting map must be different from the original
        (i.e. the allocation operation does something), and that its result leads to a subset
        of available locations (@{text "locs f1' \<subset> locs f1"}). Incidentally, @{term "locs f1"} 
        is the retrieve 
        function between level 0 and 1. 

        Proving proper subset is divided in two cases as subset and not equal. In these proofs,
        we decided to follow some advice given by Alan Bundy:~``it is often useful [for learning/generalising]
        to have more than one proof for the same goal''. We decided to take his suggestion and produce 
        such variety, and in a truly novel form rather than just an artificial ``reproving''. Leo
        proved these goals as:~i)~``head-on'', i.e.~expanding and simplifying as we went;~ii)~``planned'', i.e~having
        an idea of what we wanted to achieve at each step and convincing Isabelle (often with extra lemmas)
        along the way;~iii)~``algebraically'', i.e.~having lemmas that chisel away operators to achieve
        what Alan calls ``get rid of difficult operators''\footnote{This is a reference to trick by
        mathematicians trying to avoid complex operators. For instance, instead of proving the square 
        root (e.g @{text "\<surd>2 = x"}) of something they get rid of the square root by squaring both sides (e.g. @{text "2=x\<^sup>2"}).}.

        Moreover, independently, Iain is doing proofs by trying to ``explain'' the proof 
        through Isar's declarative features to unpick the problem in yet another format. We also set 
        it as a task for an MSc student that was not exposed to proof before (i.e.~what we could expect 
        of a well educated and motivated engineer):~she (Nataliia) is doing them on her own after discussion and 
        advice from Leo. The result~\cite{NataliiaMSc2013} is a pedagogical explanation of the proof process in
        line with Naur's~\cite{NaurNineQueens} from the perspective of a non-expert, well trained engineer. 
        This last interaction could be taken us an expert training an engineer to 
        handle/tackle proof and collecting the effort. Both Nataliia and Leo are running the proofs
        through Andrius' Isabelle/Eclipse-PP\footnote{Our Eclipse-based proof process (PP) collection
        environment that wraps around Isabelle's kernel for ``tapping the wire'' for information. It
        can be downloaded at \url{https://github.com/andriusvelykis/proofprocess}.}~\cite{Velykis12,AndriusPhD}, 
        which captures the proof process by having a history log
        and encoding of attempts and features according to our MWhy models~\cite{ai4fm-shanghai}. % ,Dagstuhl??}. 

        Next, our aim is to study this data and try to infer general patterns from both PP data for comparison
        and fine tuning for learning techniques to take over~\cite{Grov-12-slides,GGrov-SL,KatyaMLPG} %~\cite{Grov-BN1752} 
      *}

context level1_new
begin

definition
  PO_new1_postcondition_state_changes :: "nat \<Rightarrow> bool"
where
  "PO_new1_postcondition_state_changes r \<equiv> (\<forall> f1' . new1_postcondition f1' r \<longrightarrow> f1' \<noteq> f1)"

definition
  PO_new1_postcondition_state_locs_subset :: "nat \<Rightarrow> bool"
where
  "PO_new1_postcondition_state_locs_subset r \<equiv> (\<forall> f1' . new1_postcondition f1' r \<longrightarrow> locs f1' \<subseteq> locs f1)"

definition
  PO_new1_postcondition_diff_f_locs :: "nat \<Rightarrow> bool"
where
  "PO_new1_postcondition_diff_f_locs r \<equiv> (\<forall> f1' . new1_postcondition f1' r \<longrightarrow> locs f1' \<noteq> locs f1)"

definition
  PO_new1_postcondition_shrinks_f_locs :: "nat \<Rightarrow> bool"
where
  "PO_new1_postcondition_shrinks_f_locs r \<equiv> (\<forall> f1' . new1_postcondition f1' r \<longrightarrow> locs f1' \<subset> locs f1)"

definition
  PO_new1_postcondition_f_equiv :: "nat \<Rightarrow> bool"
where
  "PO_new1_postcondition_f_equiv r \<equiv> (\<forall> f1' . new1_postcondition f1' r \<and> the(f1 r) = s1 \<longrightarrow> {r} -\<triangleleft> f1' = {r} -\<triangleleft> f1)"

end 

(*------------------------------------------------------------------------*)
(* NEW1(n); DISPOSE(r, n) = Id *)

definition
  PO_new1_dispose1_identity_post :: "F1 \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> bool"
where
  "PO_new1_dispose1_identity_post f n r \<equiv> (\<forall> f' f'' . new1_post f n f' r \<and> dispose1_post f' r n f'' \<and> F1_inv f \<and> nat1 n \<longrightarrow> f = f'')"


definition
  PO_new1_dispose1_identity_pre :: "F1 \<Rightarrow> nat \<Rightarrow> nat \<Rightarrow> bool"
where
  "PO_new1_dispose1_identity_pre f n r \<equiv> (\<forall> f' . new1_pre f r \<and> new1_post f n f' r \<and> F1_inv f \<and> nat1 n \<longrightarrow> dispose1_pre f r n)"

(*<*)
end
(*>*)
