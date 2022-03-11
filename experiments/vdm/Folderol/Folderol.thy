(*
  Title:      Folderol.thy
  Author:     Leo Freitas, Nov 2020

  Isabelle/ML version of Larry's 
  https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-192.pdf
*)
theory Folderol
  imports Pure
begin

ML \<open>
(*BASIC FUNCTIONS*)
(*Length of a list*)
local fun length1 (n, [ ])  = n
        | length1 (n, _::l) = length1 (n+1, l)
in  fun length l = length1 (0,l) end;

(*The elements of a list satisfying the predicate p.*) 
fun filter _ [] = []
  | filter p (x::xs) = if p(x) then  x :: filter p xs  else  filter p xs;

infix mem; (*membership in a list*) 
fun _ mem[] = false
  | x mem (y::l)  =  (x=y) orelse (x mem l);

infix ins; (*insertion into list if not already there*) 
fun x ins xs = if x mem xs then xs else x::xs;

fun repeat _ 0 = []
| repeat x n = x :: (repeat x (n-1));

fun accumulate _ ([], y) = y
  | accumulate f (x::xs, y) = accumulate f (xs, f(x,y));

(*Look for a pair (X,z) in environment, return [z] if found, else [] *)
fun lookup (_, []) = []
  | lookup (X, (Y,z)::env) = if X = (Y:string) then [z]  else  lookup(X,env);

exception ERROR of string;

(*TERMS AND FORMULAE*)
datatype term =
    Var   of string
  | Param of string * string list
  | Bound of int
  | Fun   of string * term list;

datatype form =
    Pred  of string * term list
  | Conn  of string * form list
  | Quant of string * string * form;

(*Operations on terms and formulae*)

(*Replace the atomic term u by new throughout a term*) 
fun replace_term (u,new) t =
  if t=u then new 
  else
    case t of Fun(a,ts) => Fun(a, map (replace_term(u,new)) ts)
                    | _ => t;

(*Abstraction of a formula over u (containing no bound vars).*) 
fun abstract t =
  let fun abs i (Pred(a,ts))   = Pred(a, map (replace_term (t, Bound i)) ts) 
        | abs i (Conn(b,As))   = Conn(b, map (abs i) As)
        | abs i (Quant(q,b,A)) = Quant(q, b, abs (i+1) A)
  in abs 0 end;

(*Replace (Bound 0) in formula with t (containing no bound vars).*) 
fun subst_bound t =
  let fun subst i (Pred(a,ts))   = Pred(a, map (replace_term (Bound i, t)) ts) 
        | subst i (Conn(b,As))   = Conn(b, map (subst i) As)
        | subst i (Quant(q,b,A)) = Quant(q, b, subst (i+1) A)
   in  subst 0  end;

datatype token = Key of string  |  Id of string;

fun is_char(l,c,u) = ord l <= ord c andalso ord c <= ord u;

val x = [ord("("),ord(")"),ord("~"),ord("&"),ord("|"),ord("-"),ord(">"),ord("<"),ord("."),ord(" ")]
fun is_letter_or_digit c = 
  is_char("A",c,"Z") orelse is_char("a",c,"z") orelse is_char("0",c,"9");

(*Scanning of identifiers and keywords*)
fun token_of a = if a mem ["ALL","EXISTS"] then Key(a) else Id(a);

fun scan_ident (front, c::cs) = 
    if is_letter_or_digit c then 
      scan_ident (c::front, cs)
    else 
      (token_of (implode(rev front)), c::cs)
  | scan_ident (front, []) = (token_of (implode(rev front)), []);

