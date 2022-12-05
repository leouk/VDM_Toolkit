package vdm2isa.tr.templates;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public abstract class IsaAbstractTemplate implements IsaTemplate {
 
    @SafeVarargs //Not sure about that
    @SuppressWarnings("varargs")
    protected static <T> List<T> createList(T... elems)
    {
        return elems == null || elems.length == 0 ? Collections.emptyList() : Arrays.asList(elems);
    }
}
