package vdm2isa.tr.types;

import vdm2isa.tr.MappableNode;

/**
 * Isabelle data types represent union types and optional types in VDM
 * Each VDM type in the union represents a type constructor, whereas 
 * in optional types, nil represents a type constant (empty parameters constructor). 
 * 
 * The constructor names must be unique within the type set. 
 */
public interface TRDataType extends MappableNode {
    public TRTypeSet getDataTypeConstructors();
}