(*Scanning, recognizing --> and <->, skipping blanks, etc.*)
fun scan (front_toks, []) = rev front_toks (*end of char list*)
  (*long infix operators*)
  | scan (front_toks, "-"::"-"::">"::cs) = scan (Key"-->" ::front_toks, cs) | scan (front_toks, "<"::"-"::">"::cs) = scan (Key"<->" ::front_toks, cs)
  (*blanks, tabs, newlines*)
  | scan (front_toks, " "::cs) = scan (front_toks, cs) 
  | scan (front_toks, "\t"::cs) = scan (front_toks, cs) 
  | scan (front_toks, "\n"::cs) = scan (front_toks, cs) 
  | scan (front_toks, c::cs) =
       if is_letter_or_digit c then 
          scannext(front_toks, scan_ident([c], cs))
       else scan (Key(c)::front_toks, cs)
    and 
       scannext (front_toks, (tok, cs)) = scan (tok::front_toks, cs);

(*Parsing a list of tokens*)
fun apfst f (x,toks) = (f x, toks);

(*Functions for constructing results*)
fun cons x xs = x::xs;
fun makeFun fu ts = Fun(fu,ts);
fun makePred id ts = Pred(id,ts);
fun makeNeg A = Conn("~", [A]);
fun makeConn a A B = Conn(a, [A,B]);
fun makeQuant q b A = Quant(q, b, abstract (Fun(b,[])) A);

(*Repeated parsing, returning the list of results  *)
fun parse_repeat (a,parsefn) (Key(b)::toks) = (* a<phrase>...a<phrase> *)
      if a=b then parse_repeat1 (a,parsefn) toks else ([], Key(b)::toks)
  | parse_repeat (_, _) toks = ([], toks) 
    and 
    parse_repeat1 (a,parsefn) toks = (* <phrase>a...<phrase>a *)
      let val (u, toks2) = parsefn toks 
        in apfst (cons u) (parse_repeat (a, parsefn) toks2) end;

fun rightparen (x, Key")"::toks) = (x, toks)
  | rightparen _ = raise ERROR "Symbol ) expected";

fun parse_term (Id(a)::Key"("::toks) =
                               apfst (makeFun a) (rightparen (parse_repeat1 (",", parse_term) toks))
  | parse_term (Id(a)::toks)          = (Fun(a,[]), toks)
  | parse_term (Key"?"::Id(a)::toks) = (Var a, toks) 
  | parse_term _ = raise ERROR "Syntax of term";

(*val t0 =  apfst (makeFun "f");*)
val t1 = (rightparen (parse_repeat1 (",", parse_term) [Id"x",Key")"]));
val t2 = apfst (makeFun "f") (rightparen (parse_repeat1 (",", parse_term) [Id"x",Key")"]));
(*Precedence table*)
fun prec_of "~" = 4
  | prec_of "&" = 3
  | prec_of "|" = 2
  | prec_of "<->" = 1
  | prec_of "-->" = 1
  | prec_of _     = (~1); (*means not an infix*)

(*Parsing of formulae;  prec is the precedence of the operator to the left;
    parsing stops at an operator with lower precedence*)
fun parse (Key"ALL" ::Id(a)::Key"."::toks) = apfst (makeQuant "ALL" a) (parse toks)
| parse (Key"EXISTS"::Id(a)::Key"."::toks) = apfst (makeQuant "EXISTS" a) (parse toks)
| parse toks = parsefix 0 (parse_atom toks) 
and 
  parsefix prec (A, Key(co)::toks) =
    if prec_of co < prec then (A, Key(co)::toks) 
    else 
      parsefix prec (apfst (makeConn co A) (parsefix (prec_of co) (parse_atom toks)))
| parsefix _ (A, toks) = (A, toks)
and 
  parse_atom (Key"~"::toks) = apfst makeNeg (parse_atom toks)
| parse_atom (Key"("::toks) = rightparen (parse toks)
| parse_atom (Id(pr)::Key"("::toks) =
    apfst (makePred pr) (rightparen (parse_repeat1 (",", parse_term) toks))
| parse_atom (Id(pr)::toks) = (Pred(pr,[]), toks)
| parse_atom _ = raise ERROR "Syntax of formula";

(*check that no tokens remain*)
fun 
  parse_end (x, []) = x
| parse_end (_, _::_) = raise ERROR "Extra characters in formula"; 

fun read a = parse_end (parse (scan([], raw_explode a)));

