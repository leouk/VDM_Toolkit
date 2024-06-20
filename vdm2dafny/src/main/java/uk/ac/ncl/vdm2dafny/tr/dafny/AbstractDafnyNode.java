package uk.ac.ncl.vdm2dafny.tr.dafny;

public abstract class AbstractDafnyNode implements DafnyNode {

    @Override
    public String toString(){
        return translate();
    }
}
