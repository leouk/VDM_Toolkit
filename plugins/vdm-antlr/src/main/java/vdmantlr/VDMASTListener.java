package vdmantlr;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

import org.antlr.v4.runtime.BaseErrorListener;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonToken;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.DiagnosticErrorListener;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.atn.PredictionMode;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeListener;
import org.antlr.v4.runtime.tree.ParseTreeProperty;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.antlr.v4.runtime.tree.TerminalNode;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.Settings;
/**
 * DO NOT *-import all AST nodes! 
 * 
 * This can mask potential errors on creating the wrong AST for a given production.
 * The "unused import" warning may help to identify those. 
 */
import com.fujitsu.vdmj.ast.ASTNode;
import com.fujitsu.vdmj.ast.definitions.ASTDefinition;
import com.fujitsu.vdmj.ast.definitions.ASTDefinitionList;
import com.fujitsu.vdmj.ast.definitions.ASTTypeDefinition;
import com.fujitsu.vdmj.ast.expressions.*;
import com.fujitsu.vdmj.ast.lex.LexBooleanToken;
import com.fujitsu.vdmj.ast.lex.LexCharacterToken;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;
import com.fujitsu.vdmj.ast.lex.LexIntegerToken;
import com.fujitsu.vdmj.ast.lex.LexKeywordToken;
import com.fujitsu.vdmj.ast.lex.LexNameList;
import com.fujitsu.vdmj.ast.lex.LexNameToken;
import com.fujitsu.vdmj.ast.lex.LexQuoteToken;
import com.fujitsu.vdmj.ast.lex.LexRealToken;
import com.fujitsu.vdmj.ast.lex.LexStringToken;
import com.fujitsu.vdmj.ast.modules.ASTExportAll;
import com.fujitsu.vdmj.ast.modules.ASTExportList;
import com.fujitsu.vdmj.ast.modules.ASTExportedFunction;
import com.fujitsu.vdmj.ast.modules.ASTExportedOperation;
import com.fujitsu.vdmj.ast.modules.ASTExportedType;
import com.fujitsu.vdmj.ast.modules.ASTExportedValue;
import com.fujitsu.vdmj.ast.modules.ASTImport;
import com.fujitsu.vdmj.ast.modules.ASTImportAll;
import com.fujitsu.vdmj.ast.modules.ASTImportFromModule;
import com.fujitsu.vdmj.ast.modules.ASTImportFromModuleList;
import com.fujitsu.vdmj.ast.modules.ASTImportList;
import com.fujitsu.vdmj.ast.modules.ASTImportedFunction;
import com.fujitsu.vdmj.ast.modules.ASTImportedOperation;
import com.fujitsu.vdmj.ast.modules.ASTImportedType;
import com.fujitsu.vdmj.ast.modules.ASTImportedValue;
import com.fujitsu.vdmj.ast.modules.ASTModule;
import com.fujitsu.vdmj.ast.modules.ASTModuleExports;
import com.fujitsu.vdmj.ast.modules.ASTModuleImports;
import com.fujitsu.vdmj.ast.modules.ASTModuleList;
import com.fujitsu.vdmj.ast.patterns.ASTBind;
import com.fujitsu.vdmj.ast.patterns.ASTBooleanPattern;
import com.fujitsu.vdmj.ast.patterns.ASTCharacterPattern;
import com.fujitsu.vdmj.ast.patterns.ASTConcatenationPattern;
import com.fujitsu.vdmj.ast.patterns.ASTExpressionPattern;
import com.fujitsu.vdmj.ast.patterns.ASTIdentifierPattern;
import com.fujitsu.vdmj.ast.patterns.ASTIgnorePattern;
import com.fujitsu.vdmj.ast.patterns.ASTIntegerPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapUnionPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapletPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapletPatternList;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleBind;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleBindList;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleSeqBind;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleSetBind;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleTypeBind;
import com.fujitsu.vdmj.ast.patterns.ASTNamePatternPairList;
import com.fujitsu.vdmj.ast.patterns.ASTNilPattern;
import com.fujitsu.vdmj.ast.patterns.ASTObjectPattern;
import com.fujitsu.vdmj.ast.patterns.ASTPattern;
import com.fujitsu.vdmj.ast.patterns.ASTPatternList;
import com.fujitsu.vdmj.ast.patterns.ASTQuotePattern;
import com.fujitsu.vdmj.ast.patterns.ASTRealPattern;
import com.fujitsu.vdmj.ast.patterns.ASTRecordPattern;
import com.fujitsu.vdmj.ast.patterns.ASTSeqBind;
import com.fujitsu.vdmj.ast.patterns.ASTSetBind;
import com.fujitsu.vdmj.ast.patterns.ASTSetPattern;
import com.fujitsu.vdmj.ast.patterns.ASTStringPattern;
import com.fujitsu.vdmj.ast.patterns.ASTTuplePattern;
import com.fujitsu.vdmj.ast.patterns.ASTTypeBind;
import com.fujitsu.vdmj.ast.patterns.ASTTypeBindList;
import com.fujitsu.vdmj.ast.types.ASTBooleanType;
import com.fujitsu.vdmj.ast.types.ASTCharacterType;
import com.fujitsu.vdmj.ast.types.ASTField;
import com.fujitsu.vdmj.ast.types.ASTFieldList;
import com.fujitsu.vdmj.ast.types.ASTFunctionType;
import com.fujitsu.vdmj.ast.types.ASTInMapType;
import com.fujitsu.vdmj.ast.types.ASTIntegerType;
import com.fujitsu.vdmj.ast.types.ASTMapType;
import com.fujitsu.vdmj.ast.types.ASTNamedType;
import com.fujitsu.vdmj.ast.types.ASTNaturalOneType;
import com.fujitsu.vdmj.ast.types.ASTNaturalType;
import com.fujitsu.vdmj.ast.types.ASTOperationType;
import com.fujitsu.vdmj.ast.types.ASTOptionalType;
import com.fujitsu.vdmj.ast.types.ASTParameterType;
import com.fujitsu.vdmj.ast.types.ASTProductType;
import com.fujitsu.vdmj.ast.types.ASTQuoteType;
import com.fujitsu.vdmj.ast.types.ASTRationalType;
import com.fujitsu.vdmj.ast.types.ASTRealType;
import com.fujitsu.vdmj.ast.types.ASTRecordType;
import com.fujitsu.vdmj.ast.types.ASTSeq1Type;
import com.fujitsu.vdmj.ast.types.ASTSeqType;
import com.fujitsu.vdmj.ast.types.ASTSet1Type;
import com.fujitsu.vdmj.ast.types.ASTSetType;
import com.fujitsu.vdmj.ast.types.ASTTokenType;
import com.fujitsu.vdmj.ast.types.ASTType;
import com.fujitsu.vdmj.ast.types.ASTTypeList;
import com.fujitsu.vdmj.ast.types.ASTTypeSet;
import com.fujitsu.vdmj.ast.types.ASTUnionType;
import com.fujitsu.vdmj.ast.types.ASTUnknownType;
import com.fujitsu.vdmj.ast.types.ASTUnresolvedType;
import com.fujitsu.vdmj.ast.types.ASTVoidType;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexLocation;

import vdmantlr.generated.VDMBaseListener;
//import vdmantlr.generated.VDMLex; which one?
import vdmantlr.generated.VDMLexer;
import vdmantlr.generated.VDMParser;
import vdmantlr.generated.VDMParser.Elseif_expressionContext;

/******************
 * MISSING CASES
 ******************
 * 1. Qualified record pattern      : "mk_A`R"; qualified record expressions are working though? 
 * 2. Tuple projection expressions  : "x.#1";
 * 
 * 
 *     //TODO
    //equals_definition_list
    //local_definition_list
    //ASTTypeDefinition
    //all the isVDMPP()? isVDMRT()? semantic predicate cases
 ******************
 * LRM issues
 ****************** 
 *  1. map merge in binary munion operator
 *  2. C.2 x A.5.13 for function type instantiation expression x name
 *  3. tuple selection is left assoc and not explicitly features in family of precedences
 *  4. <> is right assoc and nothing is said about it
 *  5. various precedence priorities for unary prefix operators are irrelevant / redundant (i.e. they won’t matter and just confuse)
 *  6. suffix operators have no clearly defined associativity (e.g. “x.#1.#2” is (x.#1).#2)
 *  7. suffix operators have implicitly defined (stronger) precedence than other unary operators! (e.g. “-a~” is meant to mean “-(a~)” and not “(-a)~”)
 *  8. cases expression is irregular (e.g., leading expr features in all case alternative productios)
 *  9. cases alternative pattern list on LHS??
 * 10. various name discrepancies in unary expression AST (e.g. compared say with pattern or within itself)
 * 11. maplet expression requires a Lex(Keyword)Token where a location would be sufficient?
 * 12. lambda expressions cannot be constant functions? (e.g. type_bind_list cannot be empty)? 
 * 13. name is being used (within name list) as a LexNameToken as well as a ASTVariableExpression? 
 * 14. function_type cannot directly be on the type rule, yet is used in other places. So will effectively have two equal implementations :-(
 * 15. sl_interface can lead to empty production matching if both imports and exports are empty! Force at least exports all
 * 16. what's the point of type_definition on import_type_signature if invariants or other parts cannot be changed? 
 * 17. name production on type imports is too linient. allows for waky things like "from Other types Other`T renamed Another`S"!
 * 18. type_variable (like name) ends up being confused with AST(ParameterType) or LexNameToken depending on context (e.g. requires two production interpretations)
 * 19. Imported function AST receives type variables after function type
 * 20. export XXXX_signature should be called XXX_export (like type_export, instea of value_signature)!
 * 21. ASTExportedFunction optional type parameters come after function type?
 */

public class VDMASTListener extends VDMBaseListener {
    
    public static final String EXPR_TEST = "./exprScenario/setEnum.expr";
    public static final String PAT_TEST = "./patternScenario/example.pat";
    public static final String TEST = PAT_TEST;

    public static void main(String[] argv) throws IOException
    {
        if (argv.length < 2)
            throw new IllegalArgumentException("VDM AST Listener expects two parameters");
        VDMASTListener listener = new VDMASTListener(argv[0]);
        ParseTree t = listener.production(argv[1]);//listener.parser.pattern_list();//parser.expression();
        ParseTreeWalker.DEFAULT.walk(listener, t);
        System.out.println("\ntree="+t.toStringTree(listener.parser)+"\n");
        //ASTPatternList n = listener.getListNode((VDMParser.Pattern_listContext)t, ASTPatternList.class);
        //ASTPatternList n = listener.getListNode((ParserRuleContext)t, ASTPatternList.class);
        System.out.println("VDM=" + listener.lists.get(t).toString()+"\n");
    }

    /**
     * See ANTLR4 book Chapter 9 on error listeners
     */
    public static class VDMErrorListener extends BaseErrorListener 
    {   
        @Override
        public void syntaxError(Recognizer<?, ?> recognizer, 
            Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e)
        {
            List<String> stack = ((VDMParser)recognizer).getRuleInvocationStack(); 
            Collections.reverse(stack);
            System.err.println("rule stack: "+stack);
            System.err.println("line "+line+":"+charPositionInLine+" at "+offendingSymbol+": "+msg);
            underlineError(recognizer, (org.antlr.v4.runtime.Token)offendingSymbol, line, charPositionInLine);
        } 

        protected void underlineError(Recognizer<?, ?> recognizer, org.antlr.v4.runtime.Token offendingToken, 
            int line, int charPositionInLine) 
        {
            CommonTokenStream tokens = (CommonTokenStream)recognizer.getInputStream();
            String input = tokens.getTokenSource().getInputStream().toString(); 
            String[] lines = input.split("\n");
            String errorLine = lines[line - 1];
            System.err.println(errorLine);
            for (int i=0; i<charPositionInLine; i++) 
                System.err.print(" "); 
            int start = offendingToken.getStartIndex();
            int stop = offendingToken.getStopIndex();
            if ( start>=0 && stop>=0 ) {
                for (int i=start; i<=stop; i++) 
                    System.err.print("^"); 
            }
            System.err.println(); 
        }
    }

