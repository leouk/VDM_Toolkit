(* VDM to Isabelle Translation @2022-02-16T13:57:54.106947Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'Clocks' (Clocks.vdmsl) at line 36:9
files = [Clocks.vdmsl]
*)
theory Clocks_PO
imports Clocks
begin


\<comment>\<open>VDM source: Real1 = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 36:9\<close>
theorem Real1_TOTAL:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (r :: VDMReal)  . ((((inv_VDMReal r))) \<longrightarrow> isTest ((inv_Real1 r)) (inv_bool))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: Real1 = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 35:5\<close>
theorem Real1_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (r :: VDMReal)  . ((((inv_VDMReal r))) \<longrightarrow> (r \<ge> (0::VDMNat)))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: Time = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 45:8\<close>
theorem Time_TOTAL:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (a :: Time)   (b :: Time)  . ((( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e a))) )))  \<and>  (( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e b))) ))) \<longrightarrow> isTest ((eq_Time a   b)) (inv_bool))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: Time = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 45:8\<close>
theorem Time_EQUIV_RELATION:
	"(((\<forall> (x :: Time)  . ((( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e x)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e x))) ))) \<longrightarrow> (eq_Time x   x))) \<and> ((\<forall> (x :: Time)  (y :: Time)  . ((( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e x)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e x))) ))) \<and>  (( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e y)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e y))) ))) \<longrightarrow> ((eq_Time x   y) \<longrightarrow> (eq_Time y   x)))) \<and> (\<forall> (x :: Time)  (y :: Time)  (z :: Time)  . ((( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e x)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e x))) ))) \<and>  (( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e y)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e y))) ))) \<and>  (( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e z)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e z))) ))) \<longrightarrow> (((eq_Time x   y) \<and> (eq_Time y   z)) \<longrightarrow> (eq_Time x   z)))))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: Time = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 46:9\<close>
theorem Time_TOTAL:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (a :: Time)   (b :: Time)  . ((( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e a))) )))  \<and>  (( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e b))) ))) \<longrightarrow> isTest ((ord_Time a   b)) (inv_bool))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: Time = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 46:9\<close>
theorem Time_STRICT_ORDER:
	"(((\<forall> (x :: Time)  . ((( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e x)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e x))) ))) \<longrightarrow> (\<not> (ord_Time x   x)))) \<and> (\<forall> (x :: Time)  (y :: Time)  (z :: Time)  . ((( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e x)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e x))) ))) \<and>  (( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e y)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e y))) ))) \<and>  (( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e z)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e z))) ))) \<longrightarrow> (((ord_Time x   y) \<and> (ord_Time y   z)) \<longrightarrow> (ord_Time x   z))))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: Action = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 90:9\<close>
theorem Action_TOTAL:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (a :: Action)   (b :: Action)  . ((( (((((inv_True (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n a))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n a)))) \<and> 
		 (((inv_VDMNat (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n a)))) )))  \<and>  (( (((((inv_True (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n b))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n b)))) \<and> 
		 (((inv_VDMNat (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n b)))) ))) \<longrightarrow> isTest ((ord_Action a   b)) (inv_bool))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: Action = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 90:9\<close>
theorem Action_STRICT_ORDER:
	"(((\<forall> (x :: Action)  . ((( (((((inv_True (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n x))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n x)))) \<and> 
		 (((inv_VDMNat (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n x)))) ))) \<longrightarrow> (\<not> (ord_Action x   x)))) \<and> (\<forall> (x :: Action)  (y :: Action)  (z :: Action)  . ((( (((((inv_True (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n x))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n x)))) \<and> 
		 (((inv_VDMNat (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n x)))) ))) \<and>  (( (((((inv_True (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n y))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n y)))) \<and> 
		 (((inv_VDMNat (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n y)))) ))) \<and>  (( (((((inv_True (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n z))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n z)))) \<and> 
		 (((inv_VDMNat (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n z)))) ))) \<longrightarrow> (((ord_Action x   y) \<and> (ord_Action y   z)) \<longrightarrow> (ord_Action x   z))))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: FMURef = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 101:8\<close>
theorem FMURef_TOTAL:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: FMURef)   (y :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) )))  \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)))) ))) \<longrightarrow> isTest ((eq_FMURef x   y)) (inv_bool))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: FMURef = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 101:8\<close>
theorem FMURef_EQUIV_RELATION:
	"(((\<forall> (x :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) ))) \<longrightarrow> (eq_FMURef x   x))) \<and> ((\<forall> (x :: FMURef)  (y :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) ))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)))) ))) \<longrightarrow> ((eq_FMURef x   y) \<longrightarrow> (eq_FMURef y   x)))) \<and> (\<forall> (x :: FMURef)  (y :: FMURef)  (z :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) ))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)))) ))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f z)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f z)))) ))) \<longrightarrow> (((eq_FMURef x   y) \<and> (eq_FMURef y   z)) \<longrightarrow> (eq_FMURef x   z)))))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: FMURef = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 100:9\<close>
theorem FMURef_TOTAL:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (a :: FMURef)   (b :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f a)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f a)))) )))  \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f b)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f b)))) ))) \<longrightarrow> isTest ((ord_FMURef a   b)) (inv_bool))))"
	
	try
	
	
	oops
	
	
	
	
\<comment>\<open>VDM source: FMURef = ?\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 100:9\<close>
theorem FMURef_STRICT_ORDER:
	"(((\<forall> (x :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) ))) \<longrightarrow> (\<not> (ord_FMURef x   x)))) \<and> (\<forall> (x :: FMURef)  (y :: FMURef)  (z :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x)))) ))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)))) ))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f z)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f z)))) ))) \<longrightarrow> (((ord_FMURef x   y) \<and> (ord_FMURef y   z)) \<longrightarrow> (ord_FMURef x   z))))))"
	
	try
	
	
	oops
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "Time"
hide_const "Real1"
hide_const "Action"
hide_const "FMURef"

end