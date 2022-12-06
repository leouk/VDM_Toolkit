package vdm2isa.tr.templates;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupDir;
import org.stringtemplate.v4.STGroupFile;

public final class IsaTemplatesHelper {
    
    public enum IsaTemplates 
    { 
        theory("thy", "Isabelle theory file"), 
        claim("clm", "Claim (e.g. lemma, theorem, etc.)"),
        lemmas("lms", "Named lemmas group"),
        typedecl("tdecl", "Type declaration (e.g. type synonym or datatype)"),
        record("rec", "Record declaration"),
        abbreviation("abbrv", "Abbreviation (e.g. VDM values)"),
        definition("def", "Definition (e.g. VDM specification, inv/pre/post)"),
        fundef("fdef", "VDM function definition (e.g. body of VDM function)"),
        rfundef("fdef", "VDM (possibly mutually) recursive function as Isabelle fun"),
        rfunctiondef("fdef", "VDM (possibly mutually) recursive function as Isabelle function"),

        ifexp("vdmif", "VDM if-then-else expression")
        ;
    
        public final String arg; 
        public final String doc;

        private IsaTemplates(String attr, String doc)
        {
            this.arg = attr;
            this.doc = doc;
        }

        @Override
        public final String toString()
        {
            return name();
        }

        public final String templateName()
        {
            return name();//ISA_TEMPLATE_MAIN + "/" + name();
        }
    } 

    public static final String ISA_TEMPLATE_GROUPDIR;
    public static final String ISA_TEMPLATE_MAIN;
    protected static final STGroup group;

    static {
        ISA_TEMPLATE_MAIN = "theoryobj.stg";
        ISA_TEMPLATE_GROUPDIR = "src/main/resources/templates/";
        group = new STGroupFile(ISA_TEMPLATE_GROUPDIR + ISA_TEMPLATE_MAIN, '$', '$');//new STGroupDir(ISA_TEMPLATE_GROUPDIR, '$', '$');
    }

    private static final boolean isTemplateValid(String name)
    {
        return group.isDefined(name);
    }

    private static final ST getTemplate(String name)
    {
        if (isTemplateValid(name))
            return group.getInstanceOf(name);
        else 
            throw new IsaTemplateException("Unknown template name in Isabelle template group: " + name);
    }

    public static final ST newIsaTheory(Instant utc, String comment, String loc, String name, List<String> imports, List<String> body)
    {
        IsaTheory t = new IsaTheory(utc, comment, loc, IsaIdentifier.valueOf(name), IsaIdentifier.listOf(imports), body);
        assert isTemplateValid(IsaTemplates.theory.templateName());
        ST result = getTemplate(IsaTemplates.theory.templateName());
        //assert result.getAttributes().keySet().contains(IsaTemplates.theory.arg);?
        result.add(IsaTemplates.theory.arg, t);
        return result; 
    }

    public static final ST newIsaClaim(String comment, IsaClaim.ClaimKind kind, String name, List<IsaAttribute> attrs, String expr)
    {
        IsaClaim t = new IsaClaim(comment, kind, IsaIdentifier.valueOf(name), attrs, expr);
        assert isTemplateValid(IsaTemplates.claim.templateName());
        ST result = getTemplate(IsaTemplates.claim.templateName());
        result.add(IsaTemplates.claim.arg, t);
        return result; 
    }

    public static final ST newIsaLemmas(String comment, String name, List<String> lemmas)
    {
        IsaLemmas t = new IsaLemmas(comment, IsaIdentifier.valueOf(name), IsaIdentifier.listOf(lemmas));
        assert isTemplateValid(IsaTemplates.lemmas.templateName());
        ST result = getTemplate(IsaTemplates.lemmas.templateName());
        result.add(IsaTemplates.lemmas.arg, t);
        return result; 
    }

    /**
     * Represents an Isabelle type declaration for type syonyms and datatypes. 
     * This is used for VDM top-level type definitions (e.g. named types, quote types, etc.).
     * @param comment
     * @param kind
     * @param name
     * @param expr
     * @return
     */

    public static final ST newIsaTypeDecl(String comment, IsaTypeDecl.TypeDeclKind kind, String name, List<String> expr)
    {
        IsaTypeDecl t = new IsaTypeDecl(comment, kind, IsaIdentifier.valueOf(name), expr);
        assert isTemplateValid(IsaTemplates.typedecl.templateName());
        ST result = getTemplate(IsaTemplates.typedecl.templateName());
        result.add(IsaTemplates.typedecl.arg, t);
        return result; 
    }

    public static final List<IsaRecordField> newIsaRecordFields(List<String> names, List<String> types)
    {
        if (names == null || types == null || names.size() != types.size())
            throw new IsaTemplateException("Invalid record fields: names and types must be of same size");
        List<IsaRecordField> result = new ArrayList<IsaRecordField>(names.size());
        for(int i = 0; i < names.size(); i++)
        {
            result.add(IsaRecordField.valueOf(names.get(i), types.get(i)));
        }
        assert result.size() == names.size();
        return result; 
    }

    public static final ST newIsaRecord(String comment, String name, List<IsaRecordField> fields)
    {
        IsaRecord t = new IsaRecord(comment, IsaIdentifier.valueOf(name), fields);
        assert isTemplateValid(IsaTemplates.record.templateName());
        ST result = getTemplate(IsaTemplates.record.templateName());
        result.add(IsaTemplates.record.arg, t);
        return result; 
    }