    /**
     * See Parser super class TraceListener implementation and setTrace.
     */
    public class VDMTraceListener implements ParseTreeListener {
		@Override
		public void enterEveryRule(ParserRuleContext ctx) {
            System.out.println("enter   " + VDMASTListener.this.parser.getRuleNames()[ctx.getRuleIndex()] +
							   ", LT(1)=" + VDMASTListener.this.parser.getTokenStream().LT(1).getText());
		}

		@Override
		public void visitTerminal(TerminalNode node) {
            String token; 
            if (node.getSymbol() instanceof CommonToken)
            {
                CommonToken ctok = (CommonToken)node.getSymbol();
                token = ctok.toString(VDMASTListener.this.parser);
            }
            else
            {
                token = node.getSymbol().toString();
            }
			System.out.println("consume "+token+" rule "+
            VDMASTListener.this.parser.getRuleNames()[VDMASTListener.this.parser.getContext().getRuleIndex()]);
		}

		@Override
		public void visitErrorNode(ErrorNode node) {
		}

		@Override
		public void exitEveryRule(ParserRuleContext ctx) {
			System.out.println("exit    "+VDMASTListener.this.parser.getRuleNames()[ctx.getRuleIndex()]+
							   ", LT(1)="+VDMASTListener.this.parser.getTokenStream().LT(1).getText());
		}
	}
        
    
    //See ANTLR4 discussion on options Chapter 7. Choosing listeners with parse tree properties (i.e. to avoid visitor aggregation?)
    private final ParseTreeProperty<ASTNode> nodes;
    private final ParseTreeProperty<Vector<? extends ASTNode>> lists;
    private final VDMParser parser;
    protected ASTModuleList astModuleList;
    private final File currentFile;
    private String currentModule;
    private String savedCurrentModule;
    private LexIdentifierToken fromModuleImport;
    private ASTImportList fromModuleImportList;
    private ASTExportList moduleExportList;
    private final Dialect dialect;
    private SymbolicLiteralType littype; 

    public VDMASTListener(String fileName) throws IOException
    {
        super();
        littype = null;
        dialect = Dialect.VDM_SL;
        currentModule = null;
        fromModuleImport = null;
        fromModuleImportList = null;
        moduleExportList = null;
        savedCurrentModule = setCurrentModule("?");
        if (fileName == null || fileName.isEmpty())
            throw new IllegalArgumentException("Invalid file name " + fileName);
        currentFile = new File(fileName);
        if (!currentFile.exists())
            throw new IllegalArgumentException("File name does not exist: " + fileName);
        CharStream input = CharStreams.fromFileName(fileName); 
        //ANTLRInputStream input = new ANTLRInputStream(System.in); 
        // or read stdin SimpleLexer lexer = new SimpleLexer(input);
        VDMLexer lexer = new VDMLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        parser = new VDMParser(tokens);
        // parser.setProfile(true);
        // ParseInfo pip = parser.getParseInfo();
        // if we want full ambiguity/diagnostic information
        parser.removeErrorListeners(); // remove ConsoleErrorListener 
        parser.addErrorListener(new DiagnosticErrorListener());
        parser.getInterpreter().setPredictionMode(PredictionMode.LL_EXACT_AMBIG_DETECTION);
        // might as well add some extra information of our own 
        parser.addErrorListener(new VDMErrorListener());
        parser.addParseListener(new VDMTraceListener());
        //parser.setTrace(true);
        //ParserATNSimulator.debug = true;
        nodes = new ParseTreeProperty<ASTNode>();
        lists = new ParseTreeProperty<Vector<? extends ASTNode>>();
        astModuleList = null;
    }

    private String setCurrentModule(String mod)
    {
        String result = currentModule;
        currentModule = mod;
        return result;
    }

    public ParseTree production(String ruleName)
    {
        if (parser.getRuleIndex(ruleName) == -1)
        throw new IllegalArgumentException("Invalid VDM parser production rule name " + ruleName);
        try
        {
            Method rule = parser.getClass().getMethod(ruleName);
            return (ParseTree)rule.invoke(parser);
        }
        catch (NoSuchMethodException | IllegalAccessException | IllegalArgumentException | InvocationTargetException e)
        {
            throw new IllegalArgumentException("Valid VDM parser rule name " + ruleName + " caused " + e.getMessage());
        }
    }

    protected void throwMessage(int number, String message, LexLocation location) throws com.fujitsu.vdmj.syntax.ParserException, com.fujitsu.vdmj.lex.LexException
    {
        //from MESSAGES: 1000-1999 = Lexing errors
        if (number >= 1000 && number < 2000)
            throw new com.fujitsu.vdmj.lex.LexException(number, message, location);
        else
            //TODO figure out token depth from ANTLR somehow
            throw new com.fujitsu.vdmj.syntax.ParserException(number, message, location, 1);//reader.getTokensRead());
    }

    // Token start = ctx.getStop();
    //             Token stop = candidate.getStop();
    //             int start_line = start.getLine();
    //             int from_col = start.getCharPositionInLine() + 1 + start.getText().length();
    //             int stop_line = stop.getLine();
    //             int to_col = stop.getCharPositionInLine() + 1 + stop.getText().length();
    //             System.out.println("\nSCOPE of " + identifier + " is " + ((candidate instanceof VDMParser.Sl_documentContext) ? "whole module" : getSource(candidate)));
    //             System.out.println("start " + start_line + "(" + from_col + ")");
    //             System.out.println("stop " + stop_line + "(" + to_col + ")");
    //             return new Range(start_line, from_col, stop_line, to_col);

    /**
     * Transforms an ANTLR parser rule context (for each parsing production) into a VDMJ LexLocation.
     * It uses the context start and stop token information. @TODO Perhaps add to lexing contexts as well? 
     * @param ctx parsing context requiring LexLocation information
     * @return VDMJ-equivalent LexLocation from given contex
     */
    //See ANTLR4 Section 3.2; 2loc below is not quite right.
    //CommonToken: [@5,8:10='451',<4>,1:8] 
    //[@TokenIndex(0), StartPos(0):EndPos(inclusive)='TEXT',<TYPE>,StartLine(1):StartChar(0)]
    //Start/EndPos=character number consumed up to that point
    protected LexLocation token2loc(ParserRuleContext ctx)
    {
        //VDMParserUtils.Range r = VDMParserUtils.findScope(ctx);
        VDMParserUtils.Range r = VDMParserUtils.createRange(ctx.getText(), ctx, ctx.getParent());
        return new LexLocation(currentFile, currentModule, 
            r.start_line, r.start_character, 
            r.stop_line, r.stop_character);
        // return new LexLocation(currentFile, currentModule, 
        //     ctx.getStart().getLine(), ctx.getStart().getCharPositionInLine(),
        //     ctx.getStop().getLine(), ctx.getStop().getCharPositionInLine()+1);
    }

    protected LexLocation token2loc(TerminalNode terminal)
    {
        int line = terminal.getSymbol().getLine();
        return new LexLocation(currentFile, currentModule, line, 
            terminal.getSymbol().getStartIndex(), line, terminal.getSymbol().getStopIndex());
    }

	/**
	 * Convert an identifier into a name. A name is an identifier that has
	 * a module name qualifier, so this method uses the current module to
	 * convert the identifier passed in.
	 *
	 * @param id The identifier to convert
	 * @return The corresponding name.
	 */
    //com.fujitsu.vdmj.syntax.SyntaxReader.idToName
    protected LexNameToken id2lexname(LexIdentifierToken id)
	{
		return new LexNameToken(currentModule, id);
	}

    protected LexNameToken getMkTypeName(LexNameToken mktoken) //throws com.fujitsu.vdmj.syntax.ParserException, com.fujitsu.vdmj.lex.LexException
    {
        String typename = mktoken.name.substring(3);	// mk_... or is_...
        String[] parts = typename.split("`");

        switch (parts.length)
        {
            case 1:
                return new LexNameToken(currentModule, parts[0], mktoken.location);

            case 2:
                return new LexNameToken(parts[0], parts[1], mktoken.location, false, true);

            default:
                //throwMessage(2037, "Malformed mk_<type> name " + typename, mktoken.location);
        }

        return mktoken;//null;
    }

    private void checkResult(ParserRuleContext ctx, Object result, Class<?> resultExpectedClass)
    {
        assert resultExpectedClass != null;
        if (result == null)
            throw new UnsupportedOperationException("No node for " + ctx != null ? ctx.getClass().getSimpleName() : "null ctx(!?)");
        if (!resultExpectedClass.isAssignableFrom(result.getClass()))
            throw new UnsupportedOperationException("Expected " + resultExpectedClass.getSimpleName() + " but found " + result.getClass().getSimpleName());
    }

    @SuppressWarnings("unchecked")
    protected <T extends ASTNode> T getNode(ParserRuleContext ctx, Class<T> resultExpectedClass)
    {
        ASTNode result = nodes.get(ctx);
        checkResult(ctx, result, resultExpectedClass);
        return (T)result;
    }

    @SuppressWarnings("unchecked")
    protected <T extends Vector<? extends ASTNode>> T getListNode(ParserRuleContext ctx, Class<T> resultExpectedClass)
    {
        Vector<? extends ASTNode> result = lists.get(ctx);
        checkResult(ctx, result, resultExpectedClass);
        return (T)result;
    }

    protected void putNode(ParserRuleContext ctx, ASTNode node)
    {
        checkResult(ctx, node, node == null ? ASTNode.class : node.getClass());
        nodes.put(ctx, node);
    }

    protected void putListNode(ParserRuleContext ctx, Vector<? extends ASTNode> node)
    {
        checkResult(ctx, node, node == null ? Vector.class : node.getClass());
        lists.put(ctx, node);
    }

    /**
     * Transforms the given terminal node id (e.g. ctx.IDENTIFIER()) for the given context, which will
     * be the location source information. 
     * @param id
     * @param ctx
     * @param old
     * @return
     */
    //Could have a ParserRuleContext and have
    protected LexIdentifierToken id2lexid(TerminalNode id, ParserRuleContext ctx, int offset, boolean old)
    {
        //TerminalNode id = getToken(VDMParser.IDENTIFIER, 0);? but might not be general
        return new LexIdentifierToken(id.getText().substring(offset), old, token2loc(ctx));
    }

    protected LexIdentifierToken id2lexid(TerminalNode id, ParserRuleContext ctx, boolean old)
    {
        //TerminalNode id = getToken(VDMParser.IDENTIFIER, 0);? but might not be general
        return id2lexid(id, ctx, 0, old);
    }

    //ASTModule
	@Override 
    public void enterSl_document(VDMParser.Sl_documentContext ctx) 
    {
        astModuleList = new ASTModuleList();
    }

    @Override 
    public void enterModule(VDMParser.ModuleContext ctx)
    {
        assert ctx.modName != null && ctx.endName != null;
        if (!ctx.modName.getText().equals(ctx.endName.getText()))
		{
			//throwMessage(2049, "Expecting 'end " + ctx.modName.getText() + "'");
		}
        setCurrentModule(ctx.modName.getText());
    }

