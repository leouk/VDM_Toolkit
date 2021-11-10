# VDM Class Mapping

VDM class mapping is `vdmj` mechanism allowing users to easily (and consistently) reconstruct the VDM AST(s) to different tool-related purposes. 
 
# Preliminaries

## When to use it?

Class mapping is relevant when retartging the source AST. For instance, the VDM parsing tree (`ASTNode`) gets class mapped into the VDM type checked tree (`TCNode`), which then gets mapped into the VDM interpretation tree (`INNode`). 
 
## VDM-SL translation

For the Isabelle/HOL translation, we class mapped the type checked `TCNode` into a translation tree `TRNode`. 

# Setup

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

Source parameters refer to any accessible source class (including `private`, `protected`, and `public`) fields. 

1 . 

### `init` parameters

* TODO: not sure whether `init` allows parameters!

