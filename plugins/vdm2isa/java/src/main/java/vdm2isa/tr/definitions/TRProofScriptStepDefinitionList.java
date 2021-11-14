package vdm2isa.tr.definitions;

import java.util.Arrays;
import java.util.List;

import plugins.IsapogPlugin;
import vdm2isa.messages.IsaWarningMessage;

public class TRProofScriptStepDefinitionList extends TRDefinitionList {

    private static final long serialVersionUID = 1L;

    public TRProofScriptStepDefinitionList()
    {
        super();
    }

    public static TRProofScriptStepDefinitionList proofScript(TRDefinition... args)
    {
        TRProofScriptStepDefinitionList result = new TRProofScriptStepDefinitionList();
        List<TRDefinition> list = Arrays.asList(args);
        for(TRDefinition d : list)
        {
            if (d instanceof TRProofScriptStepDefinition)
                result.add((TRProofScriptStepDefinition)d);
            else if (d instanceof TRBasicProofScriptStepDefinition)
                result.add((TRBasicProofScriptStepDefinition)d);
            else
                IsapogPlugin.warning(IsaWarningMessage.PO_UNEXPECTED_PROOFSTEP_1P, d.location, d.getClass().getName());
        }
        return result;
    }
}
