package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeDefinition;

public abstract class DafnyBind extends AbstractDafnyNode {
    public abstract String getName();
    public abstract DafnyTypeDefinition getType();
    public abstract String translate();
}