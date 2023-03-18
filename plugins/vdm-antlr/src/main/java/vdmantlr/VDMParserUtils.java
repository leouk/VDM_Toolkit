package vdmantlr;


import java.util.Arrays;
import java.util.Comparator;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.misc.Interval;

import vdmantlr.generated.VDMParser;

/**
 * This file is heavily influenced by PVS-ANTLR ParserUtils class
 */
public class VDMParserUtils {
    
    /**
     * Scope of a declaration, in the form of a range in the document { start: { line: NUMBER, character: NUMBER }, end: { line: NUMBER, character: NUMBER } }.
     */
    public static class Range {
        int start_line;
        int start_character;
        int stop_line;
        int stop_character;
        Range (int start_line, int start_character, int stop_line, int stop_character) {
            this.start_line = start_line;
            this.start_character = start_character;
            this.stop_line = stop_line;
            this.stop_character = stop_character;
        }
        public String toString () {
            return "{ \"start\": "
                + "{ \"line\": " + this.start_line
                + ", \"character\": " + this.start_character
                + " }, \"end\": "
                + "{ \"line\": " + this.stop_line
                + ", \"character\": " + this.stop_character
                + " } }";
        }
    }
    
    /**
     * Declaration descriptor. 
     * Includes the following information: position (line, character), name of the identifier, full declaration of the identifier
     */
    public static class DeclDescriptor {
        int line;
        int character;
        String theoryName;
        String identifier;
        String declaration;
        Range scope;
        String fname;
        ParserRuleContext ctx; // this is a pointer to the original token created by the lexer
        DeclDescriptor (String identifier, String theoryName, int line, int character, String declaration, Range scope, String fname, ParserRuleContext ctx) {
            this.line = line;
            this.character = character;
            this.identifier = identifier;
            this.theoryName = theoryName;
            this.declaration = declaration;
            this.scope = scope;
            this.fname = fname;
            this.ctx = ctx;
        }
        public String toString () {
            return "{ \"line\": " + this.line
                + ", \"character\": " + this.character
                + ", \"identifier\": \"" + this.identifier + "\""
                + ", \"theoryName\": \"" + this.theoryName + "\""
                + ", \"declaration\": \"" + this.declaration + "\""
                + ", \"scope\": " + this.scope
                + " }";
        }
        public String outline () {
            return "{ \"line\": " + this.line
                + ", \"character\": " + this.character
                + ", \"identifier\": \"" + this.identifier + "\""
                + ", \"theoryName\": \"" + this.theoryName + "\""
                + " }";
        }
    }

    public static Range createRange(String identifier, ParserRuleContext ctx, ParserRuleContext parentCandidate)
    {
        // scope goes from the end of the declaration to the end of the parent node
        Token start = ctx.getStop();
        Token stop = parentCandidate.getStop();
        int start_line = start.getLine();
        int from_col = start.getCharPositionInLine() + 1 + start.getText().length();
        int stop_line = stop.getLine();
        int to_col = stop.getCharPositionInLine() + 1 + stop.getText().length();
        System.out.println("\nSCOPE of " + identifier + " is " + ((parentCandidate instanceof VDMParser.Sl_documentContext) ? "whole module" : getSource(parentCandidate)));
        System.out.println("start " + start_line + "(" + from_col + ")");
        System.out.println("stop " + stop_line + "(" + to_col + ")");
        return new Range(start_line, from_col, stop_line, to_col);
    }

    public static Range findScope(ParserRuleContext ctx)
    {
        return findScope(null, ctx);
    }

    /**
     * Find the scope of an identifier. Identifier can be null for contexts not involving names
     * @param identifier (String) Name of the identifier
     * @param ctx (ParserRuleContext) ANTLR context of the identifier
     */
    public static Range findScope (String identifier, ParserRuleContext ctx) 
    {
        ParserRuleContext candidate = ctx.getParent();
        while (candidate != null) 
        {
            // how wide to go depends on who needs the location information? 
            if (   candidate instanceof VDMParser.PatternContext
                || candidate instanceof VDMParser.BindContext
                || candidate instanceof VDMParser.ExpressionContext
                || candidate instanceof VDMParser.TypeContext
                || candidate instanceof VDMParser.StatementContext
                || candidate instanceof VDMParser.NameContext
                // || candidate instanceof VDMParser.State_definitionContext
                // || candidate instanceof VDMParser.Sl_value_definitionsContext
                // || candidate instanceof VDMParser.Sl_function_definitionsContext
                // || candidate instanceof VDMParser.Sl_operation_definitionsContext
                // || candidate instanceof VDMParser.Traces_definitionsContext
               ) 
            {
                return createRange(identifier, ctx, candidate);
            }
            candidate = candidate.getParent();
        }
        return null;
    }

    // public static String findScopeName (ParserRuleContext ctx) {
    //     String scopeName = null;
    //     RuleContext candidate = ctx.parent;
    //     while (candidate != null) 
    //     {
    //         if (candidate instanceof VDMParser.Type_definitionContext) 
    //         {
    //             VDMParser.Type_definitionContext c = (VDMParser.Type_definitionContext) candidate;
    //             scopeName = c.IDENTIFIER().getText();
    //             break;
    //         }
    //         if (candidate instanceof VDMParser.Function_definitionContext) 
    //         {
    //             VDMParser.Function_definitionContext c = (VDMParser.Function_definitionContext) candidate;
    //             if (c.explicit_function_definition() != null)
    //                 scopeName = c.explicit_function_definition().IDENTIFIER(0).getText();
    //             else if (c.implicit_function_definition() != null)
    //                 scopeName = c.implicit_function_definition().IDENTIFIER().getText();
    //             else if (c.extended_explicit_function_definition() != null)
    //                 scopeName = c.extended_explicit_function_definition().IDENTIFIER().getText();
    //             //break;
    //         }
    //         candidate = candidate.parent;
    //     }
    //     return scopeName;
    // }

    /**
     * Returns the fragment of source code associated to a given context
     * @param ctx (ParserRuleContex) context for which the source code should be returned
     */
    public static String getSource (ParserRuleContext ctx) 
    {
        Token start = ctx.getStart();
        Token stop = ctx.getStop();
        CharStream cs = start.getInputStream();
        Interval interval = new Interval(start.getStartIndex(), stop.getStopIndex());
        String src = cs.getText(interval);
        return src;
    }

    private static String[] sortedRuleNames = null;
    private static Comparator<String> ruleComparator = null;

    public synchronized static int ruleIndex(String ruleName)
    {
        if (sortedRuleNames == null)
        {   
            ruleComparator = Comparator.comparing(String::toString);
            sortedRuleNames = Arrays.copyOf(VDMParser.ruleNames, VDMParser.ruleNames.length);
            Arrays.sort(sortedRuleNames, ruleComparator);
        }
        return Arrays.binarySearch(sortedRuleNames, ruleName, ruleComparator); 
    }

    public static boolean validRuleName(String ruleName)
    {
        return ruleIndex(ruleName) != -1; 
    }
}