    @Override
    public void exitModule(VDMParser.ModuleContext ctx)
    {
        LexIdentifierToken moduleName = id2lexid((TerminalNode)ctx.modName, ctx, false);
        //@NB like with caseExpr, the ASTModuleImports require information about the module (name) :-(
		ASTModuleImports imports; 
        if (ctx.sl_interface().import_definition_list() != null) 
        {
            ASTImportFromModuleList importsList = new ASTImportFromModuleList();
            for(VDMParser.Import_definitionContext i : ctx.sl_interface().import_definition_list().import_definition())
            {
                importsList.add(getNode(i, ASTImportFromModule.class));    
            }
            imports = new ASTModuleImports(moduleName, importsList);
        }
        else 
            imports = null;
        //@NB if we allow empty exports as well, then you get a empty loop potential  for sl_interface()? 
		ASTModuleExports exports = getNode(ctx.sl_interface().export_definition(), ASTModuleExports.class);
        ASTDefinitionList defs = getListNode(ctx.module_body(), ASTDefinitionList.class);
        putNode(ctx, new ASTModule(moduleName, imports, exports, defs));
    }

    /**
     * Save the current "from" module name and create a "global" from module list.
     * Each kind of import then contributes to the overall list in whichever order.
     * The different exitImport_XXXX_signature are given to impose Java type safety 
     * on each kind of import signature.  
     */
    @Override 
    public void enterImport_definition(VDMParser.Import_definitionContext ctx)
    {
        // save where it is coming from, if different from all
        fromModuleImport = id2lexid(ctx.IDENTIFIER(), ctx, false);
        fromModuleImportList = new ASTImportList();
        // set the current module as the "from" import so that LexNameToken get the from module in its name
        savedCurrentModule = setCurrentModule(fromModuleImport.name);
    }

    @Override 
    public void exitImport_definition(VDMParser.Import_definitionContext ctx)
    {
        assert fromModuleImportList != null && fromModuleImportList.isEmpty() && fromModuleImport != null;
        if (ctx.import_module_signature().SLK_all() != null)
        {
            assert fromModuleImport.name.equals(currentModule);
            LexNameToken all = new LexNameToken(currentModule, "all", token2loc(ctx.import_module_signature().SLK_all()));
            fromModuleImportList.add(new ASTImportAll(all));
        }
        else 
        {
            assert ctx.import_module_signature().import_signature() != null && fromModuleImport.name.equals(ctx.IDENTIFIER().getText());
            // because of fromName dependency and multiple kinds of imports, require saving state on entry
            for(VDMParser.Import_signatureContext i : ctx.import_module_signature().import_signature())
            {
                fromModuleImportList.addAll(getListNode(i, ASTImportList.class));
            }
        }
        putNode(ctx, new ASTImportFromModule(fromModuleImport, fromModuleImportList));
        // restore the saveed module to be current after import processing
        setCurrentModule(savedCurrentModule);
        savedCurrentModule = null;
    }

    @Override 
    public void exitImport_types_signature(VDMParser.Import_types_signatureContext ctx)
    {
        assert fromModuleImport != null;
        ASTImportList importList = new ASTImportList();
        for(VDMParser.Type_importContext i : ctx.type_import())
        {
            importList.add(getNode(i, ASTImportedType.class));
        }
        putListNode(ctx, importList);
    }

    @Override 
    public void exitNamedImport(VDMParser.NamedImportContext ctx)
    {
        assert fromModuleImport != null;
        // here the NameContext for ctx.tname wil have LexNameToken with fromModuleImport.name
        LexNameToken tname = getNode(ctx.tname, LexNameToken.class);
        //@NB renamed module allows for any wacky name from the LRM? Will enforce same module too! 
        LexNameToken renamed = ctx.renamed != null ? getNode(ctx.renamed, LexNameToken.class) : null;
        assert tname.module.equals(currentModule) && (renamed == null || renamed.module.equals(currentModule));
        putNode(ctx, new ASTImportedType(tname, renamed));
    }

    @Override 
    public void exitTypeDefinitionImport(VDMParser.TypeDefinitionImportContext ctx)
    {
        assert fromModuleImport != null;
        ASTTypeDefinition tdef = getNode(ctx.type_definition(), ASTTypeDefinition.class);
        //@NB renamed module allows for any wacky name from the LRM? Will enforce same module too! 
        LexNameToken renamed = ctx.renamed != null ? getNode(ctx.renamed, LexNameToken.class) : null;
        assert tdef.name.module.equals(currentModule) && (renamed == null || renamed.module.equals(currentModule));
        putNode(ctx, new ASTImportedType(tdef, renamed));
    }

    @Override 
    public void exitImport_values_signature(VDMParser.Import_values_signatureContext ctx)
    {
        assert fromModuleImport != null;
        ASTImportList importList = new ASTImportList();
        for(VDMParser.Value_importContext i : ctx.value_import())
        {
            importList.add(getNode(i, ASTImportedValue.class));
        }
        putListNode(ctx, importList);
    }

    @Override
    public void exitValue_import(VDMParser.Value_importContext ctx)
    {
        assert fromModuleImport != null;
        LexNameToken vname = getNode(ctx.vname, LexNameToken.class);
        ASTType type = ctx.type() != null ? getNode(ctx.type(), ASTType.class) : null;
        LexNameToken renamed = ctx.renamed != null ? getNode(ctx.renamed, LexNameToken.class) : null;
        assert vname.module.equals(currentModule) && (renamed == null || renamed.module.equals(currentModule));
        putNode(ctx, new ASTImportedValue(vname, type, renamed));
    }

    @Override 
    public void exitImport_functions_signature(VDMParser.Import_functions_signatureContext ctx)
    {
        assert fromModuleImport != null;
        ASTImportList importList = new ASTImportList();
        for(VDMParser.Function_importContext i : ctx.function_import())
        {
            importList.add(getNode(i, ASTImportedFunction.class));
        }
        putListNode(ctx, importList);
    }

    @Override 
    public void exitFunction_import(VDMParser.Function_importContext ctx)
    {
        assert fromModuleImport != null;
        LexNameToken fname = getNode(ctx.fname, LexNameToken.class);
        LexNameList tvars = ctx.type_variable_list() != null ? getListNode(ctx.type_variable_list(), LexNameList.class) : null;
        ASTFunctionType ftype = ctx.function_type() != null ? getNode(ctx.function_type(), ASTFunctionType.class) : null;
        LexNameToken renamed = ctx.renamed != null ? getNode(ctx.renamed, LexNameToken.class) : null;
        assert fname.module.equals(currentModule) && (renamed == null || renamed.module.equals(currentModule));
        putNode(ctx, new ASTImportedFunction(fname, ftype, tvars, renamed));
    }

    @Override 
    public void exitImport_operations_signature(VDMParser.Import_operations_signatureContext ctx)
    {
        assert fromModuleImport != null;
        ASTImportList importList = new ASTImportList();
        for(VDMParser.Operation_importContext i : ctx.operation_import())
        {
            importList.add(getNode(i, ASTImportedOperation.class));
        }
        putListNode(ctx, importList);
    }

    @Override
    public void exitOperation_import(VDMParser.Operation_importContext ctx)
    {
        assert fromModuleImport != null;
        LexNameToken oname = getNode(ctx.oname, LexNameToken.class);
        ASTOperationType otype = ctx.operation_type() != null ? getNode(ctx.operation_type(), ASTOperationType.class) : null;
        LexNameToken renamed = ctx.renamed != null ? getNode(ctx.renamed, LexNameToken.class) : null;
        assert oname.module.equals(currentModule) && (renamed == null || renamed.module.equals(currentModule));
        putNode(ctx, new ASTImportedOperation(oname, otype, renamed));
    }

    @Override 
    public void enterExport_definition(VDMParser.Export_definitionContext ctx)
    {
        moduleExportList = new ASTExportList();
    }

    @Override 
    public void exitExport_definition(VDMParser.Export_definitionContext ctx)
    {
        assert moduleExportList != null && moduleExportList.isEmpty();
        if (ctx.export_module_signature().SLK_all() != null)
        {
            //@NB no need for a LexNameToken all? 
            moduleExportList.add(new ASTExportAll(token2loc(ctx.export_module_signature().SLK_all())));
        }
        else 
        {
            assert ctx.export_module_signature().export_signature() != null;
            // because of multiple kinds of exports, require saving state on entry
            for(VDMParser.Export_signatureContext i : ctx.export_module_signature().export_signature())
            {
                moduleExportList.addAll(getListNode(i, ASTExportList.class));
            }
        }
        putNode(ctx, new ASTModuleExports(moduleExportList));
    }

    @Override 
    public void exitExport_types_signature(VDMParser.Export_types_signatureContext ctx)
    {
        //TODO arguably I could add to moduleExportList directly...
        // cannot have a single export_signature type because don't have access to the inner lists
        ASTExportList exportList = new ASTExportList();
        for(VDMParser.Type_exportContext i : ctx.type_export())
        {
            exportList.add(getNode(i, ASTExportedType.class));
        }
        putListNode(ctx, exportList);
    }

    @Override 
    public void exitType_export(VDMParser.Type_exportContext ctx)
    {
        putNode(ctx, new ASTExportedType(getNode(ctx.name(), LexNameToken.class), ctx.SLK_struct() != null));
    }

    @Override 
    public void exitExport_values_signature(VDMParser.Export_values_signatureContext ctx)
    {
        ASTExportList exportList = new ASTExportList();
        for(VDMParser.Value_signatureContext i : ctx.value_signature())
        {
            exportList.add(getNode(i, ASTExportedValue.class));
        }
        putListNode(ctx, exportList);
    }

    @Override 
    public void exitValue_signature(VDMParser.Value_signatureContext ctx)
    {
        putNode(ctx, new ASTExportedValue(token2loc(ctx), 
            getListNode(ctx.name_list(), LexNameList.class),
            getNode(ctx.type(), ASTType.class)));
    }

    @Override 
    public void exitExport_functions_signature(VDMParser.Export_functions_signatureContext ctx)
    {
        ASTExportList exportList = new ASTExportList();
        for(VDMParser.Function_signatureContext i : ctx.function_signature())
        {
            exportList.add(getNode(i, ASTExportedFunction.class));
        }
        putListNode(ctx, exportList);
    }

    @Override 
    public void exitFunction_signature(VDMParser.Function_signatureContext ctx)
    {
        putNode(ctx, new ASTExportedFunction(token2loc(ctx), 
            getListNode(ctx.name_list(), LexNameList.class),
            getNode(ctx.function_type(), ASTFunctionType.class),
            ctx.type_variable_list() != null ? getListNode(ctx.type_variable_list(), LexNameList.class) : null));
    }

    @Override 
    public void exitExport_operations_signature(VDMParser.Export_operations_signatureContext ctx)
    {
        ASTExportList exportList = new ASTExportList();
        for(VDMParser.Operation_signatureContext i : ctx.operation_signature())
        {
            exportList.add(getNode(i, ASTExportedOperation.class));
        }
        putListNode(ctx, exportList);
    }

    @Override 
    public void exitOperation_signature(VDMParser.Operation_signatureContext ctx)
    {
        putNode(ctx, new ASTExportedOperation(token2loc(ctx), 
            getListNode(ctx.name_list(), LexNameList.class),
            getNode(ctx.operation_type(), ASTOperationType.class)));
    }

    @Override 
    public void exitModule_body(VDMParser.Module_bodyContext ctx)
    {
        //TODO these list methods seem prime for refactoring?
        ASTDefinitionList defs = new ASTDefinitionList();
        for(VDMParser.Sl_definition_blockContext d : ctx.sl_definition_block())
        {
            defs.add(getNode(d, ASTDefinition.class));
        }
        putListNode(ctx, defs);
    }

//------------------------
// A.4.1 Type definitions
//------------------------

    private ASTTypeList productExpand(ASTType parameters)
    {
        ASTTypeList types = new ASTTypeList();

        if (parameters instanceof ASTProductType)
        {
            // Expand unbracketed product types
            ASTProductType pt = (ASTProductType)parameters;
            types.addAll(pt.types);
        }
        else if (parameters instanceof ASTVoidType)
        {
            // No type
        }
        else
        {
            // One parameter, including bracketed product types
            types.add(parameters);
        }

        return types;
    }

