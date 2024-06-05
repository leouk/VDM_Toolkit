# VDM-SL Annotations
Repository of new [VDM-SL annotations] (https://github.com/nickbattle/vdmj/blob/master/vdmj/documentation/AnnotationGuide.pdf) for [VDMJ] (https://github.com/nickbattle/vdmj/).

VDMJ has two collections of experimental annotations. VDM Toolkit annotation are:

## @Time
Time monitoring annotation that works as a specification profiler. Useful to ascertain what part of the specification is taking what kind of time. 

## @Witness
Witness annotation useful as a automatic existential-proof discharger through VDMJ interpreation. That is, a witness to a record type will be type checked and interpreted; if that succeeds, this is akin to an exitentially quantified variable witness useful for later translation to theorem provers. 

## @Theorem and @Lemma
User-defined properties of interest to be proved in Isabelle. These must be type correct and will add the PO to the outpu of VDMJ's POG. Then next these extra POs will be translated to Isabelle as are any other POG PO.  

## Other TODO:

* @IsaModifier: for controlling named theorem attribute sets
* @Ghost: for controlling translation of functions meant for specification only (i.e. no translation of their specification). 
* @Strategy: for controlling how the `isapog` tool will output results.   