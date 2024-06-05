# VDM Class Mapping Guide

VDM class mapping is `vdmj` mechanism allowing users to easily (and consistently) reconstruct the VDM AST(s) to different tool-related purposes. 
 
# Preliminaries

## When to use it?

Class mapping is relevant when retartging the source AST. For instance, the VDM parsing tree (`ASTNode`) gets class mapped into the VDM type checked tree (`TCNode`), which then gets mapped into the VDM interpretation tree (`INNode`). 
 
## VDM-SL translation

For the Isabelle/HOL translation, we class mapped the type checked `TCNode` into a translation tree `TRNode`. 

# Setup

## VDMJ AST hierarchy

Both mapping source and target classes follow a similar pattern: each syntactic group has its own subtrees (starting from the `MappableNode` interface), and lists are treated within these trees through the `MappableList` class. 

### `annotations`

Hierarchy of all VDM-SL annotations. 

This is an independent hierarchy.

### `definitions`

Hierarchy of all VDM-SL definitions. These include top-level definitions (TLDs) like named `types`, `values`, explicit/implicit function declarations, imported modules, etc.  

This is a heavily dependent hierarchy, being TLD; hence, better be done last. 

### `expressions`

Hierarchy of all VDM-SL expressions. 

This is a heavily dependent on `pattern` hierarchy. 

### `lex`
### `modules`
### `patterns`

Hierarchy of all VDM-SL patterns and binds. These can be rather complex, and care needs to be taken when going through then. 

`TCPattern` is the abstract class for the leaf VDM pattern subcases, whereas `TCMultipleBind` is the abstract class for the leaf VDM bind subcases. 

`TCMultipleBind` subtree depends on `TCPattern`, which does not depend on any other part. 

### `statements`

Hierarchy of all VDM-SL statements and operations. 

**TODO**

### `traces`

Hierarchy of all VDM-SL traces.

**TODO**

### `types` 

Hierarchy of all VDM-SL types. 

This depends on `patterns` hierarchy.  


## Mappings file

Class mapping relies on a domain-specific language, which tells `vdmj` how to map between two AST trees and use Java's reflection libraries to (recusrively) reconstruct the tree, based on these mappings. 

Mapping does not need to be exhaustive. In fact, it's advisable to have the mappings added as underlying development progresses, rather than add all mappings of interest from the beginning.  

### Mapping kinds:

1. `map`: links source and target mapping classes;
2. `unmap`: source classes not mapped and passed as parameters;
3. `init`: static initialisers called before class mapping;
2. `package`: context for which packages source and target classes come from.    

## Mapping process

For every concrete class of interest in the source tree, create a `map`ping entry, per source/target `package` entry (*i.e.,* `package` entries must appear before their corresponding package `map`ing entries. 

### Mapping file

1. Create a `.mappings` file;
2. Add a `package` entry for source and target packages (*i.e.,* every `map` entry after `package` entry corresponds to that package.)
3. Add (one at a time) `map` entries;
4. Add `unmapped` entries: these are not `package` dependent, hence can usually be added at the end.   

### `package` entries

	package x.y.source to z.w.target;


### `map` entries

	map SOURCE{PARAMS} to TARGET(params);

Source parameters refer to any accessible source class (including `private`, `protected`, and `public`) fields, whereas target parameters refer to constructor parameters. 

Parameter `this` (of type `SOURCE`) is available and can be passed to `TARGET`, in case one wants to perform further inspection/processing with the source class. Notice you cannot get the source fields this way, as they won't be mapped and might not be `public`.

Parameters can also be empty, mostly useful for abstract class mapping. 

### `unmap` entries

	unmap x.y.source.SClass;

Fully qualified source class name that is passed as parameter rather than being class mapped. It does not make sense to `unmap` target classes.  

### `init` entries

	init x.y.target.TClass.staticMethod();

Fully qualified target class static method name. It is possible (but somewhat breaking separation of concerns) to try and initialise source classes (*i.e.,* class mapping should not affect how source classes behave). 

It is not possible to pass parameters to the static initialisers.  

### Mapping abstract classes

Abstract class mapping is needed if it is a type target of mapping (not otherwise). For example `TRTypeDefinition` expects a `TRInvariantType` parameter, which is an abstract class that will be instantiated to either `TRRecordType` or `TRNamedType`. 

Therefore, a class mapping for the abstract type is needed, even though it might just be a stub class giving access to the target hierarchy for concrete instances.  

Of course, the target class must also be abstract, even if it implements all that is needed.   

### `map` `set` clause

**TODO**

### Mapping lists

Type parameters are needed in target list classes to say what the source and target classes the list refers to. For example, `TRExpressionList` could extend `MappedList` as `MappedList<TCExpression, TRExpression>`. 

That is, the list elements mapping will take place within the list construction population as its passed between source and target trees. 

This is another example of abstract classes that need mapping: in this case `TRExpression` needs a mapping to allow it to participate in `TRExpressionList`, even though only concrete instances of `TRExpression` will be part of the list.   

In practice for `TRNode`, we needed to extend `MappedList` to `TRMappedList`, hence that's the class `TRExpressionList` (and all other `TRNode` lists) extend. 

This was to allow for list-general functionality through its elements (*i.e.,* `list.translate()` will call all the `get(i).translate()` and format the result accordingly).

## Dos

* Separate `map` entries per AST category;
* Keep `unmap` and `init` entries at the end;
* Start small and grow depending on the subtree(s) of interest
	* *e.g.,* for `TRNode`, we did `expressions` and `patterns` first.
* Some TLD will be needed from the `definitions` tree to access AST entry points for translation.
* Some TLD will be needed from the `modules` tree for access within the `plugin.run` method, where processing starts.
* Create test files per syntactic category with layered levels of complexity.
* **TODO** 

## Don'ts

* Avoid mixing subtrees as this could lead to looping
* Keep mapping and analysis/processing completely separate
	* *e.g.,* do not call `translate()` until full mapped construction has taken place.	
* There is no need to `map` abstract classes that are not field types in target classes, but just part of the hierarchy for code reuse. 
* Duplicate `map` entries: this will generate an error.
* Put `map` entries after wrong `package` entry: `map` entries must refer to the latest `package` entry before it.  
* Keep target constructors **very** simple: as part of the mapping process, you might get incomplete field values, particularly in abstract classes (*i.e.,* for checking, better do it on leaf classes, rather than abstract ones, *e.g.,* in a record field expression [`r.x`], the type for `x` will be null on first instance, then gets set finally after the whole record is handled).