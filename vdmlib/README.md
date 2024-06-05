# VDM libraries
Repository of VDM-SL libraries.

## ISO8601
Time-zone aware definition of date and time. This is an adapted/extended version of original by [Paul Chisholm] (https://www.overturetool.org/download/examples/VDMSL/ISO8601SL/index.html).  

This is useful to specifications containing date/time manipulations, including time-zones, date/time arithmetic, conversions, etc.

Examples of use: medical devices, payment protocol. 

* _**DEPENDENCY:**_ `Support1.vdmsl`
* _**TODO: improve performance of date/time transformations**_

## Asserting
Library with VDM-SL assertions. This is similar to Java assertions, but allowing for high-order definitions. It outputs to the console whenever assertion fails.  

This is useful to document complex operations in terms of expectations at different stages of its execution. It is similar  to [VDMJ's @OnFail annotation] (https://github.com/nickbattle/vdmj/blob/master/annotations/src/main/java/annotations/ast/ASTOnFailAnnotation.java), but as an operation call rather than comment. 

Examples of use: payment protocols. 

## Binary
Definition of bit-vectors in VDM-SL. This is inspired by operators in Isabelle's Word library, and other Isabelle sources. It include various bit vector arithemetic, padding, conversion (to byte-sized precision), etc. As well as conversion between hex and nat. 
  
This is useful when dealing with binary arithmetic operators in specification. 

Examples of use: payment protocols, medical devices. 
  
* _**DEPENDENCY:**_ `Support1.vdmsl`
* _**TODO: needs more bit vector operators**_
 
## FuzzySets
Implementation of Fuzyy Sets and their operations as defined by its [wiki] (https://en.wikipedia.org/wiki/Fuzzy_set). 

Fuzzy sets are useful for situations where binary logic is not sufficient, such as complex decision making processes where combination of factors are not necessarily "true"/"false" but a real-valued result between 0..1.

Examples of use: organ allocation scoring, medical processes. 

* _**DEPENDENCY:**_ `Support1.vdmsl`

## ISQ
ISO [International System of Units] (https://en.wikipedia.org/wiki/International_System_of_Units) defined in VDM-SL. This is an adaptation of [Simon Foster's Isabelle AFP entry] (https://www.isa-afp.org/entries/Physical_Quantities.html). 

This is useful for conversion of measures and units. It encodes all standard dimentions of physical quantities (e.g. length, mass, time, current, temperature, molecular amount, luminous intensity), conversions and compositions between them. 

It includes some standard conversion systems like [SI] (https://en.wikipedia.org/wiki/SI_base_unit) (e.g., second, metre, kilogram, ampere, kelvin, mole, candela) and [British Imperial] (https://en.wikipedia.org/wiki/Imperial_units) (e.g., inch, yard, mile, acre, etc.). 

Conversions can be between units themselves (e.g., metre to yard), or their combination (e.g., kilometre per hour into miles per hour). The library allows for user-defined conversion systems, like centimetre and grams as targets for length and mass.  

Examples of use: medical processes. 

* _**DEPENDENCY:**_ `Support1.vdmsl`

## Logging
Inspired by other languages logging mechanisms. 

This library is useful for logging (to console) of complicated VDM-SL operations. These include log-levels (i.e. log only in certain circumstances), log traces, user-defined parameters, etc.

Example of use: payment protocols, medical devices.

## Matrix_Seq 
Basic library of matrices inspired by corresponding library in Isabelle. 

This is useful for matrix operations like row/col transposing, scalar products, determinant, etc. 

Example of use: payment protocols.

* _**TODO: needs more matrix operators**_

## Ordering
Basic mathematical ordering operators. 

This includes necessary definitions to construct (high-order) partial and total ordering relations. 

This is useful for definition of ordering relations between complex types.
 
* _**DEPENDENCY:**_ `Relations.vdmsl`
* _**TODO: refactor min/max etc out; remove dependency**_

## Relations
Z mathematical toolkit for relations in VDM-SL.

Based on [Spivey's Z] (http://spivey.oriel.ox.ac.uk/corner/Z_Reference_Manual) and [Z/Eves (theorem prover)] (https://doi.org/10.1007/BFb0027284) mathematical toolkits. 

This is useful for mathematical operations over relations, which are missing in VDM's mathematical toolkit. 

These have been extended to transform Z functions (i.e. specific sets of relations) into VDM maps. It also includes all Z relational operators as high-order VDM functions:

 * identity
  	* `id`: makes identity relation from set
  	* `id_rel`: projected identity relation
 * basic operators
  	* `rel_dom`: domain
  	* `rel_rng`: range
  	* `rel_comp`: forward composition
  	* `	rel_circ`: backward composition
  	* `rel_dres`: domain restriction (filtering)
  	* `rel_rres`: range restriction  (filtering)
  	* `rel_ndres`: domain anti-restriction (anti-filtering)
  	* `rel_nrres`: range anti-restriction (anti-filtering)
 * extended operators
  	* `rel_inv`: inverse
  	* `rel_img`: image (relational application)
  	* `rel_dagger`: override
 * closure operators
  	* `rel_iter`: iterative closure
  	* `rel_niter`: negative iterative closure
  	* `rel_tclosure`: iterative transitive closure (fast/operational)
  	* `rel_tclosure2`: transitive closure (slow/denotational)  	* `rel_rtclosure`: reflexive transitive closure (fast)
 * relational tests
 	* `rel_is_total_on`: relational totality
 	* `rel_is_map_on`: functional relation on subset
 	* `rel_is_map`: functional relation on domain
 	* `rel_is_inmap_on`: injective relation on subset
 	* `rel_is_inmap`: injective relation on domain
 	* `rel_is_surj_on`: surjective relation on subset
 	* `rel_is_bij_on`: bijective relation on subset
 	* `rel_subset_is_map_subset`: subset relation of map is map
 * relational conversions
 	* `force_rel_as_map`: relational projection (i.e. `X x Y` to `X x set of Y`)
 	* `zip`: makes relation from two sets
 	* `unzip`: unpacks relation as two sets
 	* `make_rel_trcl_from_set`: transitively close relation from set
 	* `make_rel_subset`: subset relation on `n: nat` pairs
	* `make_rel_map`: project relation into map (i.e. `X x Y` to `map X to y`), when allowed 	
	* `make_rel_map`: project relation into injective map (i.e. `X x Y` to `inmap X to y`), when allowed 

This also includes all the toolkit theorems as traces over chosen example relations. 

## SetMapLib
Old VDM-SL library for high-order processing of data types.

Useful to play around variations over invariants through structured types (e.g. lists, sets, maps, etc.). This is somewhat artificial, and useful for experiments only. 

## Stack
Stack as an Abstract Data Type, inspired by SPARK. 

This is useful as a generic stack. Given VDM doesn't allow high-order type parameters, I use non-struct export in  combination with `?`-types to enable ADT effect. 

## Support1 
Collection of VDM-SL functions useful for sets, lists, maps, strings, etc.

This includes around 100 functions useful in various contexts. 

## Support2 
Collection of VDM-SL functions useful for handling complex optional types. 

This includes various checking and casting operators when types are not entirely knowable. It is also CG compabitle. 