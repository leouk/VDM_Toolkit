package uk.ac.ncl.vdm2dafny.tr.dafny.modules;

import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.stringtemplate.v4.ST;

import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitOperationDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitOperationDefinition;
import com.fujitsu.vdmj.tc.definitions.TCStateDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.definitions.TCValueDefinition;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCUnionType;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.DafnyVDMComment;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyConstant;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyExportDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyFunctionDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyImportDefinitionList;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyOperationDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyStateDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;

public class DafnyModule {
    private final TCModule mod;
    
    public DafnyModule(TCModule mod) {
        this.mod = mod;
        DafnyEnvironment.instance().setWorkingLocation(mod.name.getName());
    }
    public TCModule getModule() {
        return mod;
    }

    public String translate() {
        DafnyEnvironment.instance().setWorkingLocation(mod.name.getName());
        return DafnyTemplates.MODULES.render("module", Pair.of("mod", this));
    }

    public List<String> getExports() {
        return DafnyExportDefinition.from(mod).stream().map(export -> export.translate()).collect(Collectors.toList());
    }

    public String getImports() {
        return DafnyImportDefinitionList.from(mod).translate();
    }

    public String getDefinitions() {
        ST definitions = new ST("<list:{item|<item>}; separator=\"\n\n\">");
        List<String> translations = new ArrayList<>();

        // Set state
        translations.add(DafnyTemplates.banner("STATE"));
        mod.defs.stream()
            .filter(def -> def instanceof TCStateDefinition)
            .map(def -> (TCStateDefinition)def)
            .forEach(def -> translations.add(new DafnyStateDefinition(def).translate()));
        // Add values
        translations.add(DafnyTemplates.banner("CONSTANTS"));
        mod.defs.stream()
            .filter(def -> def.isValueDefinition())
            .map(def -> (TCValueDefinition)def)
            .forEach(def -> translations.add(new DafnyConstant(def).translate()));

        // Add types
        translations.add(DafnyTemplates.banner("TYPES"));
        mod.defs.stream()
            .filter(def -> def.isTypeDefinition())
            .map(def -> (TCTypeDefinition)def)
            // .filter(def -> !def.type.isUnion(def.location)) // Filter out union types for now TODO implement
            
            .filter(def -> def != null)
            .map(def -> DafnyTypeDefinition.parseType(def))
            .filter(def -> def != null)
            .forEach(def -> translations.add(def.translate()));

        // Properly get composed union definitions....
        mod.defs.stream()
            .filter(def -> def.isTypeDefinition())
            .map(def -> (TCTypeDefinition)def)
            // .filter(def -> !def.type.isUnion(def.location)) // Filter out union types for now TODO implement
            
            .filter(def -> def != null)
            .filter(def -> (def.type.isUnion(def.location)) && (def.type instanceof TCNamedType) && ((TCNamedType)def.type).type instanceof TCUnionType)
            .map(def -> def.type.getUnion().getComposeTypes())
            .flatMap(types -> types.stream()
                .flatMap(type -> type.definitions.stream()
                    .filter(def -> def.isTypeDefinition())
                    .map(def -> (TCTypeDefinition)def)))
            .map(def -> DafnyTypeDefinition.parseType(def))
            .filter(def -> def != null)
            .forEach(def -> translations.add(def.translate()));

        // Add functions
        translations.add(DafnyTemplates.banner("FUNCTIONS"));
        mod.defs.stream()
            .filter(def -> def.isFunction())
            .forEach(def -> {
                if (def instanceof TCExplicitFunctionDefinition)
                    translations.add( new DafnyFunctionDefinition((TCExplicitFunctionDefinition)def).translate() );
                else if (def instanceof TCImplicitFunctionDefinition)
                    translations.add( new DafnyFunctionDefinition((TCImplicitFunctionDefinition)def).translate() );
            });
        
        translations.add(DafnyTemplates.banner("OPERATIONS"));
        mod.defs.stream()
            .filter(def -> def.isOperation())
            .forEach(def -> {
                try {
                    if (def instanceof TCExplicitOperationDefinition)
                        translations.add( new DafnyOperationDefinition((TCExplicitOperationDefinition)def).translate() );
                    else if (def instanceof TCImplicitOperationDefinition)
                        translations.add( new DafnyOperationDefinition((TCImplicitOperationDefinition)def).translate() );
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            });
        
        // for (TCDefinition def: mod.defs) {
        //     if (def.isFunction() && def instanceof TCExplicitFunctionDefinition) {
        //         // Explicit function, pass off to function handler
        //         DafnyFunctionDefinition tdef = new DafnyFunctionDefinition(def);
        //         translations.add(tdef.translate());
        //     }
        //     else if (def.isFunction() && def instanceof TCImplicitFunctionDefinition) {
        //         // When are implicit functions ever found here?
        //         System.out.println(def.name.getName());
        //     }
        //     else if (def.isTypeDefinition()) {
        //         // Type definition, pass off to type parser
        //         TCTypeDefinition typedef = (TCTypeDefinition)def;
        //         if (!typedef.type.isUnion(typedef.location))
        //             translations.add(DafnyType.parseType(typedef).translate());
        //     }
        //     else if (def.isValueDefinition())
        //     {
        //         // TOP LEVEL CONSTANT DEFINITION!
        //         TCValueDefinition valuedef = (TCValueDefinition)def;
        //         translations.add(new DafnyConstant(valuedef).translate());
        //     }
        //     else if (def.isOperation()) {
        //         // Operations
        //     }
        //     else {
        //         System.out.println(def);
        //     }
        // }
        definitions.add("list", translations);
        return definitions.render();
    }

    public String getSignature() {
        return String.format("@vdm.module(%s)", getName());
    }

    public String getName() {
        return DafnyIdentifiers.instance().transform(mod.name.getName());
    }

    public String getPathToVdmDfy() {
        URL resource = getClass().getClassLoader().getResource("vdm.dfy");
        return URLDecoder.decode(resource.getFile().substring(1), Charset.defaultCharset());
    }

    public List<DafnyVDMComment> getComments() {
        return mod.comments.stream().map(comment -> new DafnyVDMComment(comment)).collect(Collectors.toList());
    }
}
