// Generated from /Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm-antlr/src/main/antlr4/VDM.g4 by ANTLR 4.9.2
package vdmantlr;

//import com.fujitsu.vdmj.lex.Dialect;    

import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link VDMParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface VDMVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link VDMParser#sl_document}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSl_document(VDMParser.Sl_documentContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#module}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitModule(VDMParser.ModuleContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sl_interface}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSl_interface(VDMParser.Sl_interfaceContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#import_definition_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImport_definition_list(VDMParser.Import_definition_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#import_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImport_definition(VDMParser.Import_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#import_module_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImport_module_signature(VDMParser.Import_module_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#import_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImport_signature(VDMParser.Import_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#import_types_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImport_types_signature(VDMParser.Import_types_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_import}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_import(VDMParser.Type_importContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#import_values_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImport_values_signature(VDMParser.Import_values_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#value_import}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitValue_import(VDMParser.Value_importContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#import_functions_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImport_functions_signature(VDMParser.Import_functions_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#function_import}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunction_import(VDMParser.Function_importContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#import_operations_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImport_operations_signature(VDMParser.Import_operations_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#operation_import}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOperation_import(VDMParser.Operation_importContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#export_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExport_definition(VDMParser.Export_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#export_module_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExport_module_signature(VDMParser.Export_module_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#export_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExport_signature(VDMParser.Export_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#export_types_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExport_types_signature(VDMParser.Export_types_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_export}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_export(VDMParser.Type_exportContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#export_values_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExport_values_signature(VDMParser.Export_values_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#value_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitValue_signature(VDMParser.Value_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#export_functions_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExport_functions_signature(VDMParser.Export_functions_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#function_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunction_signature(VDMParser.Function_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#export_operations_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExport_operations_signature(VDMParser.Export_operations_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#operation_signature}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOperation_signature(VDMParser.Operation_signatureContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#module_body}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitModule_body(VDMParser.Module_bodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#rt_document}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRt_document(VDMParser.Rt_documentContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#system}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSystem(VDMParser.SystemContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#rt_class_body}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRt_class_body(VDMParser.Rt_class_bodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pp_class}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPp_class(VDMParser.Pp_classContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#inheritance_clause}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInheritance_clause(VDMParser.Inheritance_clauseContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#class_body}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitClass_body(VDMParser.Class_bodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#rt_definition_block}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRt_definition_block(VDMParser.Rt_definition_blockContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pp_definition_block}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPp_definition_block(VDMParser.Pp_definition_blockContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sl_definition_block}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSl_definition_block(VDMParser.Sl_definition_blockContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pp_type_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPp_type_definitions(VDMParser.Pp_type_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#access_type_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAccess_type_definition(VDMParser.Access_type_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#access}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAccess(VDMParser.AccessContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sl_type_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSl_type_definitions(VDMParser.Sl_type_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_definition_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_definition_list(VDMParser.Type_definition_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_definition(VDMParser.Type_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#invariant_type_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInvariant_type_definition(VDMParser.Invariant_type_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_specification}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_specification(VDMParser.Type_specificationContext ctx);
	/**
	 * Visit a parse tree produced by the {@code UnionType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnionType(VDMParser.UnionTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code TypeName}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeName(VDMParser.TypeNameContext ctx);
	/**
	 * Visit a parse tree produced by the {@code BasicType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBasicType(VDMParser.BasicTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code SeqType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeqType(VDMParser.SeqTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ProductType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProductType(VDMParser.ProductTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code MapType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMapType(VDMParser.MapTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code OptionalType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOptionalType(VDMParser.OptionalTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code TypeVariable}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTypeVariable(VDMParser.TypeVariableContext ctx);
	/**
	 * Visit a parse tree produced by the {@code SetType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSetType(VDMParser.SetTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code PartialFunctionType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPartialFunctionType(VDMParser.PartialFunctionTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code VoidFunctionType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVoidFunctionType(VDMParser.VoidFunctionTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code BracketedType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBracketedType(VDMParser.BracketedTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code QuoteType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQuoteType(VDMParser.QuoteTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code CompositeType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCompositeType(VDMParser.CompositeTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#void_function_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVoid_function_type(VDMParser.Void_function_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#bracketed_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBracketed_type(VDMParser.Bracketed_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#basic_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBasic_type(VDMParser.Basic_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#quote_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQuote_type(VDMParser.Quote_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#composite_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComposite_type(VDMParser.Composite_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#field}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitField(VDMParser.FieldContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#union_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnion_type(VDMParser.Union_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#product_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProduct_type(VDMParser.Product_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#optional_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOptional_type(VDMParser.Optional_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet_type(VDMParser.Set_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set0_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet0_type(VDMParser.Set0_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set1_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet1_type(VDMParser.Set1_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#seq_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeq_type(VDMParser.Seq_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#seq0_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeq0_type(VDMParser.Seq0_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#seq1_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeq1_type(VDMParser.Seq1_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#map_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMap_type(VDMParser.Map_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#general_map_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneral_map_type(VDMParser.General_map_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#injective_map_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInjective_map_type(VDMParser.Injective_map_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#function_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunction_type(VDMParser.Function_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#partial_function_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPartial_function_type(VDMParser.Partial_function_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#total_function_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTotal_function_type(VDMParser.Total_function_typeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code VoidType}
	 * labeled alternative in {@link VDMParser#discretionary_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVoidType(VDMParser.VoidTypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code FunctionType}
	 * labeled alternative in {@link VDMParser#discretionary_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionType(VDMParser.FunctionTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_name(VDMParser.Type_nameContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_variable}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_variable(VDMParser.Type_variableContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#invariant}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInvariant(VDMParser.InvariantContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#eq_clause}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEq_clause(VDMParser.Eq_clauseContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#ord_clause}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOrd_clause(VDMParser.Ord_clauseContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#invariant_initial_function}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInvariant_initial_function(VDMParser.Invariant_initial_functionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#state_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitState_definition(VDMParser.State_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#initialisation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInitialisation(VDMParser.InitialisationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sl_value_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSl_value_definitions(VDMParser.Sl_value_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pp_value_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPp_value_definitions(VDMParser.Pp_value_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#access_value_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAccess_value_definition(VDMParser.Access_value_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#value_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitValue_definition(VDMParser.Value_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sl_function_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSl_function_definitions(VDMParser.Sl_function_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pp_function_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPp_function_definitions(VDMParser.Pp_function_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#access_function_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAccess_function_definition(VDMParser.Access_function_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#function_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunction_definition(VDMParser.Function_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#explicit_function_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExplicit_function_definition(VDMParser.Explicit_function_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pre_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPre_expression(VDMParser.Pre_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#post_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPost_expression(VDMParser.Post_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#measure_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMeasure_definition(VDMParser.Measure_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#implicit_function_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImplicit_function_definition(VDMParser.Implicit_function_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#extended_explicit_function_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExtended_explicit_function_definition(VDMParser.Extended_explicit_function_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_variable_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_variable_list(VDMParser.Type_variable_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#parameter_types}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParameter_types(VDMParser.Parameter_typesContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pattern_type_pair_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPattern_type_pair_list(VDMParser.Pattern_type_pair_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#identifier_type_pair_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIdentifier_type_pair_list(VDMParser.Identifier_type_pair_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#identifier_type_pair}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIdentifier_type_pair(VDMParser.Identifier_type_pairContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#parameters}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParameters(VDMParser.ParametersContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#function_body}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunction_body(VDMParser.Function_bodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#measure_body}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMeasure_body(VDMParser.Measure_bodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sl_operation_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSl_operation_definitions(VDMParser.Sl_operation_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sl_access_operation_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSl_access_operation_definition(VDMParser.Sl_access_operation_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pp_operation_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPp_operation_definitions(VDMParser.Pp_operation_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pp_access_operation_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPp_access_operation_definition(VDMParser.Pp_access_operation_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#rt_operation_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRt_operation_definitions(VDMParser.Rt_operation_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#rt_access_operation_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRt_access_operation_definition(VDMParser.Rt_access_operation_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#operation_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOperation_definition(VDMParser.Operation_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#explicit_operation_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExplicit_operation_definition(VDMParser.Explicit_operation_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#implicit_operation_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImplicit_operation_definition(VDMParser.Implicit_operation_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#implicit_operation_body}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitImplicit_operation_body(VDMParser.Implicit_operation_bodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#extended_explicit_operation_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExtended_explicit_operation_definition(VDMParser.Extended_explicit_operation_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#operation_type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOperation_type(VDMParser.Operation_typeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#operation_body}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOperation_body(VDMParser.Operation_bodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#externals}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExternals(VDMParser.ExternalsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#var_information}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVar_information(VDMParser.Var_informationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#vdmmode}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVdmmode(VDMParser.VdmmodeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#exceptions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExceptions(VDMParser.ExceptionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#error}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitError(VDMParser.ErrorContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#instance_variable_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInstance_variable_definitions(VDMParser.Instance_variable_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#instance_variable_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInstance_variable_definition(VDMParser.Instance_variable_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#access_assignment_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAccess_assignment_definition(VDMParser.Access_assignment_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#invariant_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInvariant_definition(VDMParser.Invariant_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#synchronization_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSynchronization_definitions(VDMParser.Synchronization_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#synchronization}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSynchronization(VDMParser.SynchronizationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#permission_predicates}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPermission_predicates(VDMParser.Permission_predicatesContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#mutex_predicate}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMutex_predicate(VDMParser.Mutex_predicateContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#thread_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitThread_definitions(VDMParser.Thread_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#thread_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitThread_definition(VDMParser.Thread_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#periodic_thread_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPeriodic_thread_definition(VDMParser.Periodic_thread_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#periodic_obligation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPeriodic_obligation(VDMParser.Periodic_obligationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sporadic_obligation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSporadic_obligation(VDMParser.Sporadic_obligationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#procedural_thread_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProcedural_thread_definition(VDMParser.Procedural_thread_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#traces_definitions}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTraces_definitions(VDMParser.Traces_definitionsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#named_trace_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNamed_trace_list(VDMParser.Named_trace_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#named_trace}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNamed_trace(VDMParser.Named_traceContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_definition_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_definition_list(VDMParser.Trace_definition_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_definition_term}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_definition_term(VDMParser.Trace_definition_termContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_definition(VDMParser.Trace_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_binding_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_binding_definition(VDMParser.Trace_binding_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_let_def_binding}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_let_def_binding(VDMParser.Trace_let_def_bindingContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_let_best_binding}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_let_best_binding(VDMParser.Trace_let_best_bindingContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_repeat_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_repeat_definition(VDMParser.Trace_repeat_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_core_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_core_definition(VDMParser.Trace_core_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_apply_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_apply_expression(VDMParser.Trace_apply_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_concurrent_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_concurrent_expression(VDMParser.Trace_concurrent_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trace_bracketed_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrace_bracketed_expression(VDMParser.Trace_bracketed_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#annotations}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAnnotations(VDMParser.AnnotationsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#expression_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpression_list(VDMParser.Expression_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpression(VDMParser.ExpressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#bracketed_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBracketed_expression(VDMParser.Bracketed_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#let_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLet_expression(VDMParser.Let_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#let_be_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLet_be_expression(VDMParser.Let_be_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#def_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDef_expression(VDMParser.Def_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#if_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIf_expression(VDMParser.If_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#elseif_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitElseif_expression(VDMParser.Elseif_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#cases_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCases_expression(VDMParser.Cases_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#cases_expression_alternatives}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCases_expression_alternatives(VDMParser.Cases_expression_alternativesContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#cases_expression_alternative}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCases_expression_alternative(VDMParser.Cases_expression_alternativeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#others_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOthers_expression(VDMParser.Others_expressionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code UnaryPlusExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnaryPlusExpr(VDMParser.UnaryPlusExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code UnaryMinusExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnaryMinusExpr(VDMParser.UnaryMinusExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code AbsoluteExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAbsoluteExpr(VDMParser.AbsoluteExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code FloorExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFloorExpr(VDMParser.FloorExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code NotExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNotExpr(VDMParser.NotExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code CardExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCardExpr(VDMParser.CardExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code PowerExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPowerExpr(VDMParser.PowerExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code DunionExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDunionExpr(VDMParser.DunionExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code DinterExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDinterExpr(VDMParser.DinterExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code HdExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitHdExpr(VDMParser.HdExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code TlExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTlExpr(VDMParser.TlExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code LenExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLenExpr(VDMParser.LenExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ElemsExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitElemsExpr(VDMParser.ElemsExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code IndsExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIndsExpr(VDMParser.IndsExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ReverseExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReverseExpr(VDMParser.ReverseExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ConcExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConcExpr(VDMParser.ConcExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code DomExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDomExpr(VDMParser.DomExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code RngExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRngExpr(VDMParser.RngExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code MergeExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMergeExpr(VDMParser.MergeExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code MapInverseExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMapInverseExpr(VDMParser.MapInverseExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#quantified_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQuantified_expression(VDMParser.Quantified_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#all_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAll_expression(VDMParser.All_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#exists_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExists_expression(VDMParser.Exists_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#exists_unique_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExists_unique_expression(VDMParser.Exists_unique_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#iota_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIota_expression(VDMParser.Iota_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set_enumeration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet_enumeration(VDMParser.Set_enumerationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set_comprehension}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet_comprehension(VDMParser.Set_comprehensionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set_range_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet_range_expression(VDMParser.Set_range_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sequence_enumeration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSequence_enumeration(VDMParser.Sequence_enumerationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sequence_comprehension}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSequence_comprehension(VDMParser.Sequence_comprehensionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#subsequence}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubsequence(VDMParser.SubsequenceContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#map_enumeration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMap_enumeration(VDMParser.Map_enumerationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#maplet}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMaplet(VDMParser.MapletContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#map_comprehension}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMap_comprehension(VDMParser.Map_comprehensionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#tuple_constructor}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTuple_constructor(VDMParser.Tuple_constructorContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#record_constructor}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRecord_constructor(VDMParser.Record_constructorContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#tight_record_name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTight_record_name(VDMParser.Tight_record_nameContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#record_modifier}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRecord_modifier(VDMParser.Record_modifierContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#record_modification}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRecord_modification(VDMParser.Record_modificationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#apply}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitApply(VDMParser.ApplyContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#field_select}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitField_select(VDMParser.Field_selectContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#tuple_select}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTuple_select(VDMParser.Tuple_selectContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#function_type_instantiation}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunction_type_instantiation(VDMParser.Function_type_instantiationContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#lambda_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLambda_expression(VDMParser.Lambda_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#narrow_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNarrow_expression(VDMParser.Narrow_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#new_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNew_expression(VDMParser.New_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#self_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSelf_expression(VDMParser.Self_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#threadid_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitThreadid_expression(VDMParser.Threadid_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#general_is_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneral_is_expression(VDMParser.General_is_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#is_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIs_expression(VDMParser.Is_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_judgement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_judgement(VDMParser.Type_judgementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#undefined_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUndefined_expression(VDMParser.Undefined_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#precondition_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPrecondition_expression(VDMParser.Precondition_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#isofbaseclass_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIsofbaseclass_expression(VDMParser.Isofbaseclass_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#isofclass_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIsofclass_expression(VDMParser.Isofclass_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#samebaseclass_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSamebaseclass_expression(VDMParser.Samebaseclass_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sameclass_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSameclass_expression(VDMParser.Sameclass_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#act_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAct_expression(VDMParser.Act_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#fin_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFin_expression(VDMParser.Fin_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#active_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitActive_expression(VDMParser.Active_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#req_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReq_expression(VDMParser.Req_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#waiting_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWaiting_expression(VDMParser.Waiting_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#time_expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTime_expression(VDMParser.Time_expressionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#name_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitName_list(VDMParser.Name_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitName(VDMParser.NameContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#old_name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOld_name(VDMParser.Old_nameContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSymbolic_literal(VDMParser.Symbolic_literalContext ctx);
	/**
	 * Visit a parse tree produced by the {@code NameDesignator}
	 * labeled alternative in {@link VDMParser#state_designator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNameDesignator(VDMParser.NameDesignatorContext ctx);
	/**
	 * Visit a parse tree produced by the {@code MapSeqDesignator}
	 * labeled alternative in {@link VDMParser#state_designator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMapSeqDesignator(VDMParser.MapSeqDesignatorContext ctx);
	/**
	 * Visit a parse tree produced by the {@code FieldReferenceDesignator}
	 * labeled alternative in {@link VDMParser#state_designator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFieldReferenceDesignator(VDMParser.FieldReferenceDesignatorContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#field_reference}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitField_reference(VDMParser.Field_referenceContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#map_seq_reference}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMap_seq_reference(VDMParser.Map_seq_referenceContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStatement(VDMParser.StatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#let_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLet_statement(VDMParser.Let_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#local_definition_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLocal_definition_list(VDMParser.Local_definition_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#local_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLocal_definition(VDMParser.Local_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#let_be_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLet_be_statement(VDMParser.Let_be_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#def_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDef_statement(VDMParser.Def_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#equals_definition_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEquals_definition_list(VDMParser.Equals_definition_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#equals_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEquals_definition(VDMParser.Equals_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#block_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlock_statement(VDMParser.Block_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#dcl_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDcl_statement(VDMParser.Dcl_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#assignment_definition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignment_definition(VDMParser.Assignment_definitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#general_assignment_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitGeneral_assignment_statement(VDMParser.General_assignment_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#assignment_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignment_statement(VDMParser.Assignment_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#multiple_assign_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultiple_assign_statement(VDMParser.Multiple_assign_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#if_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIf_statement(VDMParser.If_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#elseif_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitElseif_statement(VDMParser.Elseif_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#cases_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCases_statement(VDMParser.Cases_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#cases_statement_alternatives}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCases_statement_alternatives(VDMParser.Cases_statement_alternativesContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#cases_statement_alternative}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCases_statement_alternative(VDMParser.Cases_statement_alternativeContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#others_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOthers_statement(VDMParser.Others_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#sequence_for_loop}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSequence_for_loop(VDMParser.Sequence_for_loopContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set_for_loop}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet_for_loop(VDMParser.Set_for_loopContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#index_for_loop}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIndex_for_loop(VDMParser.Index_for_loopContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#while_loop}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWhile_loop(VDMParser.While_loopContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#nondeterministic_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNondeterministic_statement(VDMParser.Nondeterministic_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#call_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCall_statement(VDMParser.Call_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#return_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReturn_statement(VDMParser.Return_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pp_call_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPp_call_statement(VDMParser.Pp_call_statementContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ObjNewExprDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitObjNewExprDesignator(VDMParser.ObjNewExprDesignatorContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ObjApplyDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitObjApplyDesignator(VDMParser.ObjApplyDesignatorContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ObjFieldRefDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitObjFieldRefDesignator(VDMParser.ObjFieldRefDesignatorContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ObjSelfExprDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitObjSelfExprDesignator(VDMParser.ObjSelfExprDesignatorContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ObjNameDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitObjNameDesignator(VDMParser.ObjNameDesignatorContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#object_field_reference}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitObject_field_reference(VDMParser.Object_field_referenceContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#object_apply}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitObject_apply(VDMParser.Object_applyContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#specification_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSpecification_statement(VDMParser.Specification_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#start_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStart_statement(VDMParser.Start_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#start_list_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStart_list_statement(VDMParser.Start_list_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#stop_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStop_statement(VDMParser.Stop_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#stop_list_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStop_list_statement(VDMParser.Stop_list_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#duration_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDuration_statement(VDMParser.Duration_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#cycles_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCycles_statement(VDMParser.Cycles_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#always_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAlways_statement(VDMParser.Always_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#trap_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrap_statement(VDMParser.Trap_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#recursive_trap_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRecursive_trap_statement(VDMParser.Recursive_trap_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#traps}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTraps(VDMParser.TrapsContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#exit_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExit_statement(VDMParser.Exit_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#error_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitError_statement(VDMParser.Error_statementContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#identity_statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIdentity_statement(VDMParser.Identity_statementContext ctx);
	/**
	 * Visit a parse tree produced by the {@code SetUnionPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSetUnionPattern(VDMParser.SetUnionPatternContext ctx);
	/**
	 * Visit a parse tree produced by the {@code TupplePattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTupplePattern(VDMParser.TupplePatternContext ctx);
	/**
	 * Visit a parse tree produced by the {@code SeqConcPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeqConcPattern(VDMParser.SeqConcPatternContext ctx);
	/**
	 * Visit a parse tree produced by the {@code MapUnionPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMapUnionPattern(VDMParser.MapUnionPatternContext ctx);
	/**
	 * Visit a parse tree produced by the {@code RecordPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRecordPattern(VDMParser.RecordPatternContext ctx);
	/**
	 * Visit a parse tree produced by the {@code SetEnumPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSetEnumPattern(VDMParser.SetEnumPatternContext ctx);
	/**
	 * Visit a parse tree produced by the {@code MatchValuePattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMatchValuePattern(VDMParser.MatchValuePatternContext ctx);
	/**
	 * Visit a parse tree produced by the {@code MapEnumPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMapEnumPattern(VDMParser.MapEnumPatternContext ctx);
	/**
	 * Visit a parse tree produced by the {@code IdPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIdPattern(VDMParser.IdPatternContext ctx);
	/**
	 * Visit a parse tree produced by the {@code SeqEnumPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeqEnumPattern(VDMParser.SeqEnumPatternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pattern_identifier}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPattern_identifier(VDMParser.Pattern_identifierContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#match_value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMatch_value(VDMParser.Match_valueContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set_enum_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet_enum_pattern(VDMParser.Set_enum_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set_union_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet_union_pattern(VDMParser.Set_union_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#seq_enum_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeq_enum_pattern(VDMParser.Seq_enum_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#seq_conc_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeq_conc_pattern(VDMParser.Seq_conc_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#map_enum_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMap_enum_pattern(VDMParser.Map_enum_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#maplet_pattern_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMaplet_pattern_list(VDMParser.Maplet_pattern_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#maplet_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMaplet_pattern(VDMParser.Maplet_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#map_union_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMap_union_pattern(VDMParser.Map_union_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#tupple_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTupple_pattern(VDMParser.Tupple_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#record_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRecord_pattern(VDMParser.Record_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pp_object_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPp_object_pattern(VDMParser.Pp_object_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#field_pattern_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitField_pattern_list(VDMParser.Field_pattern_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#field_pattern}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitField_pattern(VDMParser.Field_patternContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pattern_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPattern_list(VDMParser.Pattern_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#pattern_bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPattern_bind(VDMParser.Pattern_bindContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBind(VDMParser.BindContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#set_bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSet_bind(VDMParser.Set_bindContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#seq_bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeq_bind(VDMParser.Seq_bindContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_bind(VDMParser.Type_bindContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#bind_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBind_list(VDMParser.Bind_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#multiple_bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultiple_bind(VDMParser.Multiple_bindContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#multiple_set_bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultiple_set_bind(VDMParser.Multiple_set_bindContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#multiple_seq_bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultiple_seq_bind(VDMParser.Multiple_seq_bindContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#multiple_type_bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMultiple_type_bind(VDMParser.Multiple_type_bindContext ctx);
	/**
	 * Visit a parse tree produced by {@link VDMParser#type_bind_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType_bind_list(VDMParser.Type_bind_listContext ctx);
}