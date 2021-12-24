(* VDM to Isabelle Translation @2021-12-24T10:01:11.749136Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '../examples/Binary/Binary.vdmsl' at line 1:8
files = [../examples/Binary/Binary.vdmsl]
*)
theory Binary
imports "VDMToolkit" "VDMUtil" 
begin

\<comment>\<open>unqualified VDM import from val2str: val2seq_of_char; use Isabelle qualified naming directly.\<close>
	\<comment>\<open>VDM import from VDMUtil: val2seq_of_char renamed val2str.\<close>
	abbreviation "val2str \<equiv> val2seq_of_char"
	
	
	\<comment>\<open>unqualified VDM import from str2val: seq_of_char2val; use Isabelle qualified naming directly.\<close>
	\<comment>\<open>VDM import from VDMUtil: seq_of_char2val renamed str2val.\<close>
	abbreviation "str2val \<equiv> seq_of_char2val"
	
	
	
\<comment>\<open>VDM source: BITS_PER_BYTE:nat1 = 8\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 80:5\<close>
abbreviation
	BITS_PER_BYTE :: "VDMNat1"
where
	"BITS_PER_BYTE \<equiv> (8::VDMNat1)"

	definition
	inv_BITS_PER_BYTE :: "\<bool>"
where
	"inv_BITS_PER_BYTE  \<equiv> (inv_VDMNat1 BITS_PER_BYTE)"

	
	
	
\<comment>\<open>VDM source: BIN_BASE:nat1 = 2\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 81:5\<close>
abbreviation
	BIN_BASE :: "VDMNat1"
where
	"BIN_BASE \<equiv> (2::VDMNat1)"

	definition
	inv_BIN_BASE :: "\<bool>"
where
	"inv_BIN_BASE  \<equiv> (inv_VDMNat1 BIN_BASE)"

	
	
	
\<comment>\<open>VDM source: BITS:set of (nat) = {0, ... ,BITS_PER_BYTE}\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 82:5\<close>
abbreviation
	BITS :: "VDMNat VDMSet"
where
	"BITS \<equiv> {(0::VDMNat)..BITS_PER_BYTE}"

	definition
	inv_BITS :: "\<bool>"
where
	"inv_BITS  \<equiv> (inv_VDMSet' (inv_VDMNat) BITS)"

	
	
	
\<comment>\<open>VDM source: BYTE_SIZE:nat1 = (npow(BIN_BASE, BITS_PER_BYTE) - 1)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 84:5\<close>
abbreviation
	BYTE_SIZE :: "VDMNat1"
where
	"BYTE_SIZE \<equiv> ((npow BIN_BASE   BITS_PER_BYTE) - (1::VDMNat1))"

	definition
	inv_BYTE_SIZE :: "\<bool>"
where
	"inv_BYTE_SIZE  \<equiv> (inv_VDMNat1 BYTE_SIZE)"

	
	
	
\<comment>\<open>VDM source: WORD_SIZE:nat1 = (npow(BIN_BASE, (2 * BITS_PER_BYTE)) - 1)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 85:5\<close>
abbreviation
	WORD_SIZE :: "VDMNat1"
where
	"WORD_SIZE \<equiv> ((npow BIN_BASE   ((2::VDMNat1) * BITS_PER_BYTE)) - (1::VDMNat1))"

	definition
	inv_WORD_SIZE :: "\<bool>"
where
	"inv_WORD_SIZE  \<equiv> (inv_VDMNat1 WORD_SIZE)"

	
	
	
\<comment>\<open>VDM source: binary = nat
	inv b == (b in set {0, 1})\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 88:5\<close>
type_synonym binary = "VDMNat"
	

\<comment>\<open>VDM source: inv_binary: (nat +> bool)
	inv_binary(b) ==
(b in set {0, 1})\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 89:9\<close>
definition
	inv_binary :: "binary \<Rightarrow> bool"
where
	"inv_binary b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_binary` specification.\<close>
		(((inv_VDMNat b)))  \<and> 
		\<comment>\<open>User defined body of inv_binary.\<close>
		(b \<in> {(0::VDMNat) , (1::VDMNat1)})"
 

	
	
\<comment>\<open>VDM source: Bit = nat
	inv b == (b in set BITS)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 91:5\<close>
type_synonym Bit = "VDMNat"
	

\<comment>\<open>VDM source: inv_Bit: (nat +> bool)
	inv_Bit(b) ==
(b in set BITS)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 92:9\<close>
definition
	inv_Bit :: "Bit \<Rightarrow> bool"
where
	"inv_Bit b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Bit` specification.\<close>
		(((inv_VDMNat b)))  \<and> 
		\<comment>\<open>User defined body of inv_Bit.\<close>
		(b \<in> BITS)"
 

	
	
\<comment>\<open>VDM source: Byte = nat
	inv v == (v < npow(2, BITS_PER_BYTE))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 94:5\<close>
type_synonym Byte = "VDMNat"
	

\<comment>\<open>VDM source: inv_Byte: (nat +> bool)
	inv_Byte(v) ==
(v < npow(2, BITS_PER_BYTE))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 95:9\<close>
definition
	inv_Byte :: "Byte \<Rightarrow> bool"
where
	"inv_Byte v \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Byte` specification.\<close>
		(((inv_VDMNat v)))  \<and> 
		\<comment>\<open>User defined body of inv_Byte.\<close>
		(v < (npow (2::VDMNat1)   BITS_PER_BYTE))"
 

	
	
\<comment>\<open>VDM source: BitVector = seq of (bool)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 97:5\<close>
type_synonym BitVector = "bool VDMSeq"
	

\<comment>\<open>VDM source: inv_BitVector: (BitVector +> bool)
	inv_BitVector(dummy0) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 97:5\<close>
definition
	inv_BitVector :: "BitVector \<Rightarrow> bool"
