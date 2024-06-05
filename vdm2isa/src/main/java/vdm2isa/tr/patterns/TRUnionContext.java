package vdm2isa.tr.patterns;

import vdm2isa.tr.MappableNode;
import vdm2isa.tr.expressions.TRExpression;

/**
 * Interface for union typed pattern context creation awareness across the AST. Various patterns, binds and lists
 * have unions within their implemented interface to enable TRExpression to have a single union projection-context aware
 * method with whichever implementer of this interface as a parameter for the context.  
 */
public interface TRUnionContext extends MappableNode {
    public boolean hasUnionTypes();

    /**
     * consider the body only when inner context is null
     * @param body
     * @return
     */
    public String unionTypesTranslate(TRExpression body, TRUnionContext innerContext);

    public TRUnionContext getNextUnionContext();
}
