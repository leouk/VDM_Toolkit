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
    public static class IsaTheory {

        public static final String TEMPLATE = "theory";
        public static final String UTC      = "utc";
        public static final String LOCATION = "location";
        public static final String NAME     = "name";
        public static final String IMPORTS  = "imports";
        public static final String BODY     = "body";


        private final ST st; 

        public IsaTheory(STGroupFile stg)
        {
            st = stg.getInstanceOf(TEMPLATE);
            st.add(UTC, Instant.now().toString());
        }

        public IsaTheory setLocation(String loc)
        {
            st.add(LOCATION, loc);
            return this;
        }

        public IsaTheory setName(String name)
        {
            st.add(NAME, name);
            return this;
        }

        public IsaTheory setImports(String imp)
        {
            st.add(IMPORTS, imp);
            return this;
        }
    } 

    public static void main(String[] args) throws IOException
    {
        STGroup.trackCreationEvents = true;
        STGroup group = new STGroupFile(ISA_TEMPLATE_GROUPDIR + "theory.stg", '$', '$');
        ST st = group.getInstanceOf("theory");
        st.add("utc", "AGORA!");
        st.add("location", "LOCATION!");
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