    @Override 
    public void exitBracketedType(VDMParser.BracketedTypeContext ctx) 
    {
        putNode(ctx, getNode(ctx.bracketed_type().type(), ASTType.class));
    }  

    @Override
    public void exitWildcardType(VDMParser.WildcardTypeContext ctx)
    {
        putNode(ctx, new ASTUnknownType(token2loc(ctx)));
    }

    @Override 
    public void exitTypeName(VDMParser.TypeNameContext ctx) 
    {
        // This is to be used in ASTNamedType as per DefinitionReader (e.g. type_definition production)? 
        //@NB Or is it UnresolvedType?
        putNode(ctx, new ASTUnresolvedType(getNode(ctx.type_name().name(), LexNameToken.class)));
    }
    
    @Override 
    public void exitTypeVariable(VDMParser.TypeVariableContext ctx) 
    {
        //@NB just like with "name" for expression x lexnametoken, we need two productions for type_variable as lexnametoken as well as a ASTType
        putNode(ctx, new ASTParameterType(getNode(ctx.type_variable(), LexNameToken.class)));
    }
    
    @Override 
    public void exitSeqType(VDMParser.SeqTypeContext ctx) 
    {
        //@NB concrete example of the mess of multiple layers can cause. An alternative is to have
        //    exitSeq1_type(...) then create there but then needs to update here, just like in UnaryExprCtx :-(
        boolean seq1 = ctx.seq_type().seq1_type() != null;
        LexLocation location = token2loc(ctx);
        ASTType type = getNode(seq1 ? ctx.seq_type().seq1_type().type() : ctx.seq_type().seq0_type().type(), ASTType.class);
        putNode(ctx, seq1 ? new ASTSeq1Type(location, type) : new ASTSeqType(location, type));
    }
    
    @Override 
    public void exitSetType(VDMParser.SetTypeContext ctx) 
    {
        boolean set1 = ctx.set_type().set1_type() != null;
        LexLocation location = token2loc(ctx);
        ASTType type = getNode(set1 ? ctx.set_type().set1_type().type() : ctx.set_type().set0_type().type(), ASTType.class);
        putNode(ctx, set1 ? new ASTSet1Type(location, type) : new ASTSetType(location, type));
    }
    
    @Override 
    public void exitMapType(VDMParser.MapTypeContext ctx) 
    {
        boolean inmap = ctx.map_type().injective_map_type() != null;
        LexLocation location = token2loc(ctx);
        ASTType dtype = getNode(inmap ? ctx.map_type().injective_map_type().dom : ctx.map_type().general_map_type().dom, ASTType.class);
        ASTType rtype = getNode(inmap ? ctx.map_type().injective_map_type().rng : ctx.map_type().general_map_type().rng, ASTType.class);
        putNode(ctx, inmap ? new ASTInMapType(location, dtype, rtype) : new ASTMapType(location, dtype, rtype));
    }
    
    @Override 
    public void exitCompositeType(VDMParser.CompositeTypeContext ctx) 
    {
        ASTFieldList fields = new ASTFieldList();
        for(VDMParser.FieldContext f : ctx.composite_type().field())
        {
            fields.add(getNode(f, ASTField.class));
        }
        putNode(ctx, new ASTRecordType(id2lexname(id2lexid(ctx.composite_type().IDENTIFIER(), ctx, false)), fields, true));
    }
    
    @Override 
    public void exitProductType(VDMParser.ProductTypeContext ctx) 
    {
        ASTTypeList productList = new ASTTypeList();
        for(VDMParser.TypeContext t : ctx.type())
        {
            productList.add(getNode(t, ASTType.class));
        }
        putNode(ctx, new ASTProductType(token2loc(ctx), productList));
    }
    
    @Override 
    public void exitUnionType(VDMParser.UnionTypeContext ctx) 
    {
        ASTTypeSet types = new ASTTypeSet();
        for(VDMParser.TypeContext t : ctx.type())
        {
            types.add(getNode(t, ASTType.class));
        }
        putNode(ctx, new ASTUnionType(token2loc(ctx), types));
    }
    
    @Override 
    public void exitBasicType(VDMParser.BasicTypeContext ctx) 
    {
        ASTType type;
        LexLocation location = token2loc(ctx);
        com.fujitsu.vdmj.lex.Token token = com.fujitsu.vdmj.lex.Token.lookup(ctx.getText(), dialect);
        if (token == null) 
            throw new IllegalStateException("Cannot have this basic type = " + ctx.getText());
        switch (token)
        {
            case BOOL:
                type = new ASTBooleanType(location);
                break;
            case NAT:
                type = new ASTNaturalType(location);
                break;
            case NAT1:
                type = new ASTNaturalOneType(location);
                break;
            case INT:
                type = new ASTIntegerType(location);
                break;
            case RAT:
                type = new ASTRationalType(location);
                break;
            case REAL:
                type = new ASTRealType(location);
                break;
            case CHAR:
                type = new ASTCharacterType(location);
                break;
            case TOKEN:
                type = new ASTTokenType(location);
                break;
            default:
                throw new IllegalStateException("Cannot have this basic type = " + ctx.getText());
        }
        putNode(ctx, type);
    }
    
    @Override 
    public void exitQuoteType(VDMParser.QuoteTypeContext ctx) 
    {
        putNode(ctx, new ASTQuoteType(new LexQuoteToken(ctx.quote_type().IDENTIFIER().getText(), token2loc(ctx))));
    }
    
    @Override 
    public void exitOptionalType(VDMParser.OptionalTypeContext ctx) 
    {
        putNode(ctx, new ASTOptionalType(token2loc(ctx), getNode(ctx.optional_type().type(), ASTType.class)));
    }
    
    @Override 
    public void exitVoidFunctionType(VDMParser.VoidFunctionTypeContext ctx) 
    {
        //@NB here because of the way the production is, there is never a ASTVoidType!
        putNode(ctx, new ASTFunctionType(token2loc(ctx), ctx.void_function_type().SEP_pfcn() != null,
            new ASTTypeList(), 
            getNode(ctx.void_function_type().type(), ASTType.class)));
    }

    @Override 
    public void exitFunctionType(VDMParser.FunctionTypeContext ctx) 
    {
        putNode(ctx, new ASTFunctionType(token2loc(ctx), ctx.SEP_pfcn() != null,
            productExpand(getNode(ctx.params, ASTType.class)), 
            getNode(ctx.ret, ASTType.class)));
    }

    /**
     * LRM has function_type in more places than just the type tree. On type tree it cannot be directly there
     * because of left-recursive issues, so repeat it here, with the same VoidType treatment as VDMJ
     */
    @Override 
    public void exitPartialFunctionType(VDMParser.PartialFunctionTypeContext ctx) 
    {
        putNode(ctx, new ASTFunctionType(token2loc(ctx), true,
            productExpand(getNode(ctx.discretionary_type(), ASTType.class)), 
            getNode(ctx.type(), ASTType.class)));
    }

    @Override 
    public void exitTotalFunctionType(VDMParser.TotalFunctionTypeContext ctx) 
    {
        putNode(ctx, new ASTFunctionType(token2loc(ctx), false,
            productExpand(getNode(ctx.discretionary_type(), ASTType.class)), 
            getNode(ctx.type(), ASTType.class)));
    }

    @Override 
    public void exitOperation_type(VDMParser.Operation_typeContext ctx)
    {
        putNode(ctx, new ASTOperationType(token2loc(ctx), 
            productExpand(getNode(ctx.params, ASTType.class)),
            getNode(ctx.rtype, ASTType.class)));
    }

    @Override 
    public void exitVoidType(VDMParser.VoidTypeContext ctx)
    {
        putNode(ctx, new ASTVoidType(token2loc(ctx)));
    }

    @Override 
    public void exitFunctionParametersType(VDMParser.FunctionParametersTypeContext ctx)
    {
        // Leave productExpand to do the job at the right place
        putNode(ctx, getNode(ctx.type(), ASTType.class));
    }

    @Override 
    public void exitType_list(VDMParser.Type_listContext ctx)
    {
        ASTTypeList result = new ASTTypeList();
        for(VDMParser.TypeContext t : ctx.type())
        {
            result.add(getNode(t, ASTType.class));
        }
        assert !result.isEmpty();
        putListNode(ctx, result);        
    }

    @Override 
    public void exitType_variable_list(VDMParser.Type_variable_listContext ctx)
    {
        LexNameList result = new LexNameList();
        for(VDMParser.Type_variableContext t : ctx.type_variable())
        {
            result.add(getNode(t, LexNameToken.class));
        }
        assert !result.isEmpty();
        putListNode(ctx, result);        
    }

    @Override 
    public void exitType_variable(VDMParser.Type_variableContext ctx)
    {
        putNode(ctx, id2lexname(id2lexid(ctx.IDENTIFIER(), ctx, false)));
    }
    
//------------------------
// A.5 Expressions
//------------------------
/* The "expression" production rule is ordered in terms of its expected precedence binding power, as defined in LRM's Appendix C.
 * This is particularly important to avoid left-recursion errors. That means the order of productions was altered reflect both 
 * Appendix's C rules, but also other implicitly needed precedence modifications not documented in the LRM (yet implemented in 
 * places like VDMJ's ExpressionReader).
 * 
 * For clarity, we kept the original LRM rule names as much as possible (e.g. either directly, or with a #NAME that is similar),
 * which means drilling into the context for the inner rule defining the actual call. Later on we might want to remove these 
 * indirections and hence minimise the number of parser rules, ATN size, prediction speed, etc. To do this, we will need to inline
 * production names on the expression tree, rather than have one production for each of the A.X.Y entries.    
 * 
 * We identified the primary expressions based on ANTLR's prediction and resolution of left-recursion. That is, by looking at 
 * the generated parser prediction switch that did not required priority semantic predicates to decide binding power. We called 
 * those the C.0 family of primary expressions (i.e. those that will always win any prediction, given their lead token uniqueness).
 */
//------------------------
// C.0 Primary expressions
//------------------------

    @Override
    public void exitBracketedExpr(VDMParser.BracketedExprContext ctx)
    {
        putNode(ctx, getNode(ctx.bracketed_expression().expression(), ASTExpression.class));
        //TODO is this needed? 
        nodes.removeFrom(ctx.bracketed_expression().expression());
    }

    @Override 
    public void exitLocal_definition(VDMParser.Local_definitionContext ctx)
    {
        if (ctx.value_definition() != null) 
            putNode(ctx, getNode(ctx.value_definition(), ASTValueDefinition.class));
        else 
            // must be either ASTImplicit/ExplicitFunctionDefinition
            putNode(ctx, getNode(ctx.function_definition(), ASTDefinition.class));
    }

    @Override
    public void exitLetExpr(VDMParser.LetExprContext ctx)
    {
        putNode(ctx, new ASTLetDefExpression(token2loc(ctx), 
            getListNode(ctx.let_expression().local_definition_list(), ASTDefinitionList.class), 
            getNode(ctx.let_expression().expression(), ASTExpression.class)));
    }

    @Override
    public void exitLetBestExpr(VDMParser.LetBestExprContext ctx)
    {
        putNode(ctx, new ASTLetBeStExpression(token2loc(ctx), 
            getNode(ctx.let_be_expression().multiple_bind(), ASTMultipleBind.class),
            ctx.let_be_expression().stexpr != null ? getNode(ctx.let_be_expression().stexpr, ASTExpression.class) : null,
            getNode(ctx.let_be_expression().inexpr, ASTExpression.class)));
    }

    @Override
    public void exitDefExpr(VDMParser.DefExprContext ctx)
    {
        putNode(ctx, new ASTDefExpression(token2loc(ctx), 
            getListNode(ctx.def_expression().equals_definition_list(), ASTDefinitionList.class), 
            getNode(ctx.def_expression().expression(), ASTExpression.class)));
    }

