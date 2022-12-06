package vdm2isa.tr.templates;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public abstract class IsaAbstractTemplate implements IsaTemplate {
 
    public final String comment;

    protected final static <T> List<T> createList(List<T> elems)
    {
        return elems == null || elems.size() == 0 ? Collections.emptyList() : new ArrayList<T>(elems);
    }

    @SafeVarargs //Not sure about that
    @SuppressWarnings("varargs")
    protected final static <T> List<T> createList(T... elems)
    {
        return elems == null || elems.length == 0 ? Collections.emptyList() : Arrays.asList(elems);
    }

    protected IsaAbstractTemplate(String comment)
    {
        this.comment = comment; 
    }
}
