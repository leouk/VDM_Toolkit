package vdm2isa.tr.templates;

import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupFile;

import com.fujitsu.vdmj.lex.LexLocation;

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
        
        st = IsaTemplatesHelper.newIsaTypeSynonym(null, IsaTemplatesHelper.newIsaVDMSourceANY(), "MyType", "nat");
        processST(st);
        
        st = IsaTemplatesHelper.newIsaDatatype(null, IsaTemplatesHelper.newIsaVDMSourceANY(), "MyDType", Arrays.asList("A", "B", "C"));
        processST(st);

        st = IsaTemplatesHelper.newIsaLemmas(null, IsaTemplatesHelper.newIsaVDMSourceANY(), "LemmasNames", Arrays.asList("Lemma1", "Lemma2", "Lemma3"));
        processST(st);

        st = IsaTemplatesHelper.newIsaClaim(null, IsaTemplatesHelper.newIsaVDMSourceANY(), ClaimKind.theorem, "test", Arrays.asList(IsaAttribute.simp, IsaAttribute.elim), "x > 0", Arrays.asList());
        processST(st);

        st = IsaTemplatesHelper.newIsaAbbreviation(null, IsaTemplatesHelper.newIsaVDMSourceANY(), Arrays.asList("abbrev"), Arrays.asList("nat"), "10");
        processST(st);

        st = IsaTemplatesHelper.newIsaVDMSpecification(null, IsaTemplatesHelper.newIsaVDMSourceANY(), Arrays.asList("geqDef", "x"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.simp),false, "x > 1");
        processST(st);

        st = IsaTemplatesHelper.newIsaRecord(null, IsaTemplatesHelper.newIsaVDMSourceANY(), "myRec", 
            IsaTemplatesHelper.newIsaRecordFields(LexLocation.ANY, Arrays.asList("field1", "field2"), Arrays.asList("nat", "int")));
        processST(st);

        st = IsaTemplatesHelper.newIsaRecord(null, IsaTemplatesHelper.newIsaVDMSourceANY(), "myRec2", 
           Arrays.asList(IsaRecordField.valueOf(LexLocation.ANY, "field1", "nat"), IsaRecordField.valueOf(LexLocation.ANY, "field2", "int")));
        processST(st);
        
        st = IsaTemplatesHelper.newIsaVDMFunDef(Arrays.asList("VDM function definition"), IsaTemplatesHelper.newIsaVDMSourceANY(), Arrays.asList("myFunDef", "x", "y"), Arrays.asList("nat", "nat", "bool"), Arrays.asList(), false, "x+y > 10");
        processST(st);

        st = IsaTemplatesHelper.newIsaRecursiveFunDef(Arrays.asList("Isabelle automatic recursive definition"), IsaTemplatesHelper.newIsaVDMSourceANY(), Arrays.asList("fact", "n"), Arrays.asList("nat", "nat"), Arrays.asList(IsaAttribute.iff), false, "(if n = 0 then 1 else n*fact(n-1))");
        processST(st);

        st = IsaTemplatesHelper.newIsaMutuallyRecursiveFunDef(
            Arrays.asList(IsaTemplatesHelper.newIsaDefinitionStruc(Arrays.asList("Isabelle even"), IsaTemplatesHelper.newIsaVDMSourceANY(), Arrays.asList("even", "n"), 
                                Arrays.asList("nat", "bool"), Arrays.asList(), true, "(if n = 0 then True else odd (n-1))"),
                           IsaTemplatesHelper.newIsaDefinitionStruc(Arrays.asList("Isabelle odd"), IsaTemplatesHelper.newIsaVDMSourceANY(), Arrays.asList("odd", "n"), Arrays.asList("nat", "bool"), 
                                Arrays.asList(), true, "(if n = 0 then False else even (n-1))")));
        processST(st);

        st = IsaTemplatesHelper.newIsaTheory(Instant.now(), "Comment", LexLocation.ANY, null, "TemplateTheory", Arrays.asList("Import"), sts, Arrays.asList(IsaTemplatesHelper.newIsaVDMExportStruc(null, IsaTemplatesHelper.newIsaVDMSourceANY(), IsaVDMTheoryExport.ExportKind.hide_const, "whichever")));
        processST(st);

        sts.clear();
    }

    public static void test2() 
    {
        group = new STGroupFile(ISA_TEMPLATE_GROUPDIR + "theoryobj.stg", '$', '$');

        st = group.getInstanceOf("theory");
        st.add("thy", new IsaTheory(Instant.now(), "Comment", LexLocation.ANY, null, IsaIdentifier.valueOf(LexLocation.ANY, "MyTheory"), IsaIdentifier.listOf(LexLocation.ANY, "Import"), Arrays.asList("\tnothing"),
        Arrays.asList(new IsaVDMTheoryExport(null, IsaTemplatesHelper.newIsaVDMSourceANY(), IsaVDMTheoryExport.ExportKind.hide_const, IsaIdentifier.valueOf(LexLocation.ANY, "Test"))))); 
        System.out.println(st.render());

        st = group.getInstanceOf("typesynonym");
        st.add("tsym", new IsaTypeSynonym(null, IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.valueOf(LexLocation.ANY, "MyType"), "nat"));
        System.out.println(st.render());

        st = group.getInstanceOf("datatype");
        st.add("dtype", new IsaDatatype(null, IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.valueOf(LexLocation.ANY, "MyDType"), Arrays.asList("A", "B", "C")));
        System.out.println(st.render());

        st = group.getInstanceOf("lemmas");
        st.add("lms", new IsaLemmas(null, IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.valueOf(LexLocation.ANY, "LemmasNames"), IsaIdentifier.listOf(LexLocation.ANY, "Lemma1", "Lemma2", "Lemma3")));
        System.out.println(st.render());

        st = group.getInstanceOf("claim");
        st.add("clm", new IsaClaim(null, IsaTemplatesHelper.newIsaVDMSourceANY(), ClaimKind.theorem, IsaIdentifier.valueOf(LexLocation.ANY, "test"), Arrays.asList(IsaAttribute.simp, IsaAttribute.elim), "x > 0", Arrays.asList()));
        System.out.println(st.render());

        st = group.getInstanceOf("abbreviation");
        st.add("def", new IsaAbbreviation(null, IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.listOf(LexLocation.ANY, "abbrev"), Arrays.asList("nat"), "10"));
        System.out.println(st.render());

        st = group.getInstanceOf("definition");
        st.add("def", new IsaDefinition(null, IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.listOf(LexLocation.ANY, "geqDef", "x"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.simp),false, "x > 1"));
        System.out.println(st.render());

        st = group.getInstanceOf("record");
        IsaRecord r = new IsaRecord(null, IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.valueOf(LexLocation.ANY, "myRec"), 
                                Arrays.asList(IsaRecordField.valueOf(LexLocation.ANY, "field1", "nat"),
                                IsaRecordField.valueOf(LexLocation.ANY, "field2", "int")));
        st.add("rec", r);
        System.out.println(st.render());

        st = group.getInstanceOf("fundef");
        st.add("fdef", new IsaDefinition(Arrays.asList("VDM function definition"), IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.listOf(LexLocation.ANY, "myFunDef", "x", "y"), Arrays.asList("nat", "nat", "bool"), Arrays.asList(), false, "x+y > 10"));
        System.out.println(st.render());

        IsaDefinition d = new IsaDefinition(Arrays.asList("Isabelle automatic recursive definition"), IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.listOf(LexLocation.ANY, "fact", "n"), Arrays.asList("nat", "nat"), Arrays.asList(IsaAttribute.iff), false, "(if n = 0 then 1 else n*fact(n-1))");
        st = group.getInstanceOf("rfundef");
        st.add("fdef", d);
        System.out.println(st.render());

        st = group.getInstanceOf("rfundef");
        d = new IsaDefinition(Arrays.asList("Isabelle even"), IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.listOf(LexLocation.ANY, "even", "n"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.simp), true, "(if n = 0 then True else odd (n-1))");
        st.add("fdef", d);
        d = new IsaDefinition(Arrays.asList("Isabelle odd"), IsaTemplatesHelper.newIsaVDMSourceANY(), IsaIdentifier.listOf(LexLocation.ANY, "odd", "n"), Arrays.asList("nat", "bool"), Arrays.asList(IsaAttribute.iff), true, "(if n = 0 then False else even (n-1))");
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