    @Override
    public void exitIfExpr(VDMParser.IfExprContext ctx)
    {
        ASTElseIfExpressionList elseIfList = new ASTElseIfExpressionList();
        for(Elseif_expressionContext ei : ctx.if_expression().elseif_expression())
        {
            elseIfList.add(getNode(ei, ASTElseIfExpression.class));
        }
        //If want to save the elseif_expression, have to create it as a separa ParserRuleContext
        //putListNode(ctx.if_expression().elseif_expression(), ASTElseIfExpressionList.class);
        putNode(ctx, new ASTIfExpression(
                token2loc(ctx), 
                getNode(ctx.if_expression().testExpr, ASTExpression.class),
                getNode(ctx.if_expression().thenExpr, ASTExpression.class), 
                elseIfList, 
                getNode(ctx.if_expression().elseExpr, ASTExpression.class)));
    }

    /**
     * VDM case alternatives are irrgular, namely each case alternative depends on the toplevel expression
     * as well as its own target/result expression. At enterCasesExpr, it's expression will not have been
     * walked through yet. So we can't use it to populate the case alternative in the lisst, hence all is done
     * here and other case alternative productions are ignored. 
     */
    @Override
    public void exitCasesExpr(VDMParser.CasesExprContext ctx)
    {
        ASTCaseAlternativeList casesList = new ASTCaseAlternativeList();
        ASTExpression leadExpr = getNode(ctx.cases_expression().expression(), ASTExpression.class);
        ASTExpression others = 
            ctx.cases_expression().others_expression() != null ? 
                getNode(ctx.cases_expression().others_expression().expression(), ASTExpression.class) : null; 
        for(VDMParser.Cases_expression_alternativeContext c : ctx.cases_expression().cases_expression_alternatives().cases_expression_alternative())
        {
            ASTExpression cExpr = getNode(c.expression(), ASTExpression.class);
            //@NB Case alternative LHS has pattern list? What's the use case given patterns can't refer to other patterns? 
            for(VDMParser.PatternContext p : c.pattern_list().pattern())
            {
                casesList.add(new ASTCaseAlternative(leadExpr, getNode(p, ASTPattern.class), cExpr));
            }
        }
        putNode(ctx, new ASTCasesExpression(token2loc(ctx), leadExpr, casesList, others));
    }

//------------------------
// A.5.4 Unary Expressions
//------------------------

    //@LRM Concrete example where having multiple layers is bad idea? 
    @Override
    public void exitUnaryExpr(VDMParser.UnaryExprContext ctx)
    {
        ASTExpression node = getNode(ctx.unary_expression(), ASTExpression.class);
        nodes.removeFrom(ctx.unary_expression());
        putNode(ctx, node);
    }

