package vdm2isa.tr.definitions;

import java.util.TreeSet;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.MappableNode;
import vdm2isa.tr.TRNode;

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

    public TRDefinitionSet(TRDefinitionList definitions)
    {
        addAll(definitions);
    }

    public void setup()
    {
        for(TRDefinition d : this)
        {
            if (!d.setupDone())
                d.setup();
        }
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
        TRDefinitionList result = new TRDefinitionList();
        result.addAll(this);
        TRNode.setup(result);
        return result;
    }

    public  boolean allAreLocalDefinition()
	{
		return asList().allAreLocalDefinition();
	}

	public <T extends TRDefinition> boolean allAre(T def)
	{
        return asList().allAre(def);
    }
}