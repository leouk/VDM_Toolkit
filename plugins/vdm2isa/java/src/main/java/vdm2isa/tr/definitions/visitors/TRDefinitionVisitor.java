/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions.visitors;

import vdm2isa.tr.definitions.TRBasicProofScriptStepDefinition;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TREqualsDefinition;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.definitions.TRImplicitFunctionDefinition;
import vdm2isa.tr.definitions.TRImportedDefinition;
import vdm2isa.tr.definitions.TRLocalDefinition;
import vdm2isa.tr.definitions.TRProofObligationDefinition;
import vdm2isa.tr.definitions.TRProofScriptDefinition;
import vdm2isa.tr.definitions.TRProofScriptStepDefinition;
import vdm2isa.tr.definitions.TRQualifiedDefinition;
import vdm2isa.tr.definitions.TRRenamedDefinition;
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
        return caseDefinition(node, arg);
    }

    public R caseProofScriptDefinition(TRProofScriptDefinition node, S arg) {
        return caseDefinition(node, arg);
    }

    public R caseProofScriptStepDefinition(TRProofScriptStepDefinition node, S arg) {
        return caseDefinition(node, arg);
    }

    public R caseBasicProofScriptStepDefinition(TRBasicProofScriptStepDefinition node, S arg) {
        return caseDefinition(node, arg);
    }

    public R caseEqualsDefinition(TREqualsDefinition node, S arg) {
        return caseDefinition(node, arg);
    }

    public R caseQualifiedDefinition(TRQualifiedDefinition node, S arg) {
        return caseDefinition(node, arg);
    }

    public R caseImportedDefinition(TRImportedDefinition node, S arg) {
        return caseDefinition(node, arg);
    }

    public R caseRenamedDefinition(TRRenamedDefinition node, S arg) {
        return caseImportedDefinition(node, arg);
    }

    public R caseImplicitFunctionDefinition(TRImplicitFunctionDefinition node, S arg) {
        return caseDefinition(node, arg);
    }
}
