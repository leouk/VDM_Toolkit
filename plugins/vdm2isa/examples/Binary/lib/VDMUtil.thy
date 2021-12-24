(* VDM to Isabelle Translation @2021-12-24T10:01:11.759610Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '../examples/Binary/lib/VDMUtil.vdmsl' at line 1:8
files = [../examples/Binary/lib/VDMUtil.vdmsl]
*)
theory VDMUtil
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: set2seq[T]: (set of (@T) +> seq of (@T))
	set2seq(x) ==
not yet specified\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 19:1\<close>

\<comment>\<open>VDM source: pre_set2seq[T]: (set of (@T) +> bool)
	pre_set2seq(x) ==
null\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 19:1\<close>
definition
	pre_set2seq :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSet \<Rightarrow> bool"
where
	"pre_set2seq inv_T   x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_set2seq` specification.\<close>
		((inv_VDMSet' inv_T x))"


\<comment>\<open>VDM source: post_set2seq[T]: (set of (@T) * seq of (@T) +> bool)
	post_set2seq(x, RESULT) ==
null\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 19:1\<close>
definition
	post_set2seq :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSet \<Rightarrow> 'T VDMSeq \<Rightarrow> bool"
where
	"post_set2seq inv_T   x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_set2seq` specification.\<close>
		((inv_VDMSet' inv_T x)  \<and>  (inv_VDMSeq' inv_T RESULT))"

definition
	set2seq :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSet \<Rightarrow> 'T VDMSeq"
where
	"set2seq inv_T   x \<equiv> 
	\<comment>\<open>User defined body of set2seq.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `set2seq`.\<close>
	(if post_set2seq inv_T   x (undefined) then	undefined else	undefined)"

	
	
\<comment>\<open>VDM source: get_file_pos: (() +> [(seq of (char) * nat * nat * seq of (char) * seq of (char))])
	get_file_pos() ==
not yet specified\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 24:1\<close>

\<comment>\<open>VDM source: pre_get_file_pos: (() +> bool)
	pre_get_file_pos() ==
null\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 24:1\<close>
definition
	pre_get_file_pos :: "bool"
where
	"pre_get_file_pos  \<equiv> True"


\<comment>\<open>VDM source: post_get_file_pos: ([(seq of (char) * nat * nat * seq of (char) * seq of (char))] +> bool)
	post_get_file_pos(RESULT) ==
null\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 24:1\<close>
definition
	post_get_file_pos :: "(VDMChar VDMSeq \<times> VDMNat \<times> VDMNat \<times> VDMChar VDMSeq \<times> VDMChar VDMSeq) option \<Rightarrow> bool"
where
	"post_get_file_pos RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_get_file_pos` specification.\<close>
		((inv_Option 
		((inv_VDMSeq' (inv_VDMChar) )\<and>
		 (inv_VDMNat )\<and>
		 (inv_VDMNat )\<and>
		 (inv_VDMSeq' (inv_VDMChar) )\<and>
		 (inv_VDMSeq' (inv_VDMChar) )
		) RESULT))"

definition
	get_file_pos :: "(VDMChar VDMSeq \<times> VDMNat \<times> VDMNat \<times> VDMChar VDMSeq \<times> VDMChar VDMSeq) option"
where
	"get_file_pos  \<equiv> 
	\<comment>\<open>User defined body of get_file_pos.\<close>
	undefined"

	
	
\<comment>\<open>VDM source: val2seq_of_char[T]: (@T +> seq of (char))
	val2seq_of_char(x) ==
not yet specified\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 28:1\<close>

\<comment>\<open>VDM source: pre_val2seq_of_char[T]: (@T +> bool)
	pre_val2seq_of_char(x) ==
null\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 28:1\<close>
definition
	pre_val2seq_of_char :: "('T \<Rightarrow> bool) \<Rightarrow> 'T \<Rightarrow> bool"
where
	"pre_val2seq_of_char inv_T   x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_val2seq_of_char` specification.\<close>
		(inv_T x)"


\<comment>\<open>VDM source: post_val2seq_of_char[T]: (@T * seq of (char) +> bool)
	post_val2seq_of_char(x, RESULT) ==
null\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 28:1\<close>
definition
	post_val2seq_of_char :: "('T \<Rightarrow> bool) \<Rightarrow> 'T \<Rightarrow> VDMChar VDMSeq \<Rightarrow> bool"
where
	"post_val2seq_of_char inv_T   x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_val2seq_of_char` specification.\<close>
		(inv_T x  \<and>  (inv_VDMSeq' (inv_VDMChar) RESULT))"

definition
	val2seq_of_char :: "('T \<Rightarrow> bool) \<Rightarrow> 'T \<Rightarrow> VDMChar VDMSeq"
where
	"val2seq_of_char inv_T   x \<equiv> 
	\<comment>\<open>User defined body of val2seq_of_char.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `val2seq_of_char`.\<close>
	(if post_val2seq_of_char inv_T   x (undefined) then	undefined else	undefined)"

	
	
\<comment>\<open>VDM source: seq_of_char2val[p]: (seq1 of (char) -> (bool * [@p]))
	seq_of_char2val(s) ==
let mk_(b, v):(bool * ?) = seq_of_char2val_(s) in (if is_(v, @p)
then mk_(b, v)
else mk_(false, nil))
	post let mk_(b, t):(bool * [@p]) = RESULT in ((not b) => (t = nil))\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 33:1\<close>

\<comment>\<open>VDM source: pre_seq_of_char2val[p]: (seq1 of (char) +> bool)
	pre_seq_of_char2val(s) ==
null\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 33:1\<close>
definition
	pre_seq_of_char2val :: "VDMChar VDMSeq1 \<Rightarrow> bool"
where
	"pre_seq_of_char2val s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_seq_of_char2val` specification.\<close>
		((inv_VDMSeq1' (inv_VDMChar) s))"


\<comment>\<open>VDM source: post_seq_of_char2val[p]: (seq1 of (char) * (bool * [@p]) +> bool)
	post_seq_of_char2val(s, RESULT) ==
let mk_(b, t):(bool * [@p]) = RESULT in ((not b) => (t = nil))\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 37:6\<close>
definition
	post_seq_of_char2val :: "('p \<Rightarrow> bool) \<Rightarrow> VDMChar VDMSeq1 \<Rightarrow> (bool \<times> 'p option) \<Rightarrow> bool"
where
	"post_seq_of_char2val inv_p   s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_seq_of_char2val` specification.\<close>
		((inv_VDMSeq1' (inv_VDMChar) s)  \<and>  
		((inv_bool (fst RESULT))\<and>
		 (inv_Option inv_p (snd RESULT))
		))  \<and> 
		\<comment>\<open>User defined body of post_seq_of_char2val.\<close>
		\<comment>\<open>Implicit check on generic type invariant for `post_seq_of_char2val`.\<close>
		(if post_post_seq_of_char2val inv_p   s   RESULT ((
		let 
(t::'p option) = RESULT;
(b::bool) = RESULT
		in
			(if (
		((inv_bool (fst dummy0))\<and>
		 (inv_Option inv_p (snd dummy0))
		)) then
			((\<not> b) \<longrightarrow> (t = None))
		 else
			undefined
		)
		)) then
			(
		let 
(t::'p option) = RESULT;
(b::bool) = RESULT
		in
			(if (
		((inv_bool (fst dummy0))\<and>
		 (inv_Option inv_p (snd dummy0))
		)) then
			((\<not> b) \<longrightarrow> (t = None))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		"

definition
	seq_of_char2val :: "('p \<Rightarrow> bool) \<Rightarrow> VDMChar VDMSeq1 \<Rightarrow> (bool \<times> 'p option)"
where
	"seq_of_char2val inv_p   s \<equiv> 
	\<comment>\<open>User defined body of seq_of_char2val.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `seq_of_char2val`.\<close>
	(if post_seq_of_char2val inv_p   s ((
		let 
(v::'UNKNOWN) = (seq_of_char2val_ s);
(b::bool) = (seq_of_char2val_ s)
		in
			(if (
		((inv_bool (fst dummy0))\<and>
		 inv_True (snd dummy0)
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close>
		)) then
			(
		if (isTest (v) inv_p) then
		((b , v))
		else
		(((False::\<bool>) , None)))
		 else
			undefined
		)
		)) then
			(
		let 
(b::bool) = (seq_of_char2val_ s);
(v::'UNKNOWN) = (seq_of_char2val_ s)
		in
			(if (
		((inv_bool (fst dummy0))\<and>
		 inv_True (snd dummy0)
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close>
		)) then
			(
		if (isTest (v) inv_p) then
		((b , v))
		else
		(((False::\<bool>) , None)))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		"

	
	
\<comment>\<open>VDM source: seq_of_char2val_: (seq1 of (char) -> (bool * ?))
	seq_of_char2val_(s) ==
not yet specified\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 39:1\<close>

\<comment>\<open>VDM source: pre_seq_of_char2val_: (seq1 of (char) +> bool)
	pre_seq_of_char2val_(s) ==
null\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 39:1\<close>
definition
	pre_seq_of_char2val_ :: "VDMChar VDMSeq1 \<Rightarrow> bool"
where
	"pre_seq_of_char2val_ s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_seq_of_char2val_` specification.\<close>
		((inv_VDMSeq1' (inv_VDMChar) s))"


\<comment>\<open>VDM source: post_seq_of_char2val_: (seq1 of (char) * (bool * ?) +> bool)
	post_seq_of_char2val_(s, RESULT) ==
null\<close>
\<comment>\<open>in 'VDMUtil' (../examples/Binary/lib/VDMUtil.vdmsl) at line 39:1\<close>
definition
	post_seq_of_char2val_ :: "VDMChar VDMSeq1 \<Rightarrow> (bool \<times> 'UNKNOWN) \<Rightarrow> bool"
where
	"post_seq_of_char2val_ s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_seq_of_char2val_` specification.\<close>
		((inv_VDMSeq1' (inv_VDMChar) s)  \<and>  
		((inv_bool (fst RESULT))\<and>
		 inv_True (snd RESULT)
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close>
		))"

definition
	seq_of_char2val_ :: "VDMChar VDMSeq1 \<Rightarrow> (bool \<times> 'UNKNOWN)"
where
	"seq_of_char2val_ s \<equiv> 
	\<comment>\<open>User defined body of seq_of_char2val_.\<close>
	undefined"

end