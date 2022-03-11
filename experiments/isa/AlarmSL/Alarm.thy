theory Alarm
imports "../../lib/VDMToolkit"
begin

(*****************************************)

type_synonym Period   = VDMToken

(* If you don't add these, you will need to know it's inv_True where needed.
   Arguably you have to have a initialisation proof for every invariant as 
   they will participate (i.e. any lemmas they require) in latter feasibility
   proofs. Of course the inv_True cases can be ignored 
 *) 
definition
  inv_Period :: "Period \<Rightarrow> \<bool>"
  where
  "inv_Period \<equiv> inv_True"
  
type_synonym ExpertId = VDMToken
  
definition
 inv_ExpertId :: "ExpertId \<Rightarrow> \<bool>"
 where
 "inv_ExpertId \<equiv> inv_True"

datatype Qualification = Elec | Mech | Bio | Chem

definition
  inv_Qualification :: "Qualification \<Rightarrow> \<bool>"
  where
  "inv_Qualification \<equiv> inv_True"
  
record Alarm =
  alarm_alarmtext :: "char VDMSeq"  
  alarm_quali     :: Qualification

(* Always have True invariant for all types, even when not defined so that 
   they are available for later translations, as well as readability and partial proofs

   Arguably, it should also be from Alarm_scheme (e.g. compose ... end in VDM), given that
   in VDM the syntax of the defined type for records can't talk about the record itself. 
 *)
definition
  inv_Alarm :: "Alarm \<Rightarrow> \<bool>"
  where
  "inv_Alarm \<equiv> inv_True"
  
record Expert =
  expert_expertid  :: ExpertId
  expert_quali     :: "Qualification VDMSet"
  
definition
  inv_Expert :: "Expert \<Rightarrow> \<bool>"
  where
  "inv_Expert e \<equiv>
      let eq = (expert_quali e) in 
        inv_SetElems inv_True eq \<and>
        eq \<noteq> {}"

lemmas inv_Expert_defs = inv_SetElems_def inv_Expert_def

(* You could add the theorem directly without the need of a definition; I like to
   separate them again to enable code generation in separate parts.
 *)
definition
  PO_Expert_init :: \<bool>
  where  
  "PO_Expert_init \<equiv> \<exists> e . inv_Expert e"

theorem PO_Expert_init: PO_Expert_init
  unfolding PO_Expert_init_def inv_Expert_def Let_def
  apply (rule exI[of _ "\<lparr> expert_expertid = ''X'', expert_quali = {Bio}\<rparr>"])
  by simp

(* Useful in inv_Plant witness *)    
lemma l_inv_Expert_w[simp]: "expert_quali e \<noteq> {} \<Longrightarrow> inv_Expert e"
  by (simp add: inv_Expert_def)  
    
type_synonym Schedule = "Period \<rightharpoonup> Expert set" 
  
(* This is fine but will entail more complicated proofs unnecessarily *)
definition
  inv_Schedule :: "Schedule \<Rightarrow> \<bool>"
  where
  "inv_Schedule s \<equiv> 
      inv_Map inv_Period (inv_SetElems inv_Expert) s 
 \<and>
      (\<forall> exs1 \<in> rng s . 
          exs1 \<noteq> {} \<and>
          (\<forall> ex1 \<in> exs1 . \<forall> ex2 \<in> exs1 . 
              ex1 \<noteq> ex2 \<longrightarrow> (expert_quali ex1) \<noteq> (expert_quali ex2)))"
  
definition
  inv_Schedule2 :: "Schedule \<Rightarrow> \<bool>"
  where
  "inv_Schedule2 s \<equiv> 
      inv_Map inv_Period (inv_SetElems inv_Expert) s 
 \<and>
      (\<forall> exs1 \<in> rng s . 
          exs1 \<noteq> {} \<and>
          (\<forall> ex1 \<in> exs1 . \<forall> ex2 \<in> (exs1 - {ex1}) . 
              (expert_quali ex1) = (expert_quali ex2)))"
  
definition
  PO_Schedule_init :: \<bool>
  where  
  "PO_Schedule_init \<equiv> \<exists> s . inv_Schedule s"

