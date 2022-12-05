package vdm2isa.lex.templates;

import java.io.IOException;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupFile;

import vdm2isa.lex.templates.IsaClaim.ClaimKind;
import vdm2isa.lex.templates.IsaTypeDecl.TypeDeclKind;

public class IsaST {
    
    public static final String ISA_TEMPLATE_GROUPDIR = "src/main/resources/templates/";

    private static STGroup group; 
    private static ST st;
    
    public static void main(String[] args) throws IOException
    {
        //STGroup.verbose = true;
        STGroup.trackCreationEvents = true;
        
        test2();
    }

    public static void test2() 
    {
        group = new STGroupFile(ISA_TEMPLATE_GROUPDIR + "theoryobj.stg", '$', '$');

        st = group.getInstanceOf("theory");
        st.add("thy", new IsaTheory("HERE!", "Test", "Import", "\tnothing")); 
        System.out.println(st.render());

        st = group.getInstanceOf("typedecl");
        st.add("tdecl", new IsaTypeDecl(TypeDeclKind.type_synonym, "MyType", "nat"));
        System.out.println(st.render());

        st = group.getInstanceOf("typedecl");
        st.add("tdecl", new IsaTypeDecl(TypeDeclKind.datatype, "MyDType", "A", "B", "C"));
        System.out.println(st.render());

        st = group.getInstanceOf("lemmas");
        st.add("lms", new IsaLemmas(IsaIdentifier.valueOf("LemmasNames"), "Lemma1", "Lemma2", "Lemma3"));
        System.out.println(st.render());

        st = group.getInstanceOf("claim");
        st.add("clm", new IsaClaim(ClaimKind.theorem, IsaIdentifier.valueOf("test"), "x > 0", IsaAttribute.simp, IsaAttribute.elim));
        System.out.println(st.render());

        st = group.getInstanceOf("abbreviation");
        st.add("abbrv", new IsaAbbreviation(IsaIdentifier.valueOf("abbrev"), "nat", "10"));
        System.out.println(st.render());

        st = group.getInstanceOf("definition");
        st.add("def", new IsaDefinition(IsaIdentifier.valueOf("myDef"), "nat", "10", IsaAttribute.simp));
        System.out.println(st.render());

        st = group.getInstanceOf("record");
        IsaRecord r = new IsaRecord(IsaIdentifier.valueOf("myRec"), 
                                IsaRecordField.valueOf("field1", "nat"),
                                IsaRecordField.valueOf("field2", "int"));
        st.add("rec", r);
        System.out.println(st.render());

        st.inspect();
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