val re = raw_explode "leo vejamos";
(*Printing: conversion of terms/formulae to strings*)
fun enclose a = "(" ^ a ^ ")";

fun conc_list _ [] = ""
  | conc_list sep (b::bs) = (sep ^ b) ^ (conc_list sep bs);

fun conc_list1 sep (b::bs) = b ^ (conc_list sep bs)
  | conc_list1 _ [] = raise ERROR "Invalid empty string list";

val makestring = Int.toString;

fun stringof_term (Param(a,_)) = a
  | stringof_term (Var a) = "?"^a
  | stringof_term (Bound i) = "B." ^ makestring i
  | stringof_term (Fun (a,ts)) = a ^ stringof_args ts
and 
    stringof_args [] = ""
  | stringof_args ts = enclose (conc_list1 "," (map stringof_term ts));

fun max(m,n) : int = if m>n then m else n;

fun stringof_form _ (Pred (a,ts)) = a ^ stringof_args ts
  | stringof_form _ (Conn("~", [A])) = "~" ^ stringof_form (prec_of "~") A
  | stringof_form prec (Conn(C, [A,B])) =
      let val stringf = stringof_form (max(prec_of C, prec));
          val Z = stringf A ^ " " ^ C ^ " " ^ stringf B
       in 
          if (prec_of C <= prec) then (enclose Z) else Z end
  | stringof_form prec (Quant(q,b,A)) =
      let val B = subst_bound (Fun(b,[])) A
           val Z = q^" "^b ^ ". " ^ stringof_form 0 B 
        in 
           if prec>0 then (enclose Z) else Z end
  | stringof_form _ _ = raise ERROR "stringof_form: Bad formula"; 

val stringof = stringof_form 0;

(*UNIFICATION*)
exception UNIFY;

(*Naive unification of terms containing no bound variables*)
fun unify_terms ([],[], env) = env
  | unify_terms (t::ts, u::us, env) =
    let fun chasevar (Var a) = (*Chase variable assignments*)
               (case lookup(a,env) of
                  u::_ => chasevar u | [] => Var a)
          | chasevar t = t;
        fun unify_var (a, t) = (*unification with var*)
          let fun occs (Fun(_,ts))  = occsl ts
                | occs (Param(_,bs))= occsl(map Var bs)
                | occs (Var b)      = a=b orelse occsl(lookup(b,env)) 
                | occs _ = false
              and occsl [] = false
                | occsl(t::ts) = occs t  orelse  occsl ts
          in 
            if t= Var a then env
            else if occs t then raise UNIFY else (a,t)::env end
      and unify_term (Var a, t) = unify_var (a, t)
        | unify_term (t, Var a) = unify_var (a, t) 
        | unify_term (Param(a,_), Param(b,_)) =
            if a=b then env else raise UNIFY 
        | unify_term (Fun(a,ts), Fun(b,us)) =
            if a=b then unify_terms (ts,us,env) else raise UNIFY 
        | unify_term _ = raise UNIFY
  in 
    unify_terms (ts, us, unify_term (chasevar t, chasevar u)) end 
| unify_terms _ = raise UNIFY;

(*Unification of atomic formulae*)
fun unify (Pred(a,ts), Pred(b,us), env) =
  if a=b then 
    unify_terms(ts,us,env) 
  else 
   raise UNIFY 
|   unify _ = raise UNIFY;

(*Accumulate all Vars in the term (not Vars attached to a Param).*) 
fun vars_in_term (Var a, bs) = a ins bs
  | vars_in_term (Fun(_,ts), bs) = accumulate vars_in_term (ts,bs) 
  | vars_in_term (_, bs) = bs;

(*Instantiate a term by an environment*)
fun inst_term env (Fun(a,ts)) = Fun(a, map (inst_term env) ts)
  | inst_term env (Param(a,bs)) = 
         Param(a, accumulate vars_in_term (map (inst_term env o Var) bs, []))
  | inst_term env (Var a) = 
        (case lookup(a,env) of
          u::_ => inst_term env u |[] =>Var a)
  | inst_term _ t = t;