(* These existential proofs are harder becuase of the required witness in the \<exists>;
   one strategy is to let schematic variables and crunch goal close to clarer subgoals
   and that will also allow safe/simp etc to work, but won't finish the proof
 *)  
theorem PO_Schedule_init: PO_Schedule_init
  unfolding PO_Schedule_init_def inv_Schedule_def
  (* Because you have the VDM AST you know what introduction rules will be needed 
     based on the structure of the tree
   *)
  (*apply (intro exI conjI ballI impI) *)
  apply (intro exI, safe)
  (* First goal is a nice suggestion for a weakening lemma *)
  (* Second goal is telling me the original model is redudant *)
  (* Third goal is dependant on the witness provided for ?s *)
  oops

(* Weakening lemmas trade given goals to simpler/easier (often multiple) subgoals,
   with True as the ultimate aim as the "sub goal" needed, as the example below (which isn't true)
 *)
lemma l_inv_Schedule_inv_Map_w: 
    "\<lbrakk> inv_VDMSet (dom s) ; inv_VDMSet (ran s) ; 
       inv_SetElems (inv_SetElems inv_Expert) (ran s) \<rbrakk>
     \<Longrightarrow>
      inv_Map inv_Period (inv_SetElems inv_Expert) s"
  unfolding inv_Map_def inv_Period_def by simp

theorem PO_Schedule_init: PO_Schedule_init
  unfolding PO_Schedule_init_def inv_Schedule_def
  (* Like with Event-B, you can imainge at modelling time, asking the user to provide
     a satisfying witness for the model. See AlarmSL.vdmsl
  apply (intro exI[of _ "\<lparr>expert_period = ''e1'', expert_quali = {Bio}\<rparr>"])
   *)
  apply (intro exI, safe)
  apply (rule l_inv_Schedule_inv_Map_w)
  oops  

  value "[ [''p1'', ''p2''] [\<mapsto>] 
           [{ \<lparr>expert_expertid = ''e1'', expert_quali = {Bio}\<rparr> },
            { \<lparr>expert_expertid = ''e2'', expert_quali = {Elec}\<rparr> }
           ] ]"    

theorem PO_Schedule_init: PO_Schedule_init
  unfolding PO_Schedule_init_def inv_Schedule_def
  apply (rule exI[of _ 
                    "[ [''p1'', ''p2''] 
                       [\<mapsto>] 
                       [{ \<lparr>expert_expertid = ''e1'', expert_quali = {Bio}\<rparr> },
                        { \<lparr>expert_expertid = ''e2'', expert_quali = {Elec}\<rparr> }
                       ]  
                     ]"
                 ], safe)
    apply (rule l_inv_Schedule_inv_Map_w)
      apply (simp add: inv_VDMSet_def)  
     apply (simp add: inv_VDMSet_def)
    apply (simp add: inv_SetElems_def inv_Expert_def)
    (* Here you see why map enumerations / comprehensions are tricky: Isabelle likes them
       list-based, and doesn't have enough automation.  
     *)
    unfolding rng_def ran_def
     apply (safe, simp split:if_splits)
    apply (simp split:if_splits)
    apply auto
    oops (* proof is finished, but forget it to try again nicer *)
      
(* As a general principle, let's define / translate the witnesses defined with @witness! *)
      
definition
  witness_Schedule :: Schedule
  where
  "witness_Schedule \<equiv> [ [''p1'', ''p2''] [\<mapsto>] 
           [{ \<lparr>expert_expertid = ''e1'', expert_quali = {Bio, Elec}\<rparr> },
            { \<lparr>expert_expertid = ''e2'', expert_quali = {Elec, Bio}\<rparr> }
           ] ]"

lemmas witness_Schedule_defs = witness_Schedule_def inv_Schedule_def
  
lemma l_witness_Schedule: "inv_Schedule witness_Schedule" 
  unfolding witness_Schedule_defs 
  apply safe
  (* the simplifier will work if you chain all the necessary facts at once *)
  apply (simp add: l_inv_Schedule_inv_Map_w inv_VDMSet_def inv_Expert_defs)
  unfolding rng_defs 
  by (auto split:if_splits)