where
	"inv_BitVector dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_BitVector` specification.\<close>
		(((inv_VDMSeq' (inv_bool) dummy0)))"
 

	
	
\<comment>\<open>VDM source: ByteVector = seq of (BinByte)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 99:5\<close>
type_synonym ByteVector = "BinByte VDMSeq"
	

\<comment>\<open>VDM source: inv_ByteVector: (ByteVector +> bool)
	inv_ByteVector(dummy0) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 99:5\<close>
definition
	inv_ByteVector :: "ByteVector \<Rightarrow> bool"
where
	"inv_ByteVector dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ByteVector` specification.\<close>
		(((inv_VDMSeq' (inv_BinByte) dummy0)))"

		 

	
	
\<comment>\<open>VDM source: BinByte0 = BitVector
	inv b == ((len b) <= BITS_PER_BYTE)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 101:5\<close>
type_synonym BinByte0 = "BitVector"
	

\<comment>\<open>VDM source: inv_BinByte0: (BitVector +> bool)
	inv_BinByte0(b) ==
((len b) <= BITS_PER_BYTE)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 102:9\<close>
definition
	inv_BinByte0 :: "BinByte0 \<Rightarrow> bool"
where
	"inv_BinByte0 b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_BinByte0` specification.\<close>
		((inv_BitVector b))  \<and> 
		\<comment>\<open>User defined body of inv_BinByte0.\<close>
		((len b) \<le> BITS_PER_BYTE)"
 

	
	
\<comment>\<open>VDM source: BinByte = BinByte0
	inv b == ((len b) = BITS_PER_BYTE)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 104:5\<close>
type_synonym BinByte = "BinByte0"
	

\<comment>\<open>VDM source: inv_BinByte: (BinByte0 +> bool)
	inv_BinByte(b) ==
((len b) = BITS_PER_BYTE)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 105:9\<close>
definition
	inv_BinByte :: "BinByte \<Rightarrow> bool"
where
	"inv_BinByte b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_BinByte` specification.\<close>
		((inv_BinByte0 b))  \<and> 
		\<comment>\<open>User defined body of inv_BinByte.\<close>
		((len b) = BITS_PER_BYTE)"
 

	
	
\<comment>\<open>VDM source: BitVectorOp = (<BAnd> | <BOr> | <BXor>)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 107:5\<close>
datatype BitVectorOp = U_BAnd  | 
		 U_BOr  | 
		 U_BXor 
	

\<comment>\<open>VDM source: inv_BitVectorOp: (BitVectorOp +> bool)
	inv_BitVectorOp(dummy0) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 107:5\<close>
definition
	inv_BitVectorOp :: "BitVectorOp \<Rightarrow> bool"
where
	"inv_BitVectorOp dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_BitVectorOp` specification.\<close>
		((((inv_True dummy0))))"
 

	
	
\<comment>\<open>VDM source: String = seq1 of (char)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 109:5\<close>
type_synonym String = "VDMChar VDMSeq1"
	

\<comment>\<open>VDM source: inv_String: (String +> bool)
	inv_String(dummy0) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 109:5\<close>
definition
	inv_String :: "String \<Rightarrow> bool"
where
	"inv_String dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_String` specification.\<close>
		(((inv_VDMSeq1' (inv_VDMChar) dummy0)))"
 

	
	
\<comment>\<open>VDM source: injective[T]: (seq of (@T) +> bool)
	injective(ss) ==
((card (elems ss)) = (len ss))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 112:3\<close>

\<comment>\<open>VDM source: pre_injective[T]: (seq of (@T) +> bool)
	pre_injective(ss) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 112:3\<close>
definition
	pre_injective :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq \<Rightarrow> bool"
where
	"pre_injective inv_T   ss \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_injective` specification.\<close>
		((inv_VDMSeq' inv_T ss))"


\<comment>\<open>VDM source: post_injective[T]: (seq of (@T) * bool +> bool)
	post_injective(ss, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 112:3\<close>
definition
	post_injective :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_injective inv_T   ss   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_injective` specification.\<close>
		((inv_VDMSeq' inv_T ss)  \<and>  (inv_bool RESULT))"

definition
	injective :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq \<Rightarrow> bool"
where
	"injective inv_T   ss \<equiv> 
	\<comment>\<open>User defined body of injective.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `injective`.\<close>
	(if post_injective inv_T   ss (((vdm_card (elems ss)) = (len ss))) then	((vdm_card (elems ss)) = (len ss)) else	undefined)"

	
	
\<comment>\<open>VDM source: hasSizeBytes: (nat * nat1 -> bool)
	hasSizeBytes(value, no_of_bytes) ==
(value < (BIN_BASE ** (no_of_bytes * BITS_PER_BYTE)))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 117:5\<close>

\<comment>\<open>VDM source: pre_hasSizeBytes: (nat * nat1 +> bool)
	pre_hasSizeBytes(value, no_of_bytes) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 117:5\<close>
definition
	pre_hasSizeBytes :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_hasSizeBytes value   no_of_bytes \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_hasSizeBytes` specification.\<close>
		((inv_VDMNat value)  \<and>  (inv_VDMNat1 no_of_bytes))"


\<comment>\<open>VDM source: post_hasSizeBytes: (nat * nat1 * bool +> bool)
	post_hasSizeBytes(value, no_of_bytes, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 117:5\<close>
definition
	post_hasSizeBytes :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_hasSizeBytes value   no_of_bytes   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_hasSizeBytes` specification.\<close>
		((inv_VDMNat value)  \<and>  (inv_VDMNat1 no_of_bytes)  \<and>  (inv_bool RESULT))"

definition
	hasSizeBytes :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"hasSizeBytes value   no_of_bytes \<equiv> 
	\<comment>\<open>User defined body of hasSizeBytes.\<close>
	(value < (BIN_BASE ^ nat (no_of_bytes * BITS_PER_BYTE))
	\<comment>\<open>Result of the power operator is context dependenant on second argument type being nat or real.\<close>
	)"

	
	
\<comment>\<open>VDM source: hasSizeBits: (nat * nat1 -> bool)
	hasSizeBits(value, no_of_bits) ==
(value < (BIN_BASE ** no_of_bits))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 121:5\<close>

\<comment>\<open>VDM source: pre_hasSizeBits: (nat * nat1 +> bool)
	pre_hasSizeBits(value, no_of_bits) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 121:5\<close>
definition
	pre_hasSizeBits :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_hasSizeBits value   no_of_bits \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_hasSizeBits` specification.\<close>
		((inv_VDMNat value)  \<and>  (inv_VDMNat1 no_of_bits))"


\<comment>\<open>VDM source: post_hasSizeBits: (nat * nat1 * bool +> bool)
	post_hasSizeBits(value, no_of_bits, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 121:5\<close>
definition
	post_hasSizeBits :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_hasSizeBits value   no_of_bits   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_hasSizeBits` specification.\<close>
		((inv_VDMNat value)  \<and>  (inv_VDMNat1 no_of_bits)  \<and>  (inv_bool RESULT))"

definition
	hasSizeBits :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"hasSizeBits value   no_of_bits \<equiv> 
	\<comment>\<open>User defined body of hasSizeBits.\<close>
	(value < (BIN_BASE ^ nat no_of_bits)
	\<comment>\<open>Result of the power operator is context dependenant on second argument type being nat or real.\<close>
	)"

	
	
\<comment>\<open>VDM source: b2n: (bool -> binary)
	b2n(b) ==
(if b
then 1
else 0)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 124:5\<close>

\<comment>\<open>VDM source: pre_b2n: (bool +> bool)
	pre_b2n(b) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 124:5\<close>
definition
	pre_b2n :: "bool \<Rightarrow> bool"
where
	"pre_b2n b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_b2n` specification.\<close>
		((inv_bool b))"


\<comment>\<open>VDM source: post_b2n: (bool * binary +> bool)
	post_b2n(b, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 124:5\<close>
definition
	post_b2n :: "bool \<Rightarrow> binary \<Rightarrow> bool"
where
	"post_b2n b   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_b2n` specification.\<close>
		((inv_bool b)  \<and>  (inv_binary RESULT))"

definition
	b2n :: "bool \<Rightarrow> binary"
where
	"b2n b \<equiv> 
	\<comment>\<open>User defined body of b2n.\<close>
	(
		if (b) then
		((1::VDMNat1))
		else
		((0::VDMNat)))"

	
	
\<comment>\<open>VDM source: n2b: (binary -> bool)
	n2b(n) ==
(n <> 0)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 127:5\<close>

\<comment>\<open>VDM source: pre_n2b: (binary +> bool)
	pre_n2b(n) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 127:5\<close>
definition
	pre_n2b :: "binary \<Rightarrow> bool"
where
	"pre_n2b n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_n2b` specification.\<close>
		((inv_binary n))"


\<comment>\<open>VDM source: post_n2b: (binary * bool +> bool)
	post_n2b(n, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 127:5\<close>
definition
	post_n2b :: "binary \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_n2b n   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_n2b` specification.\<close>
		((inv_binary n)  \<and>  (inv_bool RESULT))"

definition
	n2b :: "binary \<Rightarrow> bool"
where
	"n2b n \<equiv> 
	\<comment>\<open>User defined body of n2b.\<close>
	(n \<noteq> (0::VDMNat))"

	
	
\<comment>\<open>VDM source: npow: (nat * nat -> nat1)
	npow(base, exp) ==
(base ** exp)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 131:5\<close>

\<comment>\<open>VDM source: pre_npow: (nat * nat +> bool)
	pre_npow(base, exp) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 131:5\<close>
definition
	pre_npow :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_npow base   exp \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_npow` specification.\<close>
		((inv_VDMNat base)  \<and>  (inv_VDMNat exp))"


\<comment>\<open>VDM source: post_npow: (nat * nat * nat1 +> bool)
	post_npow(base, exp, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 131:5\<close>
definition
	post_npow :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"post_npow base   exp   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_npow` specification.\<close>
		((inv_VDMNat base)  \<and>  (inv_VDMNat exp)  \<and>  (inv_VDMNat1 RESULT))"

definition
	npow :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat1"
where
	"npow base   exp \<equiv> 
	\<comment>\<open>User defined body of npow.\<close>
	(base ^ nat exp)
	\<comment>\<open>Result of the power operator is context dependenant on second argument type being nat or real.\<close>
	"

	
	
\<comment>\<open>VDM source: bv2natQ: (BitVector * nat -> nat)
	bv2natQ(bv, p) ==
(if (bv = [])
then p
else bv2natQ((tl bv), (b2n((hd bv)) + (2 * p))))
	measure (len bv)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 143:5\<close>

\<comment>\<open>VDM source: pre_bv2natQ: (BitVector * nat +> bool)
	pre_bv2natQ(bv, p) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 143:5\<close>
definition
	pre_bv2natQ :: "BitVector \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_bv2natQ bv   p \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bv2natQ` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat p))"


\<comment>\<open>VDM source: post_bv2natQ: (BitVector * nat * nat +> bool)
	post_bv2natQ(bv, p, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 143:5\<close>
definition
	post_bv2natQ :: "BitVector \<Rightarrow> VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_bv2natQ bv   p   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_bv2natQ` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat p)  \<and>  (inv_VDMNat RESULT))"

fun
	bv2natQ :: "BitVector \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"bv2natQ bv   p = 
	\<comment>\<open>User defined body of bv2natQ.\<close>
	(
		if ((bv = [])) then
		(p)
		else
		((bv2natQ (tl bv)   ((b2n (hd bv)) + ((2::VDMNat1) * p)))))"

	
	
\<comment>\<open>VDM source: bv2nat: (BitVector -> nat)
	bv2nat(bv) ==
bv2natQ(bv, 0)
	post (RESULT < npow(BIN_BASE, (len bv)))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 157:5\<close>

\<comment>\<open>VDM source: pre_bv2nat: (BitVector +> bool)
	pre_bv2nat(bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 157:5\<close>
definition
	pre_bv2nat :: "BitVector \<Rightarrow> bool"
where
	"pre_bv2nat bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bv2nat` specification.\<close>
		((inv_BitVector bv))"


\<comment>\<open>VDM source: post_bv2nat: (BitVector * nat +> bool)
	post_bv2nat(bv, RESULT) ==
(RESULT < npow(BIN_BASE, (len bv)))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 160:16\<close>
definition
	post_bv2nat :: "BitVector \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_bv2nat bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bv2nat` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bv2nat.\<close>
		(RESULT < (npow BIN_BASE   (len bv)))"

definition
	bv2nat :: "BitVector \<Rightarrow> VDMNat"
where
	"bv2nat bv \<equiv> 
	\<comment>\<open>User defined body of bv2nat.\<close>
	(bv2natQ bv   (0::VDMNat))"

	
	
\<comment>\<open>VDM source: nat2bvQ: (nat * BitVector -> BitVector)
	nat2bvQ(n, bv) ==
(if (n = 0)
then (reverse bv)
else nat2bvQ((n div 2), (bv ^ [n2b((n mod 2))])))
	measure n\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 162:5\<close>

\<comment>\<open>VDM source: pre_nat2bvQ: (nat * BitVector +> bool)
	pre_nat2bvQ(n, bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 162:5\<close>
definition
	pre_nat2bvQ :: "VDMNat \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"pre_nat2bvQ n   bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_nat2bvQ` specification.\<close>
		((inv_VDMNat n)  \<and>  (inv_BitVector bv))"


\<comment>\<open>VDM source: post_nat2bvQ: (nat * BitVector * BitVector +> bool)
	post_nat2bvQ(n, bv, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 162:5\<close>
definition
	post_nat2bvQ :: "VDMNat \<Rightarrow> BitVector \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_nat2bvQ n   bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_nat2bvQ` specification.\<close>
		((inv_VDMNat n)  \<and>  (inv_BitVector bv)  \<and>  (inv_BitVector RESULT))"

fun
	nat2bvQ :: "VDMNat \<Rightarrow> BitVector \<Rightarrow> BitVector"
where
	"nat2bvQ n   bv = 
	\<comment>\<open>User defined body of nat2bvQ.\<close>
	(
		if ((n = (0::VDMNat))) then
		((vdm_reverse bv))
		else
		((nat2bvQ (n vdmdiv (2::VDMNat1))   (bv @ [(n2b (n vdmmod (2::VDMNat1)))]))))"

	
	
\<comment>\<open>VDM source: nat2bv: (nat -> BitVector)
	nat2bv(n) ==
nat2bvQ(n, [])
	post (n < npow(BIN_BASE, (len RESULT)))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 171:5\<close>

\<comment>\<open>VDM source: pre_nat2bv: (nat +> bool)
	pre_nat2bv(n) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 171:5\<close>
definition
	pre_nat2bv :: "VDMNat \<Rightarrow> bool"
where
	"pre_nat2bv n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_nat2bv` specification.\<close>
		((inv_VDMNat n))"


\<comment>\<open>VDM source: post_nat2bv: (nat * BitVector +> bool)
	post_nat2bv(n, RESULT) ==
(n < npow(BIN_BASE, (len RESULT)))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 175:11\<close>
definition
	post_nat2bv :: "VDMNat \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_nat2bv n   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_nat2bv` specification.\<close>
		((inv_VDMNat n)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_nat2bv.\<close>
		(n < (npow BIN_BASE   (len RESULT)))"

definition
	nat2bv :: "VDMNat \<Rightarrow> BitVector"
where
	"nat2bv n \<equiv> 
	\<comment>\<open>User defined body of nat2bv.\<close>
	(nat2bvQ n   [])"

	
	
\<comment>\<open>VDM source: bin2byte: (BinByte -> Byte)
	bin2byte(bv) ==
bv2nat(bv)
	post post_bv2nat(bv, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 177:5\<close>

\<comment>\<open>VDM source: pre_bin2byte: (BinByte +> bool)
	pre_bin2byte(bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 177:5\<close>
definition
	pre_bin2byte :: "BinByte \<Rightarrow> bool"
where
	"pre_bin2byte bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bin2byte` specification.\<close>
		((inv_BinByte bv))"


\<comment>\<open>VDM source: post_bin2byte: (BinByte * Byte +> bool)
	post_bin2byte(bv, RESULT) ==
post_bv2nat(bv, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 180:9\<close>
definition
	post_bin2byte :: "BinByte \<Rightarrow> Byte \<Rightarrow> bool"
where
	"post_bin2byte bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bin2byte` specification.\<close>
		((inv_BinByte bv)  \<and>  (inv_Byte RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bin2byte.\<close>
		(post_bv2nat bv   RESULT)"

definition
	bin2byte :: "BinByte \<Rightarrow> Byte"
where
	"bin2byte bv \<equiv> 
	\<comment>\<open>User defined body of bin2byte.\<close>
	(bv2nat bv)"

	
	
\<comment>\<open>VDM source: byte2bin: (Byte -> BinByte)
	byte2bin(n) ==
binPad(nat2bv(n))
	post post_nat2bv(n, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 182:5\<close>

\<comment>\<open>VDM source: pre_byte2bin: (Byte +> bool)
	pre_byte2bin(n) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 182:5\<close>
definition
	pre_byte2bin :: "Byte \<Rightarrow> bool"
where
	"pre_byte2bin n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_byte2bin` specification.\<close>
		((inv_Byte n))"


\<comment>\<open>VDM source: post_byte2bin: (Byte * BinByte +> bool)
	post_byte2bin(n, RESULT) ==
post_nat2bv(n, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 185:9\<close>
definition
	post_byte2bin :: "Byte \<Rightarrow> BinByte \<Rightarrow> bool"
where
	"post_byte2bin n   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_byte2bin` specification.\<close>
		((inv_Byte n)  \<and>  (inv_BinByte RESULT))  \<and> 
		\<comment>\<open>User defined body of post_byte2bin.\<close>
		(post_nat2bv n   RESULT)"

definition
	byte2bin :: "Byte \<Rightarrow> BinByte"
where
	"byte2bin n \<equiv> 
	\<comment>\<open>User defined body of byte2bin.\<close>
	(binPad (nat2bv n))"

	
	
\<comment>\<open>VDM source: zeroed: (nat -> BitVector)
	zeroed(size) ==
[false | - in seq [p | p in set {1, ... ,size}]]
	post ((len RESULT) = size)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 188:5\<close>

\<comment>\<open>VDM source: pre_zeroed: (nat +> bool)
	pre_zeroed(size) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 188:5\<close>
definition
	pre_zeroed :: "VDMNat \<Rightarrow> bool"
where
	"pre_zeroed size \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_zeroed` specification.\<close>
		((inv_VDMNat size))"


\<comment>\<open>VDM source: post_zeroed: (nat * BitVector +> bool)
	post_zeroed(size, RESULT) ==
((len RESULT) = size)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 191:20\<close>
definition
	post_zeroed :: "VDMNat \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_zeroed size   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_zeroed` specification.\<close>
		((inv_VDMNat size)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_zeroed.\<close>
		((len RESULT) = size)"

definition
	zeroed :: "VDMNat \<Rightarrow> BitVector"
where
	"zeroed size \<equiv> 
	\<comment>\<open>User defined body of zeroed.\<close>
	[ (False::\<bool>) . dummy0_ignore \<leftarrow> [ p . p \<leftarrow> sorted_list_of_set ({(1::VDMNat1)..size}) , ((p \<in>{(1::VDMNat1)..size})) ]
	\<comment>\<open>`Set bind `(p \<in> {(1::VDMNat1)..size})` in sequence comprehension requires its Isabelle type to instantiate class linorder.`   This can be a problem if the target type of @{term \<open>{(1::VDMNat1)..size}\<close>}   has a VDM ord_ predicate.\<close>  , ((dummy0_ignore \<in>(elems [ p . p \<leftarrow> sorted_list_of_set ({(1::VDMNat1)..size}) , ((p \<in>{(1::VDMNat1)..size})) ]
	\<comment>\<open>`Set bind `(p \<in> {(1::VDMNat1)..size})` in sequence comprehension requires its Isabelle type to instantiate class linorder.`   This can be a problem if the target type of @{term \<open>{(1::VDMNat1)..size}\<close>}   has a VDM ord_ predicate.\<close> ))) ]"

	
	
\<comment>\<open>VDM source: bvPad: (BitVector * nat -> BitVector)
	bvPad(bv, size) ==
(zeroed(size) ^ bv)
	post ((len RESULT) = ((len bv) + size))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 193:5\<close>

\<comment>\<open>VDM source: pre_bvPad: (BitVector * nat +> bool)
	pre_bvPad(bv, size) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 193:5\<close>
definition
	pre_bvPad :: "BitVector \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_bvPad bv   size \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bvPad` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat size))"


\<comment>\<open>VDM source: post_bvPad: (BitVector * nat * BitVector +> bool)
	post_bvPad(bv, size, RESULT) ==
((len RESULT) = ((len bv) + size))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 196:20\<close>
definition
	post_bvPad :: "BitVector \<Rightarrow> VDMNat \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_bvPad bv   size   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bvPad` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat size)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bvPad.\<close>
		((len RESULT) = ((len bv) + size))"

definition
	bvPad :: "BitVector \<Rightarrow> VDMNat \<Rightarrow> BitVector"
where
	"bvPad bv   size \<equiv> 
	\<comment>\<open>User defined body of bvPad.\<close>
	((zeroed size) @ bv)"

	
	
\<comment>\<open>VDM source: binPad: (BinByte0 -> BinByte)
	binPad(bv) ==
bvPad(bv, (BITS_PER_BYTE - (len bv)))
	post post_bvPad(bv, (BITS_PER_BYTE - (len bv)), RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 198:5\<close>

\<comment>\<open>VDM source: pre_binPad: (BinByte0 +> bool)
	pre_binPad(bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 198:5\<close>
definition
	pre_binPad :: "BinByte0 \<Rightarrow> bool"
where
	"pre_binPad bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_binPad` specification.\<close>
		((inv_BinByte0 bv))"


\<comment>\<open>VDM source: post_binPad: (BinByte0 * BinByte +> bool)
	post_binPad(bv, RESULT) ==
post_bvPad(bv, (BITS_PER_BYTE - (len bv)), RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 201:9\<close>
definition
	post_binPad :: "BinByte0 \<Rightarrow> BinByte \<Rightarrow> bool"
where
	"post_binPad bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_binPad` specification.\<close>
		((inv_BinByte0 bv)  \<and>  (inv_BinByte RESULT))  \<and> 
		\<comment>\<open>User defined body of post_binPad.\<close>
		(post_bvPad bv   (BITS_PER_BYTE - (len bv))   RESULT)"

definition
	binPad :: "BinByte0 \<Rightarrow> BinByte"
where
	"binPad bv \<equiv> 
	\<comment>\<open>User defined body of binPad.\<close>
	(bvPad bv   (BITS_PER_BYTE - (len bv)))"

	
	
\<comment>\<open>VDM source: fold1[T]: ((@T * @T -> @T) * seq1 of (@T) +> @T)
	fold1(f, s) ==
(if ((len s) = 1)
then (hd s)
else let lens:nat1 = (len s) in f((fold1)[@T](f, (s(1, ... ,(lens div 2)))), (fold1)[@T](f, (s(((lens div 2) + 1), ... ,lens)))))
	measure (len s)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 203:5\<close>

\<comment>\<open>VDM source: pre_fold1[T]: ((@T * @T -> @T) * seq1 of (@T) +> bool)
	pre_fold1(f, s) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 203:5\<close>
definition
	pre_fold1 :: "('T \<Rightarrow> bool) \<Rightarrow> ('T \<Rightarrow> 'T \<Rightarrow> 'T) \<Rightarrow> 'T VDMSeq1 \<Rightarrow> bool"
where
	"pre_fold1 inv_T   f   s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_fold1` specification.\<close>
		((inv_Lambda inv_T (inv_Lambda inv_T inv_T)f)  \<and>  (inv_VDMSeq1' inv_T s))"


\<comment>\<open>VDM source: post_fold1[T]: ((@T * @T -> @T) * seq1 of (@T) * @T +> bool)
	post_fold1(f, s, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 203:5\<close>
definition
	post_fold1 :: "('T \<Rightarrow> bool) \<Rightarrow> ('T \<Rightarrow> 'T \<Rightarrow> 'T) \<Rightarrow> 'T VDMSeq1 \<Rightarrow> 'T \<Rightarrow> bool"
where
	"post_fold1 inv_T   f   s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_fold1` specification.\<close>
		((inv_Lambda inv_T (inv_Lambda inv_T inv_T)f)  \<and>  (inv_VDMSeq1' inv_T s)  \<and>  inv_T RESULT)"

fun
	fold1 :: "('T \<Rightarrow> bool) \<Rightarrow> ('T \<Rightarrow> 'T \<Rightarrow> 'T) \<Rightarrow> 'T VDMSeq1 \<Rightarrow> 'T"
where
	"fold1 inv_T   f   s = 
	\<comment>\<open>User defined body of fold1.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `fold1`.\<close>
	(if post_fold1 inv_T   f   s ((
		if (((len s) = (1::VDMNat1))) then
		((hd s))
		else
		((
		let 
(lens::VDMNat1) = (len s)
		in
			(if ((inv_VDMNat1 lens)) then
			(f (fold1 inv_T   f   (s {(1::VDMNat1)$$(lens vdmdiv (2::VDMNat1))}))   (fold1 inv_T   f   (s {((lens vdmdiv (2::VDMNat1)) + (1::VDMNat1))$$lens})))
		 else
			undefined
		)
		)))) then
			(
		if (((len s) = (1::VDMNat1))) then
		((hd s))
		else
		((
		let 
(lens::VDMNat1) = (len s)
		in
			(if ((inv_VDMNat1 lens)) then
			(f (fold1 inv_T   f   (s {(1::VDMNat1)$$(lens vdmdiv (2::VDMNat1))}))   (fold1 inv_T   f   (s {((lens vdmdiv (2::VDMNat1)) + (1::VDMNat1))$$lens})))
		 else
			undefined
		)
		)))
		 else
			undefined
		)
		"

	
	
\<comment>\<open>VDM source: min: (nat * nat +> nat)
	min(x, y) ==
(if (x < y)
then x
else y)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 219:5\<close>

\<comment>\<open>VDM source: pre_min: (nat * nat +> bool)
	pre_min(x, y) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 219:5\<close>
definition
	pre_min :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_min x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_min` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y))"


\<comment>\<open>VDM source: post_min: (nat * nat * nat +> bool)
	post_min(x, y, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 219:5\<close>
definition
	post_min :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_min x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_min` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMNat RESULT))"

definition
	min :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"min x   y \<equiv> 
	\<comment>\<open>User defined body of min.\<close>
	(
		if ((x < y)) then
		(x)
		else
		(y))"

	
	
\<comment>\<open>VDM source: minxs_nat: (seq1 of (nat) -> nat)
	minxs_nat(s) ==
(minxs)[nat](s, min)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 222:5\<close>

\<comment>\<open>VDM source: pre_minxs_nat: (seq1 of (nat) +> bool)
	pre_minxs_nat(s) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 222:5\<close>
definition
	pre_minxs_nat :: "VDMNat VDMSeq1 \<Rightarrow> bool"
where
	"pre_minxs_nat s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_minxs_nat` specification.\<close>
		((inv_VDMSeq1' (inv_VDMNat) s))"


\<comment>\<open>VDM source: post_minxs_nat: (seq1 of (nat) * nat +> bool)
	post_minxs_nat(s, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 222:5\<close>
definition
	post_minxs_nat :: "VDMNat VDMSeq1 \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_minxs_nat s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_minxs_nat` specification.\<close>
		((inv_VDMSeq1' (inv_VDMNat) s)  \<and>  (inv_VDMNat RESULT))"

definition
	minxs_nat :: "VDMNat VDMSeq1 \<Rightarrow> VDMNat"
where
	"minxs_nat s \<equiv> 
	\<comment>\<open>User defined body of minxs_nat.\<close>
	(minxs (inv_VDMNat)   s   min)"

	
	
\<comment>\<open>VDM source: minxs[T]: (seq1 of (@T) * (@T * @T -> @T) -> @T)
	minxs(s, lt_ord) ==
(fold1)[@T](lt_ord, s)
	post ((RESULT in set (elems s)) and (forall e in set (elems s) & ((lt_ord(RESULT, e) = RESULT) or (RESULT = e))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 226:5\<close>

\<comment>\<open>VDM source: pre_minxs[T]: (seq1 of (@T) * (@T * @T -> @T) +> bool)
	pre_minxs(s, lt_ord) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 226:5\<close>
definition
	pre_minxs :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq1 \<Rightarrow> ('T \<Rightarrow> 'T \<Rightarrow> 'T) \<Rightarrow> bool"
where
	"pre_minxs inv_T   s   lt_ord \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_minxs` specification.\<close>
		((inv_VDMSeq1' inv_T s)  \<and>  (inv_Lambda inv_T (inv_Lambda inv_T inv_T)lt_ord))"


\<comment>\<open>VDM source: post_minxs[T]: (seq1 of (@T) * (@T * @T -> @T) * @T +> bool)
	post_minxs(s, lt_ord, RESULT) ==
((RESULT in set (elems s)) and (forall e in set (elems s) & ((lt_ord(RESULT, e) = RESULT) or (RESULT = e))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 230:27\<close>
definition
	post_minxs :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq1 \<Rightarrow> ('T \<Rightarrow> 'T \<Rightarrow> 'T) \<Rightarrow> 'T \<Rightarrow> bool"
where
	"post_minxs inv_T   s   lt_ord   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_minxs` specification.\<close>
		((inv_VDMSeq1' inv_T s)  \<and>  (inv_Lambda inv_T (inv_Lambda inv_T inv_T)lt_ord)  \<and>  inv_T RESULT)  \<and> 
		\<comment>\<open>User defined body of post_minxs.\<close>
		\<comment>\<open>Implicit check on generic type invariant for `post_minxs`.\<close>
		(if post_post_minxs inv_T   s   lt_ord   RESULT (((RESULT \<in> (elems s)) \<and> (\<forall> e \<in> (elems s)  . (((lt_ord RESULT   e) = RESULT) \<or> (RESULT = e))))) then	((RESULT \<in> (elems s)) \<and> (\<forall> e \<in> (elems s)  . (((lt_ord RESULT   e) = RESULT) \<or> (RESULT = e)))) else	undefined)"

definition
	minxs :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq1 \<Rightarrow> ('T \<Rightarrow> 'T \<Rightarrow> 'T) \<Rightarrow> 'T"
where
	"minxs inv_T   s   lt_ord \<equiv> 
	\<comment>\<open>User defined body of minxs.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `minxs`.\<close>
	(if post_minxs inv_T   s   lt_ord ((fold1 inv_T   lt_ord   s)) then	(fold1 inv_T   lt_ord   s) else	undefined)"

	
	
\<comment>\<open>VDM source: firstBitIndex: (BitVector -> nat)
	firstBitIndex(bv) ==
let s:seq of (nat1) = [i | i in set (inds bv) & bv(i)] in (if (s = [])
then 0
else minxs_nat(s))
	post (if (bv = [])
then (RESULT = 0)
else ((RESULT <= (len bv)) and (((RESULT <> 0) => (bv(RESULT) and (forall i in set (inds bv) & ((i < RESULT) => (not bv(i)))))) and ((RESULT = 0) => (not (exists [e in set (elems bv)] & e))))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 232:5\<close>

\<comment>\<open>VDM source: pre_firstBitIndex: (BitVector +> bool)
	pre_firstBitIndex(bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 232:5\<close>
definition
	pre_firstBitIndex :: "BitVector \<Rightarrow> bool"
where
	"pre_firstBitIndex bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_firstBitIndex` specification.\<close>
		((inv_BitVector bv))"


\<comment>\<open>VDM source: post_firstBitIndex: (BitVector * nat +> bool)
	post_firstBitIndex(bv, RESULT) ==
(if (bv = [])
then (RESULT = 0)
else ((RESULT <= (len bv)) and (((RESULT <> 0) => (bv(RESULT) and (forall i in set (inds bv) & ((i < RESULT) => (not bv(i)))))) and ((RESULT = 0) => (not (exists [e in set (elems bv)] & e))))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 238:9\<close>
definition
	post_firstBitIndex :: "BitVector \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_firstBitIndex bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_firstBitIndex` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_firstBitIndex.\<close>
		(
		if ((bv = [])) then
		((RESULT = (0::VDMNat)))
		else
		(((RESULT \<le> (len bv)) \<and> (((RESULT \<noteq> (0::VDMNat)) \<longrightarrow> ((bv RESULT) \<and> (\<forall> i \<in> (inds bv)  . ((i < RESULT) \<longrightarrow> (\<not> (bv i)))))) \<and> ((RESULT = (0::VDMNat)) \<longrightarrow> (\<not> (\<exists> e \<in> (elems bv)  . e)))))))"

definition
	firstBitIndex :: "BitVector \<Rightarrow> VDMNat"
where
	"firstBitIndex bv \<equiv> 
	\<comment>\<open>User defined body of firstBitIndex.\<close>
	(
		let 
(s::VDMNat1 VDMSeq) = [ i . i \<leftarrow> sorted_list_of_set ((inds bv)) , ((i \<in>(inds bv))) , (bv i) ]
	\<comment>\<open>`Set bind `(i \<in> (inds bv))` in sequence comprehension requires its Isabelle type to instantiate class linorder.`   This can be a problem if the target type of @{term \<open>(inds bv)\<close>}   has a VDM ord_ predicate.\<close> 
		in
			(if ((inv_VDMSeq' (inv_VDMNat1) s)) then
			(
		if ((s = [])) then
		((0::VDMNat))
		else
		((minxs_nat s)))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: firstBit: (BitVector -> nat)
	firstBit(bv) ==
firstBitIndex((reverse bv))
	post post_firstBitIndex((reverse bv), RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 250:5\<close>

\<comment>\<open>VDM source: pre_firstBit: (BitVector +> bool)
	pre_firstBit(bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 250:5\<close>
definition
	pre_firstBit :: "BitVector \<Rightarrow> bool"
where
	"pre_firstBit bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_firstBit` specification.\<close>
		((inv_BitVector bv))"


\<comment>\<open>VDM source: post_firstBit: (BitVector * nat +> bool)
	post_firstBit(bv, RESULT) ==
post_firstBitIndex((reverse bv), RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 253:9\<close>
definition
	post_firstBit :: "BitVector \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_firstBit bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_firstBit` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_firstBit.\<close>
		(post_firstBitIndex (vdm_reverse bv)   RESULT)"

definition
	firstBit :: "BitVector \<Rightarrow> VDMNat"
where
	"firstBit bv \<equiv> 
	\<comment>\<open>User defined body of firstBit.\<close>
	(firstBitIndex (vdm_reverse bv))"

	
	
\<comment>\<open>VDM source: firstByteIndex: (BinByte0 -> Bit)
	firstByteIndex(bv) ==
firstBitIndex(binPad(bv))
	post post_firstBitIndex(binPad(bv), RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 255:5\<close>

\<comment>\<open>VDM source: pre_firstByteIndex: (BinByte0 +> bool)
	pre_firstByteIndex(bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 255:5\<close>
definition
	pre_firstByteIndex :: "BinByte0 \<Rightarrow> bool"
where
	"pre_firstByteIndex bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_firstByteIndex` specification.\<close>
		((inv_BinByte0 bv))"


\<comment>\<open>VDM source: post_firstByteIndex: (BinByte0 * Bit +> bool)
	post_firstByteIndex(bv, RESULT) ==
post_firstBitIndex(binPad(bv), RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 258:9\<close>
definition
	post_firstByteIndex :: "BinByte0 \<Rightarrow> Bit \<Rightarrow> bool"
where
	"post_firstByteIndex bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_firstByteIndex` specification.\<close>
		((inv_BinByte0 bv)  \<and>  (inv_Bit RESULT))  \<and> 
		\<comment>\<open>User defined body of post_firstByteIndex.\<close>
		(post_firstBitIndex (binPad bv)   RESULT)"

definition
	firstByteIndex :: "BinByte0 \<Rightarrow> Bit"
where
	"firstByteIndex bv \<equiv> 
	\<comment>\<open>User defined body of firstByteIndex.\<close>
	(firstBitIndex (binPad bv))"

	
	
\<comment>\<open>VDM source: firstByteBit: (BinByte0 -> Bit)
	firstByteBit(bv) ==
firstBit(binPad(bv))
	post post_firstBit(binPad(bv), RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 260:5\<close>

\<comment>\<open>VDM source: pre_firstByteBit: (BinByte0 +> bool)
	pre_firstByteBit(bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 260:5\<close>
definition
	pre_firstByteBit :: "BinByte0 \<Rightarrow> bool"
where
	"pre_firstByteBit bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_firstByteBit` specification.\<close>
		((inv_BinByte0 bv))"


\<comment>\<open>VDM source: post_firstByteBit: (BinByte0 * Bit +> bool)
	post_firstByteBit(bv, RESULT) ==
post_firstBit(binPad(bv), RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 263:9\<close>
definition
	post_firstByteBit :: "BinByte0 \<Rightarrow> Bit \<Rightarrow> bool"
where
	"post_firstByteBit bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_firstByteBit` specification.\<close>
		((inv_BinByte0 bv)  \<and>  (inv_Bit RESULT))  \<and> 
		\<comment>\<open>User defined body of post_firstByteBit.\<close>
		(post_firstBit (binPad bv)   RESULT)"

definition
	firstByteBit :: "BinByte0 \<Rightarrow> Bit"
where
	"firstByteBit bv \<equiv> 
	\<comment>\<open>User defined body of firstByteBit.\<close>
	(firstBit (binPad bv))"

	
	
\<comment>\<open>VDM source: removeLeadingZeroedBits: (BitVector -> BitVector)
	removeLeadingZeroedBits(bv) ==
(if ((bv = []) or (hd bv))
then bv
else let fi:nat = firstBitIndex(bv) in (if (fi = 0)
then []
else (bv(fi, ... ,(len bv)))))
	post ((len RESULT) <= (len bv))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 265:5\<close>

\<comment>\<open>VDM source: pre_removeLeadingZeroedBits: (BitVector +> bool)
	pre_removeLeadingZeroedBits(bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 265:5\<close>
definition
	pre_removeLeadingZeroedBits :: "BitVector \<Rightarrow> bool"
where
	"pre_removeLeadingZeroedBits bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_removeLeadingZeroedBits` specification.\<close>
		((inv_BitVector bv))"


\<comment>\<open>VDM source: post_removeLeadingZeroedBits: (BitVector * BitVector +> bool)
	post_removeLeadingZeroedBits(bv, RESULT) ==
((len RESULT) <= (len bv))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 278:20\<close>
definition
	post_removeLeadingZeroedBits :: "BitVector \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_removeLeadingZeroedBits bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_removeLeadingZeroedBits` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_removeLeadingZeroedBits.\<close>
		((len RESULT) \<le> (len bv))"

definition
	removeLeadingZeroedBits :: "BitVector \<Rightarrow> BitVector"
where
	"removeLeadingZeroedBits bv \<equiv> 
	\<comment>\<open>User defined body of removeLeadingZeroedBits.\<close>
	(
		if (((bv = []) \<or> (hd bv))) then
		(bv)
		else
		((
		let 
(fi::VDMNat) = (firstBitIndex bv)
		in
			(if ((inv_VDMNat fi)) then
			(
		if ((fi = (0::VDMNat))) then
		([])
		else
		((bv {fi$$(len bv)})))
		 else
			undefined
		)
		)))"

	
	
\<comment>\<open>VDM source: max: (nat * nat -> nat)
	max(x, y) ==
(if (x >= y)
then x
else y)
	post ((RESULT >= x) and (RESULT >= y))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 280:5\<close>

\<comment>\<open>VDM source: pre_max: (nat * nat +> bool)
	pre_max(x, y) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 280:5\<close>
definition
	pre_max :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_max x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_max` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y))"


\<comment>\<open>VDM source: post_max: (nat * nat * nat +> bool)
	post_max(x, y, RESULT) ==
((RESULT >= x) and (RESULT >= y))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 283:21\<close>
definition
	post_max :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_max x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_max` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_max.\<close>
		((RESULT \<ge> x) \<and> (RESULT \<ge> y))"

definition
	max :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"max x   y \<equiv> 
	\<comment>\<open>User defined body of max.\<close>
	(
		if ((x \<ge> y)) then
		(x)
		else
		(y))"

	
	
\<comment>\<open>VDM source: bvOp: (BitVector * BitVector * BitVectorOp -> BitVector)
	bvOp(lhs, rhs, op) ==
let pad_size:nat = max((len lhs), (len rhs)), l:BitVector = bvPad(lhs, (pad_size - (len lhs))), r:BitVector = bvPad(rhs, (pad_size - (len rhs))) in [(cases op :
<BAnd> -> (l(i) and r(i)),
<BOr> -> (l(i) or r(i)),
<BXor> -> ((l(i) and (not r(i))) or ((not l(i)) and r(i)))
end) | i in set ((inds l) inter (inds r)) & ((len l) = (len r))]
	post ((len RESULT) = max((len lhs), (len rhs)))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 285:5\<close>

\<comment>\<open>VDM source: pre_bvOp: (BitVector * BitVector * BitVectorOp +> bool)
	pre_bvOp(lhs, rhs, op) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 285:5\<close>
definition
	pre_bvOp :: "BitVector \<Rightarrow> BitVector \<Rightarrow> BitVectorOp \<Rightarrow> bool"
where
	"pre_bvOp lhs   rhs   op \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bvOp` specification.\<close>
		((inv_BitVector lhs)  \<and>  (inv_BitVector rhs)  \<and>  (inv_BitVectorOp op))"


\<comment>\<open>VDM source: post_bvOp: (BitVector * BitVector * BitVectorOp * BitVector +> bool)
	post_bvOp(lhs, rhs, op, RESULT) ==
((len RESULT) = max((len lhs), (len rhs)))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 302:20\<close>
definition
	post_bvOp :: "BitVector \<Rightarrow> BitVector \<Rightarrow> BitVectorOp \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_bvOp lhs   rhs   op   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bvOp` specification.\<close>
		((inv_BitVector lhs)  \<and>  (inv_BitVector rhs)  \<and>  (inv_BitVectorOp op)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bvOp.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		())"

definition
	bvOp :: "BitVector \<Rightarrow> BitVector \<Rightarrow> BitVectorOp \<Rightarrow> BitVector"
where
	"bvOp lhs   rhs   op \<equiv> 
	\<comment>\<open>User defined body of bvOp.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	())"

	
	
\<comment>\<open>VDM source: bvAnd: (BitVector * BitVector -> BitVector)
	bvAnd(lhs, rhs) ==
bvOp(lhs, rhs, <BAnd>)
	post post_bvOp(lhs, rhs, <BAnd>, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 306:5\<close>

\<comment>\<open>VDM source: pre_bvAnd: (BitVector * BitVector +> bool)
	pre_bvAnd(lhs, rhs) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 306:5\<close>
definition
	pre_bvAnd :: "BitVector \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"pre_bvAnd lhs   rhs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bvAnd` specification.\<close>
		((inv_BitVector lhs)  \<and>  (inv_BitVector rhs))"


\<comment>\<open>VDM source: post_bvAnd: (BitVector * BitVector * BitVector +> bool)
	post_bvAnd(lhs, rhs, RESULT) ==
post_bvOp(lhs, rhs, <BAnd>, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 309:9\<close>
definition
	post_bvAnd :: "BitVector \<Rightarrow> BitVector \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_bvAnd lhs   rhs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bvAnd` specification.\<close>
		((inv_BitVector lhs)  \<and>  (inv_BitVector rhs)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bvAnd.\<close>
		(post_bvOp lhs   rhs   BitVectorOp.U_BAnd    RESULT)"

definition
	bvAnd :: "BitVector \<Rightarrow> BitVector \<Rightarrow> BitVector"
where
	"bvAnd lhs   rhs \<equiv> 
	\<comment>\<open>User defined body of bvAnd.\<close>
	(bvOp lhs   rhs   BitVectorOp.U_BAnd )"

	
	
\<comment>\<open>VDM source: bvOr: (BitVector * BitVector -> BitVector)
	bvOr(lhs, rhs) ==
bvOp(lhs, rhs, <BOr>)
	post post_bvOp(lhs, rhs, <BOr>, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 311:5\<close>

\<comment>\<open>VDM source: pre_bvOr: (BitVector * BitVector +> bool)
	pre_bvOr(lhs, rhs) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 311:5\<close>
definition
	pre_bvOr :: "BitVector \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"pre_bvOr lhs   rhs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bvOr` specification.\<close>
		((inv_BitVector lhs)  \<and>  (inv_BitVector rhs))"


\<comment>\<open>VDM source: post_bvOr: (BitVector * BitVector * BitVector +> bool)
	post_bvOr(lhs, rhs, RESULT) ==
post_bvOp(lhs, rhs, <BOr>, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 314:9\<close>
definition
	post_bvOr :: "BitVector \<Rightarrow> BitVector \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_bvOr lhs   rhs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bvOr` specification.\<close>
		((inv_BitVector lhs)  \<and>  (inv_BitVector rhs)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bvOr.\<close>
		(post_bvOp lhs   rhs   BitVectorOp.U_BOr    RESULT)"

definition
	bvOr :: "BitVector \<Rightarrow> BitVector \<Rightarrow> BitVector"
where
	"bvOr lhs   rhs \<equiv> 
	\<comment>\<open>User defined body of bvOr.\<close>
	(bvOp lhs   rhs   BitVectorOp.U_BOr )"

	
	
\<comment>\<open>VDM source: bvXor: (BitVector * BitVector -> BitVector)
	bvXor(lhs, rhs) ==
bvOp(lhs, rhs, <BXor>)
	post post_bvOp(lhs, rhs, <BXor>, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 316:5\<close>

\<comment>\<open>VDM source: pre_bvXor: (BitVector * BitVector +> bool)
	pre_bvXor(lhs, rhs) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 316:5\<close>
definition
	pre_bvXor :: "BitVector \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"pre_bvXor lhs   rhs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bvXor` specification.\<close>
		((inv_BitVector lhs)  \<and>  (inv_BitVector rhs))"


\<comment>\<open>VDM source: post_bvXor: (BitVector * BitVector * BitVector +> bool)
	post_bvXor(lhs, rhs, RESULT) ==
post_bvOp(lhs, rhs, <BXor>, RESULT)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 319:9\<close>
definition
	post_bvXor :: "BitVector \<Rightarrow> BitVector \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_bvXor lhs   rhs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bvXor` specification.\<close>
		((inv_BitVector lhs)  \<and>  (inv_BitVector rhs)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bvXor.\<close>
		(post_bvOp lhs   rhs   BitVectorOp.U_BXor    RESULT)"

definition
	bvXor :: "BitVector \<Rightarrow> BitVector \<Rightarrow> BitVector"
where
	"bvXor lhs   rhs \<equiv> 
	\<comment>\<open>User defined body of bvXor.\<close>
	(bvOp lhs   rhs   BitVectorOp.U_BXor )"

	
	
\<comment>\<open>VDM source: bvNot: (BitVector -> BitVector)
	bvNot(bv) ==
[(not bv(i)) | i in set (inds bv)]
	post (((len RESULT) = (len bv)) and (forall i in set (inds bv) & (not (bv(i) = RESULT(i)))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 321:5\<close>

\<comment>\<open>VDM source: pre_bvNot: (BitVector +> bool)
	pre_bvNot(bv) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 321:5\<close>
definition
	pre_bvNot :: "BitVector \<Rightarrow> bool"
where
	"pre_bvNot bv \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bvNot` specification.\<close>
		((inv_BitVector bv))"


\<comment>\<open>VDM source: post_bvNot: (BitVector * BitVector +> bool)
	post_bvNot(bv, RESULT) ==
(((len RESULT) = (len bv)) and (forall i in set (inds bv) & (not (bv(i) = RESULT(i)))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 325:9\<close>
definition
	post_bvNot :: "BitVector \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_bvNot bv   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bvNot` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bvNot.\<close>
		(((len RESULT) = (len bv)) \<and> (\<forall> i \<in> (inds bv)  . (\<not> ((bv i) = (RESULT i)))))"

definition
	bvNot :: "BitVector \<Rightarrow> BitVector"
where
	"bvNot bv \<equiv> 
	\<comment>\<open>User defined body of bvNot.\<close>
	[ (\<not> (bv i)) . i \<leftarrow> sorted_list_of_set ((inds bv)) , ((i \<in>(inds bv))) ]
	\<comment>\<open>`Set bind `(i \<in> (inds bv))` in sequence comprehension requires its Isabelle type to instantiate class linorder.`   This can be a problem if the target type of @{term \<open>(inds bv)\<close>}   has a VDM ord_ predicate.\<close> "

	
	
\<comment>\<open>VDM source: natShl: (nat * nat1 -> nat)
	natShl(x, y) ==
(x * npow(BIN_BASE, y))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 329:5\<close>

\<comment>\<open>VDM source: pre_natShl: (nat * nat1 +> bool)
	pre_natShl(x, y) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 329:5\<close>
definition
	pre_natShl :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_natShl x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_natShl` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))"


\<comment>\<open>VDM source: post_natShl: (nat * nat1 * nat +> bool)
	post_natShl(x, y, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 329:5\<close>
definition
	post_natShl :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_natShl x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_natShl` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat RESULT))"

definition
	natShl :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat"
where
	"natShl x   y \<equiv> 
	\<comment>\<open>User defined body of natShl.\<close>
	(x * (npow BIN_BASE   y))"

	
	
\<comment>\<open>VDM source: natShr: (nat * nat1 -> nat)
	natShr(x, y) ==
(x div npow(BIN_BASE, y))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 332:5\<close>

\<comment>\<open>VDM source: pre_natShr: (nat * nat1 +> bool)
	pre_natShr(x, y) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 332:5\<close>
definition
	pre_natShr :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_natShr x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_natShr` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))"


\<comment>\<open>VDM source: post_natShr: (nat * nat1 * nat +> bool)
	post_natShr(x, y, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 332:5\<close>
definition
	post_natShr :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_natShr x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_natShr` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat RESULT))"

definition
	natShr :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat"
where
	"natShr x   y \<equiv> 
	\<comment>\<open>User defined body of natShr.\<close>
	(x vdmdiv (npow BIN_BASE   y))"

	
	
\<comment>\<open>VDM source: bvShl: (BitVector * nat1 -> BitVector)
	bvShl(bv, s) ==
(bv ^ zeroed(s))
	post (((len RESULT) = ((len bv) + s)) and (removeLeadingZeroedBits(RESULT) = removeLeadingZeroedBits(nat2bv(natShl(bv2nat(bv), s)))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 336:5\<close>

\<comment>\<open>VDM source: pre_bvShl: (BitVector * nat1 +> bool)
	pre_bvShl(bv, s) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 336:5\<close>
definition
	pre_bvShl :: "BitVector \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_bvShl bv   s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bvShl` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat1 s))"


\<comment>\<open>VDM source: post_bvShl: (BitVector * nat1 * BitVector +> bool)
	post_bvShl(bv, s, RESULT) ==
(((len RESULT) = ((len bv) + s)) and (removeLeadingZeroedBits(RESULT) = removeLeadingZeroedBits(nat2bv(natShl(bv2nat(bv), s)))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 341:9\<close>
definition
	post_bvShl :: "BitVector \<Rightarrow> VDMNat1 \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_bvShl bv   s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bvShl` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat1 s)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bvShl.\<close>
		(((len RESULT) = ((len bv) + s)) \<and> ((removeLeadingZeroedBits RESULT) = (removeLeadingZeroedBits (nat2bv (natShl (bv2nat bv)   s)))))"

definition
	bvShl :: "BitVector \<Rightarrow> VDMNat1 \<Rightarrow> BitVector"
where
	"bvShl bv   s \<equiv> 
	\<comment>\<open>User defined body of bvShl.\<close>
	(bv @ (zeroed s))"

	
	
\<comment>\<open>VDM source: bvShr: (BitVector * nat1 -> BitVector)
	bvShr(bv, s) ==
let shift_amount:int = ((len bv) - s) in (if (shift_amount <= 0)
then zeroed((len bv))
else bvPad((bv(1, ... ,shift_amount)), s))
	post (((len RESULT) = (len bv)) and (removeLeadingZeroedBits(RESULT) = removeLeadingZeroedBits(nat2bv(natShr(bv2nat(bv), s)))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 345:5\<close>

\<comment>\<open>VDM source: pre_bvShr: (BitVector * nat1 +> bool)
	pre_bvShr(bv, s) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 345:5\<close>
definition
	pre_bvShr :: "BitVector \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_bvShr bv   s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_bvShr` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat1 s))"


\<comment>\<open>VDM source: post_bvShr: (BitVector * nat1 * BitVector +> bool)
	post_bvShr(bv, s, RESULT) ==
(((len RESULT) = (len bv)) and (removeLeadingZeroedBits(RESULT) = removeLeadingZeroedBits(nat2bv(natShr(bv2nat(bv), s)))))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 355:9\<close>
definition
	post_bvShr :: "BitVector \<Rightarrow> VDMNat1 \<Rightarrow> BitVector \<Rightarrow> bool"
where
	"post_bvShr bv   s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_bvShr` specification.\<close>
		((inv_BitVector bv)  \<and>  (inv_VDMNat1 s)  \<and>  (inv_BitVector RESULT))  \<and> 
		\<comment>\<open>User defined body of post_bvShr.\<close>
		(((len RESULT) = (len bv)) \<and> ((removeLeadingZeroedBits RESULT) = (removeLeadingZeroedBits (nat2bv (natShr (bv2nat bv)   s)))))"

definition
	bvShr :: "BitVector \<Rightarrow> VDMNat1 \<Rightarrow> BitVector"
where
	"bvShr bv   s \<equiv> 
	\<comment>\<open>User defined body of bvShr.\<close>
	(
		let 
(shift_amount::VDMInt) = ((len bv) - s)
		in
			(if ((inv_VDMInt shift_amount)) then
			(
		if ((shift_amount \<le> (0::VDMNat))) then
		((zeroed (len bv)))
		else
		((bvPad (bv {(1::VDMNat1)$$shift_amount})   s)))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: HEX_BASE:nat1 = 16\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 363:5\<close>
abbreviation
	HEX_BASE :: "VDMNat1"
where
	"HEX_BASE \<equiv> (16::VDMNat1)"

	definition
	inv_HEX_BASE :: "\<bool>"
where
	"inv_HEX_BASE  \<equiv> (inv_VDMNat1 HEX_BASE)"

	
	
	
\<comment>\<open>VDM source: HEX_TOUPPER:inmap (char) to (char) = {a |-> A, b |-> B, c |-> C, d |-> D, e |-> E, f |-> F}\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 364:5\<close>
abbreviation
	HEX_TOUPPER :: "(VDMChar \<rightharpoonup> VDMChar)"
where
	"HEX_TOUPPER \<equiv> [(CHR ''a''::VDMChar)\<mapsto>(CHR ''A''::VDMChar),(CHR ''b''::VDMChar)\<mapsto>(CHR ''B''::VDMChar),(CHR ''c''::VDMChar)\<mapsto>(CHR ''C''::VDMChar),(CHR ''d''::VDMChar)\<mapsto>(CHR ''D''::VDMChar),(CHR ''e''::VDMChar)\<mapsto>(CHR ''E''::VDMChar),(CHR ''f''::VDMChar)\<mapsto>(CHR ''F''::VDMChar)]"

	definition
	inv_HEX_TOUPPER :: "\<bool>"
where
	"inv_HEX_TOUPPER  \<equiv> (inv_Inmap (inv_VDMChar) (inv_VDMChar) HEX_TOUPPER)"

	
	
	
\<comment>\<open>VDM source: NAT_HEX_LETTER:inmap (nat) to (char) = {10 |-> A, 11 |-> B, 12 |-> C, 13 |-> D, 14 |-> E, 15 |-> F}\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 365:5\<close>
abbreviation
	NAT_HEX_LETTER :: "(VDMNat \<rightharpoonup> VDMChar)"
where
	"NAT_HEX_LETTER \<equiv> [(10::VDMNat1)\<mapsto>(CHR ''A''::VDMChar),(11::VDMNat1)\<mapsto>(CHR ''B''::VDMChar),(12::VDMNat1)\<mapsto>(CHR ''C''::VDMChar),(13::VDMNat1)\<mapsto>(CHR ''D''::VDMChar),(14::VDMNat1)\<mapsto>(CHR ''E''::VDMChar),(15::VDMNat1)\<mapsto>(CHR ''F''::VDMChar)]"

	definition
	inv_NAT_HEX_LETTER :: "\<bool>"
where
	"inv_NAT_HEX_LETTER  \<equiv> (inv_Inmap (inv_VDMNat) (inv_VDMChar) NAT_HEX_LETTER)"

	
	
	
\<comment>\<open>VDM source: HEX_INVARIANT:bool = ((rng HEX_TOUPPER) = (rng NAT_HEX_LETTER))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 366:5\<close>
abbreviation
	HEX_INVARIANT :: "bool"
where
	"HEX_INVARIANT \<equiv> ((rng HEX_TOUPPER) = (rng NAT_HEX_LETTER))"

	definition
	inv_HEX_INVARIANT :: "\<bool>"
where
	"inv_HEX_INVARIANT  \<equiv> (inv_bool HEX_INVARIANT)"

	
	
	
\<comment>\<open>VDM source: HEX_BIN_OCTET_LEN:nat1 = 2\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 369:5\<close>
abbreviation
	HEX_BIN_OCTET_LEN :: "VDMNat1"
where
	"HEX_BIN_OCTET_LEN \<equiv> (2::VDMNat1)"

	definition
	inv_HEX_BIN_OCTET_LEN :: "\<bool>"
where
	"inv_HEX_BIN_OCTET_LEN  \<equiv> (inv_VDMNat1 HEX_BIN_OCTET_LEN)"

	
	
	
\<comment>\<open>VDM source: NUM_CHARS:set1 of (char) = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 371:5\<close>
abbreviation
	NUM_CHARS :: "VDMChar VDMSet1"
where
	"NUM_CHARS \<equiv> {(CHR ''0''::VDMChar) , (CHR ''1''::VDMChar) , (CHR ''2''::VDMChar) , (CHR ''3''::VDMChar) , (CHR ''4''::VDMChar) , (CHR ''5''::VDMChar) , (CHR ''6''::VDMChar) , (CHR ''7''::VDMChar) , (CHR ''8''::VDMChar) , (CHR ''9''::VDMChar)}"

	definition
	inv_NUM_CHARS :: "\<bool>"
where
	"inv_NUM_CHARS  \<equiv> (inv_VDMSet1' (inv_VDMChar) NUM_CHARS)"

	
	
	
\<comment>\<open>VDM source: HEX_CHARS:set1 of (char) = ((NUM_CHARS union (dom HEX_TOUPPER)) union (rng HEX_TOUPPER))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 372:5\<close>
abbreviation
	HEX_CHARS :: "VDMChar VDMSet1"
where
	"HEX_CHARS \<equiv> ((NUM_CHARS \<union> (dom HEX_TOUPPER)) \<union> (rng HEX_TOUPPER))"

	definition
	inv_HEX_CHARS :: "\<bool>"
where
	"inv_HEX_CHARS  \<equiv> (inv_VDMSet1' (inv_VDMChar) HEX_CHARS)"

	
	
	
\<comment>\<open>VDM source: HexDigit = nat
	inv digit == (digit < HEX_BASE)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 376:5\<close>
type_synonym HexDigit = "VDMNat"
	

\<comment>\<open>VDM source: inv_HexDigit: (nat +> bool)
	inv_HexDigit(digit) ==
(digit < HEX_BASE)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 377:9\<close>
definition
	inv_HexDigit :: "HexDigit \<Rightarrow> bool"
where
	"inv_HexDigit digit \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_HexDigit` specification.\<close>
		(((inv_VDMNat digit)))  \<and> 
		\<comment>\<open>User defined body of inv_HexDigit.\<close>
		(digit < HEX_BASE)"
 

	
	
\<comment>\<open>VDM source: HexString = String
	inv hs == ((elems hs) subset HEX_CHARS)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 380:5\<close>
type_synonym HexString = "String"
	

\<comment>\<open>VDM source: inv_HexString: (String +> bool)
	inv_HexString(hs) ==
((elems hs) subset HEX_CHARS)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 381:9\<close>
definition
	inv_HexString :: "HexString \<Rightarrow> bool"
where
	"inv_HexString hs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_HexString` specification.\<close>
		((inv_String hs))  \<and> 
		\<comment>\<open>User defined body of inv_HexString.\<close>
		((elems hs) \<subseteq> HEX_CHARS)"
 

	
	
\<comment>\<open>VDM source: CannonicalHexString = HexString
	inv chs == (((elems chs) inter (dom HEX_TOUPPER)) = {})\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 384:5\<close>
type_synonym CannonicalHexString = "HexString"
	

\<comment>\<open>VDM source: inv_CannonicalHexString: (HexString +> bool)
	inv_CannonicalHexString(chs) ==
(((elems chs) inter (dom HEX_TOUPPER)) = {})\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 385:9\<close>
definition
	inv_CannonicalHexString :: "CannonicalHexString \<Rightarrow> bool"
where
	"inv_CannonicalHexString chs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_CannonicalHexString` specification.\<close>
		((inv_HexString chs))  \<and> 
		\<comment>\<open>User defined body of inv_CannonicalHexString.\<close>
		(((elems chs) \<inter> (dom HEX_TOUPPER)) = {})"

		 

	
	
\<comment>\<open>VDM source: HexStringExact2 = HexString
	inv s == ((len s) = 2)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 387:5\<close>
type_synonym HexStringExact2 = "HexString"
	

\<comment>\<open>VDM source: inv_HexStringExact2: (HexString +> bool)
	inv_HexStringExact2(s) ==
((len s) = 2)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 388:9\<close>
definition
	inv_HexStringExact2 :: "HexStringExact2 \<Rightarrow> bool"
where
	"inv_HexStringExact2 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_HexStringExact2` specification.\<close>
		((inv_HexString s))  \<and> 
		\<comment>\<open>User defined body of inv_HexStringExact2.\<close>
		((len s) = (2::VDMNat1))"

		 

	
	
\<comment>\<open>VDM source: UniqueHexStringList1 = seq1 of (HexString)
	inv list == (injective)[HexString](list)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 390:5\<close>
type_synonym UniqueHexStringList1 = "HexString VDMSeq1"
	

\<comment>\<open>VDM source: inv_UniqueHexStringList1: (seq1 of (HexString) +> bool)
	inv_UniqueHexStringList1(list) ==
(injective)[HexString](list)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 391:9\<close>
definition
	inv_UniqueHexStringList1 :: "UniqueHexStringList1 \<Rightarrow> bool"
where
	"inv_UniqueHexStringList1 list \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_UniqueHexStringList1` specification.\<close>
		(((inv_VDMSeq1' (inv_HexString) list)))  \<and> 
		\<comment>\<open>User defined body of inv_UniqueHexStringList1.\<close>
		(injective (inv_String)   list)"

		 

	
	
\<comment>\<open>VDM source: hexSizeBytes: (HexString -> nat)
	hexSizeBytes(hs) ==
let hs_clean:HexString = removeLeadingZeros(hs) in (((len hs_clean) div HEX_BIN_OCTET_LEN) + ((len hs_clean) mod HEX_BIN_OCTET_LEN))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 400:5\<close>

\<comment>\<open>VDM source: pre_hexSizeBytes: (HexString +> bool)
	pre_hexSizeBytes(hs) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 400:5\<close>
definition
	pre_hexSizeBytes :: "HexString \<Rightarrow> bool"
where
	"pre_hexSizeBytes hs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_hexSizeBytes` specification.\<close>
		((inv_HexString hs))"


\<comment>\<open>VDM source: post_hexSizeBytes: (HexString * nat +> bool)
	post_hexSizeBytes(hs, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 400:5\<close>
definition
	post_hexSizeBytes :: "HexString \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_hexSizeBytes hs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_hexSizeBytes` specification.\<close>
		((inv_HexString hs)  \<and>  (inv_VDMNat RESULT))"

definition
	hexSizeBytes :: "HexString \<Rightarrow> VDMNat"
where
	"hexSizeBytes hs \<equiv> 
	\<comment>\<open>User defined body of hexSizeBytes.\<close>
	(
		let 
(hs_clean::HexString) = (removeLeadingZeros hs)
		in
			(if ((inv_String)hs_clean) then
			(((len hs_clean) vdmdiv HEX_BIN_OCTET_LEN) + ((len hs_clean) vdmmod HEX_BIN_OCTET_LEN))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: removeLeadingZeros: (HexString -> HexString)
	removeLeadingZeros(hs) ==
nat2hex(hex2nat(hs))
	post (hex2nat(hs) = hex2nat(RESULT))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 408:5\<close>

\<comment>\<open>VDM source: pre_removeLeadingZeros: (HexString +> bool)
	pre_removeLeadingZeros(hs) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 408:5\<close>
definition
	pre_removeLeadingZeros :: "HexString \<Rightarrow> bool"
where
	"pre_removeLeadingZeros hs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_removeLeadingZeros` specification.\<close>
		((inv_HexString hs))"


\<comment>\<open>VDM source: post_removeLeadingZeros: (HexString * HexString +> bool)
	post_removeLeadingZeros(hs, RESULT) ==
(hex2nat(hs) = hex2nat(RESULT))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 412:21\<close>
definition
	post_removeLeadingZeros :: "HexString \<Rightarrow> HexString \<Rightarrow> bool"
where
	"post_removeLeadingZeros hs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_removeLeadingZeros` specification.\<close>
		((inv_HexString hs)  \<and>  (inv_HexString RESULT))  \<and> 
		\<comment>\<open>User defined body of post_removeLeadingZeros.\<close>
		((hex2nat hs) = (hex2nat RESULT))"

definition
	removeLeadingZeros :: "HexString \<Rightarrow> HexString"
where
	"removeLeadingZeros hs \<equiv> 
	\<comment>\<open>User defined body of removeLeadingZeros.\<close>
	(nat2hex (hex2nat hs))"

	
	
\<comment>\<open>VDM source: hex2nat: (HexString -> nat)
	hex2nat(hs) ==
hex2nat0(hs, 0)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 414:5\<close>

\<comment>\<open>VDM source: pre_hex2nat: (HexString +> bool)
	pre_hex2nat(hs) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 414:5\<close>
definition
	pre_hex2nat :: "HexString \<Rightarrow> bool"
where
	"pre_hex2nat hs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_hex2nat` specification.\<close>
		((inv_HexString hs))"


\<comment>\<open>VDM source: post_hex2nat: (HexString * nat +> bool)
	post_hex2nat(hs, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 414:5\<close>
definition
	post_hex2nat :: "HexString \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_hex2nat hs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_hex2nat` specification.\<close>
		((inv_HexString hs)  \<and>  (inv_VDMNat RESULT))"

definition
	hex2nat :: "HexString \<Rightarrow> VDMNat"
where
	"hex2nat hs \<equiv> 
	\<comment>\<open>User defined body of hex2nat.\<close>
	(hex2nat0 hs   (0::VDMNat))"

	
	
\<comment>\<open>VDM source: hex2digit: (char -> nat)
	hex2digit(hs) ==
(if (hs in set (dom HEX_TOUPPER))
then hex2digit(HEX_TOUPPER(hs))
else (if (hs in set (rng HEX_TOUPPER))
then (inverse NAT_HEX_LETTER)(hs)
else ((str2val)[nat]([hs]).#2)))
	pre ((HEX_INVARIANT and ((hs in set HEX_CHARS) and (hs in set NUM_CHARS))) => ((str2val)[nat]([hs]).#1))
	measure (if (hs in set (dom HEX_TOUPPER))
then 1
else 0)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 417:5\<close>

\<comment>\<open>VDM source: pre_hex2digit: (char +> bool)
	pre_hex2digit(hs) ==
((HEX_INVARIANT and ((hs in set HEX_CHARS) and (hs in set NUM_CHARS))) => ((str2val)[nat]([hs]).#1))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 435:29\<close>
definition
	pre_hex2digit :: "VDMChar \<Rightarrow> bool"
where
	"pre_hex2digit hs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_hex2digit` specification.\<close>
		((inv_VDMChar hs))  \<and> 
		\<comment>\<open>User defined body of pre_hex2digit.\<close>
		((HEX_INVARIANT \<and> ((hs \<in> HEX_CHARS) \<and> (hs \<in> NUM_CHARS))) \<longrightarrow> (fst ((str2val (inv_VDMNat)   [hs]))))"


\<comment>\<open>VDM source: post_hex2digit: (char * nat +> bool)
	post_hex2digit(hs, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 417:5\<close>
definition
	post_hex2digit :: "VDMChar \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_hex2digit hs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_hex2digit` specification.\<close>
		((inv_VDMChar hs)  \<and>  (inv_VDMNat RESULT))"

fun
	hex2digit :: "VDMChar \<Rightarrow> VDMNat"
where
	"hex2digit hs = 
	\<comment>\<open>User defined body of hex2digit.\<close>
	(
		if ((hs \<in> (dom HEX_TOUPPER))) then
		((hex2digit (HEX_TOUPPER hs)))
		else
		((
		if ((hs \<in> (rng HEX_TOUPPER))) then
		(((vdm_inverse NAT_HEX_LETTER) hs))
		else
		((snd ((str2val (inv_VDMNat)   [hs])))))))"

	
	
\<comment>\<open>VDM source: hex2nat0: (seq of (char) * nat -> nat)
	hex2nat0(hs, res) ==
(if (hs = [])
then res
else hex2nat0((tl hs), ((HEX_BASE * res) + hex2digit((hd hs)))))
	pre (forall i in set (elems hs) & pre_hex2digit(i))
	measure (len hs)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 439:5\<close>

\<comment>\<open>VDM source: pre_hex2nat0: (seq of (char) * nat +> bool)
	pre_hex2nat0(hs, res) ==
(forall i in set (elems hs) & pre_hex2digit(i))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 451:9\<close>
definition
	pre_hex2nat0 :: "VDMChar VDMSeq \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_hex2nat0 hs   res \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_hex2nat0` specification.\<close>
		((inv_VDMSeq' (inv_VDMChar) hs)  \<and>  (inv_VDMNat res))  \<and> 
		\<comment>\<open>User defined body of pre_hex2nat0.\<close>
		(\<forall> i \<in> (elems hs)  . (pre_hex2digit i))"


\<comment>\<open>VDM source: post_hex2nat0: (seq of (char) * nat * nat +> bool)
	post_hex2nat0(hs, res, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 439:5\<close>
definition
	post_hex2nat0 :: "VDMChar VDMSeq \<Rightarrow> VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_hex2nat0 hs   res   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_hex2nat0` specification.\<close>
		((inv_VDMSeq' (inv_VDMChar) hs)  \<and>  (inv_VDMNat res)  \<and>  (inv_VDMNat RESULT))"

fun
	hex2nat0 :: "VDMChar VDMSeq \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"hex2nat0 hs   res = 
	\<comment>\<open>User defined body of hex2nat0.\<close>
	(
		if ((hs = [])) then
		(res)
		else
		((hex2nat0 (tl hs)   ((HEX_BASE * res) + (hex2digit (hd hs))))))"

	
	
\<comment>\<open>VDM source: nat2hex: (nat -> HexString)
	nat2hex(n) ==
nat2hex0(n, "")\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 455:5\<close>

\<comment>\<open>VDM source: pre_nat2hex: (nat +> bool)
	pre_nat2hex(n) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 455:5\<close>
definition
	pre_nat2hex :: "VDMNat \<Rightarrow> bool"
where
	"pre_nat2hex n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_nat2hex` specification.\<close>
		((inv_VDMNat n))"


\<comment>\<open>VDM source: post_nat2hex: (nat * HexString +> bool)
	post_nat2hex(n, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 455:5\<close>
definition
	post_nat2hex :: "VDMNat \<Rightarrow> HexString \<Rightarrow> bool"
where
	"post_nat2hex n   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_nat2hex` specification.\<close>
		((inv_VDMNat n)  \<and>  (inv_HexString RESULT))"

definition
	nat2hex :: "VDMNat \<Rightarrow> HexString"
where
	"nat2hex n \<equiv> 
	\<comment>\<open>User defined body of nat2hex.\<close>
	(nat2hex0 n   (''''))"

	
	
\<comment>\<open>VDM source: digit2hex: (HexDigit -> HexString)
	digit2hex(digit) ==
(if (digit in set (dom NAT_HEX_LETTER))
then [NAT_HEX_LETTER(digit)]
else (val2str)[nat](digit))\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 458:5\<close>

\<comment>\<open>VDM source: pre_digit2hex: (HexDigit +> bool)
	pre_digit2hex(digit) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 458:5\<close>
definition
	pre_digit2hex :: "HexDigit \<Rightarrow> bool"
where
	"pre_digit2hex digit \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_digit2hex` specification.\<close>
		((inv_HexDigit digit))"


\<comment>\<open>VDM source: post_digit2hex: (HexDigit * HexString +> bool)
	post_digit2hex(digit, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 458:5\<close>
definition
	post_digit2hex :: "HexDigit \<Rightarrow> HexString \<Rightarrow> bool"
where
	"post_digit2hex digit   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_digit2hex` specification.\<close>
		((inv_HexDigit digit)  \<and>  (inv_HexString RESULT))"

definition
	digit2hex :: "HexDigit \<Rightarrow> HexString"
where
	"digit2hex digit \<equiv> 
	\<comment>\<open>User defined body of digit2hex.\<close>
	(
		if ((digit \<in> (dom NAT_HEX_LETTER))) then
		([(NAT_HEX_LETTER digit)])
		else
		((val2str (inv_VDMNat)   digit)))"

	
	
\<comment>\<open>VDM source: nat2hex0: (nat * seq of (char) -> seq of (char))
	nat2hex0(n, res) ==
(if (n = 0)
then res
else nat2hex0((n div 16), (digit2hex((n mod 16)) ^ res)))
	measure n\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 465:5\<close>

\<comment>\<open>VDM source: pre_nat2hex0: (nat * seq of (char) +> bool)
	pre_nat2hex0(n, res) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 465:5\<close>
definition
	pre_nat2hex0 :: "VDMNat \<Rightarrow> VDMChar VDMSeq \<Rightarrow> bool"
where
	"pre_nat2hex0 n   res \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_nat2hex0` specification.\<close>
		((inv_VDMNat n)  \<and>  (inv_VDMSeq' (inv_VDMChar) res))"


\<comment>\<open>VDM source: post_nat2hex0: (nat * seq of (char) * seq of (char) +> bool)
	post_nat2hex0(n, res, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 465:5\<close>
definition
	post_nat2hex0 :: "VDMNat \<Rightarrow> VDMChar VDMSeq \<Rightarrow> VDMChar VDMSeq \<Rightarrow> bool"
where
	"post_nat2hex0 n   res   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_nat2hex0` specification.\<close>
		((inv_VDMNat n)  \<and>  (inv_VDMSeq' (inv_VDMChar) res)  \<and>  (inv_VDMSeq' (inv_VDMChar) RESULT))"

fun
	nat2hex0 :: "VDMNat \<Rightarrow> VDMChar VDMSeq \<Rightarrow> VDMChar VDMSeq"
where
	"nat2hex0 n   res = 
	\<comment>\<open>User defined body of nat2hex0.\<close>
	(
		if ((n = (0::VDMNat))) then
		(res)
		else
		((nat2hex0 (n vdmdiv (16::VDMNat1))   ((digit2hex (n vdmmod (16::VDMNat1))) @ res))))"

	
	
\<comment>\<open>VDM source: equal: (nat * nat -> bool)
	equal(x, y) ==
(x = y)\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 476:5\<close>

\<comment>\<open>VDM source: pre_equal: (nat * nat +> bool)
	pre_equal(x, y) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 476:5\<close>
definition
	pre_equal :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_equal x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_equal` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y))"


\<comment>\<open>VDM source: post_equal: (nat * nat * bool +> bool)
	post_equal(x, y, RESULT) ==
null\<close>
\<comment>\<open>in 'Binary' (../examples/Binary/Binary.vdmsl) at line 476:5\<close>
definition
	post_equal :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_equal x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_equal` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_bool RESULT))"

definition
	equal :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"equal x   y \<equiv> 
	\<comment>\<open>User defined body of equal.\<close>
	(x = y)"

\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_type "BitVectorOp"
hide_const "HEX_BIN_OCTET_LEN"
hide_const "HEX_CHARS"
hide_const "equal"
hide_const "N2B_EQUIV"
hide_const "post_bvShr"
hide_const "post_firstByteIndex"
hide_const "hex2digit"
hide_const "max"
hide_const "post_nat2bv"
hide_const "post_bvShl"
hide_const "measure_fold1"
hide_const "post_firstByteBit"
hide_const "post_bv2nat"
hide_const "inv_BinByte0"
hide_const "HEX_BASE"
hide_const "HEX_TOUPPER"
hide_const "NAT_HEX_LETTER"
hide_const "inv_UniqueHexStringList1"
hide_const "post_bvNot"
hide_const "nat2hex0"
hide_const "post_bvAnd"
hide_const "post_bvOp"
hide_const "post_binPad"
hide_const "HEX_INVARIANT"
hide_const "post_bvOr"
hide_const "nat2bvQ"
hide_const "post_removeLeadingZeros"
hide_const "post_zeroed"
hide_const "inv_Byte"
hide_const "removeLeadingZeros"
hide_const "measure_nat2bvQ"
hide_const "inv_HexDigit"
hide_const "measure_nat2hex0"
hide_const "post_byte2bin"
hide_const "pre_hex2digit"
hide_const "npow"
hide_const "BIN_BASE"
hide_const "post_firstBit"
hide_const "digit2hex"
hide_const "measure_hex2nat0"
hide_const "inv_binary"
hide_const "NUM_CHARS"
hide_const "inv_BinByte"
hide_const "inv_Bit"
hide_const "inv_HexString"
hide_const "post_firstBitIndex"
hide_const "post_bvXor"
hide_const "post_removeLeadingZeroedBits"
hide_const "post_minxs"
hide_const "bvOp"
hide_const "bv2natQ"
hide_const "post_bin2byte"
hide_const "inv_HexStringExact2"
hide_const "measure_bv2natQ"
hide_const "post_max"
hide_const "measure_hex2digit"
hide_const "inv_CannonicalHexString"
hide_const "b2n"
hide_const "n2b"
hide_const "hex2nat0"
hide_const "zeroed"
hide_const "min"
hide_const "pre_hex2nat0"
hide_type "binary"
hide_const "post_bvPad"

end