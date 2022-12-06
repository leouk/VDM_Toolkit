package vdm2isa.tr.templates;

import java.io.IOException;
import java.time.Instant;
import java.util.Arrays;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupFile;

import vdm2isa.tr.templates.IsaClaim.ClaimKind;
import vdm2isa.tr.templates.IsaTypeDecl.TypeDeclKind;

public class IsaST {
    
    public static final String ISA_TEMPLATE_GROUPDIR = "src/main/resources/templates/";

    private static STGroup group; 
    private static ST st;
    
    public static void main(String[] args) throws IOException
    {
        //STGroup.verbose = true;
        STGroup.trackCreationEvents = true;
        
        test3();
    }

    public static void test3()
    {
        st = IsaTemplatesHelper.newIsaTheory(Instant.now(), "Comment", "Location", "MyTheory", Arrays.asList("Import"), Arrays.asList("\tnothing"));
        System.out.println(st.render());

        st = IsaTemplatesHelper.newIsaTypeDecl("", TypeDeclKind.type_synonym, "MyType", Arrays.asList("nat"));
        System.out.println(st.render());
        
        st = IsaTemplatesHelper.newIsaTypeDecl("", TypeDeclKind.datatype, "MyDType", Arrays.asList("A", "B", "C"));
        System.out.println(st.render());

        st = IsaTemplatesHelper.newIsaLemmas(null, "LemmasNames", Arrays.asList("Lemma1", "Lemma2", "Lemma3"));
        System.out.println(st.render());

        st = IsaTemplatesHelper.newIsaClaim(null, ClaimKind.theorem, "test", Arrays.asList(IsaAttribute.simp, IsaAttribute.elim), "x > 0");
        System.out.println(st.render());

        st = IsaTemplatesHelper.newIsaAbbreviation("", Arrays.asList("abbrev"), Arrays.asList("nat"), "10");
        System.out.println(st.render());

        st = IsaTemplatesHelper.newIsaDefinition("", Arrays.asList("geqDef", "x"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.simp),false, "x > 1");
        System.out.println(st.render());

        st = IsaTemplatesHelper.newIsaRecord("", "myRec", 
            IsaTemplatesHelper.newIsaRecordFields(Arrays.asList("field1", "field2"), Arrays.asList("nat", "int")));
        System.out.println(st.render());

        st = IsaTemplatesHelper.newIsaRecord("", "myRec", 
           Arrays.asList(IsaRecordField.valueOf("field1", "nat"), IsaRecordField.valueOf("field2", "int")));
        System.out.println(st.render());
        
        st = IsaTemplatesHelper.newIsaVDMFunDef("VDM function definition", Arrays.asList("myFunDef", "x", "y"), Arrays.asList("nat", "nat", "bool"), Arrays.asList(), false, "x+y > 10");
        System.out.println(st.render());

        st = IsaTemplatesHelper.newIsaRecursiveFunDef("Isabelle automatic recursive definition", Arrays.asList("fact", "n"), Arrays.asList("nat", "nat"), Arrays.asList(IsaAttribute.iff), false, "(if n = 0 then 1 else n*fact(n-1))");
        System.out.println(st.render());

        st = IsaTemplatesHelper.newIsaMutuallyRecursiveFunDef(
            Arrays.asList(IsaTemplatesHelper.newIsaDefinitionStruc("Isabelle even", Arrays.asList("even", "n"), 
                                Arrays.asList("nat", "bool"), Arrays.asList(), true, "(if n = 0 then True else odd (n-1))"),
                           IsaTemplatesHelper.newIsaDefinitionStruc("Isabelle odd", Arrays.asList("odd", "n"), Arrays.asList("nat", "bool"), 
                                Arrays.asList(), true, "(if n = 0 then False else even (n-1))")));
        System.out.println(st.render());
    }