val xx = accumulate vars_in_term (map (inst_term [] o Var) ["leo"], ["oxi"]);

(*INFERENCE: GOALS AND PROOF STATES: GOALS AND PROOF STATES*)
datatype side = Left | Right;

type entry = int * side * form;
type goal = entry list;
type goaltable = goal list;

fun inst_form [] A = A
  | inst_form env (Pred(a,ts)) = Pred(a, map (inst_term env) ts)
  | inst_form env (Conn(b,As)) = Conn(b, map (inst_form env) As)
  | inst_form env (Quant(q,b,A)) = Quant(q, b, inst_form env A);

fun inst_goal _ [] = []
  | inst_goal env ((m,si,A)::G) = (m, si, inst_form env A) :: inst_goal env G;

fun inst_goals [] Gs = Gs
  | inst_goals env Gs = map (inst_goal env) Gs : goaltable;

(*Accumulate over all terms in a formula*)
fun accum_form f (Pred(_,ts), bs) = accumulate f (ts, bs)
  | accum_form f (Conn(_,As), bs) = accumulate (accum_form f) (As, bs) 
  | accum_form f (Quant(_,_,A), bs) = accum_form f (A,bs);

(*Accumulate over all formulae in a goal*) 
fun accum_goal _ ([], bs) = bs
  | accum_goal f ((_,_,A)::G, bs) = accum_goal f (G, f(A,bs));

val vars_in_form = accum_form vars_in_term;
val vars_in_goal = (accum_goal vars_in_form) : (entry list * string list -> string list);

(*Accumulate all Params*)
fun params_in_term (Param (a,bs), pairs) = (a,bs) ins pairs
  | params_in_term (Fun(_,ts), pairs)    = accumulate params_in_term (ts, pairs)
  | params_in_term (_, pairs) = pairs;

val params_in_form = accum_form params_in_term; 
val params_in_goal = accum_goal params_in_form : (entry list * (string * string list) list -> (string * string list) list);

(*Returns (As,Bs),preserving order of elements
  As = Left entries,  Bs = Right entries *)
fun split_goal G =
  let fun split (As,Bs, []: goal) = (As,Bs)
        | split (As,Bs, (_,Left,A)::H) = split (A::As,Bs, H)
        | split (As,Bs, (_,Right,B)::H) = split (As, B::Bs, H) 
   in split([], [], rev G) end;

fun is_pred (Pred _) = true 
  | is_pred _ = false;

(*Solve the goal (A|-A’) by unifying A with A’, 
  Left and Right atomic formulae. Returns list 
  [ (A,env) ] if successful, otherwise []. *)
fun solve_goal G =
  let fun findA ([], _) = [] (*failure*)
        | findA (A::As, Bs) =
              let fun findB [] = findA (As,Bs)
                    | findB (B::Bs) = [ (A, unify(A,B,[])) ]
                        handle UNIFY => findB Bs
               in findB Bs end 
               val (As,Bs) = split_goal G
      in findA(filter is_pred As, filter is_pred Bs) end;

(*Insert goals into a goaltable. For each solved goal (A,env), 
  accumulates the formula (in reverse) and instantiates all other goals.*)
fun insert_goals ([], As, tab) = (As,tab) 
  | insert_goals (G::Gs, As, tab) =
       case solve_goal G of
          (A,env)::_ => (*instantiate other goals*) 
             insert_goals (inst_goals env Gs, (inst_form env A) :: As,
             inst_goals env tab) 
        | [] =>  
             insert_goals (Gs, As, G::tab);

fun stringof_sy (Pred(a,_)) = a
  | stringof_sy (Conn(a,_)) = a
  | stringof_sy (Quant(q,_,_)) = q;

fun stringof_side Right = ":right" 
  | stringof_side Left = ":left";

(*Generation of new variable names*)
val oxi=chr(ord("a")+27)
local
fun make_letter n = chr(ord("a")+n);
fun make_varname (n,tail) =
  if n<26 then 
    make_letter n ^ tail
  else 
    make_varname (n div 26, make_letter(n mod 26) ^ tail);
  val varcount = Unsynchronized.ref ~1 in
