theory UnionTypesStudy
imports VDMToolkit
begin

datatype TUnion5 = Uint "VDMInt" | Ureal "VDMReal"

definition
		inv_TUnion5 :: "TUnion5 => bool"
where
		"inv_TUnion5 u == 
			(case u of
				Uint v  => inv_VDMInt v \<and> v > 0
			|	Ureal v => inv_VDMReal v \<and> v > 0)"  

value "Uint 10"

datatype TUnion6 = Uint "VDMInt" | Unat "VDMNat"

definition
		inv_TUnion6 :: "TUnion6 => bool"
where
		"inv_TUnion6 u == 
			(case u of
				Uint v => (inv_VDMInt v \<and> v < 0)
			|	Unat v => inv_VDMNat v \<and> v > 0)"  

value "Uint 10"
value "Uint 0"
value "Uint (-1)"
value "inv_TUnion6 (Uint 10)"
value "inv_TUnion6 (Uint (-1))"
value "inv_TUnion6 (Uint 0)"
value "inv_TUnion6 (Unat 10)"
value "inv_TUnion6 (Unat (-1))"
value "inv_TUnion6 (Unat 0)"

end