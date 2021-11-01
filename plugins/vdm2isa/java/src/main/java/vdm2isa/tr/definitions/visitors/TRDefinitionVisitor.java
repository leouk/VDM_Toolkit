/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions.visitors;

import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.definitions.TRLocalDefinition;
import vdm2isa.tr.definitions.TRProofObligationDefinition;
import vdm2isa.tr.definitions.TRProofScriptDefinition;
import vdm2isa.tr.definitions.TRTypeDefinition;
import vdm2isa.tr.definitions.TRValueDefinition;

/**
 * The base type for all TRDefinition visitors. All methods, by default, call
 * the abstract caseDefinition method, via the various intermediate default
 * methods for their parent types.
 */
public abstract class TRDefinitionVisitor<R, S>
{
 	abstract public R caseDefinition(TRDefinition node, S arg);

 	public R caseExplicitFunctionDefinition(TRExplicitFunctionDefinition node, S arg)
	{
		return caseDefinition(node, arg);
	}

 	public R caseLocalDefinition(TRLocalDefinition node, S arg)
	{
		return caseDefinition(node, arg);
	}

 	public R caseTypeDefinition(TRTypeDefinition node, S arg)
	{
		return caseDefinition(node, arg);
	}

 	public R caseValueDefinition(TRValueDefinition node, S arg)
	{
		return caseLocalDefinition(node, arg);
	}

    public R caseProofObligationDefinition(TRProofObligationDefinition node, S arg) {
        return caseProofObligationDefinition(node, arg);
    }

    public R caseProofScriptDefinition(TRProofScriptDefinition node, S arg) {
        return caseProofScriptDefinition(node, arg);
    }
}