fun gensym() = (varcount := !varcount+1; make_varname (!varcount,"")) 
and init_gensym() = varcount := ~1
end;

(*The "cost" of reducing a connective*)
fun cost (_,       Conn("~", _))          = 1    (*a single subgoal*)
  | cost (Left,    Conn("&", _))          = 1
  | cost (Right,   Conn("|", _))          = 1
  | cost (Right,   Conn("-->", _))        = 1
  | cost (Right,   Quant("ALL",_,_))      = 1
  | cost (Left,    Quant("EXISTS",_,_))   = 1
  | cost (Right,   Conn("&", _))          = 2    (*case split: 2 subgoals*)
  | cost (Left,    Conn("|", _))          = 2
  | cost (Left,    Conn("-->", _))        = 2
  | cost (_ ,      Conn("<->", _))        = 2
  | cost (Left,    Quant("ALL",_,_))      = 3    (*quantifier expansion*)
  | cost (Right,   Quant("EXISTS",_,_))   = 3    (*quantifier expansion*)
  | cost _ = 4;                                  (*no reductions possible*)

fun paircost (si,A) = (cost(si,A), si, A);

(*Insertion into a list, ordered by sort keys. *) 
fun insert less =
  let fun insr (x, []) = [x]
        | insr (x, y::ys) = if less(y,x) then y :: insr (x,ys) else x::y::ys
   in insr end;

(*Insert an entry into a goal, in correct order *)
fun entry_less ((m,_,_): entry, (n,_,_): entry) = m<n; 

val insert_early = insert entry_less;

(*Quantified formulae are put back at end -- they are used in a cycle*) 
fun entry_lesseq ((m,_,_): entry, (n,_,_): entry) = m<=n;

val insert_late = insert entry_lesseq;

(*Extend the goal G by inserting a list of (side,form) pairs*)
fun new_goal G pairs = accumulate insert_early (map paircost pairs, G);

(*Extend the goal G, making a list of goals*)
fun new_goals G pairslist = map (new_goal G) pairslist;

exception REDUCE;

(*Reduce the pair using the rest of the goal (G) to make new goals*) 
fun reduce_goal (pair, G) =
  let val goals = new_goals G;
      fun vars_in A = vars_in_goal (G, vars_in_form(A,[]));
      fun subparam A = subst_bound (Param(gensym(), vars_in A)) A; 
      fun subvar A = subst_bound (Var(gensym())) A;
      fun red(_,Right,Conn("~", [A]))     = goals[[(Left,A)]]
        | red(_,Left, Conn("~", [A]))     = goals[[(Right,A)]]
        | red(_,Right,Conn("&", [A,B]))   = goals[[(Right,A)], [(Right,B)]]
        | red(_,Left, Conn("&", [A,B]))   = goals[[(Left,A)], [(Left,B)]]
        | red(_,Right,Conn("|", [A,B]))   = goals[[(Right,A)], [(Left,B)]]
        | red(_,Left, Conn("|", [A,B]))   = goals[[(Left,A)], [(Left,B)]]
        | red(_,Right,Conn("-->", [A,B])) = goals[[(Left,A),(Right,B)]]
        | red(_,Left, Conn("-->", [A,B])) = goals[[(Right,A)], [(Left,B)]] 
        | red(_,Right,Conn("<->", [A,B])) = goals[[(Left,A),(Right,B)], [(Right,A),(Left,B)]] 
        | red(_,Left, Conn("<->", [A,B])) = goals[[(Left,A),(Left,B)], [(Right,A),(Right,B)]]
        | red(_,Right,Quant("ALL",_,A))   = goals[[(Right, subparam A)]] 
        | red(_,Left, Quant("ALL",_,A))   = [ insert_early (paircost(Left, subvar A), insert_late(pair,G)) ] 
        | red(_,Right,Quant("EXISTS",_,A))= [ insert_early (paircost(Right, subvar A), insert_late(pair,G)) ] 
        | red(_,Left, Quant("EXISTS",_,A))= goals[[(Left, subparam A)]]
        | red _ = raise REDUCE
        in  red pair  end;

