package vdm2isa.tr.patterns;

import vdm2isa.tr.MappableNode;

/**
 * Interface for record pattern context creation awareness across the AST (e.g. mk_R(x,y)). Various patterns, binds and lists
 * have this within their implemented interface to enable TRExpression to have a single record-context aware
 * method with whichever implementer of this interface as a parameter for the context.  
 */
public interface TRRecordContext extends MappableNode {
    public boolean hasRecordPattern();
    public String recordPatternTranslate(String varName);
}
