package vdm2isa.tr.templates;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroupDir;

public abstract class IsaAbstractTemplate implements IsaTemplate {
 
    public static final String ISA_TEMPLATE_GROUPDIR = "src/main/resources/templates/";

    protected final STGroupDir group;
    protected final Set<String> templateNames;
    public final String comment; 

    protected IsaAbstractTemplate()
    {
        this(null);
    }

    protected IsaAbstractTemplate(String comment)
    {
        this.group = new STGroupDir(ISA_TEMPLATE_GROUPDIR, '$', '$');
        this.templateNames = this.group.getTemplateNames();
        this.comment = comment; 
    }

    public final boolean isTemplateValid(String name)
    {
        return templateNames.contains(name);
    }

    public final ST getTemplate(String name)
    {
        if (isTemplateValid(name))
            return group.getInstanceOf(name);
        else 
            throw new IsaTemplateException("Unknown template name in Isabelle template group: " + name);
    }

    @SafeVarargs //Not sure about that
    @SuppressWarnings("varargs")
    protected static <T> List<T> createList(T... elems)
    {
        return elems == null || elems.length == 0 ? Collections.emptyList() : Arrays.asList(elems);
    }
}
