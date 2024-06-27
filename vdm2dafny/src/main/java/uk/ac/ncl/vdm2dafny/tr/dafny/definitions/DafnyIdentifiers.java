package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCQuoteType;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;

public class DafnyIdentifiers {
    private static DafnyIdentifiers INSTANCE;

    private Map<Pair<String, String>, String> renamedMap = new HashMap<>();
    private Map<String, String> quoteMap = new HashMap<>();

    private Set<String> RESERVED_WORDS = Set.of(
        "abstract" , "allocated" , "as" , "assert" , "assume" ,
        "bool" , "break" , "by" ,
        "calc" , "case" , "char" , "class" , "codatatype" ,
        "const" , "constructor" , "continue" ,
        "datatype" , "decreases" ,
        "else" , "ensures" , "exists" , "expect" , "export" , "extends" ,
        "false" , "for" , "forall" , "fresh" , "function" , "ghost" ,
        "if" , "imap" , "import" , "in" , "include" ,
        "int" , "invariant" , "is" , "iset" , "iterator" ,
        "label" , "lemma" , "map" , "match" , "method" ,
        "modifies" , "modify" , "module" , "multiset" ,
        "nameonly" , "nat" , "new" , "newtype" , "null" ,
        "object" , "object?" , "old" , "opaque" , "opened" , "ORDINAL",
        "predicate" , "print" , "provides" ,
        "reads" , "real" , "refines" , "requires" , "return" ,
        "returns" , "reveal" , "reveals" ,
        "seq" , "set" , "static" , "string" ,
        "then" , "this" , "trait" , "true" , "twostate" , "type" ,
        "unchanged" , "var" , "while" , "witness" ,
        "yield" , "yields" ,
        "array", "array2", "array3",
        "bv0", "bv1", "bv2"
    );

    private DafnyIdentifiers() {}

    public final static DafnyIdentifiers instance() {
        if (INSTANCE == null)
            INSTANCE = new DafnyIdentifiers();
        return INSTANCE;
    }

    public void reset() {
        renamedMap.clear();
    }

    public void addQuote(String belongsto, TCQuoteType quoteType) {
        String quote = quoteType.value;
        if (quoteMap.containsKey(quote)) {
            DafnyTranslateCommand.report(DafnyErrorMessage.VDMSL_DUPLICATE_QUOTES_2P, quoteType.location, belongsto, quoteMap.get(quote));
        }
        else {
            quoteMap.put(quote, belongsto);
        }
    }

    public boolean quoteIsType(String belongsto, TCQuoteType quoteType) {
        return quoteMap.containsKey(quoteType.value) && quoteMap.get(quoteType.value).equals(belongsto);
    }

    public void addTransformation(TCNameToken tok, String rename) {
        addTransformation(tok.getModule(), tok.getName(), rename);
    }

    private void addTransformation(String module, String name, String rename) {
        renamedMap.put(Pair.of(module, transform(name)), transform(rename));
    }

    private boolean renameExists(TCNameToken tok) {
        return renamedMap.containsKey(Pair.of(tok.getModule(), tok.getName()));
    }

    private String getRename(TCNameToken tok) {
        assert renameExists(tok);
        return renamedMap.get(Pair.of(tok.getModule(), tok.getName()));
    }

    public String transform(TCNameToken tok) {
        if (renameExists(tok)) {
            return getRename(tok);
        }
        else if (!DafnyEnvironment.instance().sameModule(tok)) {
            return tok.getModule() + "." + transform(tok.getName());
        }
        else {
            return transform(tok.getName());
        }
    }
    
    public String transform(TCIdentifierToken tok) {
        return transform(tok.getName());
    }

    public String transform(String name) {
        String transformed = name;
        if (name.matches("^([0-9]|_).*$")) {
            // illegal start of var name
            transformed = "dfy_" + name;
        }
        if (RESERVED_WORDS.contains(transformed)) {
            transformed = "dfy_" + name;
        }
        if (transformed.matches("^[0-9]*$")) {
            transformed = "dfy_" + name;
        }
        
        // Replace all nonidchars with _
        transformed = transformed.replaceAll("[^0-9A-Za-z?_']", "_");
        
        // After everything else, modify for pre and postconditions
        // if (name.startsWith("pre_")) {
        //     transformed = name.substring(4) + "_requires";
        // }
        // if (name.startsWith("post_")) {
        //     transformed = name.substring(5) + "_ensures";
        // }
        return transformed;
    }
}