    public static void test2() 
    {
        group = new STGroupFile(ISA_TEMPLATE_GROUPDIR + "theoryobj.stg", '$', '$');

        st = group.getInstanceOf("theory");
        st.add("thy", new IsaTheory(Instant.now(), "Comment", "Location", IsaIdentifier.valueOf("MyTheory"), IsaIdentifier.listOf("Import"), Arrays.asList("\tnothing"))); 
        System.out.println(st.render());

        st = group.getInstanceOf("typedecl");
        st.add("tdecl", new IsaTypeDecl("", TypeDeclKind.type_synonym, IsaIdentifier.valueOf("MyType"), Arrays.asList("nat")));
        System.out.println(st.render());

        st = group.getInstanceOf("typedecl");
        st.add("tdecl", new IsaTypeDecl("", TypeDeclKind.datatype, IsaIdentifier.valueOf("MyDType"), Arrays.asList("A", "B", "C")));
        System.out.println(st.render());

        st = group.getInstanceOf("lemmas");
        st.add("lms", new IsaLemmas(null, IsaIdentifier.valueOf("LemmasNames"), IsaIdentifier.listOf("Lemma1", "Lemma2", "Lemma3")));
        System.out.println(st.render());

        st = group.getInstanceOf("claim");
        st.add("clm", new IsaClaim(null, ClaimKind.theorem, IsaIdentifier.valueOf("test"), Arrays.asList(IsaAttribute.simp, IsaAttribute.elim), "x > 0"));
        System.out.println(st.render());

        st = group.getInstanceOf("abbreviation");
        st.add("abbrv", new IsaAbbreviation("", IsaIdentifier.listOf("abbrev"), Arrays.asList("nat"), "10"));
        System.out.println(st.render());

        st = group.getInstanceOf("definition");
        st.add("def", new IsaDefinition("", IsaIdentifier.listOf("geqDef", "x"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.simp),false, "x > 1"));
        System.out.println(st.render());

        st = group.getInstanceOf("record");
        IsaRecord r = new IsaRecord("", IsaIdentifier.valueOf("myRec"), 
                                Arrays.asList(IsaRecordField.valueOf("field1", "nat"),
                                IsaRecordField.valueOf("field2", "int")));
        st.add("rec", r);
        System.out.println(st.render());

        st = group.getInstanceOf("fundef");
        st.add("fdef", new IsaDefinition("VDM function definition", IsaIdentifier.listOf("myFunDef", "x", "y"), Arrays.asList("nat", "nat", "bool"), Arrays.asList(), false, "x+y > 10"));
        System.out.println(st.render());

        IsaDefinition d = new IsaDefinition("Isabelle automatic recursive definition", IsaIdentifier.listOf("fact", "n"), Arrays.asList("nat", "nat"), Arrays.asList(IsaAttribute.iff), false, "(if n = 0 then 1 else n*fact(n-1))");
        st = group.getInstanceOf("rfundef");
        st.add("fdef", d);
        System.out.println(st.render());

        st = group.getInstanceOf("rfundef");
        d = new IsaDefinition("Isabelle even", IsaIdentifier.listOf("even", "n"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.simp), true, "(if n = 0 then True else odd (n-1))");
        st.add("fdef", d);
        d = new IsaDefinition("Isabelle odd", IsaIdentifier.listOf("odd", "n"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.iff), true, "(if n = 0 then False else even (n-1))");
        st.add("fdef", d);
        System.out.println(st.render());

        // st = group.getInstanceOf("listIt");
        // st.add("l", d);
        // st.add("l", d);
        // st.add("l", d);
        // System.out.println(st.render());

        //        st.inspect();
    }

    public static void test1() throws IOException
    {
        group = new STGroupFile(ISA_TEMPLATE_GROUPDIR + "theory.stg", '$', '$');

        st = group.getInstanceOf("theory");
        st.add("utc", "NOW!");
        st.add("location", "HERE!");
        st.add("name", "Test");
        st.add("imports", "OtherFile");
        st.add("body", "\tnothing");
        System.out.println(st.render());

        st = group.getInstanceOf("abbreviation");
        st.add("name", "test");
        st.add("type", "VDMNat \\<Rightarrow> \\<bool>");
        st.add("expr", "True");
        System.out.println(st.render());
        st = group.getInstanceOf("definition");
        st.add("name", "test");
        st.add("type", "VDMNat \\<Rightarrow> \\<bool>");
        st.add("attr", "simp");
        st.add("attr", "intro!");
        st.add("expr", "True");
        System.out.println(st.render());
        //st.inspect();

        st = group.getInstanceOf("typedecl");
        st.add("kind", "type_synonym");
        st.add("name", "'a");
        st.add("name", "test");
        st.add("expr", "'a set");
        System.out.println(st.render());

        st = group.getInstanceOf("typedecl");
        st.add("kind", "datatype");
        st.add("name", "'a");
        st.add("name", "test");
        st.add("expr", "'a set");
        System.out.println(st.render());

        st = group.getInstanceOf("lemmas");
        st.add("name", "test");
        st.add("lemma", "f_def");
        st.add("lemma", "g_def");
        System.out.println(st.render());

        st = group.getInstanceOf("claim");
        st.add("kind", "lemma");
        st.add("name", "test");
        st.add("attr", "simp");
        st.add("attr", "intro!");
        st.add("expr", "True");
        System.out.println(st.render());

        st = group.getInstanceOf("claim");
        st.add("kind", "theorem");
        st.add("name", "test");
        st.add("attr", "simp");
        st.add("attr", "intro!");
        st.add("expr", "True");
        System.out.println(st.render());

        //st.inspect();
    }  
}
