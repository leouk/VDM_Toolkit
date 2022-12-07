package vdm2isa.tr.templates;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public abstract class IsaAbstractTemplate implements IsaTemplate {
 
    public final String comment;

    protected final static <T> List<T> createList(List<T> elems)
    {
        // clear all nulls
        List<T> result;
        if (elems == null) 
            result = Collections.emptyList();
        else 
        {
            result = new ArrayList<T>(elems != null ? elems.size() : 0);
            for(T e : elems) 
            {
                if (e == null) continue;
                result.add(e);
            }
        }
        return result;
    }

    @SafeVarargs //Not sure about that
    @SuppressWarnings("varargs")
    protected final static <T> List<T> createList(T... elems)
    {
        return elems == null || elems.length == 0 ? Collections.emptyList() : Arrays.asList(elems);
    }

    protected IsaAbstractTemplate(String comment)
    {
        // empty comments become null ones to avoid emitting empty comments 
        this.comment = comment != null && comment.isEmpty() ? null : comment; 
    }
}
