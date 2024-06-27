package uk.ac.ncl.util;

import java.util.regex.Pattern;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroupFile;

import com.fujitsu.vdmj.lex.LexLocation;

public enum DafnyTemplates {
    MESSAGES("templates/messages.stg"), 
    DEFINITIONS("templates/definitions.stg"), 
    EXPRESSIONS("templates/expressions.stg"), 
    FUNCTIONS("templates/functions.stg"), 
    STATEMENTS("templates/statements.stg"), 
    MODULES("templates/modules.stg"),
    PATTERNS("templates/patterns.stg"),
    IMPORT("templates/imports.stg"),
    TYPES("templates/types.stg");

    private final STGroupFile group;

    private DafnyTemplates(String path) {
        group = new STGroupFile(path);
    }

    public ST loadTemplate(String templateName) {
        return group.getInstanceOf("/" + templateName);
    }

    public static final String banner(String msg) {
        // StringBuilder sb = new StringBuilder();
        // final int msgSize = msg.length();
        // final int bannerSize = msgSize * 2 < 100 ? 100 : msgSize * 2;
        // for (int idx = 0; idx < bannerSize; idx++) {
        //     sb.append("/");
        // }
        // sb.append("\n");
        // for (int idx = 0; idx < (bannerSize / 2) - (msgSize / 2) - 1; idx++) {
        //     sb.append("/");
        // }
        // sb.append(" " + msg + " ");
        // for (int idx = 0; idx < bannerSize - ((bannerSize / 2) - (msgSize / 2) - 1) - (msgSize) - 2; idx++) {
        //     sb.append("/");
        // }
        // sb.append("\n");
        // for (int idx = 0; idx < bannerSize; idx++) {
        //     sb.append("/");
        // }
        return String.format("/*    %1$s     */", msg);
        // return sb.toString();
    }

    /**
     * Render a template within the selected template group
     * @param templateName the template name to use, this should be in the referenced stg file
     * @param pairs Pairs of parameters, should be a <code>String -> Object</code> mapping; generally just <code>Pair.of("name", this)</code>
     * @return rendered template with the parameters given in the pairs object.
     */
    @SafeVarargs
    public final String render(String templateName, Pair<String, Object>... pairs) {
        return render(loadTemplate(templateName), pairs);
    }

    @SafeVarargs
    public final String render(ST template, Pair<String, Object>... pairs) {
        for (Pair<String, Object> pair: pairs)
            template.add(pair.key(), pair.value());
        return template.render();
    }

    @SafeVarargs
    public final static String renderTemplate(String templateString, Pair<String, Object>... pairs) {
        ST template = new ST(templateString);
        for (Pair<String, Object> pair: pairs)
            template.add(pair.key(), pair.value());
        return template.render();
    }
}
