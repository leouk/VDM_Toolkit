package vdm2isa.tr.templates;

/**
 * Represents VDM function definitions. That means, template will generate a
 * if pre_f_def then f else undefined template. 
 */
public class IsaVDMFunDef extends IsaDefinition {

    protected IsaVDMFunDef(IsaIdentifier name, String type, String expr, IsaAttribute... attr)
    {
        super(name, type, expr, false, attr);
    }
    
    protected IsaVDMFunDef(String comment, IsaIdentifier name, String type, String expr, IsaAttribute... attr)
    {
        super(comment, name, type, expr, false, attr);
    }
}
