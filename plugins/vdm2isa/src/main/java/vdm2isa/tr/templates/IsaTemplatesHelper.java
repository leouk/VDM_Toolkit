package vdm2isa.tr.templates;

import java.time.Instant;
import java.util.Arrays;
import java.util.List;

import org.stringtemplate.v4.ST;

import vdm2isa.tr.definitions.templates.IsaAbbreviation;
import vdm2isa.tr.definitions.templates.IsaAttribute;
import vdm2isa.tr.definitions.templates.IsaClaim;
import vdm2isa.tr.definitions.templates.IsaDefinition;
import vdm2isa.tr.definitions.templates.IsaLemmas;
import vdm2isa.tr.definitions.templates.IsaRecord;
import vdm2isa.tr.definitions.templates.IsaRecordField;
import vdm2isa.tr.definitions.templates.IsaTypeDecl;
import vdm2isa.tr.definitions.templates.IsaVDMFunDef;
import vdm2isa.tr.expressions.templates.IsaIfThenElse;
import vdm2isa.tr.modules.templates.IsaTheory;

public final class IsaTemplatesHelper {
    
    public enum IsaTemplates 
    { 
        theory("thy"), 
        claim("clm"),
        lemmas("lms"),
        typedecl("tdecl"),
        record("rec"),
        abbreviation("abbrv"),
        definition("def"),
        fundef("fdef"),
        rfundef("fdef"),

        ifexp("vdmif")
        ;
    
        public final String arg; 

        private IsaTemplates(String attr)
        {
            this.arg = attr;
        }

        @Override
        public String toString()
        {
            return name();
        }
    } 

    public static final ST newIsaTheory(Instant utc, String comment, String loc, String name, String body, String... imports)
    {
        IsaTheory t = new IsaTheory(utc, comment, loc, name, body, imports);
        assert t.isTemplateValid(IsaTemplates.theory.name());
        ST result = t.getTemplate(IsaTemplates.theory.name());
        //assert result.getAttributes().keySet().contains(IsaTemplates.theory.arg);?
        result.add(IsaTemplates.theory.arg, t);
        return result; 
    }

    public static final ST newIsaClaim(String comment, IsaClaim.ClaimKind kind, IsaIdentifier name, String expr, IsaAttribute... attrs)
    {
        IsaClaim t = new IsaClaim(comment, kind, name, expr, attrs);
        assert t.isTemplateValid(IsaTemplates.claim.name());
        ST result = t.getTemplate(IsaTemplates.claim.name());
        result.add(IsaTemplates.claim.arg, t);
        return result; 
    }

    public static final ST newIsaLemmas(String comment, IsaIdentifier name, String... lemmas)
    {
        IsaLemmas t = new IsaLemmas(comment, name, lemmas);
        assert t.isTemplateValid(IsaTemplates.lemmas.name());
        ST result = t.getTemplate(IsaTemplates.lemmas.name());
        result.add(IsaTemplates.lemmas.arg, t);
        return result; 
    }

    public static final ST newIsaTypeDecl(String comment, IsaTypeDecl.TypeDeclKind kind, IsaIdentifier name, String... expr)
    {
        IsaTypeDecl t = new IsaTypeDecl(comment, kind, name, expr);
        assert t.isTemplateValid(IsaTemplates.typedecl.name());
        ST result = t.getTemplate(IsaTemplates.typedecl.name());
        result.add(IsaTemplates.typedecl.arg, t);
        return result; 
    }

    public static final IsaRecordField[] newIsaRecordFields(List<IsaIdentifier> names, List<String> types)
    {
        if (names == null || types == null || names.size() != types.size())
            throw new IsaTemplateException("Invalid record fields: names and types must be of same size");
        IsaRecordField[] result = new IsaRecordField[names.size()];
        for(int i = 0; i < names.size(); i++)
        {
            result[i] = new IsaRecordField(names.get(i), types.get(i));
        }
        assert result.length == names.size();
        return result; 
    }

    public static final ST newIsaRecord(String comment, IsaIdentifier name, IsaRecordField... fields)
    {
        IsaRecord t = new IsaRecord(comment, name, fields);
        assert t.isTemplateValid(IsaTemplates.record.name());
        ST result = t.getTemplate(IsaTemplates.record.name());
        result.add(IsaTemplates.record.arg, t);
        return result; 
    }

    public static final ST newIsaAbbreviation(String comment, IsaIdentifier name, String type, String expr)
    {
        IsaAbbreviation t = new IsaAbbreviation(comment, name, type, expr);
        assert t.isTemplateValid(IsaTemplates.abbreviation.name());
        ST result = t.getTemplate(IsaTemplates.abbreviation.name());
        result.add(IsaTemplates.abbreviation.arg, t);
        return result; 
    }

    public static final ST newIsaDefinition(String comment, IsaIdentifier name, String type, String expr, boolean eq, IsaAttribute... attrs)
    {
        IsaDefinition t = new IsaDefinition(comment, name, type, expr, eq, attrs);
        assert t.isTemplateValid(IsaTemplates.definition.name());
        ST result = t.getTemplate(IsaTemplates.definition.name());
        result.add(IsaTemplates.definition.arg, t);
        return result; 
    }

    public static final ST newIsaVDMFunDef(String comment, IsaIdentifier name, String type, String expr, boolean eq, IsaAttribute... attrs)
    {
        IsaVDMFunDef t = new IsaVDMFunDef(comment, name, type, expr, attrs);
        assert t.isTemplateValid(IsaTemplates.fundef.name());
        ST result = t.getTemplate(IsaTemplates.fundef.name());
        result.add(IsaTemplates.fundef.arg, t);
        return result; 
    }

    public static final ST newIsaRecursiveFunDef(String comment, IsaIdentifier name, String type, String expr, boolean eq, IsaAttribute... attrs)
    {
        IsaVDMFunDef t = new IsaVDMFunDef(comment, name, type, expr, attrs);
        assert t.isTemplateValid(IsaTemplates.fundef.name());
        ST result = t.getTemplate(IsaTemplates.fundef.name());
        result.add(IsaTemplates.fundef.arg, t);
        return result; 
    }

    public static final ST newIsaMutuallyRecursiveFunDef(String comment, IsaIdentifier name, String type, String expr, boolean eq, IsaAttribute... attrs)
    {
        IsaVDMFunDef t = new IsaVDMFunDef(comment, name, type, expr, attrs);
        assert t.isTemplateValid(IsaTemplates.fundef.name());
        ST result = t.getTemplate(IsaTemplates.fundef.name());
        result.add(IsaTemplates.fundef.arg, t);
        return result; 
    }

    public static final ST newIsaIfThenElse(String comment, String test, String then, String els)
    {
        IsaIfThenElse t = new IsaIfThenElse(comment, test, then, els);
        assert t.isTemplateValid(IsaTemplates.ifexp.name());
        ST result = t.getTemplate(IsaTemplates.ifexp.name());
        result.add(IsaTemplates.ifexp.arg, t);
        return result; 
    }
}
