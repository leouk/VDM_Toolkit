theory NDBr
imports NDBa
begin

(* To do: rename types to be ndb rather than ndba *)

typedecl ndb_rid (* Type if relationship type identifier *)

record ndbr_triple =
  fv  :: ndba_eid
  rnm :: ndb_rid
  tv  :: ndba_eid

(* Diverging from the informal spec, we introduce type synonyms for
   each of the state types:
*)
type_synonym ndbr_statusmap  =  "ndba_esetnm \<rightharpoonup> ndba_status"
type_synonym ndbr_picturemap =  "ndba_esetnm \<rightharpoonup> ndba_picture"
type_synonym ndbr_widthmap   =  "ndba_esetnm \<rightharpoonup> ndba_width"
type_synonym ndbr_membsmap   =  "ndba_esetnm \<rightharpoonup> (ndba_eid set)"
type_synonym ndbr_fsmap      =  "ndb_rid \<rightharpoonup> ndba_esetnm"
type_synonym ndbr_nmmap      =  "ndb_rid \<rightharpoonup> (ndba_relnm option)"
type_synonym ndbr_tsmap      =  "ndb_rid \<rightharpoonup> ndba_esetnm"
type_synonym ndbr_mapmap     =  "ndb_rid \<rightharpoonup> ndba_maptype"
type_synonym ndbr_valofmap   =  "ndba_eid \<rightharpoonup> (ndba_value option)"
(* Straight into the state definition! *)

record ndbr_state =
   status :: ndbr_statusmap
   picture :: ndbr_picturemap
   width :: ndbr_widthmap
   membs :: ndbr_membsmap
   fs :: ndbr_fsmap
   nm :: ndbr_nmmap
   ts :: ndbr_tsmap
   map :: ndbr_mapmap
   valof :: ndbr_valofmap
   conns :: "ndbr_triple set"

(* Should probably be an if-then-else on esetnm \<in> dom? *)
definition ndbr_esetinfo :: "ndba_esetnm \<Rightarrow> ndbr_state \<Rightarrow> ndba_esetinf"
 where "ndbr_esetinfo esetnm sr = 
  ndba_esetinf.make (the ((status sr) esetnm)) (the((picture sr) esetnm)) (the((width sr) esetnm)) (the((membs sr) esetnm))"

definition ndbr_reltype :: "ndb_rid \<Rightarrow> ndbr_state \<Rightarrow> ndba_reltype"
  where "ndbr_reltype rid sr \<equiv> ndba_reltype.make (the ((fs sr) rid)) (the ((nm sr) rid)) (the ((ts sr) rid))"


definition ndbr_relinfo :: "ndb_rid \<Rightarrow> ndbr_state \<Rightarrow> ndba_relinf"
  where "ndbr_relinfo rid sr \<equiv> let a_map = (the ((map sr) rid)) in
                               let a_conns = {ndba_pair.make (fv t) (tv t) | t . t\<in>conns(sr) \<and> rnm(t) = rid}
                               in ndba_relinf.make a_map a_conns"

(* Map comprehensions? *)
definition retra_esets :: "ndbr_state \<Rightarrow> ndba_esets"
  where "retra_esets sr = empty"

definition retra_rels :: "ndbr_state \<Rightarrow> ndba_reltypes"
  where "retra_rels sr = empty"

definition ndb_retra :: "ndbr_state \<Rightarrow> ndba_state"
  where "ndb_retra sr \<equiv> \<lparr>esets_map = retra_esets sr, rels_map = retra_rels sr, ents_map = valof(sr) \<rparr>"



definition ndbr_inv_domains :: "ndbr_state \<Rightarrow> bool"
  where "ndbr_inv_domains sr \<equiv> let statusr = dom (status(sr)) in let fsr = dom( fs(sr))
                            in dom(width(sr))=statusr \<and> dom(picture(sr))=statusr
                             \<and> dom(membs(sr))=statusr \<and> dom(nm(sr)) = fsr
                             \<and> dom(ts(sr)) = fsr \<and> dom(map(sr))= fsr"

definition ndbr_inv_rids :: "ndbr_triple set \<Rightarrow> ndb_rid set \<Rightarrow> bool"
  where "ndbr_inv_rids connset nms \<equiv> \<forall> t \<in> connset. rnm(t) \<in> nms"

(* Reformulate? *)
definition ndbr_inv_rels :: "ndbr_fsmap \<Rightarrow> ndbr_nmmap \<Rightarrow> ndbr_tsmap \<Rightarrow> bool"
  where "ndbr_inv_rels fss nms tss \<equiv> \<not>(\<exists> rid1 \<in> dom fss. \<not>(\<exists> rid2 \<in> dom fss. 
                                    rid1 \<noteq> rid2 \<and> fss(rid1) = fss(rid2) \<and>
                                   nms(rid1) = nms(rid2) \<and> tss(rid1) = tss(rid2) ))"

definition ndbr_inv_state :: "ndbr_state \<Rightarrow> bool"
  where "ndbr_inv_state sr \<equiv> ndba_inv_state(ndb_retra(sr)) \<and>
                              ndbr_inv_domains(sr) \<and> (ndbr_inv_rids (conns sr) (dom (nm sr)))
                              \<and> (ndbr_inv_rels (fs sr) (nm sr) (ts sr))"

end