(* Ain't that a much neater proof?! This shows how the use of designed witnesses work well 
   and can be chained too, as defined in the example for the witness for Plant
 *)    
theorem PO_Schedule_init: PO_Schedule_init
  unfolding PO_Schedule_init_def using l_witness_Schedule by blast  
    
record Plant =
  plant_schedule :: Schedule
  plant_alarms   :: "Alarm VDMSet"
  
definition 
  pre_QualificationOK :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> \<bool>"
  where
  "pre_QualificationOK exs reqquali \<equiv> 
      inv_VDMSet exs \<and>
      inv_SetElems inv_Expert exs \<and>
      inv_Qualification reqquali"  

definition 
  post_QualificationOK :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> \<bool> \<Rightarrow> \<bool>"
  where
  "post_QualificationOK exs q RESULT \<equiv> 
    pre_QualificationOK exs q \<and>
    inv_True RESULT"
  
definition 
  QualificationOK :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> \<bool>"
  where
  "QualificationOK exs reqquali \<equiv> 
      \<exists> ex \<in> exs . reqquali \<in> (expert_quali ex)"  

definition
  PO_QualificationOK_feas0 :: \<bool>
  where
  "PO_QualificationOK_feas0 \<equiv> \<forall> exs q . pre_QualificationOK exs q \<longrightarrow> (\<exists> r . r = QualificationOK exs q \<and> post_QualificationOK exs q r)"
 
theorem PO_QualificationOK_feas0: PO_QualificationOK_feas0
  unfolding PO_QualificationOK_feas0_def post_QualificationOK_def
  by (safe, simp)

