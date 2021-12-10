package vdm2isa.tr.definitions;

import java.util.TreeSet;

import vdm2isa.tr.TRNode;

//@SuppressWarnings("serial")
public class TRDefinitionSet extends TreeSet<TRDefinition> {
    
    private boolean alreadySetup;

    public TRDefinitionSet()
    {
        super();
        alreadySetup = false;
    }

    public TRDefinitionSet(TRDefinition definition)
    {
        this();
        add(definition);
    }

    public TRDefinitionSet(TRDefinitionList definitions)
    {
        this();
        addAll(definitions);
    }

    public void setup()
    {
        for(TRDefinition d : this)
        {
            if (!d.setupDone())
                d.setup();
        }
        alreadySetup = true;
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

    public static final void setup(TRDefinitionSet n) 
    {
        if (n != null && !n.setupDone())
			n.setup();
    }

    private boolean setupDone() {
        return alreadySetup;
    }
}