    /**
     * Represents an Isabelle abbreviation. This is used mostly for VDM values. 
     * @param comment
     * @param name
     * @param type
     * @param expr
     * @return
     */
    public static final ST newIsaAbbreviation(String comment, List<String> name, List<String> type, String expr)
    {
        IsaAbbreviation t = new IsaAbbreviation(comment, IsaIdentifier.listOf(name), type, expr);
        assert isTemplateValid(IsaTemplates.abbreviation.templateName());
        ST result = getTemplate(IsaTemplates.abbreviation.templateName());
        result.add(IsaTemplates.abbreviation.arg, t);
        return result; 
    }

    /**
     * Represents an Isabelle definition. This is used mostly for VDM (inv/pre/post, etc.) specifications.
     * @param comment
     * @param name
     * @param type
     * @param expr
     * @param eq
     * @param attrs
     * @return
     */
    public static final ST newIsaDefinition(String comment, List<String> name, List<String> type, List<IsaAttribute> attrs, boolean eq, String expr)
    {
        IsaDefinition t = IsaTemplatesHelper.newIsaDefinitionStruc(comment, name, type, attrs, eq, expr);
        assert isTemplateValid(IsaTemplates.definition.templateName());
        ST result = getTemplate(IsaTemplates.definition.templateName());
        result.add(IsaTemplates.definition.arg, t);
        return result; 
    }

    /**
     * Creates an IsaDefinition structure, which is useful for various Isabelle definition templates.
     * @param comment
     * @param name
     * @param type
     * @param attrs
     * @param eq
     * @param expr
     * @return
     */
    public static final IsaDefinition newIsaDefinitionStruc(String comment, List<String> name, List<String> type, List<IsaAttribute> attrs, boolean eq, String expr)
    {
        return new IsaDefinition(comment, IsaIdentifier.listOf(name), type, attrs, eq, expr);
    }

    /**
     * Represents VDM function definitions. That means, template will generate a i(f pre_f x then f x else undefined) output. 
     * @param comment
     * @param name
     * @param type
     * @param expr
     * @param eq
     * @param attrs
     * @return
     */
    public static final ST newIsaVDMFunDef(String comment, List<String> name, List<String> type, List<IsaAttribute> attrs, boolean eq, String expr)
    {
        IsaDefinition t = IsaTemplatesHelper.newIsaDefinitionStruc(comment, name, type, attrs, false, expr);
        assert isTemplateValid(IsaTemplates.fundef.templateName());
        ST result = getTemplate(IsaTemplates.fundef.templateName());
        result.add(IsaTemplates.fundef.arg, t);
        return result; 
    }

    /**
     * Represents VDM recursive function definitions translated as an Isabelle fun (automatic termination proof). 
     * That means, template will generate an Isabelle fun declaration with adequate simp sets. These can be mutually recursive.
     * @param comment
     * @param name
     * @param type
     * @param expr
     * @param eq
     * @param attrs
     * @return
     */
    public static final ST newIsaRecursiveFunDef(String comment, List<String> name, List<String> type, List<IsaAttribute> attrs, boolean eq, String expr)
    {
        IsaDefinition t = IsaTemplatesHelper.newIsaDefinitionStruc(comment, name, type, attrs, true, expr);
        assert isTemplateValid(IsaTemplates.rfundef.templateName());
        ST result = getTemplate(IsaTemplates.rfundef.templateName());
        result.add(IsaTemplates.rfundef.arg, t);
        return result; 
    }

        /**
     * Represents VDM recursive function definitions translated as an Isabelle function (user provided termination proof). 
     * That means, template will generate an Isabelle function declaration with adequate simp sets.  These can be mutually recursive.
     * @param comment
     * @param name
     * @param type
     * @param expr
     * @param eq
     * @param attrs
     * @return
     */
    public static final ST newIsaRecursiveFunctionDef(String comment, List<String> name, List<String> type, List<IsaAttribute> attrs, boolean eq, String expr)
    {
        IsaDefinition t = IsaTemplatesHelper.newIsaDefinitionStruc(comment, name, type, attrs, true, expr);
        assert isTemplateValid(IsaTemplates.fundef.templateName());
        ST result = getTemplate(IsaTemplates.fundef.templateName());
        result.add(IsaTemplates.fundef.arg, t);
        return result; 
    }

    public static final ST newIsaMutuallyRecursiveFunDef(List<IsaDefinition> fdefs)
    {
        if (fdefs == null || fdefs.size() == 0)
            throw new IsaTemplateException("Invalid mutually recursive fun definition: empty definitions");
        assert isTemplateValid(IsaTemplates.rfundef.templateName());
        ST result = getTemplate(IsaTemplates.rfundef.templateName());
        result.add(IsaTemplates.rfundef.arg, fdefs);
        return result; 
    }

    public static final ST newIsaMutuallyRecursiveFunctionDef(List<IsaDefinition> fdefs)
    {
        if (fdefs == null || fdefs.size() == 0)
            throw new IsaTemplateException("Invalid mutually recursive function definition: empty definitions");
        assert isTemplateValid(IsaTemplates.rfunctiondef.templateName());
        ST result = getTemplate(IsaTemplates.rfunctiondef.templateName());
        result.add(IsaTemplates.rfunctiondef.arg, fdefs);
        return result; 
    }

    public static final ST newIsaIfThenElse(String comment, String test, String then, String els)
    {
        IsaIfThenElse t = new IsaIfThenElse(comment, test, then, els);
        assert isTemplateValid(IsaTemplates.ifexp.templateName());
        ST result = getTemplate(IsaTemplates.ifexp.templateName());
        result.add(IsaTemplates.ifexp.arg, t);
        return result; 
    }
}
