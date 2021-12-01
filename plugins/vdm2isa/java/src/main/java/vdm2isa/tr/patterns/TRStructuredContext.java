package vdm2isa.tr.patterns;

import vdm2isa.tr.MappableNode;

/**
 * Interface for structured pattern context creation awareness across the AST (e.g. mk_(x,y)). Various patterns, binds and lists
 * have this within their implemented interface to enable TRExpression to have a single structured-context aware
 * method with whichever implementer of this interface as a parameter for the context.  
 */
public interface TRStructuredContext extends MappableNode {
    public boolean hasStructuredPattern();
    public String structuredPatternTranslate(String varName);
}