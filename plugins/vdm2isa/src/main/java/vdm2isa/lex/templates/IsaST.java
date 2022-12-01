package vdm2isa.lex.templates;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.time.Instant;
import java.util.Enumeration;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupFile;

public class IsaST {
    
    public static final String ISA_TEMPLATE_GROUPDIR = "src/main/resources/templates/";

    // Maybe go into this? To avoid having template injection everywehre? 
    public static class IsaTheory0 {

        public static final String TEMPLATE = "theory";
        public static final String UTC      = "utc";
        public static final String LOCATION = "location";
        public static final String NAME     = "name";
        public static final String IMPORTS  = "imports";
        public static final String BODY     = "body";


        private final ST st; 

        public IsaTheory0(STGroupFile stg)
        {
            st = stg.getInstanceOf(TEMPLATE);
            st.add(UTC, Instant.now().toString());
        }

        public IsaTheory0 setLocation(String loc)
        {
            st.add(LOCATION, loc);
            return this;
        }

        public IsaTheory0 setName(String name)
        {
            st.add(NAME, name);
            return this;
        }

        public IsaTheory0 setImports(String imp)
        {
            st.add(IMPORTS, imp);
            return this;
        }
    } 

    public static class IsaTheory {

        public final Instant utc;
        public final String comment;
        public final String location; 
        public final String name;
        public final String imports;
        public final String body;

        public IsaTheory(String location, String name, String imports, String body)
        {
            this(Instant.now(), "", location, name, imports, body);
        }

        public IsaTheory(Instant utc, String location, String name, String imports, String body)
        {
            this(utc, "", location, name, imports, body);
        }

        public IsaTheory(Instant utc, String comment, String loc, String name, String imports, String body)
        {
            this.utc = utc;
            this.comment = comment;
            this.location = loc;
            this.name = name;
            this.imports = imports;
            this.body = body;
        }
    } 

    public static void main(String[] args) throws IOException
    {
        STGroup.trackCreationEvents = true;
        STGroup group = new STGroupFile(ISA_TEMPLATE_GROUPDIR + "theory.stg", '$', '$');
        ST st = group.getInstanceOf("theory");
        st.add("utc", "NOW!");
        st.add("location", "HERE!");
        st.add("name", "Test");
        st.add("imports", "OtherFile");
        st.add("body", "\tnothing");
        System.out.println(st.render());

        st = group.getInstanceOf("theory2");
        st.add("thy", new IsaTheory("HERE!", "Test", "Import", "\tnothing")); 
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

        st = group.getInstanceOf("tsynonym");
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

        st.inspect();
    }  
}
