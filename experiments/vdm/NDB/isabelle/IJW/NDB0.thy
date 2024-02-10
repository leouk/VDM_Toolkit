theory NDB0
imports "../../../heap/HEAP/VDMMaps"
begin

(* Introduce the arbitrary types that have not been instantiated
   at level 0 of NDB 
*)
typedecl ndb0_status  (* determines whether or not entities can be added to 
                         or deleted from a set *)
typedecl ndb0_picture (* details the format of the values of the member entities *)
typedecl ndb0_width   (* used for outputting values *)
typedecl ndb0_eid     (* entity identifier type *)
typedecl ndb0_esetnm  (* entity set name type *)
typedecl ndb0_relnm   (* relation name type *)
typedecl ndb0_value   (* type of the values of entity members
                            Q: is 'nil' to be defined as a specific value of this 
                            type?
                      *) 
type_synonym ndb0_eidpair = "(ndb0_eid \<times> ndb0_eid)"

(* Type for the maps *)
datatype ndb0_maptype = OneOne | OneMany | ManyOne | ManyMany

(* The relation info record consists of... *)
record ndb0_relinf =
  map :: "ndb0_maptype"                (* The type of relation map *)
  conns :: "ndb0_eidpair set" (* A set of entity identifier pairs 
                                          describing the connections 
                                        *)

(* The relationship type record consists of... *)
record ndb0_reltype =
   fs :: ndb0_esetnm  (* The from entity set *) 
   nm :: "ndb0_relnm option"   (* An optional name for the relationship *)
   ts :: ndb0_esetnm  (*The to entity set *)
(* NOTE: using isabelle optional type; though, perhaps need it more as a value? *)

(* The entity set information records consists of ... *)
record ndb0_esetinf =
  status :: ndb0_status     (* A status *)
  picture :: ndb0_picture   (* The picture *)
  width :: ndb0_width       (* The width *)
  membs :: "ndb0_eid set"   (* A set of member entities *)

(* The abstract (level 0) state of ndb consists ...*)
record ndb0_state =
    esets :: "ndb0_esetnm \<rightharpoonup> ndb0_esetinf" (* an entity sets map *)
    rels  :: "ndb0_reltype \<rightharpoonup> ndb0_relinf" (* A relationships map *)
    ents  :: "ndb0_eid \<rightharpoonup> ndb0_value option" (* A eid-value map 
                                              (where value is optional) *)



(* Let's now define some auxilliary functions: *)

(* Checks if a set of entities are in an entityset *)
definition are_membs :: "ndb0_eid set \<Rightarrow> ndb0_esetinf \<Rightarrow> bool"
where "are_membs eset esetinf \<equiv> eset \<subset> membs(esetinf)"

definition froms :: "ndb0_eidpair set \<Rightarrow> ndb0_eid set"
  where "froms prset = {}"

end