(* This is better for later proofs; arguably doesn't matter*)    
theorem PO_QualificationOK_feas: 
  "pre_QualificationOK exs q \<Longrightarrow> post_QualificationOK exs q (QualificationOK exs q)"
  by (simp add: post_QualificationOK_def)

(* Here because QualificationOK is a boolean valued function, and we are defining 
   another boolean valued function with the invariant, then they appear together

   Initialisation proof below shows why it's wrong; go look.
 *)  
definition
  inv_Plant_wrong :: "Plant \<Rightarrow> \<bool>"
  where
  "inv_Plant_wrong p \<equiv> 
      let sch = (plant_schedule p);
          alm = (plant_alarms p)
      in
         \<forall> a \<in> alm . \<forall> peri \<in> dom sch . 
            pre_QualificationOK (the (sch peri)) (alarm_quali a) \<and> 
            QualificationOK (the (sch peri)) (alarm_quali a)"

definition
  PO_Plant_wrong_init :: \<bool>
  where  
  "PO_Plant_wrong_init \<equiv> \<exists> s . inv_Plant_wrong s"

lemma PO_plant_init_l1_w: 
    "peri \<in> dom (plant_schedule s) \<Longrightarrow>
       inv_VDMSet (the (plant_schedule s peri))"
  apply safe
  unfolding inv_VDMSet_def 
  apply simp  
  apply (cases s, simp) using [[show_types]]
    (* Can't know whether range elements of plant_schedule are finite sets;
       missing inv_Schedule for it, as well as inv_VDMSet for the plant_alarms! 
     *)
  oops
lemma PO_plant_init_l2_w: 
    "peri \<in> dom (plant_schedule s) \<Longrightarrow>
       inv_SetElems inv_Expert (the (plant_schedule s peri))"
  unfolding inv_Expert_defs 
  apply (simp,safe)
    (* Again missing inv_Expert for result of plant_schedule!@@@! *)
  oops 
    
theorem PO_Plant_wrong_init: PO_Plant_wrong_init
  unfolding PO_Plant_wrong_init_def inv_Plant_wrong_def Let_def
  apply (intro exI ballI conjI)
  unfolding pre_QualificationOK_def inv_Qualification_def
    (* can the goals be true in general? create the lemmas 

       lemmas work, but are unprovable, see comments  
   apply (frule PO_plant_init_l1_w)
    apply (frule PO_plant_init_l2_w)
   apply (simp)
     *)
    defer
  unfolding QualificationOK_def
  apply (rule bexI)
    (* we now know our witness needs goals 1-2 *)
  oops
    
definition
  inv_Plant :: "Plant \<Rightarrow> \<bool>"
  where
  "inv_Plant p \<equiv> 
      let sch = (plant_schedule p);
          alm = (plant_alarms p)
      in
         inv_Schedule sch \<and> inv_SetElems inv_Alarm alm \<and>
         (\<forall> a \<in> alm . \<forall> peri \<in> dom sch . 
            pre_QualificationOK (the (sch peri)) (alarm_quali a) \<and> 
            QualificationOK (the (sch peri)) (alarm_quali a))"

definition
  witness_Plant :: Plant
  where
  "witness_Plant \<equiv> \<lparr> plant_schedule = witness_Schedule, plant_alarms = {} \<rparr>"

(* @TODO come up with a measure/heuristic for what to expand based on the AST 
         structure / user defined with @expand annotation? *)  
lemmas witness_Plant_defs = witness_Plant_def inv_Plant_def Let_def
  
lemma l_witness_Plant: "inv_Plant witness_Plant" 
  unfolding witness_Plant_defs 
  apply safe
  apply (simp add: l_witness_Schedule) 
  (* Alarms ought to be there? *)
  by simp_all
    
definition
  PO_Plant_init :: \<bool>
  where  
  "PO_Plant_init \<equiv> \<exists> s . inv_Plant s"

theorem PO_Plant_init: PO_Plant_init
  unfolding PO_Plant_init_def using l_witness_Plant by blast  

(* Out of interest let's see if a nicer witness works as well *)
definition
  inv_Plant1 :: "Plant \<Rightarrow> \<bool>"
  where
  "inv_Plant1 p \<equiv> inv_Plant p \<and> inv_VDMSet1 (plant_alarms p)"

definition
  witness_Plant1 :: Plant
  where
  "witness_Plant1 \<equiv> witness_Plant\<lparr> plant_alarms := 
      {\<lparr> alarm_alarmtext = ''A1'', alarm_quali = Bio \<rparr>,
       \<lparr> alarm_alarmtext = ''A2'', alarm_quali = Elec \<rparr>
      } 
                     \<rparr>"

(* @TODO come up with a measure/heuristic for what to expand based on the AST 
         structure / user defined with @expand annotation? *)  
lemmas witness_Plant1_defs = witness_Plant1_def inv_Plant1_def witness_Plant_def Let_def

lemma l_witness_Plant1: "inv_Plant1 witness_Plant1" 
  unfolding witness_Plant1_defs 
  apply (simp,safe)
  unfolding inv_Plant_def
   apply (simp add: l_witness_Schedule)
  unfolding witness_Schedule_def pre_QualificationOK_def inv_Alarm_def
   apply (simp add: inv_Qualification_def QualificationOK_def)
  by (simp add: inv_VDMSet1_defs) 
    
definition
  PO_Plant1_init :: \<bool>
  where  
  "PO_Plant1_init \<equiv> \<exists> s . inv_Plant1 s"
  
theorem PO_Plant1_init: PO_Plant1_init
  unfolding PO_Plant1_init_def using l_witness_Plant1 by blast  

(*****************************************)

(*Useful artificial functions to show the point *)

definition
  pre_g :: "Qualification \<Rightarrow> \<bool>"
  where
  "pre_g q \<equiv> inv_Qualification q \<and> q \<noteq> Chem"
  
definition
  post_g :: "Qualification \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
  where
  "post_g q RESULT \<equiv> 
      pre_g q \<and>
      inv_VDMNat RESULT \<and>
      RESULT mod 10 = 0 \<and> RESULT \<ge> 10"
  
definition
  g :: "Qualification \<Rightarrow> VDMNat"
  where
  "g q \<equiv> (case q of Elec \<Rightarrow> 10 | Mech \<Rightarrow> 20 | Bio \<Rightarrow> 30)"

definition
  PO_g_feas :: \<bool>
  where
  "PO_g_feas \<equiv> \<forall> q . pre_g q \<longrightarrow> (\<exists> r . r = g q \<and> post_g q r)"

theorem PO_g_feas: PO_g_feas
  unfolding PO_g_feas_def post_g_def g_def pre_g_def
  apply simp
  unfolding inv_Qualification_def inv_True_def inv_VDMNat_def
  by (intro allI impI, case_tac q, auto)
    
(* Given the number of times Expert VDMSet is used as a type, it would make
   translation more readble to have it defined as a type of its own like

   Experts = set of Expert

   and then translate it as well. 
 *)
definition
  pre_f :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> \<bool>"
  where
  "pre_f exs q \<equiv> 
      inv_VDMSet exs \<and> inv_SetElems inv_Expert exs \<and> inv_Qualification q \<and>
      (pre_QualificationOK exs q \<and> QualificationOK exs q \<longrightarrow> pre_g q)"

definition
  post_f :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
  where
  "post_f exs q RESULT \<equiv> 
     pre_f exs q \<and>
     inv_VDMNat RESULT \<and>
     post_vdm_card exs (vdm_card exs) \<and>
     post_g q (g q) \<and> 
     RESULT mod 2 = 0
     "

definition
  f :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> VDMNat"
  where
  "f exs q \<equiv> vdm_card exs + g q"
  
definition
  PO_f_feas :: \<bool>
  where
  "PO_f_feas \<equiv> \<forall> exs q . pre_f exs q \<longrightarrow> (\<exists> r . r = f exs q \<and> post_f exs q r)"

(* Even the proof scripts can be automatically generated, roughly, as particular strategies.
   Some of those can take advantage of Eisbach as well, or skip-in-case-failure modes etc.

   Unfold + simp, from types \<rightarrow> post \<rightarrow> pre \<rightarrow> def top-most first

   LATTER: there is also the possibility of having "lemmas" statememnts defined to compose/combine 
   various def expansions in one. 
 *)  
theorem PO_f_feasibility: PO_f_feas
  unfolding PO_f_feas_def 
  (*  apply (simp )*) 
  unfolding post_f_def
  apply simp 
  unfolding post_g_def
  apply simp
  unfolding post_vdm_card_def
  unfolding f_def g_def 
    (* vdm_card_def, say because it's a basic function; don't go there; 
use lemmas instead *)
  
  unfolding pre_f_def pre_g_def
  apply simp
  unfolding pre_QualificationOK_def
  apply simp
  unfolding QualificationOK_def
  (* go to the invariants then*)
  apply safe
  (* or to the subgoals of interest; when to have them? Here was one with a late strategy, let's see one with an earlier strategy *)    
    oops

lemmas PO_f_top_level_def =  PO_f_feas_def post_f_def post_g_def
      
theorem PO_f_feasibility: PO_f_feas
  unfolding PO_f_top_level_def 
  apply (simp)
  apply safe
      (* At this point as part of the translation strategy you could spawn each
         subgoal as a lemma to be used in this proof. That is not optimal and a choice
         of what is a lemma is needed; possibly the AST can give hints to this 
       *)
  oops

lemma PO_f_g: "pre_g q \<Longrightarrow> 0 \<le> g q" 
  unfolding g_def pre_g_def by (cases q, auto)
    
lemma PO_f_l1_l1: 
    "inv_VDMSet exs \<Longrightarrow> inv_SetElems inv_Expert exs  \<Longrightarrow> pre_QualificationOK exs q" 
  unfolding pre_QualificationOK_def  
  by (simp  add: inv_Qualification_def) (* this showed missing inv_VDMSet exs in pre_f *)

lemma PO_f_l1_l2: 
    "e \<in> exs \<Longrightarrow> q \<in> expert_quali e \<Longrightarrow> QualificationOK exs q" 
  unfolding QualificationOK_def inv_Expert_def Let_def
  by (rule bexI, simp_all)

lemma PO_f_l1_l3_f: 
    "inv_VDMSet exs \<Longrightarrow> e \<in> exs \<Longrightarrow> inv_SetElems inv_Expert exs \<Longrightarrow> \<exists> ex\<in>exs. \<exists>q . q \<in> expert_quali ex" 
  unfolding inv_SetElems_def QualificationOK_def 
  apply (elim ballE[of _ _ e], intro bexI[of _ e])
  apply (simp_all)
  unfolding inv_Expert_def Let_def
  by auto (* constructing this took a whiel because of the necessary bindings in various places *)
 
lemma PO_f_l1: "pre_f exs q \<Longrightarrow> inv_VDMNat (f exs q)" 
  unfolding f_def pre_f_def pre_QualificationOK_def 
  apply (elim conjE ) (* don't impE here, as the pre for g might fail; in which case we get a contradictory case *)
   apply (meson PO_f_l1_l3_f empty_iff l_inv_SetElems_empty)
   defer 
  thm equals0D empty_iff
   apply (simp add: PO_f_g inv_VDMNat_def inv_VDMSet_def)
  unfolding inv_VDMNat_def 
  apply (rule PO_f_l1_l2)
  oops (* this seems to show there is something missing in pre_f for when pre_g fails it doesn't work! *)  
    
lemma PO_f_l2: "pre_f exs q \<Longrightarrow> post_vdm_card exs (vdm_card exs)" 
  unfolding post_vdm_card_def pre_vdm_card_def pre_f_def
  using PO_feas_vdm_card post_vdm_card_def pre_vdm_card_def by blast
    
lemma PO_f_l3: "pre_f exs q \<Longrightarrow> pre_g q" 
  unfolding pre_f_def 
  apply (elim conjE impE, intro conjI)
    apply (simp add: PO_f_l1_l1)
   defer apply simp
  apply (subgoal_tac "exs \<noteq> {}")
    
  unfolding QualificationOK_def find_theorems "_ \<noteq> {}"  
    apply (simp add: ex_in_conv[of exs,symmetric])
  apply (rule bexI[of _ "\<lparr>expert_expertid = ''E1'', expert_quali = {q}\<rparr>"], simp)
  unfolding inv_SetElems_def inv_Expert_def Let_def apply simp
   apply (frule PO_f_l1_l3_f, simp_all)
    oops (* missing pre? *)

lemma PO_f_l3: "pre_f exs q \<Longrightarrow> exs \<noteq> {} \<Longrightarrow> pre_g q" 
  unfolding pre_f_def 
  apply (elim conjE impE, intro conjI)
    apply (simp add: PO_f_l1_l1)
   defer apply simp
    find_theorems "_ \<Longrightarrow> QualificationOK _ _ "
    apply (simp add: ex_in_conv[of exs,symmetric], safe)
    apply (rule PO_f_l1_l2, simp)
  oops 
    
lemma PO_f_l4: "pre_f exs q \<Longrightarrow> inv_VDMNat (g q)" oops
lemma PO_f_l5: "pre_f exs q \<Longrightarrow> g q mod 10 = 0" oops
lemma PO_f_l6: "pre_f exs q \<Longrightarrow> 10 \<le> g q" oops
lemma PO_f_l7: "pre_f exs q \<Longrightarrow> f exs q mod 2 = 0" oops
 
theorem PO_f_feasibility: PO_f_feas
  unfolding PO_f_top_level_def 
(*  apply (simp add: PO_f_l1 PO_f_l2 PO_f_l3 PO_f_l4 PO_f_l5 PO_f_l6 PO_f_l7) *)
    oops

definition
  pre_f_stronger_old :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> \<bool>"
  where
  "pre_f_stronger_old exs q \<equiv> 
      inv_VDMSet exs \<and> inv_SetElems inv_Expert exs \<and> inv_Qualification q \<and>
      pre_QualificationOK exs q \<and> QualificationOK exs q \<and> pre_g q"

definition
  pre_f_stronger :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> \<bool>"
  where
  "pre_f_stronger exs q \<equiv> 
      inv_VDMSet exs \<and> inv_SetElems inv_Expert exs \<and> inv_Qualification q \<and>
      pre_QualificationOK exs q \<and> QualificationOK exs q \<and> pre_g q \<and>
      vdm_card exs mod 2 = 0"

definition
  post_f_stronger :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
  where
  "post_f_stronger exs q RESULT \<equiv> 
     pre_f_stronger exs q \<and>
     inv_VDMNat RESULT \<and>
     post_vdm_card exs (vdm_card exs) \<and>
     post_g q (g q) \<and> 
     RESULT mod 2 = 0
     "
  
definition
  PO_f_stronger_feas :: \<bool>
  where
  "PO_f_stronger_feas \<equiv> \<forall> exs q . pre_f_stronger exs q \<longrightarrow> (\<exists> r . r = f exs q \<and> post_f_stronger exs q r)"

lemmas PO_f_stronger_top_level_def =  PO_f_stronger_feas_def post_f_stronger_def post_g_def

lemma PO_f_stronger_l0:
  "pre_f_stronger exs q \<Longrightarrow> pre_g q"
  unfolding pre_f_stronger_def by simp

lemma PO_f_stronger_l1:
  "pre_f_stronger exs q \<Longrightarrow> finite exs"
  unfolding pre_f_stronger_def inv_VDMSet_def by simp
    
lemma PO_g_mod_10: "pre_g q \<Longrightarrow> g q mod 10 = 0"
  unfolding pre_g_def g_def 
  by (case_tac q, simp_all)  

lemma PO_g_geq_10: "pre_g q \<Longrightarrow> g q \<ge> 10"
  unfolding pre_g_def g_def 
  by (case_tac q, simp_all) 

(* difficulty in this one is the chaining of forward reasoning facts *)    
lemma PO_f_stronger_l2: "pre_f_stronger exs q \<Longrightarrow> f exs q \<ge> 0" 
  unfolding  f_def
  apply (frule PO_f_stronger_l0, frule PO_g_geq_10, frule PO_f_stronger_l1) 
  apply (frule l_vdm_card_positive)
  by linarith
  
lemma PO_f_stronger_l3_l0: "pre_g q \<Longrightarrow> g q mod 2 = 0" 
  unfolding pre_g_def g_def by (case_tac q, auto)

lemma PO_f_stronger_l4:
  "pre_f_stronger exs q \<Longrightarrow> int (card exs) mod 2 = 0"
  unfolding pre_f_stronger_def vdm_card_def 
  by (simp split: if_splits)

lemma PO_f_stronger_l3: "pre_f_stronger exs q \<Longrightarrow> f exs q mod 2 = 0" 
  unfolding f_def 
  apply (cut_tac PO_f_stronger_l0 PO_f_stronger_l3_l0, simp_all)
  apply (frule PO_f_stronger_l1)
  find_theorems "_ + _ mod _"
  by (simp add: mod_add_eq PO_f_stronger_l4)
  (* Aha! missing precondition *)
    
theorem PO_f_feasibility: PO_f_stronger_feas
  unfolding PO_f_stronger_top_level_def 
  apply (intro allI impI)  
    apply (simp add: PO_f_g inv_VDMNat_def PO_f_stronger_l0) 
    apply (simp add: PO_f_stronger_l0 PO_g_mod_10 PO_g_geq_10)
  apply (simp add: PO_f_stronger_l1 PO_f_stronger_l2 PO_f_stronger_l3)
  by (simp add: inv_VDMNat_def post_vdm_card_def)
    
(*****************************************)

(* pre / post of those *)    
definition 
  NumberOfExperts :: "Period \<Rightarrow> Plant \<Rightarrow> VDMNat"
where
  "NumberOfExperts peri plant \<equiv> 
      vdm_card (the ((plant_schedule plant) peri))"

definition 
  ExpertIsOnDuty :: "Expert \<Rightarrow> Plant \<Rightarrow> Period VDMSet"
where
  "ExpertIsOnDuty ex p \<equiv>
      let s = (plant_schedule p) in 
        { peri | peri . peri \<in> dom s \<and> ex \<in> (the(s(peri))) }"

lemma "{ x | x . x \<in> {0,1,(2::nat)} \<and> x > 0 } = {1,2}" by auto

(* arguably, we ought also to have pre_dom *)
definition 
  pre_ExpertToPage :: "Alarm \<Rightarrow> Period \<Rightarrow> Plant \<Rightarrow> \<bool>"
  where
  "pre_ExpertToPage a peri plant \<equiv> 
      inv_Alarm a \<and> inv_Period peri \<and> inv_Plant plant \<and>
      peri \<in> dom (plant_schedule plant) \<and>
      a \<in> (plant_alarms plant)"  

definition 
  post_ExpertToPage :: "Alarm \<Rightarrow> Period \<Rightarrow> Plant \<Rightarrow> Expert \<Rightarrow> \<bool>"
  where
  "post_ExpertToPage a peri plant RESULT \<equiv> 
      pre_ExpertToPage a peri plant \<and> inv_Expert RESULT \<and>
      RESULT \<in> (the ((plant_schedule plant) peri)) \<and>
      (alarm_quali a) \<in> (expert_quali RESULT)"

definition
  PO_ExpertToPage_feas :: \<bool>
  where
  "PO_ExpertToPage_feas \<equiv> \<forall> a peri plant . 
      pre_ExpertToPage a peri plant \<longrightarrow> (\<exists> r . post_ExpertToPage a peri plant r)"

theorem PO_ExpertToPage_feas
  unfolding PO_ExpertToPage_feas_def post_ExpertToPage_def 
  apply (simp,safe)
  unfolding pre_ExpertToPage_def
  apply (safe, simp)
  apply (subgoal_tac "y={}", simp) oops (* missing set1 in Expert *)
    
record R =
   x :: int
   y :: int
value "let R=\<lparr> x = 10, y = 20  \<rparr> in R \<lparr> x := 20 \<rparr>"  
value "let R=\<lparr> x = 10, y = 20  \<rparr> in \<lparr> x = (x R)+10, y = (y R) \<rparr>"  

lemma "[ x \<mapsto> (10::nat) ] = A" oops
lemma "(Map.empty(x \<mapsto> (10::nat)))( x \<mapsto> 20) = A" apply simp oops  

definition
	pre_ChangeExpert :: "Plant \<Rightarrow> Expert \<Rightarrow> Expert \<Rightarrow> Period \<Rightarrow> \<bool>"
	where
	"pre_ChangeExpert p ex1 ex2 peri \<equiv> 
     inv_Plant p \<and> inv_Expert ex1 \<and> inv_Expert ex2 \<and> inv_Period peri"

definition
	post_ChangeExpert :: "Plant \<Rightarrow> Expert \<Rightarrow> Expert \<Rightarrow> Period \<Rightarrow> Plant \<Rightarrow> \<bool>"
	where
	"post_ChangeExpert p ex1 ex2 peri RESULT \<equiv> 
     pre_ChangeExpert p ex1 ex2 peri \<and> inv_Plant RESULT \<and>
     True"
  
definition
	ChangeExpert :: "Plant \<Rightarrow> Expert \<Rightarrow> Expert \<Rightarrow> Period \<Rightarrow> Plant"
	where
	"ChangeExpert p ex1 ex2 peri \<equiv> 
      let plan = (plant_schedule p) in
        p\<lparr> plant_schedule := plan ++ [peri \<mapsto> ((the(plan peri)) - {ex1}) \<union> {ex2}]\<rparr>"

definition
  PO_ChangeExpert_feas :: \<bool>
  where
  "PO_ChangeExpert_feas \<equiv> \<forall> p ex1 ex2 peri . 
      pre_ChangeExpert p ex1 ex2 peri  \<longrightarrow> 
        (\<exists> r . r = ChangeExpert p ex1 ex2 peri \<and> post_ChangeExpert p ex1 ex2 peri r)"

theorem PO_ChangeExpert_feas
  unfolding PO_ChangeExpert_feas_def post_ChangeExpert_def
  apply (simp, safe)
  unfolding ChangeExpert_def 
  apply simp
  unfolding inv_Plant_def Let_def
  apply (simp, safe)
  apply (simp_all)
  oops
    
end