(*Print the string a
fun prints a = output(std_out,a);
*)
fun prints a = writeln a;

(*Print the rule used, with each formula found by unification, indenting by number of goals left.*)
fun print_step ((_,si,C), ngoals, As) = 
    (prints (implode(repeat " " ngoals) ^ 
       stringof_sy C ^ stringof_side si); 
     prints (conc_list " " (map stringof (rev As))); prints"\n");

(*A single inference in the goaltable*) 
fun proof_step [] = [] : goaltable
  | proof_step ([]::_) = raise ERROR "Empty goal"
  | proof_step ((ent::G)::tab) =
    let val (As,newtab) = insert_goals (reduce_goal(ent,G), [], tab) 
     in print_step(ent, length tab, As); newtab end;

(*Perform n proof steps, no limit if n<0. Stops if impossible to continue.*) 
fun proof_steps (_,[])  = [] (*success -- no goals*)
  | proof_steps (0,tab) = tab
  | proof_steps (n,tab) = proof_steps (n-1, proof_step tab)
      handle REDUCE => (prints"\n**No proof rules applicable**\n";  tab);

fun pair si A = (si,A);

(*Make a goal from lists of formulae: As|-Bs*) 
fun make_goal (As,Bs) : goal = 
    new_goal [] (map (pair Left) As @ map (pair Right) Bs);

(*Reading of goals: Astrs|-Bstrs *)
fun read_tab (Astrs,Bstrs) : goaltable =
  let val As = rev(map read Astrs)  
      and Bs = rev(map read Bstrs);
      val G = make_goal(As,Bs);
       val (_, tab) = insert_goals ([G], [], [])
   in tab end;

fun stringof_sequent [] = "empty"
  | stringof_sequent As = conc_list1 ", " (map stringof As);

fun print_goal G =
  let val (As,Bs) = split_goal G
   in prints (stringof_sequent As ^ " |- " ^ stringof_sequent Bs ^ "\n\n") end;

fun print_param (a,ts) = prints (a ^ "         " ^ stringof_args (map Var ts) ^ "\n");

fun print_params [] = () 
  | print_params pairs =
      (prints "Param     Not allowed in\n";
          map print_param pairs; prints "\n");

fun print_count 1 = ()
  | print_count n = prints (makestring n ^ " goals\n");

val x = (accumulate params_in_goal ([],[]));
fun print_tab [] = prints"No more goals: proof finished\n" 
  | print_tab Gs = (prints"\n"; map print_goal Gs; 
                    print_count (length Gs); 
                    print_params (accumulate params_in_goal (Gs,[])));

(*Top-level commands: interaction with proof state*)
val the_goaltable = Unsynchronized.ref ([] : goaltable);

fun set_tab tab = (the_goaltable := tab; print_tab tab);

(*Read a goal: the sequent As|-Bs *) 
fun read_goalseq (Astrs,Bstrs) = (init_gensym(); set_tab(read_tab (Astrs,Bstrs)));

(*Read the goal |-B *)
fun read_goal Bstr = read_goalseq([],[Bstr]);

fun step()  = set_tab (proof_step(!the_goaltable));
fun steps n = set_tab (proof_steps (max(n,0), !the_goaltable)); 
fun run()   = set_tab (proof_steps (~1, !the_goaltable));

fun run_goalseq (Astrs,Bstrs) = (read_goalseq (Astrs,Bstrs); run());

fun run_goal b = run_goalseq([],[b]);

(*Raises exception unless some goals are left unsolved after n proof steps*) 
fun fail_goal n A = 
  (read_goal A; steps n;
    (case !the_goaltable of
        [] => raise ERROR "This proof should have failed!" 
    | _::_ => prints"Failed, as expected\n"));

(*
val y=(parse_repeat1 (",", parse_term) [])
val x=(rightparen )*)
\<close>

ML_command \<open> run_goal"(P|Q)&(P|R) --> P|(Q&R)"; steps 2 \<close>
end