package vdm2isa.tr.definitions;

import java.util.TreeSet;

//@SuppressWarnings("serial")
public class TRDefinitionSet extends TreeSet<TRDefinition> {
    
    public TRDefinitionSet()
    {
        super();
    }

    public TRDefinitionSet(TRDefinition definition)
    {
        add(definition);
    }

    @Override
    public String toString()
    {
        StringBuilder sb = new StringBuilder();

        for (TRDefinition d: this)
        {
            sb.append(d.toString());
            sb.append("\n");
        }

        return sb.toString();
    }

    public TRDefinitionList asList()
    {
        TRDefinitionList list = new TRDefinitionList();
        list.addAll(this);
        return list;
    }
}