    @Override
    public void exitUnaryPlusExpr(VDMParser.UnaryPlusExprContext ctx)
    {
        putNode(ctx, new ASTUnaryPlusExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitUnaryMinusExpr(VDMParser.UnaryMinusExprContext ctx)
    {
        putNode(ctx, new ASTUnaryMinusExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitAbsoluteExpr(VDMParser.AbsoluteExprContext ctx)
    {
        putNode(ctx, new ASTAbsoluteExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitFloorExpr(VDMParser.FloorExprContext ctx)
    {
        putNode(ctx, new ASTFloorExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitCardinalityExpr(VDMParser.CardinalityExprContext ctx)
    {
        putNode(ctx, new ASTCardinalityExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitPowerSetExpr(VDMParser.PowerSetExprContext ctx)
    {
        putNode(ctx, new ASTPowerSetExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitNotExpr(VDMParser.NotExprContext ctx)
    {
        putNode(ctx, new ASTNotExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitSetDunionExpr(VDMParser.SetDunionExprContext ctx)
    {
        putNode(ctx, new ASTDistUnionExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitSetDinterExpr(VDMParser.SetDinterExprContext ctx)
    {
        putNode(ctx, new ASTDistIntersectExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitSeqHdExpr(VDMParser.SeqHdExprContext ctx)
    {
        putNode(ctx, new ASTHeadExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitSeqTlExpr(VDMParser.SeqTlExprContext ctx)
    {
        putNode(ctx, new ASTTailExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitSeqLenExpr(VDMParser.SeqLenExprContext ctx)
    {
        putNode(ctx, new ASTLenExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitSeqElemsExpr(VDMParser.SeqElemsExprContext ctx)
    {
        putNode(ctx, new ASTElementsExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitSeqIndsExpr(VDMParser.SeqIndsExprContext ctx)
    {
        putNode(ctx, new ASTIndicesExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitSeqReverseExpr(VDMParser.SeqReverseExprContext ctx)
    {
        putNode(ctx, new ASTReverseExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitSeqDistConcExpr(VDMParser.SeqDistConcExprContext ctx)
    {
        putNode(ctx, new ASTDistConcatExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitMapDomExpr(VDMParser.MapDomExprContext ctx)
    {
        putNode(ctx, new ASTMapDomainExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitMapRngExpr(VDMParser.MapRngExprContext ctx)
    {
        putNode(ctx, new ASTMapRangeExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitMapMergeExpr(VDMParser.MapMergeExprContext ctx)
    {
        putNode(ctx, new ASTDistMergeExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitMapInverseExpr(VDMParser.MapInverseExprContext ctx)
    {
        putNode(ctx, new ASTMapInverseExpression(token2loc(ctx), getNode(ctx.expression(), ASTExpression.class)));
    }

//------------------------
// A.5.6 Quantified Expressions
//------------------------

    @Override 
    public void exitQuantifiedExpr(VDMParser.QuantifiedExprContext ctx)
    {
        //TODO another concrete example of having multiple layers of grammar becoming convoluted
        if (ctx.quantified_expression().all_expression() != null)
            putNode(ctx, getNode(ctx.quantified_expression().all_expression(), ASTExpression.class));
        else if (ctx.quantified_expression().exists_expression() != null)
            putNode(ctx, getNode(ctx.quantified_expression().exists_expression(), ASTExpression.class));
        else 
            putNode(ctx, getNode(ctx.quantified_expression().exists_unique_expression(), ASTExpression.class));
    }

    @Override
    public void exitAll_expression(VDMParser.All_expressionContext ctx)
    {
        putNode(ctx, new ASTForAllExpression(token2loc(ctx), 
            getListNode(ctx.bind_list(), ASTMultipleBindList.class),
            getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitExists_expression(VDMParser.Exists_expressionContext ctx)
    {
        putNode(ctx, new ASTExistsExpression(token2loc(ctx), 
            getListNode(ctx.bind_list(), ASTMultipleBindList.class),
            getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitExists_unique_expression(VDMParser.Exists_unique_expressionContext ctx)
    {
        putNode(ctx, new ASTExists1Expression(token2loc(ctx), 
            getNode(ctx.bind(), ASTBind.class),
            getNode(ctx.expression(), ASTExpression.class)));
    }

    /**
     * Concrete example where having the inner productions explicitly named can cause confusion!
     */
    @Override
    //public void exitIota_expression(VDMParser.Iota_expressionContext ctx)
    public void exitIotaExpr(VDMParser.IotaExprContext ctx)
    {
        putNode(ctx, new ASTIotaExpression(token2loc(ctx), 
            getNode(ctx.iota_expression().bind(), ASTBind.class),
            getNode(ctx.iota_expression().expression(), ASTExpression.class)));
    }

    @Override
    public void exitSetEnumExpr(VDMParser.SetEnumExprContext ctx)
    {
        // empty set has no expression_list context but just an empty members list
        ASTExpressionList members = 
            ctx.set_enumeration().expression_list() != null ?
                getListNode(ctx.set_enumeration().expression_list(), ASTExpressionList.class) : new ASTExpressionList();
        putNode(ctx, new ASTSetEnumExpression(token2loc(ctx), members));
    }

    @Override
    public void exitSetCompExpr(VDMParser.SetCompExprContext ctx)
    {
        // if no filter, then pass null
        putNode(ctx, new ASTSetCompExpression(token2loc(ctx),
            getNode(ctx.set_comprehension().expr, ASTExpression.class),
            getListNode(ctx.set_comprehension().bind_list(), ASTMultipleBindList.class),
            ctx.set_comprehension().filter != null ? getNode(ctx.set_comprehension().filter, ASTExpression.class) : null));
    }

    @Override
    public void exitSetRangeExpr(VDMParser.SetRangeExprContext ctx)
    {
        putNode(ctx, new ASTSetRangeExpression(token2loc(ctx),
            getNode(ctx.set_range_expression().low, ASTExpression.class),
            getNode(ctx.set_range_expression().high, ASTExpression.class)));
    }

    @Override
    public void exitSeqEnumExpr(VDMParser.SeqEnumExprContext ctx)
    {
        // empty set has no expression_list context but just an empty members list
        ASTExpressionList members = 
            ctx.sequence_enumeration().expression_list() != null ?
                getListNode(ctx.sequence_enumeration().expression_list(), ASTExpressionList.class) : new ASTExpressionList();
        putNode(ctx, new ASTSeqEnumExpression(token2loc(ctx), members));
    }

    @Override
    public void exitSeqCompExpr(VDMParser.SeqCompExprContext ctx)
    {
        // if no filter, then pass null
        putNode(ctx, new ASTSeqCompExpression(token2loc(ctx),
            getNode(ctx.sequence_comprehension().expr, ASTExpression.class),
            getNode(ctx.sequence_comprehension().bind(), ASTBind.class),
            ctx.sequence_comprehension().filter != null ? getNode(ctx.sequence_comprehension().filter, ASTExpression.class) : null));
    }

    @Override 
    public void exitMaplet(VDMParser.MapletContext ctx)
    {
        //@NB the use of LexToken is unnecessary here? 
        //      From LexTokenReader.nextToken(), it seems this should be a keyword token?
        putNode(ctx, new ASTMapletExpression(
            getNode(ctx.dom, ASTExpression.class),
            // explicitly fully imported Token to avoid confusion with ANTLR's Token class
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.MAPLET, token2loc(ctx.SEP_maplet())),
            getNode(ctx.rng, ASTExpression.class)));
    }

    @Override
    public void exitMaplet_list(VDMParser.Maplet_listContext ctx)
    {
        ASTMapletExpressionList result = new ASTMapletExpressionList();
        for(VDMParser.MapletContext m : ctx.maplet())
        {
            result.add(getNode(m, ASTMapletExpression.class));
        }
        putListNode(ctx, result);
    }

    @Override
    public void exitMapEnumExpr(VDMParser.MapEnumExprContext ctx)
    {
        // empty set has no expression_list context but just an empty members list
        ASTMapletExpressionList members = ctx.map_enumeration().maplet_list() != null ?
                getListNode(ctx.map_enumeration().maplet_list(), ASTMapletExpressionList.class) : new ASTMapletExpressionList();
        putNode(ctx, new ASTMapEnumExpression(token2loc(ctx), members));
    }

    @Override
    public void exitMapCompExpr(VDMParser.MapCompExprContext ctx)
    {
        putNode(ctx, new ASTMapCompExpression(token2loc(ctx),
            getNode(ctx.map_comprehension().expr, ASTMapletExpression.class),
            getListNode(ctx.map_comprehension().bind_list(), ASTMultipleBindList.class),
            ctx.map_comprehension().filter != null ? getNode(ctx.map_comprehension().filter, ASTExpression.class) : null));
    }

    @Override 
    public void exitRecord_modification(VDMParser.Record_modificationContext ctx)
    {
        putNode(ctx, new ASTRecordModifier(id2lexid(ctx.IDENTIFIER(), ctx, false), 
            getNode(ctx.expression(), ASTExpression.class)));
    }

    @Override
    public void exitRecord_modification_list(VDMParser.Record_modification_listContext ctx)
    {
        ASTRecordModifierList result = new ASTRecordModifierList();
        for(VDMParser.Record_modificationContext r : ctx.record_modification())
        {
            result.add(getNode(r, ASTRecordModifier.class));
        }
        putListNode(ctx, result);
    }

    @Override
    public void exitRecordMuExpr(VDMParser.RecordMuExprContext ctx)
    {
        putNode(ctx, new ASTMuExpression(token2loc(ctx), 
            getNode(ctx.record_modifier().expression(), ASTExpression.class),
            getListNode(ctx.record_modifier().record_modification_list(), ASTRecordModifierList.class)));
    }

    @Override 
    public void exitLambdaExpr(VDMParser.LambdaExprContext ctx)
    {
        //@NB why not constant lambda functions? (e.g. lambda & 20) 
        putNode(ctx, new ASTLambdaExpression(token2loc(ctx), 
            getListNode(ctx.lambda_expression().type_bind_list(), ASTTypeBindList.class), 
            getNode(ctx.lambda_expression().expression(), ASTExpression.class)));
    }

    @Override 
    public void exitNarrowExpr(VDMParser.NarrowExprContext ctx)
    {
        LexLocation location = token2loc(ctx);
        ASTType type = getNode(ctx.narrow_expression().type(), ASTType.class);
        ASTExpression test = getNode(ctx.narrow_expression().expression(), ASTExpression.class);
        ASTNarrowExpression result;
        //@NB is this right? got similar to ExpressionReader
        if (type instanceof ASTUnresolvedType)
        {
            ASTUnresolvedType utype = (ASTUnresolvedType)type;
            result = new ASTNarrowExpression(location, utype.typename, test);
        }
        else
        {
            result = new ASTNarrowExpression(location, type, test);
        }
        putNode(ctx, result);
    }

    @Override
    public void exitIs_expression(VDMParser.Is_expressionContext ctx)
    {
        ASTIsExpression result;
        LexLocation location = token2loc(ctx);
        //@NB is this right? Seemed so from the ASTIsExpression constructor, but not quite the same as ExpressionReader 
        //    given I separated the two productions for is_expression (is_X(E)) and type judgement (is_(X, E))
        ASTExpression test = getNode(ctx.expression(), ASTExpression.class);
        if (ctx.basic_type() != null)
        {
            result = new ASTIsExpression(location, getNode(ctx.basic_type(), ASTType.class), test);
        }
        else 
        {
            result = new ASTIsExpression(location, 
                getNode(ctx.name(), LexNameToken.class), test);
        }
        putNode(ctx, result);
    }

    @Override 
    public void exitType_judgement(VDMParser.Type_judgementContext ctx)
    {
        ASTIsExpression result;
        LexLocation location = token2loc(ctx);
        ASTExpression test = getNode(ctx.expression(), ASTExpression.class);
        ASTType type = getNode(ctx.type(), ASTType.class);
        //@NB is this right? got similar to ExpressionReader
        if (type instanceof ASTUnresolvedType)
        {
            ASTUnresolvedType utype = (ASTUnresolvedType)type;
            result = new ASTIsExpression(location, utype.typename, test);
        }
        else
        {
            result = new ASTIsExpression(location, type, test);
        }
        putNode(ctx, result);
    }

    @Override
    public void exitUndefinedExpr(VDMParser.UndefinedExprContext ctx)
    {
        putNode(ctx, new ASTUndefinedExpression(token2loc(ctx)));
    }

    @Override
    public void exitPreconditionExpr(VDMParser.PreconditionExprContext ctx)
    {
        ASTExpressionList exprs = getListNode(ctx.precondition_expression().expression_list(), ASTExpressionList.class);
        ASTExpressionList params = new ASTExpressionList();
        params.addAll(exprs.subList(1, exprs.size()));
        putNode(ctx, new ASTPreExpression(token2loc(ctx), exprs.get(0), params));
    }

    //TODO all the isVDMPP()? isVDMRT()? semantic predicate cases

//------------------------
// C.1 The family of combinators
//------------------------

    @Override 
    public void exitIterateExpr(VDMParser.IterateExprContext ctx)
    {
        //@NB I think these will all be LexKeywordToken right? 
        putNode(ctx, new ASTStarStarExpression(
            getNode(ctx.iter, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.STARSTAR, token2loc(ctx.O_EXP())), 
            getNode(ctx.power, ASTExpression.class)));
    }

    @Override 
    public void exitMapCompositionExpr(VDMParser.MapCompositionExprContext ctx)
    {
        putNode(ctx, new ASTCompExpression(
            getNode(ctx.lhs, ASTExpression.class), 
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.COMP, token2loc(ctx.SLK_comp())), 
            getNode(ctx.rhs, ASTExpression.class)));
    }

//------------------------
// C.2 The family of applicators
//------------------------

    @Override 
    public void exitSubSeqExpr(VDMParser.SubSeqExprContext ctx)
    {
        putNode(ctx, new ASTSubseqExpression(
            getNode(ctx.call, ASTExpression.class), 
            getNode(ctx.low, ASTExpression.class), 
            getNode(ctx.high, ASTExpression.class)));
    }

    @Override 
    public void exitApplyExpr(VDMParser.ApplyExprContext ctx)
    {
        ASTExpressionList params = 
            ctx.expression_list() != null ? getListNode(ctx.expression_list(), ASTExpressionList.class) : new ASTExpressionList();
        putNode(ctx, new ASTApplyExpression(getNode(ctx.expression(), ASTExpression.class), params));
    }

    @Override 
    public void exitFunctionTypeInstExpr(VDMParser.FunctionTypeInstExprContext ctx)
    {
        putNode(ctx, new ASTFuncInstantiationExpression(
            getNode(ctx.expression(), ASTExpression.class), 
            getListNode(ctx.type_list(), ASTTypeList.class)));
    }

    @Override 
    public void exitFieldSelExpr(VDMParser.FieldSelExprContext ctx)
    {
        //@NB I think this is always going to be ASTFieldExpression with LexIdentifierToken for SL right? 
        putNode(ctx, new ASTFieldExpression(getNode(ctx.expression(), ASTExpression.class), 
            id2lexid(ctx.IDENTIFIER(), ctx, false)));
    }

    @Override
    public void exitTupleSelExpr(VDMParser.TupleSelExprContext ctx)
    {
        putNode(ctx, new ASTFieldNumberExpression(
            getNode(ctx.expression(), ASTExpression.class), 
            str2int(token2loc(ctx.NUMERAL()), ctx.NUMERAL().getText(), 10)));
    }

//------------------------
// A.5.5 Binary Expressions
//------------------------

//------------------------
// C.3 The family of evaluators
//------------------------
    @Override 
    public void exitMapRngFilterExpr(VDMParser.MapRngFilterExprContext ctx) 
    {
        putNode(ctx, new ASTRangeResByExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.RANGERESBY, token2loc(ctx.O_NRRES())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitMapRngRestrictExpr(VDMParser.MapRngRestrictExprContext ctx) 
    {
        putNode(ctx, new ASTRangeResToExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.RANGERESTO, token2loc(ctx.O_RRES())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitMapDomFilterExpr(VDMParser.MapDomFilterExprContext ctx) 
    {
        putNode(ctx, new ASTDomainResByExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.DOMRESBY, token2loc(ctx.O_NDRES())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitMapDomRestrictExpr(VDMParser.MapDomRestrictExprContext ctx) 
    {
        putNode(ctx, new ASTDomainResToExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.DOMRESTO, token2loc(ctx.O_DRES())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitMapUnionExpr(VDMParser.MapUnionExprContext ctx) 
    {
        putNode(ctx, new ASTMapUnionExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.MUNION, token2loc(ctx.SLK_munion())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitMapOverrideExpr(VDMParser.MapOverrideExprContext ctx) 
    {
        putNode(ctx, new ASTPlusPlusExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.PLUSPLUS, token2loc(ctx.O_OVERRIDE())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitArithmeticIntegerDivisionExpr(VDMParser.ArithmeticIntegerDivisionExprContext ctx) 
    {
        putNode(ctx, new ASTDivExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.DIV, token2loc(ctx.SLK_div())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitArithmeticModuloExpr(VDMParser.ArithmeticModuloExprContext ctx) 
    {
        putNode(ctx, new ASTModExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.MOD, token2loc(ctx.SLK_mod())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitArithmeticReminderExpr(VDMParser.ArithmeticReminderExprContext ctx) 
    {
        putNode(ctx, new ASTRemExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.REM, token2loc(ctx.SLK_rem())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitArithmeticDivideExpr(VDMParser.ArithmeticDivideExprContext ctx) 
    {
        putNode(ctx, new ASTDivideExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.DIVIDE, token2loc(ctx.O_DIV())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitArithmeticMultiplicationExpr(VDMParser.ArithmeticMultiplicationExprContext ctx) 
    {
        putNode(ctx, new ASTTimesExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.TIMES, token2loc(ctx.O_TIMES())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitArithmeticMinusExpr(VDMParser.ArithmeticMinusExprContext ctx) 
    {
        putNode(ctx, new ASTSubtractExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.MINUS, token2loc(ctx.O_MINUS())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitArithmeticPlusExpr(VDMParser.ArithmeticPlusExprContext ctx) 
    {
        putNode(ctx, new ASTPlusExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.PLUS, token2loc(ctx.O_PLUS())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitSetDiffExpr(VDMParser.SetDiffExprContext ctx) 
    {
        putNode(ctx, new ASTSetDifferenceExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.SETDIFF, token2loc(ctx.O_DIFF())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitSetUnionExpr(VDMParser.SetUnionExprContext ctx) 
    {
        putNode(ctx, new ASTSetUnionExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.UNION, token2loc(ctx.SLK_union())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitSetInterExpr(VDMParser.SetInterExprContext ctx) 
    {
        putNode(ctx, new ASTSetIntersectExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.INTER, token2loc(ctx.SLK_inter())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitSeqConcatExpr(VDMParser.SeqConcatExprContext ctx) 
    {
        putNode(ctx, new ASTSeqConcatExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.CONCATENATE, token2loc(ctx.O_CONCAT())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

//------------------------
// C.4 The family of relations
//------------------------

    @Override 
    public void exitRelationalGreaterThanEqualExpr(VDMParser.RelationalGreaterThanEqualExprContext ctx) 
    {
        putNode(ctx, new ASTGreaterEqualExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.GE, token2loc(ctx.O_GEQ())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitRelationalLessThanEqualExpr(VDMParser.RelationalLessThanEqualExprContext ctx) 
    {
        putNode(ctx, new ASTLessEqualExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.LE, token2loc(ctx.O_LEQ())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitRelationalGreaterThanExpr(VDMParser.RelationalGreaterThanExprContext ctx) 
    {
        putNode(ctx, new ASTGreaterExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.GT, token2loc(ctx.O_GT())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitRelationalLessThanExpr(VDMParser.RelationalLessThanExprContext ctx) 
    {
        putNode(ctx, new ASTLessExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.LT, token2loc(ctx.O_LT())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitRelationalNotEqualExpr(VDMParser.RelationalNotEqualExprContext ctx) 
    {
        putNode(ctx, new ASTNotEqualExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.NE, token2loc(ctx.O_NEQ())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitRelationalEqualExpr(VDMParser.RelationalEqualExprContext ctx) 
    {
        putNode(ctx, new ASTEqualsExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.EQUALS, token2loc(ctx.O_EQUAL())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitSetNotMemberExpr(VDMParser.SetNotMemberExprContext ctx) 
    {
        putNode(ctx, new ASTNotInSetExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.NOTINSET, token2loc(ctx.SLK_ninset())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitSetMemberExpr(VDMParser.SetMemberExprContext ctx) 
    {
        putNode(ctx, new ASTInSetExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.INSET, token2loc(ctx.SLK_inset())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitSetPSubsetExpr(VDMParser.SetPSubsetExprContext ctx) 
    {
        putNode(ctx, new ASTProperSubsetExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.PSUBSET, token2loc(ctx.SLK_psubset())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitSetSubsetExpr(VDMParser.SetSubsetExprContext ctx) 
    {
        putNode(ctx, new ASTSubsetExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.SUBSET, token2loc(ctx.SLK_subset())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

//------------------------
// C.5 The family of (logical) connectives
//------------------------

    @Override 
    public void exitLogicalAndExpr(VDMParser.LogicalAndExprContext ctx) 
    {
        putNode(ctx, new ASTAndExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.AND, token2loc(ctx.SLK_and())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitLogicalOrExpr(VDMParser.LogicalOrExprContext ctx) 
    {
        putNode(ctx, new ASTOrExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.OR, token2loc(ctx.SLK_or())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitLogicalImpliesExpr(VDMParser.LogicalImpliesExprContext ctx) 
    {
        putNode(ctx, new ASTImpliesExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.IMPLIES, token2loc(ctx.O_IMPLIES())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

    @Override 
    public void exitLogicalIffExpr(VDMParser.LogicalIffExprContext ctx) 
    {
        putNode(ctx, new ASTEquivalentExpression(
            getNode(ctx.lhs, ASTExpression.class),
            new LexKeywordToken(com.fujitsu.vdmj.lex.Token.EQUIVALENT, token2loc(ctx.O_IFF())),
            getNode(ctx.rhs, ASTExpression.class)));
    }

//------------------------
// C.6 The family of constructors
//------------------------

    @Override 
    public void exitTupleMkExpr(VDMParser.TupleMkExprContext ctx)
    {
        ASTExpressionList tuple = new ASTExpressionList();
        tuple.add(getNode(ctx.tuple_constructor().expression(), ASTExpression.class));
        tuple.addAll(getListNode(ctx.tuple_constructor().expression_list(), ASTExpressionList.class));
        putNode(ctx, new ASTTupleExpression(token2loc(ctx), tuple));
    }

    @Override 
    public void exitRecordMkExpr(VDMParser.RecordMkExprContext ctx)
    {
        ASTExpression result;
        ASTExpressionList exprs = ctx.record_constructor().expression_list() != null ? 
            getListNode(ctx.record_constructor().expression_list(), ASTExpressionList.class) : new ASTExpressionList();
        LexNameToken typename = getNode(ctx.record_constructor().tight_record_name(), LexNameToken.class);        
        LexNameToken mktypeName = getMkTypeName(typename);
        com.fujitsu.vdmj.lex.Token type = com.fujitsu.vdmj.lex.Token.lookup(mktypeName.name, dialect);
        if (type != null)
        {
            if (exprs.size() != 1)
            {
                //TODO
                result = null;//throwMessage(2300, "mk_<type> must have a single argument", typename.location);
            }

            if (type == com.fujitsu.vdmj.lex.Token.TOKEN)
            {
                result = new ASTMkBasicExpression(new ASTTokenType(mktypeName.location), exprs.get(0));
            }
            else
            {
                //TODO
                result = null;//throwMessage(2036, "Expecting mk_token", typename.location);
            }
        }
        else
        {
            result = new ASTMkTypeExpression(mktypeName, exprs);
        }
        putNode(ctx, result);
    }

    @Override 
    public void exitOldNameExpr(VDMParser.OldNameExprContext ctx)
    {
        putNode(ctx, new ASTVariableExpression(id2lexname(id2lexid(ctx.old_name().IDENTIFIER(), ctx, true))));
    }

    @Override 
    public void exitNameExpr(VDMParser.NameExprContext ctx)
    {
        putNode(ctx, new ASTVariableExpression(getNode(ctx.name(), LexNameToken.class)));
    }

    @Override
    public void enterSymbolicLitExpr(VDMParser.SymbolicLitExprContext ctx)
    {
        this.littype = SymbolicLiteralType.EXPRESSION;
    }

    @Override
    public void exitSymbolicLitExpr(VDMParser.SymbolicLitExprContext ctx)
    {
        if (!SymbolicLiteralType.EXPRESSION.equals(littype))
            throw new UnsupportedOperationException("Expected symbolic literal expression but found " + String.valueOf(littype));
        this.littype = null; 
        ASTExpression node = getNode(ctx.symbolic_literal(), ASTExpression.class);
        nodes.removeFrom(ctx.symbolic_literal());
        putNode(ctx, node);
    }

    @Override
    public void exitExpression_list(VDMParser.Expression_listContext ctx)
    {
        // empty expression list  
        ASTExpressionList result = new ASTExpressionList();
        for(VDMParser.ExpressionContext e : ctx.expression())
        {
            result.add(getNode(e, ASTExpression.class));
        }
        //TODO throw an ANTLR error in case of null? Not really given production is never empty ?
        assert !result.isEmpty();
        putListNode(ctx, result);
    }

//------------------------
// A.8.0 Names and Symbolic literals
//------------------------

    public static enum SymbolicLiteralType { PATTERN, EXPRESSION }

    public static enum NumericLiteralType { INT10, INT16, REAL }

    private final NumericLiteralType figureOutNumericLiteralType(String s)
    {
        //TODO these to me sounds like lexing rules that could have more info? 
        NumericLiteralType result; 
        if (s.startsWith("0x") || s.startsWith("0X"))
            result = NumericLiteralType.INT16;
        else if (s.indexOf(".") != -1 || 
                s.indexOf("e") != -1 ||
                s.indexOf("E") != -1)
            result = NumericLiteralType.REAL;
        else 
            result = NumericLiteralType.INT10;
        return result;
    }

    protected LexIntegerToken str2int(LexLocation location, String s, int base)
    {
        LexIntegerToken result;
        try
        {
            long l = Long.parseLong(s, base);
            result = new LexIntegerToken(l, location);
        }
        catch (NumberFormatException e)
        {
            //throwMessage(1014, "Cannot convert [" + s + "] in base " + base, location);
            throw e;
        }
        return result;
    }

    protected LexRealToken str2real(LexLocation location, String s)
    {
        LexRealToken result;
        try
        {
            double d = Double.parseDouble(s);
            result = new LexRealToken(d, location);
        }
        catch (NumberFormatException e)
        {
            throw new UnsupportedOperationException();
        }
        return result;
    }

    @Override 
    public void exitNumericLiteral(VDMParser.NumericLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        String p = ctx.NUMERIC_LITERAL().getText();
        NumericLiteralType nlittype = figureOutNumericLiteralType(p);
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                switch (nlittype)
                {
                    case INT10:
                        node = new ASTIntegerPattern(str2int(location, p, 10));
                        break;
                    case INT16:
                        node = new ASTIntegerPattern(str2int(location, p.substring(2), 16));
                        break;
                    case REAL:
                        node = new ASTRealPattern(str2real(location, p));
                        break;
                }
                break;
            case EXPRESSION:
                switch (nlittype)
                {
                    case INT10:
                        node = new ASTIntegerLiteralExpression(str2int(location, p, 10));
                        break;
                    case INT16:
                        node = new ASTIntegerLiteralExpression(str2int(location, p.substring(2), 16));
                        break;
                    case REAL:
                        node = new ASTRealLiteralExpression(str2real(location, p));
                        break;
                }
                break;
        }
        if (node == null) throw new UnsupportedOperationException("Invalid littype?");
        putNode(ctx, node);
    }

    @Override 
    public void exitCharacterLiteral(VDMParser.CharacterLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        String p = ctx.CHARACTER_LITERAL().getText();
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                // p = 'C' (e.g. p(0/2)=', p(1)=C )
                node = new ASTCharacterPattern(new LexCharacterToken(p.charAt(1), location)); 
                break;
            case EXPRESSION:
                node = new ASTCharLiteralExpression(new LexCharacterToken(p.charAt(1), location));
                break;
        }
        putNode(ctx, node);
    }

    @Override
    public void exitStringLiteral(VDMParser.StringLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        String p = ctx.TEXT_LITERAL().getText();
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                node = new ASTStringPattern(new LexStringToken(p, location)); 
                break;
            case EXPRESSION:
                node = new ASTStringLiteralExpression(new LexStringToken(p, location));
                break;
        }
        putNode(ctx, node);
    }

    @Override
    public void exitQuoteLiteral(VDMParser.QuoteLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        String quote = ctx.IDENTIFIER().getText();
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                node = new ASTQuotePattern(new LexQuoteToken(quote, location)); 
                break;
            case EXPRESSION:
                node = new ASTQuoteLiteralExpression(new LexQuoteToken(quote, location));
                break;
        }
        putNode(ctx, node);
    }

    @Override 
    public void exitBooleanLiteral(VDMParser.BooleanLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                node = new ASTBooleanPattern(new LexBooleanToken(ctx.SLK_true() != null, location));
                break;
            case EXPRESSION:
                node = new ASTBooleanLiteralExpression(new LexBooleanToken(ctx.SLK_true() != null, location));
                break;
        }
        putNode(ctx, node);
    }

    @Override 
    public void exitNilLiteral(VDMParser.NilLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                node = new ASTNilPattern(new LexKeywordToken(com.fujitsu.vdmj.lex.Token.NIL, location));
                break;
            case EXPRESSION:
                node = new ASTNilExpression(location);
                break;
        }
        putNode(ctx, node);
    }

//------------------------
// A.8.1 Patterns + Literals
//------------------------

    @Override 
    public void exitPattern_list(VDMParser.Pattern_listContext ctx)
    {
        // empty pattern list (empty set/q etc) is non-null 
        ASTPatternList result = new ASTPatternList();
        for(VDMParser.PatternContext p : ctx.pattern())
        {
            result.add(getNode(p, ASTPattern.class));
        }
        //TODO has to be Mappable? Instead of ASTNode?!
        putListNode(ctx, result);
    }

    @Override
    public void exitBracketedExprPattern(VDMParser.BracketedExprPatternContext ctx)
    {
        putNode(ctx, new ASTExpressionPattern(getNode(ctx.expression(), ASTExpression.class)));
    }
    
    @Override 
    public void exitSetEnumPattern(VDMParser.SetEnumPatternContext ctx)
    {
        ParserRuleContext plist = ctx.pattern_list();
        ASTPatternList list;
        // empty sets have no matching pattern_list context
        if (plist == null)
            list = new ASTPatternList();
        else 
            list = getListNode(plist, ASTPatternList.class);
        putNode(ctx, new ASTSetPattern(token2loc(ctx), list));
    }

    @Override 
    public void exitSetUnionPattern(VDMParser.SetUnionPatternContext ctx)
    {
        ASTPattern p1 = getNode(ctx.pattern(0), ASTPattern.class);
        ASTPattern p2 = getNode(ctx.pattern(1), ASTPattern.class);
        putNode(ctx, new ASTMapUnionPattern(p1, token2loc(ctx.SLK_union()), p2));
    }

    @Override 
    public void exitSeqEnumPattern(VDMParser.SeqEnumPatternContext ctx)
    {
        ParserRuleContext plist = ctx.pattern_list();
        ASTPatternList list;
        // empty seqs have no matching pattern_list context
        if (plist == null)
            list = new ASTPatternList();
        else 
            list = getListNode(plist, ASTPatternList.class);
        putNode(ctx, new ASTSetPattern(token2loc(ctx), list));
    }

    @Override 
    public void exitSeqConcatPattern(VDMParser.SeqConcatPatternContext ctx)
    {
        ASTPattern lhs = getNode(/*ctx.pattern(0)*/ctx.lhs, ASTPattern.class);
        ASTPattern rhs = getNode(/*ctx.pattern(1)*/ctx.rhs, ASTPattern.class);
        putNode(ctx, new ASTConcatenationPattern(lhs, token2loc(ctx.O_CONCAT()), rhs));
    }

    @Override 
    public void exitEmptyMapPattern(VDMParser.EmptyMapPatternContext ctx)
    {
        putNode(ctx, new ASTMapPattern(token2loc(ctx), new ASTMapletPatternList()));
    }

    @Override 
    public void exitMaplet_pattern(VDMParser.Maplet_patternContext ctx)
    {
        ASTPattern from = getNode(ctx.from, ASTPattern.class);
        ASTPattern to = getNode(ctx.to, ASTPattern.class);
        putNode(ctx, new ASTMapletPattern(from, to));
    }

    @Override
    public void exitMaplet_pattern_list(VDMParser.Maplet_pattern_listContext ctx)
    {
        // empty pattern list (empty map) is non-null 
        ASTMapletPatternList result = new ASTMapletPatternList();
        for(VDMParser.Maplet_patternContext p : ctx.maplet_pattern())
        {
            result.add(getNode(p, ASTMapletPattern.class));
        }
        putListNode(ctx, result);        
    }

    @Override 
    public void exitMapEnumPattern(VDMParser.MapEnumPatternContext ctx)
    {
        putNode(ctx, new ASTMapPattern(token2loc(ctx), getListNode(ctx.maplet_pattern_list(), ASTMapletPatternList.class)));
    }

    @Override 
    public void exitMapMunionPattern(VDMParser.MapMunionPatternContext ctx)
    {
        ASTPattern lhs = getNode(ctx.lhs, ASTPattern.class);
        ASTPattern rhs = getNode(ctx.rhs, ASTPattern.class);
        putNode(ctx, new ASTMapUnionPattern(lhs, token2loc(ctx.SLK_munion()), rhs));
    }

    @Override 
    public void exitTupplePattern(VDMParser.TupplePatternContext ctx)
    {
        //ASTPattern p = getNode(ctx.pattern(), ASTPattern.class);
        //LRM: no need for "pattern , pattern_list"
        ASTPatternList list = getListNode(ctx.pattern_list(), ASTPatternList.class);
        if (list.isEmpty())
            throw new UnsupportedOperationException("Tupple must have >1 arguments");
        putNode(ctx, new ASTTuplePattern(token2loc(ctx), list));
    }

    @Override
    public void exitPPObjectPattern(VDMParser.PPObjectPatternContext ctx)
    {
        //@NB needs to be implement ASTNamePatternPairList Mappable 
        ASTNamePatternPairList list = null;//(ASTNamePatternPairList)lists.get(ctx.field_pattern_list());
        LexNameToken classname = id2lexname(id2lexid(ctx.OBJECT_IDENTIFIER(), ctx, "obj_".length(), false));
        putNode(ctx, new ASTObjectPattern(token2loc(ctx), classname, list));
    }

    @Override
    public void exitTight_record_name(VDMParser.Tight_record_nameContext ctx)
    {
        LexNameToken typename;
        // check on ctx.second token type instead of != null?
        // mk_A`R(...)
        if (ctx.SEP_tick() != null)
        {
            String qualifiedName = ctx.RECORD_IDENTIFIER().getText();
            String mod = qualifiedName.substring(3);//mk_.length()=3
            String name = ctx.IDENTIFIER().getText();
            typename = new LexNameToken(mod, name, token2loc(ctx));
            //String qualifiedName = ctx.RECORD_IDENTIFIER().getText();
            // int backtick = qualifiedName.indexOf('`');
            // assert backtick >= 0;
            // String mod = qualifiedName.substring(3, backtick);//"mk_".length()=3
            // String name = qualifiedName.substring(backtick + 1);
            // typename = new LexNameToken(mod, name, token2loc(ctx));
        }
        // mk_R(...)
        else 
        {
            assert ctx.RECORD_IDENTIFIER() != null; //TODO assert or recognition failure?
            typename = id2lexname(id2lexid(ctx.RECORD_IDENTIFIER(), ctx, 3, false));
        }
        putNode(ctx, typename);
    }

    @Override
    public void exitRecordPattern(VDMParser.RecordPatternContext ctx)
    {
        //ASTPatternList list = (ASTPatternList)lists.get(ctx.pattern_list());
        ASTPatternList list = (ASTPatternList)getListNode(ctx.pattern_list(), ASTPatternList.class);
        LexNameToken typename = getNode(ctx.tight_record_name(), LexNameToken.class);
        VDMParserUtils.Range r = VDMParserUtils.findScope(ctx.tight_record_name().getText(), ctx.tight_record_name());
        System.out.println(r);
        putNode(ctx, new ASTRecordPattern(typename, list));
    }

    @Override 
    public void enterSymbolicLiteralPattern(VDMParser.SymbolicLiteralPatternContext ctx)
    {
        this.littype = SymbolicLiteralType.PATTERN;
    }

    @Override 
    public void exitSymbolicLiteralPattern(VDMParser.SymbolicLiteralPatternContext ctx)
    {
        if (!SymbolicLiteralType.PATTERN.equals(littype))
            throw new UnsupportedOperationException("Expected symbolic literal pattern but found " + String.valueOf(littype));
        this.littype = null; 
        // how to know what kind of pattern came through? 
        // ctx.symbolic_literal?
        ASTPattern node = getNode(ctx.symbolic_literal(), ASTPattern.class);
        if (!(node instanceof ASTIntegerPattern || 
            node instanceof ASTRealPattern ||
            node instanceof ASTCharacterPattern ||
            node instanceof ASTStringPattern ||
            node instanceof ASTQuotePattern ||
            node instanceof ASTBooleanPattern ||
            node instanceof ASTNilPattern))
        {
            throw new UnsupportedOperationException("Unknown pattern node " + node.getClass().getSimpleName());
        }
        //TODO should such removals also be present in other sub-trees? 
        nodes.removeFrom(ctx.symbolic_literal()); 
        putNode(ctx, node);
    }    

    @Override
    public void exitIgnorePattern(VDMParser.IgnorePatternContext ctx)
    {
        // Interval i = ctx.getSourceInterval();
        // System.out.println(i);
        putNode(ctx, new ASTIgnorePattern(token2loc(ctx)));
    }

    @Override
    public void exitIdPattern(VDMParser.IdPatternContext ctx)
    {
        putNode(ctx, new ASTIdentifierPattern(id2lexname(id2lexid(ctx.IDENTIFIER(), ctx, false))));
    }

//------------------------
// A.8.2 Bindings
//------------------------

    @Override 
    public void exitPattern_bind(VDMParser.Pattern_bindContext ctx)
    {
        //@NB readPatternOrBind is complicated (i.e. backtracks on error? is ambigous in the grammar?)
        //@NB LRM says pattern then bind; VDMJ prioritises bind. Following that here
        if (ctx.bind() != null)
        {
            ASTBind bind = getNode(ctx.bind(), ASTBind.class);
            nodes.removeFrom(ctx.bind());
            putNode(ctx, bind);
        }
        else if (ctx.pattern() != null)
        {
            ASTPattern pattern = getNode(ctx.bind(), ASTPattern.class);
            nodes.removeFrom(ctx.pattern());
            putNode(ctx, pattern);
        }
        else 
            // recognition exception might be null? 
            throw ctx.exception != null ? ctx.exception : new UnsupportedOperationException();
    }

    @Override
    public void exitSetBind(VDMParser.SetBindContext ctx)
    {
        ASTPattern p = getNode(ctx.pattern(), ASTPattern.class);
        ASTExpression expr = getNode(ctx.expression(), ASTExpression.class);
        putNode(ctx, new ASTSetBind(p, expr));
    }

    @Override
    public void exitSeqBind(VDMParser.SeqBindContext ctx)
    {
        ASTPattern p = getNode(ctx.pattern(), ASTPattern.class);
        ASTExpression expr = getNode(ctx.expression(), ASTExpression.class);
        putNode(ctx, new ASTSeqBind(p, expr));
    }

    @Override
    //TODO another example of possible confusion; in this case we must have both! Given how they are used in bind and type_bind_list!
    public void exitType_bind(VDMParser.Type_bindContext ctx)
    {
        ASTPattern p = getNode(ctx./*type_bind().*/pattern(), ASTPattern.class);
        ASTType type= getNode(ctx./*type_bind().*/type(), ASTType.class);
        putNode(ctx, new ASTTypeBind(p, type));
    }
 
    @Override
    public void exitTypeBind(VDMParser.TypeBindContext ctx)
    {
        putNode(ctx, getNode(ctx.type_bind(), ASTTypeBind.class));
    }

    @Override 
    public void exitBind_list(VDMParser.Bind_listContext ctx)
    {
        // empty bind list (empty multiple bind list) is non-null 
        ASTMultipleBindList result = new ASTMultipleBindList();
        for(VDMParser.Multiple_bindContext mb : ctx.multiple_bind())
        {
            result.add(getNode(mb, ASTMultipleBind.class));
        }
        putListNode(ctx, result);
    }

    @Override
    public void exitMultipleSetBind(VDMParser.MultipleSetBindContext ctx)
    {
        ASTPatternList list = getListNode(ctx.pattern_list(), ASTPatternList.class);
        ASTExpression expr = getNode(ctx.expression(), ASTExpression.class);
        putNode(ctx, new ASTMultipleSetBind(list, expr));
    }

    @Override
    public void exitMultipleSeqBind(VDMParser.MultipleSeqBindContext ctx)
    {
        ASTPatternList list = getListNode(ctx.pattern_list(), ASTPatternList.class);
        ASTExpression expr = getNode(ctx.expression(), ASTExpression.class);
        putNode(ctx, new ASTMultipleSeqBind(list, expr));
    }

    @Override
    public void exitMultipleTypeBind(VDMParser.MultipleTypeBindContext ctx)
    {
        ASTPatternList list = getListNode(ctx.pattern_list(), ASTPatternList.class);
        ASTType type = getNode(ctx.type(), ASTType.class);
        putNode(ctx, new ASTMultipleTypeBind(list, type));
    }

    @Override 
    public void exitType_bind_list(VDMParser.Type_bind_listContext ctx)
    {
        // empty bind list (empty type bind list) is non-null 
        ASTTypeBindList result = new ASTTypeBindList();
        for(VDMParser.Type_bindContext tb : ctx.type_bind())
        {
            result.add(getNode(tb, ASTTypeBind.class));
        }
        putListNode(ctx, result);
    }

        /**
     * Akin to ExpressionReader.readIdList() as a LexNameList result!
     */
    @Override 
    public void exitName_list(VDMParser.Name_listContext ctx)
    {
        // empty pattern list (empty set/q etc) is non-null 
        LexNameList result = new LexNameList();
        for(VDMParser.NameContext n : ctx.name())
        {
            result.add(getNode(n, LexNameToken.class));
        }
        putListNode(ctx, result);
    }

    protected boolean isReserved(String name)
	{
		return
			name.startsWith("pre_") ||
			name.startsWith("post_") ||
			name.startsWith("inv_") ||
			name.startsWith("init_") ||
			name.startsWith("measure_") ||
			Settings.release == Release.VDM_10 &&
			(
				name.startsWith("eq_") ||
				name.startsWith("ord_") ||
				name.startsWith("min_") ||
				name.startsWith("max_")
			);
	}

    @Override
    public void exitQualifiedName(VDMParser.QualifiedNameContext ctx)
    {
        LexNameToken name = new LexNameToken(ctx.IDENTIFIER(0).getText(), id2lexid(ctx.IDENTIFIER(1), ctx, false));
        if (isReserved(name.name))
        {
            //throwMessage(2295, "Name " + name + " contains a reserved prefix", tok);
        }
        putNode(ctx, name);
    }

    @Override
    public void exitIdName(VDMParser.IdNameContext ctx)
    {
        LexNameToken name = id2lexname(id2lexid(ctx.IDENTIFIER(), ctx, false));
        if (isReserved(name.name))
        {
            //throwMessage(2295, "Name " + name + " contains a reserved prefix", tok);
        }
        putNode(ctx, name);
    }
}

