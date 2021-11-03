package vdm2isa.tr;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.Mappable;

/**
 * Interface for all mappable nodes (i.e. TRNode and its lists and lists of lists etc.)
 */
public interface MappableNode extends Mappable {
    
	/**
	 * Top-level translation associated with this TRNode. 
	 * @return Isabelle YXML string.
	 */
	public String translate();

	/**
	 * Top-level (implicit) invariant-related translation associated with this TRNode. TRNodes with contextual
	 * information do not require extra parameters (i.e. they can be inferred from TRNode fields); otherwise, 
	 * an extended version with the variable(s) names needed can be added (i.e. TRType doesn't have its associated 
	 * variable name to be used for invariant translation). See TRType#invTranslate(String). 
	 * @return Isabelle YXML string.
	 */
	public String invTranslate();

	/**
	 * Whether or not the TRNode should issue this Isabelle comment. Useful for explicit definitions
	 * @return
	 */
	public String tldIsaComment();

	public LexLocation getLocation();
	
	public void report(int number, String msg);
	public void warning(int number, String msg);

	public String getSemanticSeparator();
	public String setSemanticSeparator(String sep);
	public String getInvTranslateSeparator();
	public String setInvTranslateSeparator(String sep);
	public String getFormattingSeparator();
	public String setFormattingSeparator(String sep);
}
