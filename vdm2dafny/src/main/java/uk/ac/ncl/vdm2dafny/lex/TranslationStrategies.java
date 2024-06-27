package uk.ac.ncl.vdm2dafny.lex;

import org.stringtemplate.v4.ST;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public enum TranslationStrategies {
    PARAMETERISE("<arg0><arg1><arg2>"),
    PARAMETERISE_SPACE("<arg0> <arg1> <arg2>"),
    PREFIX("<arg0><arg1>"),
    PREFIX_SPACE("<arg0> <arg1>"),
    SUFFIX("<arg1><arg2>"),
    SUFFIX_SPACE("<arg1> <arg2>"),
    LITERAL("<arg0>"),
    CALL("<arg0>(<arg1>)"),
    CALL2("<arg0>(<arg1>, <arg2>)"),
    TYPEPARAM("<arg0>\\<<arg1>>"),
    TYPEPARAM2("<arg0>\\<<arg1>, <arg2>>"),
    BIND("<arg0> <arg1> :: <arg2>"),
    ;
    private final String template;
    private static int LINE_LENGTH = 30;

    private TranslationStrategies(String template) {
        this.template = template;
    }
    
    public final String render(String... args) {
        ST template = new ST(this.template);
        for (int i = 0; i < args.length; ++i) {
            template.add(String.format("arg%s", i), args[i]);
        }
        return template.render();
    } 
}
