# VDM-SL Annotations
Repository of new [VDM-SL annotations] (https://github.com/nickbattle/vdmj/blob/master/vdmj/documentation/AnnotationGuide.pdf) for [VDMJ] (https://github.com/nickbattle/vdmj/).

## Annotations 3
VDMJ has two collections of experimental annotations. We added a new one. For now it contains:

### @Time
Time monitoring annotation that works as a specification profiler. Useful to ascertain what part of the specification is taking what kind of time. 

## Witness
Witness annotation is part of the Isabelle translation infrastructure in order to allow for existential witnesses in translated proof scripts. It is part of Edward Jaccob's MComp dissertation.

### @Witness
Witness annotation useful as a automatic existential-proof discharger through VDMJ interpreation. That is, a witness to a record type will be type checked and interpreted; if that succeeds, this is akin to an exitentially quantified variable witness useful for later translation to theorem provers. 
 
