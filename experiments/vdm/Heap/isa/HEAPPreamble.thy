(* $Id: HEAP0.thy 1743 2013-08-16 15:01:23Z nljsf $ *)
(*<*)
theory HEAPPreamble
imports VDMToolkit
begin

(*>*)

section \<open> The heap in Isabelle \<close>

subsection \<open> Introduction \<close>
text \<open>
This section introduces the formal encoding of the heap storage case study
in the Isabelle proof assistant. We do not introduce Isabelle in detail, but
rather refer the reader to the Isabelle documentation \cite{NipkowPW02,paulson1994isabelle}.

In the next section, we explain the naming conventions for our development and the overall 
architecture of the formalisation. Then, Section~\ref{s:isa:models:level0} describes the formalisation
of level 0. 
\<close>

subsection \<open> Background \<close>

text
\<open> 
We use locales to describe the VDM models of a Heap.  
This increases the modularity and clarity of the POs
we are using Isabelle to prove, given of course the 
locale universally quantifying assumptions and preconditions.

For example, we can state:

\<close>
(*<*)
(* Dummy locale to make the below read fine *)
locale LOCALE = fixes x::nat
type_synonym STATE_N = nat
type_synonym IN1 = nat
type_synonym INn = nat
type_synonym Out = nat

(* Ugly def for the state of a precondition definition *)
definition 
  pre_without_state_invariant_or_input_subtype :: "STATE_N \<Rightarrow> IN1 \<Rightarrow> INn \<Rightarrow> bool"
where
  "pre_without_state_invariant_or_input_subtype a b x = True"

definition 
  post_without_state_invariant_or_IO_subtype :: "STATE_N \<Rightarrow> IN1 \<Rightarrow> INn \<Rightarrow> STATE_N \<Rightarrow> Out \<Rightarrow> bool"
where
  "post_without_state_invariant_or_IO_subtype a b x y s = True"

 definition 
    invariant :: "STATE_N \<Rightarrow> bool"
  where
    "invariant s \<equiv> True"
(*>*)

lemma (in LOCALE) Op1_FSB:   
 "\<exists> after_state result . invariant after_state \<and> post after_state result"
(*<*) sorry (*>*)

text \<open>
We also use definition to capture VDM features. This
is useful for the folding/unfolding of zooming pattern. For
example, a property for an operation is stated as a
definition: 
\<close>

definition 
     OP_N_X :: "STATE_N \<Rightarrow> IN1 \<Rightarrow> INn \<Rightarrow> bool"
  where
    "OP_N_X S i_1 i_n \<equiv> pre_without_state_invariant_or_input_subtype S i_1 i_n"

text \<open> \noindent and things like the invariant are also
packaged up as definitions. \<close>

subsubsection\<open> Naming conventions \<close>

text_raw\<open>
We use the following conventions:
\begin{itemize}
\item auxilliary functions are capitilised and have
a ``\_'' between each part of the name

\item In the construction of the VDM operations
macros, we introduce definitions of the following form,
for each part of an operation and state. We use short names
(pre, post, inv) for the various parts.\\
\<close>
 
 definition 
    STATE_N_inv :: "STATE_N \<Rightarrow> bool"
  where
    "STATE_N_inv S_n \<equiv> invariant S_n"

definition 
     OP_N_pre :: "STATE_N \<Rightarrow> IN1 \<Rightarrow> INn \<Rightarrow> bool"
  where
    "OP_N_pre S i_1 i_n \<equiv> pre_without_state_invariant_or_input_subtype S i_1 i_n"

  definition 
     OP_N_post :: "STATE_N \<Rightarrow> IN1 \<Rightarrow> INn \<Rightarrow> STATE_N \<Rightarrow> Out \<Rightarrow> bool"
  where
    "OP_N_post S i_1 i_n S' out \<equiv> post_without_state_invariant_or_IO_subtype  S i_1 i_n S' out"
 

text_raw\<open>

\item We also introduce an Isabelle shortcut to unfold all the names
that occur in a definition, as follows:\\
\<close>
(*<*)
lemma OP_N_pre_OP1_def: "True" sorry
lemma OP_N_pre_OP2_def: "True" sorry
(*>*)
lemmas OP_N_pre_defs = OP_N_pre_def OP_N_pre_OP1_def OP_N_pre_OP2_def text_raw\<open> etc. \<close>

text_raw\<open>

\item Finally, the specification of the VDM oerations themselves
is given in a locale, where the inputs, invariant and preconditions
are provided, and given long names. We use a locale \emph{levelN\_basic}
to encode the common state and any common inputs and the invariant.

This is a useful construct as we also have common preconditions
that arise in the translation of VDM types to Isabelle (and we need
some predicates to enforce subtyping). This is
discussed in more detail later.\\


\<close>

 locale level_N_basic =
     fixes f :: STATE_N   \<comment> \<open>common state\<close>
     and   s1 :: IN1     \<comment> \<open>common inputs\<close>
     and   sn :: INn
    assumes l_N_input1_PROP: "pred-input1-subtype"
     and     l_N_inputn_PROP: "pred-inputn-subtype"
     and    l_N_invariant     : "STATE_inv f"
  
  locale level_N_OP = level_N_basic +
      fixes  i :: IN1          \<comment> \<open>specific inputs\<close>
      assumes OP_precondition : "OP_pre f s i \<and> STATE_inv f"

text_raw\<open>

The post-condition is then expressed as a definition within the locale:\\

\<close>


definition (in level_N_OP)
   OP_N_postcondition :: "STATE_N \<Rightarrow> Out \<Rightarrow> bool"
where
  "OP_N_postcondition f' r \<equiv> OP_N_post f s1 sn f' r \<and> STATE_N_inv f'"

text_raw\<open> 
\item Next, the proof obligations are specified using the following
form and  nomenclature: \\
\<close>

definition (in level_N_OP)
    OP_N_feasibility :: "bool"
  where
    "OP_N_feasibility \<equiv> (\<exists> f' r' . OP_N_postcondition f' r')"

text_raw\<open> which is then stated as a lemma: \\\<close>

lemma (in level_N_OP) OP_N_Feasibility: "OP_N_feasibility"
(*<*) sorry (*>*)

text_raw\<open>
\end{itemize}
\<close>

(*<*)
end (*>*)
