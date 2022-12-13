package vdm2isa.tr.templates;

import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupFile;

import vdm2isa.tr.templates.IsaClaim.ClaimKind;

public class IsaST {
    
    public static final String ISA_TEMPLATE_GROUPDIR = "src/main/resources/templates/";

    private static STGroup group; 
    private static ST st;
    private static List<String> sts;
    private static boolean debug;

    
    public static void main(String[] args) throws IOException
    {
        //STGroup.verbose = true;
        STGroup.trackCreationEvents = true;
        debug = true;
        
        test3();
    }

    private static void processST(ST st)
    {
        String s = st.render();
        sts.add(s);
        if (debug) System.out.println(s);
    }

    public static void test3()
    {
        sts = new ArrayList<>();
        
        st = IsaTemplatesHelper.newIsaTypeSynonym(null, null, "MyType", "nat");
        processST(st);
        
        st = IsaTemplatesHelper.newIsaDatatype(null, null, "MyDType", Arrays.asList("A", "B", "C"));
        processST(st);

        st = IsaTemplatesHelper.newIsaLemmas(null, null, "LemmasNames", Arrays.asList("Lemma1", "Lemma2", "Lemma3"));
        processST(st);

        st = IsaTemplatesHelper.newIsaClaim(null, null, ClaimKind.theorem, "test", Arrays.asList(IsaAttribute.simp, IsaAttribute.elim), "x > 0", Arrays.asList());
        processST(st);

        st = IsaTemplatesHelper.newIsaAbbreviation(null, null, Arrays.asList("abbrev"), Arrays.asList("nat"), "10");
        processST(st);

        st = IsaTemplatesHelper.newIsaDefinition(null, null, Arrays.asList("geqDef", "x"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.simp),false, "x > 1");
        processST(st);

        st = IsaTemplatesHelper.newIsaRecord(null, null, "myRec", 
            IsaTemplatesHelper.newIsaRecordFields(Arrays.asList("field1", "field2"), Arrays.asList("nat", "int")));
        processST(st);

        st = IsaTemplatesHelper.newIsaRecord(null, null, "myRec2", 
           Arrays.asList(IsaRecordField.valueOf("field1", "nat"), IsaRecordField.valueOf("field2", "int")));
        processST(st);
        
        st = IsaTemplatesHelper.newIsaVDMFunDef(Arrays.asList("VDM function definition"), null, Arrays.asList("myFunDef", "x", "y"), Arrays.asList("nat", "nat", "bool"), Arrays.asList(), false, "x+y > 10");
        processST(st);

        st = IsaTemplatesHelper.newIsaRecursiveFunDef(Arrays.asList("Isabelle automatic recursive definition"), null, Arrays.asList("fact", "n"), Arrays.asList("nat", "nat"), Arrays.asList(IsaAttribute.iff), false, "(if n = 0 then 1 else n*fact(n-1))");
        processST(st);

        st = IsaTemplatesHelper.newIsaMutuallyRecursiveFunDef(
            Arrays.asList(IsaTemplatesHelper.newIsaDefinitionStruc(Arrays.asList("Isabelle even"), null, Arrays.asList("even", "n"), 
                                Arrays.asList("nat", "bool"), Arrays.asList(), true, "(if n = 0 then True else odd (n-1))"),
                           IsaTemplatesHelper.newIsaDefinitionStruc(Arrays.asList("Isabelle odd"), null, Arrays.asList("odd", "n"), Arrays.asList("nat", "bool"), 
                                Arrays.asList(), true, "(if n = 0 then False else even (n-1))")));
        processST(st);

        st = IsaTemplatesHelper.newIsaTheory(Instant.now(), "Comment", "Location", "TemplateTheory", Arrays.asList("Import"), sts, Arrays.asList(IsaTemplatesHelper.newIsaVDMExportStruc(null, null, IsaVDMTheoryExport.ExportKind.hide_const, "whichever")));
        processST(st);

        sts.clear();
    }

    public static void test2() 
    {
        group = new STGroupFile(ISA_TEMPLATE_GROUPDIR + "theoryobj.stg", '$', '$');

        st = group.getInstanceOf("theory");
        st.add("thy", new IsaTheory(Instant.now(), "Comment", "Location", IsaIdentifier.valueOf("MyTheory"), IsaIdentifier.listOf("Import"), Arrays.asList("\tnothing"),
        Arrays.asList(new IsaVDMTheoryExport(null, null, IsaVDMTheoryExport.ExportKind.hide_const, IsaIdentifier.valueOf("Test"))))); 
        System.out.println(st.render());

        st = group.getInstanceOf("typesynonym");
        st.add("tsym", new IsaTypeSynonym(null, null, IsaIdentifier.valueOf("MyType"), "nat"));
        System.out.println(st.render());

        st = group.getInstanceOf("datatype");
        st.add("dtype", new IsaDatatype(null, null, IsaIdentifier.valueOf("MyDType"), Arrays.asList("A", "B", "C")));
        System.out.println(st.render());

        st = group.getInstanceOf("lemmas");
        st.add("lms", new IsaLemmas(null, null, IsaIdentifier.valueOf("LemmasNames"), IsaIdentifier.listOf("Lemma1", "Lemma2", "Lemma3")));
        System.out.println(st.render());

        st = group.getInstanceOf("claim");
        st.add("clm", new IsaClaim(null, null, ClaimKind.theorem, IsaIdentifier.valueOf("test"), Arrays.asList(IsaAttribute.simp, IsaAttribute.elim), "x > 0", Arrays.asList()));
        System.out.println(st.render());

        st = group.getInstanceOf("abbreviation");
        st.add("def", new IsaAbbreviation(null, null, IsaIdentifier.listOf("abbrev"), Arrays.asList("nat"), "10"));
        System.out.println(st.render());

        st = group.getInstanceOf("definition");
        st.add("def", new IsaDefinition(null, null, IsaIdentifier.listOf("geqDef", "x"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.simp),false, "x > 1"));
        System.out.println(st.render());

        st = group.getInstanceOf("record");
        IsaRecord r = new IsaRecord(null, null, IsaIdentifier.valueOf("myRec"), 
                                Arrays.asList(IsaRecordField.valueOf("field1", "nat"),
                                IsaRecordField.valueOf("field2", "int")));
        st.add("rec", r);
        System.out.println(st.render());

        st = group.getInstanceOf("fundef");
        st.add("fdef", new IsaDefinition(Arrays.asList("VDM function definition"), null, IsaIdentifier.listOf("myFunDef", "x", "y"), Arrays.asList("nat", "nat", "bool"), Arrays.asList(), false, "x+y > 10"));
        System.out.println(st.render());

        IsaDefinition d = new IsaDefinition(Arrays.asList("Isabelle automatic recursive definition"), null, IsaIdentifier.listOf("fact", "n"), Arrays.asList("nat", "nat"), Arrays.asList(IsaAttribute.iff), false, "(if n = 0 then 1 else n*fact(n-1))");
        st = group.getInstanceOf("rfundef");
        st.add("fdef", d);
        System.out.println(st.render());

        st = group.getInstanceOf("rfundef");
        d = new IsaDefinition(Arrays.asList("Isabelle even"), null, IsaIdentifier.listOf("even", "n"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.simp), true, "(if n = 0 then True else odd (n-1))");
        st.add("fdef", d);
        d = new IsaDefinition(Arrays.asList("Isabelle odd"), null, IsaIdentifier.listOf("odd", "n"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.iff), true, "(if n = 0 then False else even (n-1))");
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
