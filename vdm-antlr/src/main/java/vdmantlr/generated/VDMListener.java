// Generated from /Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm-antlr/src/main/antlr4/VDM.g4 by ANTLR 4.9.2
package vdmantlr.generated;

//import com.fujitsu.vdmj.lex.Dialect;    

import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link VDMParser}.
 */
public interface VDMListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link VDMParser#sl_document}.
	 * @param ctx the parse tree
	 */
	void enterSl_document(VDMParser.Sl_documentContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sl_document}.
	 * @param ctx the parse tree
	 */
	void exitSl_document(VDMParser.Sl_documentContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#module}.
	 * @param ctx the parse tree
	 */
	void enterModule(VDMParser.ModuleContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#module}.
	 * @param ctx the parse tree
	 */
	void exitModule(VDMParser.ModuleContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sl_interface}.
	 * @param ctx the parse tree
	 */
	void enterSl_interface(VDMParser.Sl_interfaceContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sl_interface}.
	 * @param ctx the parse tree
	 */
	void exitSl_interface(VDMParser.Sl_interfaceContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#import_definition_list}.
	 * @param ctx the parse tree
	 */
	void enterImport_definition_list(VDMParser.Import_definition_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#import_definition_list}.
	 * @param ctx the parse tree
	 */
	void exitImport_definition_list(VDMParser.Import_definition_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#import_definition}.
	 * @param ctx the parse tree
	 */
	void enterImport_definition(VDMParser.Import_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#import_definition}.
	 * @param ctx the parse tree
	 */
	void exitImport_definition(VDMParser.Import_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#import_module_signature}.
	 * @param ctx the parse tree
	 */
	void enterImport_module_signature(VDMParser.Import_module_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#import_module_signature}.
	 * @param ctx the parse tree
	 */
	void exitImport_module_signature(VDMParser.Import_module_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#import_signature}.
	 * @param ctx the parse tree
	 */
	void enterImport_signature(VDMParser.Import_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#import_signature}.
	 * @param ctx the parse tree
	 */
	void exitImport_signature(VDMParser.Import_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#import_types_signature}.
	 * @param ctx the parse tree
	 */
	void enterImport_types_signature(VDMParser.Import_types_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#import_types_signature}.
	 * @param ctx the parse tree
	 */
	void exitImport_types_signature(VDMParser.Import_types_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_import}.
	 * @param ctx the parse tree
	 */
	void enterType_import(VDMParser.Type_importContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_import}.
	 * @param ctx the parse tree
	 */
	void exitType_import(VDMParser.Type_importContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#import_values_signature}.
	 * @param ctx the parse tree
	 */
	void enterImport_values_signature(VDMParser.Import_values_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#import_values_signature}.
	 * @param ctx the parse tree
	 */
	void exitImport_values_signature(VDMParser.Import_values_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#value_import}.
	 * @param ctx the parse tree
	 */
	void enterValue_import(VDMParser.Value_importContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#value_import}.
	 * @param ctx the parse tree
	 */
	void exitValue_import(VDMParser.Value_importContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#import_functions_signature}.
	 * @param ctx the parse tree
	 */
	void enterImport_functions_signature(VDMParser.Import_functions_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#import_functions_signature}.
	 * @param ctx the parse tree
	 */
	void exitImport_functions_signature(VDMParser.Import_functions_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#function_import}.
	 * @param ctx the parse tree
	 */
	void enterFunction_import(VDMParser.Function_importContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#function_import}.
	 * @param ctx the parse tree
	 */
	void exitFunction_import(VDMParser.Function_importContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#import_operations_signature}.
	 * @param ctx the parse tree
	 */
	void enterImport_operations_signature(VDMParser.Import_operations_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#import_operations_signature}.
	 * @param ctx the parse tree
	 */
	void exitImport_operations_signature(VDMParser.Import_operations_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#operation_import}.
	 * @param ctx the parse tree
	 */
	void enterOperation_import(VDMParser.Operation_importContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#operation_import}.
	 * @param ctx the parse tree
	 */
	void exitOperation_import(VDMParser.Operation_importContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#export_definition}.
	 * @param ctx the parse tree
	 */
	void enterExport_definition(VDMParser.Export_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#export_definition}.
	 * @param ctx the parse tree
	 */
	void exitExport_definition(VDMParser.Export_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#export_module_signature}.
	 * @param ctx the parse tree
	 */
	void enterExport_module_signature(VDMParser.Export_module_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#export_module_signature}.
	 * @param ctx the parse tree
	 */
	void exitExport_module_signature(VDMParser.Export_module_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#export_signature}.
	 * @param ctx the parse tree
	 */
	void enterExport_signature(VDMParser.Export_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#export_signature}.
	 * @param ctx the parse tree
	 */
	void exitExport_signature(VDMParser.Export_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#export_types_signature}.
	 * @param ctx the parse tree
	 */
	void enterExport_types_signature(VDMParser.Export_types_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#export_types_signature}.
	 * @param ctx the parse tree
	 */
	void exitExport_types_signature(VDMParser.Export_types_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_export}.
	 * @param ctx the parse tree
	 */
	void enterType_export(VDMParser.Type_exportContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_export}.
	 * @param ctx the parse tree
	 */
	void exitType_export(VDMParser.Type_exportContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#export_values_signature}.
	 * @param ctx the parse tree
	 */
	void enterExport_values_signature(VDMParser.Export_values_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#export_values_signature}.
	 * @param ctx the parse tree
	 */
	void exitExport_values_signature(VDMParser.Export_values_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#value_signature}.
	 * @param ctx the parse tree
	 */
	void enterValue_signature(VDMParser.Value_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#value_signature}.
	 * @param ctx the parse tree
	 */
	void exitValue_signature(VDMParser.Value_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#export_functions_signature}.
	 * @param ctx the parse tree
	 */
	void enterExport_functions_signature(VDMParser.Export_functions_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#export_functions_signature}.
	 * @param ctx the parse tree
	 */
	void exitExport_functions_signature(VDMParser.Export_functions_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#function_signature}.
	 * @param ctx the parse tree
	 */
	void enterFunction_signature(VDMParser.Function_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#function_signature}.
	 * @param ctx the parse tree
	 */
	void exitFunction_signature(VDMParser.Function_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#export_operations_signature}.
	 * @param ctx the parse tree
	 */
	void enterExport_operations_signature(VDMParser.Export_operations_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#export_operations_signature}.
	 * @param ctx the parse tree
	 */
	void exitExport_operations_signature(VDMParser.Export_operations_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#operation_signature}.
	 * @param ctx the parse tree
	 */
	void enterOperation_signature(VDMParser.Operation_signatureContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#operation_signature}.
	 * @param ctx the parse tree
	 */
	void exitOperation_signature(VDMParser.Operation_signatureContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#module_body}.
	 * @param ctx the parse tree
	 */
	void enterModule_body(VDMParser.Module_bodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#module_body}.
	 * @param ctx the parse tree
	 */
	void exitModule_body(VDMParser.Module_bodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#rt_document}.
	 * @param ctx the parse tree
	 */
	void enterRt_document(VDMParser.Rt_documentContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#rt_document}.
	 * @param ctx the parse tree
	 */
	void exitRt_document(VDMParser.Rt_documentContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#system}.
	 * @param ctx the parse tree
	 */
	void enterSystem(VDMParser.SystemContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#system}.
	 * @param ctx the parse tree
	 */
	void exitSystem(VDMParser.SystemContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#rt_class_body}.
	 * @param ctx the parse tree
	 */
	void enterRt_class_body(VDMParser.Rt_class_bodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#rt_class_body}.
	 * @param ctx the parse tree
	 */
	void exitRt_class_body(VDMParser.Rt_class_bodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pp_class}.
	 * @param ctx the parse tree
	 */
	void enterPp_class(VDMParser.Pp_classContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pp_class}.
	 * @param ctx the parse tree
	 */
	void exitPp_class(VDMParser.Pp_classContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#inheritance_clause}.
	 * @param ctx the parse tree
	 */
	void enterInheritance_clause(VDMParser.Inheritance_clauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#inheritance_clause}.
	 * @param ctx the parse tree
	 */
	void exitInheritance_clause(VDMParser.Inheritance_clauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#class_body}.
	 * @param ctx the parse tree
	 */
	void enterClass_body(VDMParser.Class_bodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#class_body}.
	 * @param ctx the parse tree
	 */
	void exitClass_body(VDMParser.Class_bodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#rt_definition_block}.
	 * @param ctx the parse tree
	 */
	void enterRt_definition_block(VDMParser.Rt_definition_blockContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#rt_definition_block}.
	 * @param ctx the parse tree
	 */
	void exitRt_definition_block(VDMParser.Rt_definition_blockContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pp_definition_block}.
	 * @param ctx the parse tree
	 */
	void enterPp_definition_block(VDMParser.Pp_definition_blockContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pp_definition_block}.
	 * @param ctx the parse tree
	 */
	void exitPp_definition_block(VDMParser.Pp_definition_blockContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sl_definition_block}.
	 * @param ctx the parse tree
	 */
	void enterSl_definition_block(VDMParser.Sl_definition_blockContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sl_definition_block}.
	 * @param ctx the parse tree
	 */
	void exitSl_definition_block(VDMParser.Sl_definition_blockContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pp_type_definitions}.
	 * @param ctx the parse tree
	 */
	void enterPp_type_definitions(VDMParser.Pp_type_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pp_type_definitions}.
	 * @param ctx the parse tree
	 */
	void exitPp_type_definitions(VDMParser.Pp_type_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#access_type_definition}.
	 * @param ctx the parse tree
	 */
	void enterAccess_type_definition(VDMParser.Access_type_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#access_type_definition}.
	 * @param ctx the parse tree
	 */
	void exitAccess_type_definition(VDMParser.Access_type_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#access}.
	 * @param ctx the parse tree
	 */
	void enterAccess(VDMParser.AccessContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#access}.
	 * @param ctx the parse tree
	 */
	void exitAccess(VDMParser.AccessContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sl_type_definitions}.
	 * @param ctx the parse tree
	 */
	void enterSl_type_definitions(VDMParser.Sl_type_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sl_type_definitions}.
	 * @param ctx the parse tree
	 */
	void exitSl_type_definitions(VDMParser.Sl_type_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_definition_list}.
	 * @param ctx the parse tree
	 */
	void enterType_definition_list(VDMParser.Type_definition_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_definition_list}.
	 * @param ctx the parse tree
	 */
	void exitType_definition_list(VDMParser.Type_definition_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_definition}.
	 * @param ctx the parse tree
	 */
	void enterType_definition(VDMParser.Type_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_definition}.
	 * @param ctx the parse tree
	 */
	void exitType_definition(VDMParser.Type_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#invariant_type_definition}.
	 * @param ctx the parse tree
	 */
	void enterInvariant_type_definition(VDMParser.Invariant_type_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#invariant_type_definition}.
	 * @param ctx the parse tree
	 */
	void exitInvariant_type_definition(VDMParser.Invariant_type_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_specification}.
	 * @param ctx the parse tree
	 */
	void enterType_specification(VDMParser.Type_specificationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_specification}.
	 * @param ctx the parse tree
	 */
	void exitType_specification(VDMParser.Type_specificationContext ctx);
	/**
	 * Enter a parse tree produced by the {@code UnionType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterUnionType(VDMParser.UnionTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code UnionType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitUnionType(VDMParser.UnionTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code TypeName}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterTypeName(VDMParser.TypeNameContext ctx);
	/**
	 * Exit a parse tree produced by the {@code TypeName}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitTypeName(VDMParser.TypeNameContext ctx);
	/**
	 * Enter a parse tree produced by the {@code BasicType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterBasicType(VDMParser.BasicTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code BasicType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitBasicType(VDMParser.BasicTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterSeqType(VDMParser.SeqTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitSeqType(VDMParser.SeqTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ProductType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterProductType(VDMParser.ProductTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ProductType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitProductType(VDMParser.ProductTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterMapType(VDMParser.MapTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitMapType(VDMParser.MapTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code OptionalType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterOptionalType(VDMParser.OptionalTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code OptionalType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitOptionalType(VDMParser.OptionalTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code TypeVariable}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterTypeVariable(VDMParser.TypeVariableContext ctx);
	/**
	 * Exit a parse tree produced by the {@code TypeVariable}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitTypeVariable(VDMParser.TypeVariableContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterSetType(VDMParser.SetTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitSetType(VDMParser.SetTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PartialFunctionType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterPartialFunctionType(VDMParser.PartialFunctionTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PartialFunctionType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitPartialFunctionType(VDMParser.PartialFunctionTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code VoidFunctionType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterVoidFunctionType(VDMParser.VoidFunctionTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code VoidFunctionType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitVoidFunctionType(VDMParser.VoidFunctionTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code BracketedType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterBracketedType(VDMParser.BracketedTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code BracketedType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitBracketedType(VDMParser.BracketedTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code QuoteType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterQuoteType(VDMParser.QuoteTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code QuoteType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitQuoteType(VDMParser.QuoteTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code CompositeType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void enterCompositeType(VDMParser.CompositeTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code CompositeType}
	 * labeled alternative in {@link VDMParser#type}.
	 * @param ctx the parse tree
	 */
	void exitCompositeType(VDMParser.CompositeTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#void_function_type}.
	 * @param ctx the parse tree
	 */
	void enterVoid_function_type(VDMParser.Void_function_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#void_function_type}.
	 * @param ctx the parse tree
	 */
	void exitVoid_function_type(VDMParser.Void_function_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#bracketed_type}.
	 * @param ctx the parse tree
	 */
	void enterBracketed_type(VDMParser.Bracketed_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#bracketed_type}.
	 * @param ctx the parse tree
	 */
	void exitBracketed_type(VDMParser.Bracketed_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#basic_type}.
	 * @param ctx the parse tree
	 */
	void enterBasic_type(VDMParser.Basic_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#basic_type}.
	 * @param ctx the parse tree
	 */
	void exitBasic_type(VDMParser.Basic_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#quote_type}.
	 * @param ctx the parse tree
	 */
	void enterQuote_type(VDMParser.Quote_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#quote_type}.
	 * @param ctx the parse tree
	 */
	void exitQuote_type(VDMParser.Quote_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#composite_type}.
	 * @param ctx the parse tree
	 */
	void enterComposite_type(VDMParser.Composite_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#composite_type}.
	 * @param ctx the parse tree
	 */
	void exitComposite_type(VDMParser.Composite_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#field}.
	 * @param ctx the parse tree
	 */
	void enterField(VDMParser.FieldContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#field}.
	 * @param ctx the parse tree
	 */
	void exitField(VDMParser.FieldContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#union_type}.
	 * @param ctx the parse tree
	 */
	void enterUnion_type(VDMParser.Union_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#union_type}.
	 * @param ctx the parse tree
	 */
	void exitUnion_type(VDMParser.Union_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#product_type}.
	 * @param ctx the parse tree
	 */
	void enterProduct_type(VDMParser.Product_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#product_type}.
	 * @param ctx the parse tree
	 */
	void exitProduct_type(VDMParser.Product_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#optional_type}.
	 * @param ctx the parse tree
	 */
	void enterOptional_type(VDMParser.Optional_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#optional_type}.
	 * @param ctx the parse tree
	 */
	void exitOptional_type(VDMParser.Optional_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#set_type}.
	 * @param ctx the parse tree
	 */
	void enterSet_type(VDMParser.Set_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#set_type}.
	 * @param ctx the parse tree
	 */
	void exitSet_type(VDMParser.Set_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#set0_type}.
	 * @param ctx the parse tree
	 */
	void enterSet0_type(VDMParser.Set0_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#set0_type}.
	 * @param ctx the parse tree
	 */
	void exitSet0_type(VDMParser.Set0_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#set1_type}.
	 * @param ctx the parse tree
	 */
	void enterSet1_type(VDMParser.Set1_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#set1_type}.
	 * @param ctx the parse tree
	 */
	void exitSet1_type(VDMParser.Set1_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#seq_type}.
	 * @param ctx the parse tree
	 */
	void enterSeq_type(VDMParser.Seq_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#seq_type}.
	 * @param ctx the parse tree
	 */
	void exitSeq_type(VDMParser.Seq_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#seq0_type}.
	 * @param ctx the parse tree
	 */
	void enterSeq0_type(VDMParser.Seq0_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#seq0_type}.
	 * @param ctx the parse tree
	 */
	void exitSeq0_type(VDMParser.Seq0_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#seq1_type}.
	 * @param ctx the parse tree
	 */
	void enterSeq1_type(VDMParser.Seq1_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#seq1_type}.
	 * @param ctx the parse tree
	 */
	void exitSeq1_type(VDMParser.Seq1_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#map_type}.
	 * @param ctx the parse tree
	 */
	void enterMap_type(VDMParser.Map_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#map_type}.
	 * @param ctx the parse tree
	 */
	void exitMap_type(VDMParser.Map_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#general_map_type}.
	 * @param ctx the parse tree
	 */
	void enterGeneral_map_type(VDMParser.General_map_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#general_map_type}.
	 * @param ctx the parse tree
	 */
	void exitGeneral_map_type(VDMParser.General_map_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#injective_map_type}.
	 * @param ctx the parse tree
	 */
	void enterInjective_map_type(VDMParser.Injective_map_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#injective_map_type}.
	 * @param ctx the parse tree
	 */
	void exitInjective_map_type(VDMParser.Injective_map_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#function_type}.
	 * @param ctx the parse tree
	 */
	void enterFunction_type(VDMParser.Function_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#function_type}.
	 * @param ctx the parse tree
	 */
	void exitFunction_type(VDMParser.Function_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#partial_function_type}.
	 * @param ctx the parse tree
	 */
	void enterPartial_function_type(VDMParser.Partial_function_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#partial_function_type}.
	 * @param ctx the parse tree
	 */
	void exitPartial_function_type(VDMParser.Partial_function_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#total_function_type}.
	 * @param ctx the parse tree
	 */
	void enterTotal_function_type(VDMParser.Total_function_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#total_function_type}.
	 * @param ctx the parse tree
	 */
	void exitTotal_function_type(VDMParser.Total_function_typeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code VoidType}
	 * labeled alternative in {@link VDMParser#discretionary_type}.
	 * @param ctx the parse tree
	 */
	void enterVoidType(VDMParser.VoidTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code VoidType}
	 * labeled alternative in {@link VDMParser#discretionary_type}.
	 * @param ctx the parse tree
	 */
	void exitVoidType(VDMParser.VoidTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code FunctionType}
	 * labeled alternative in {@link VDMParser#discretionary_type}.
	 * @param ctx the parse tree
	 */
	void enterFunctionType(VDMParser.FunctionTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code FunctionType}
	 * labeled alternative in {@link VDMParser#discretionary_type}.
	 * @param ctx the parse tree
	 */
	void exitFunctionType(VDMParser.FunctionTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_name}.
	 * @param ctx the parse tree
	 */
	void enterType_name(VDMParser.Type_nameContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_name}.
	 * @param ctx the parse tree
	 */
	void exitType_name(VDMParser.Type_nameContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_variable}.
	 * @param ctx the parse tree
	 */
	void enterType_variable(VDMParser.Type_variableContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_variable}.
	 * @param ctx the parse tree
	 */
	void exitType_variable(VDMParser.Type_variableContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#invariant}.
	 * @param ctx the parse tree
	 */
	void enterInvariant(VDMParser.InvariantContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#invariant}.
	 * @param ctx the parse tree
	 */
	void exitInvariant(VDMParser.InvariantContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#eq_clause}.
	 * @param ctx the parse tree
	 */
	void enterEq_clause(VDMParser.Eq_clauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#eq_clause}.
	 * @param ctx the parse tree
	 */
	void exitEq_clause(VDMParser.Eq_clauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#ord_clause}.
	 * @param ctx the parse tree
	 */
	void enterOrd_clause(VDMParser.Ord_clauseContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#ord_clause}.
	 * @param ctx the parse tree
	 */
	void exitOrd_clause(VDMParser.Ord_clauseContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#invariant_initial_function}.
	 * @param ctx the parse tree
	 */
	void enterInvariant_initial_function(VDMParser.Invariant_initial_functionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#invariant_initial_function}.
	 * @param ctx the parse tree
	 */
	void exitInvariant_initial_function(VDMParser.Invariant_initial_functionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#state_definition}.
	 * @param ctx the parse tree
	 */
	void enterState_definition(VDMParser.State_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#state_definition}.
	 * @param ctx the parse tree
	 */
	void exitState_definition(VDMParser.State_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#initialisation}.
	 * @param ctx the parse tree
	 */
	void enterInitialisation(VDMParser.InitialisationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#initialisation}.
	 * @param ctx the parse tree
	 */
	void exitInitialisation(VDMParser.InitialisationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sl_value_definitions}.
	 * @param ctx the parse tree
	 */
	void enterSl_value_definitions(VDMParser.Sl_value_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sl_value_definitions}.
	 * @param ctx the parse tree
	 */
	void exitSl_value_definitions(VDMParser.Sl_value_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pp_value_definitions}.
	 * @param ctx the parse tree
	 */
	void enterPp_value_definitions(VDMParser.Pp_value_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pp_value_definitions}.
	 * @param ctx the parse tree
	 */
	void exitPp_value_definitions(VDMParser.Pp_value_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#access_value_definition}.
	 * @param ctx the parse tree
	 */
	void enterAccess_value_definition(VDMParser.Access_value_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#access_value_definition}.
	 * @param ctx the parse tree
	 */
	void exitAccess_value_definition(VDMParser.Access_value_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#value_definition}.
	 * @param ctx the parse tree
	 */
	void enterValue_definition(VDMParser.Value_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#value_definition}.
	 * @param ctx the parse tree
	 */
	void exitValue_definition(VDMParser.Value_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sl_function_definitions}.
	 * @param ctx the parse tree
	 */
	void enterSl_function_definitions(VDMParser.Sl_function_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sl_function_definitions}.
	 * @param ctx the parse tree
	 */
	void exitSl_function_definitions(VDMParser.Sl_function_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pp_function_definitions}.
	 * @param ctx the parse tree
	 */
	void enterPp_function_definitions(VDMParser.Pp_function_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pp_function_definitions}.
	 * @param ctx the parse tree
	 */
	void exitPp_function_definitions(VDMParser.Pp_function_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#access_function_definition}.
	 * @param ctx the parse tree
	 */
	void enterAccess_function_definition(VDMParser.Access_function_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#access_function_definition}.
	 * @param ctx the parse tree
	 */
	void exitAccess_function_definition(VDMParser.Access_function_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#function_definition}.
	 * @param ctx the parse tree
	 */
	void enterFunction_definition(VDMParser.Function_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#function_definition}.
	 * @param ctx the parse tree
	 */
	void exitFunction_definition(VDMParser.Function_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#explicit_function_definition}.
	 * @param ctx the parse tree
	 */
	void enterExplicit_function_definition(VDMParser.Explicit_function_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#explicit_function_definition}.
	 * @param ctx the parse tree
	 */
	void exitExplicit_function_definition(VDMParser.Explicit_function_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pre_expression}.
	 * @param ctx the parse tree
	 */
	void enterPre_expression(VDMParser.Pre_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pre_expression}.
	 * @param ctx the parse tree
	 */
	void exitPre_expression(VDMParser.Pre_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#post_expression}.
	 * @param ctx the parse tree
	 */
	void enterPost_expression(VDMParser.Post_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#post_expression}.
	 * @param ctx the parse tree
	 */
	void exitPost_expression(VDMParser.Post_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#measure_definition}.
	 * @param ctx the parse tree
	 */
	void enterMeasure_definition(VDMParser.Measure_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#measure_definition}.
	 * @param ctx the parse tree
	 */
	void exitMeasure_definition(VDMParser.Measure_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#implicit_function_definition}.
	 * @param ctx the parse tree
	 */
	void enterImplicit_function_definition(VDMParser.Implicit_function_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#implicit_function_definition}.
	 * @param ctx the parse tree
	 */
	void exitImplicit_function_definition(VDMParser.Implicit_function_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#extended_explicit_function_definition}.
	 * @param ctx the parse tree
	 */
	void enterExtended_explicit_function_definition(VDMParser.Extended_explicit_function_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#extended_explicit_function_definition}.
	 * @param ctx the parse tree
	 */
	void exitExtended_explicit_function_definition(VDMParser.Extended_explicit_function_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_variable_list}.
	 * @param ctx the parse tree
	 */
	void enterType_variable_list(VDMParser.Type_variable_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_variable_list}.
	 * @param ctx the parse tree
	 */
	void exitType_variable_list(VDMParser.Type_variable_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#parameter_types}.
	 * @param ctx the parse tree
	 */
	void enterParameter_types(VDMParser.Parameter_typesContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#parameter_types}.
	 * @param ctx the parse tree
	 */
	void exitParameter_types(VDMParser.Parameter_typesContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pattern_type_pair_list}.
	 * @param ctx the parse tree
	 */
	void enterPattern_type_pair_list(VDMParser.Pattern_type_pair_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pattern_type_pair_list}.
	 * @param ctx the parse tree
	 */
	void exitPattern_type_pair_list(VDMParser.Pattern_type_pair_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#identifier_type_pair_list}.
	 * @param ctx the parse tree
	 */
	void enterIdentifier_type_pair_list(VDMParser.Identifier_type_pair_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#identifier_type_pair_list}.
	 * @param ctx the parse tree
	 */
	void exitIdentifier_type_pair_list(VDMParser.Identifier_type_pair_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#identifier_type_pair}.
	 * @param ctx the parse tree
	 */
	void enterIdentifier_type_pair(VDMParser.Identifier_type_pairContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#identifier_type_pair}.
	 * @param ctx the parse tree
	 */
	void exitIdentifier_type_pair(VDMParser.Identifier_type_pairContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#parameters}.
	 * @param ctx the parse tree
	 */
	void enterParameters(VDMParser.ParametersContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#parameters}.
	 * @param ctx the parse tree
	 */
	void exitParameters(VDMParser.ParametersContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#function_body}.
	 * @param ctx the parse tree
	 */
	void enterFunction_body(VDMParser.Function_bodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#function_body}.
	 * @param ctx the parse tree
	 */
	void exitFunction_body(VDMParser.Function_bodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#measure_body}.
	 * @param ctx the parse tree
	 */
	void enterMeasure_body(VDMParser.Measure_bodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#measure_body}.
	 * @param ctx the parse tree
	 */
	void exitMeasure_body(VDMParser.Measure_bodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sl_operation_definitions}.
	 * @param ctx the parse tree
	 */
	void enterSl_operation_definitions(VDMParser.Sl_operation_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sl_operation_definitions}.
	 * @param ctx the parse tree
	 */
	void exitSl_operation_definitions(VDMParser.Sl_operation_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sl_access_operation_definition}.
	 * @param ctx the parse tree
	 */
	void enterSl_access_operation_definition(VDMParser.Sl_access_operation_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sl_access_operation_definition}.
	 * @param ctx the parse tree
	 */
	void exitSl_access_operation_definition(VDMParser.Sl_access_operation_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pp_operation_definitions}.
	 * @param ctx the parse tree
	 */
	void enterPp_operation_definitions(VDMParser.Pp_operation_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pp_operation_definitions}.
	 * @param ctx the parse tree
	 */
	void exitPp_operation_definitions(VDMParser.Pp_operation_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pp_access_operation_definition}.
	 * @param ctx the parse tree
	 */
	void enterPp_access_operation_definition(VDMParser.Pp_access_operation_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pp_access_operation_definition}.
	 * @param ctx the parse tree
	 */
	void exitPp_access_operation_definition(VDMParser.Pp_access_operation_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#rt_operation_definitions}.
	 * @param ctx the parse tree
	 */
	void enterRt_operation_definitions(VDMParser.Rt_operation_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#rt_operation_definitions}.
	 * @param ctx the parse tree
	 */
	void exitRt_operation_definitions(VDMParser.Rt_operation_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#rt_access_operation_definition}.
	 * @param ctx the parse tree
	 */
	void enterRt_access_operation_definition(VDMParser.Rt_access_operation_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#rt_access_operation_definition}.
	 * @param ctx the parse tree
	 */
	void exitRt_access_operation_definition(VDMParser.Rt_access_operation_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#operation_definition}.
	 * @param ctx the parse tree
	 */
	void enterOperation_definition(VDMParser.Operation_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#operation_definition}.
	 * @param ctx the parse tree
	 */
	void exitOperation_definition(VDMParser.Operation_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#explicit_operation_definition}.
	 * @param ctx the parse tree
	 */
	void enterExplicit_operation_definition(VDMParser.Explicit_operation_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#explicit_operation_definition}.
	 * @param ctx the parse tree
	 */
	void exitExplicit_operation_definition(VDMParser.Explicit_operation_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#implicit_operation_definition}.
	 * @param ctx the parse tree
	 */
	void enterImplicit_operation_definition(VDMParser.Implicit_operation_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#implicit_operation_definition}.
	 * @param ctx the parse tree
	 */
	void exitImplicit_operation_definition(VDMParser.Implicit_operation_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#implicit_operation_body}.
	 * @param ctx the parse tree
	 */
	void enterImplicit_operation_body(VDMParser.Implicit_operation_bodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#implicit_operation_body}.
	 * @param ctx the parse tree
	 */
	void exitImplicit_operation_body(VDMParser.Implicit_operation_bodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#extended_explicit_operation_definition}.
	 * @param ctx the parse tree
	 */
	void enterExtended_explicit_operation_definition(VDMParser.Extended_explicit_operation_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#extended_explicit_operation_definition}.
	 * @param ctx the parse tree
	 */
	void exitExtended_explicit_operation_definition(VDMParser.Extended_explicit_operation_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#operation_type}.
	 * @param ctx the parse tree
	 */
	void enterOperation_type(VDMParser.Operation_typeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#operation_type}.
	 * @param ctx the parse tree
	 */
	void exitOperation_type(VDMParser.Operation_typeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#operation_body}.
	 * @param ctx the parse tree
	 */
	void enterOperation_body(VDMParser.Operation_bodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#operation_body}.
	 * @param ctx the parse tree
	 */
	void exitOperation_body(VDMParser.Operation_bodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#externals}.
	 * @param ctx the parse tree
	 */
	void enterExternals(VDMParser.ExternalsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#externals}.
	 * @param ctx the parse tree
	 */
	void exitExternals(VDMParser.ExternalsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#var_information}.
	 * @param ctx the parse tree
	 */
	void enterVar_information(VDMParser.Var_informationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#var_information}.
	 * @param ctx the parse tree
	 */
	void exitVar_information(VDMParser.Var_informationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#vdmmode}.
	 * @param ctx the parse tree
	 */
	void enterVdmmode(VDMParser.VdmmodeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#vdmmode}.
	 * @param ctx the parse tree
	 */
	void exitVdmmode(VDMParser.VdmmodeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#exceptions}.
	 * @param ctx the parse tree
	 */
	void enterExceptions(VDMParser.ExceptionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#exceptions}.
	 * @param ctx the parse tree
	 */
	void exitExceptions(VDMParser.ExceptionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#error}.
	 * @param ctx the parse tree
	 */
	void enterError(VDMParser.ErrorContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#error}.
	 * @param ctx the parse tree
	 */
	void exitError(VDMParser.ErrorContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#instance_variable_definitions}.
	 * @param ctx the parse tree
	 */
	void enterInstance_variable_definitions(VDMParser.Instance_variable_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#instance_variable_definitions}.
	 * @param ctx the parse tree
	 */
	void exitInstance_variable_definitions(VDMParser.Instance_variable_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#instance_variable_definition}.
	 * @param ctx the parse tree
	 */
	void enterInstance_variable_definition(VDMParser.Instance_variable_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#instance_variable_definition}.
	 * @param ctx the parse tree
	 */
	void exitInstance_variable_definition(VDMParser.Instance_variable_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#access_assignment_definition}.
	 * @param ctx the parse tree
	 */
	void enterAccess_assignment_definition(VDMParser.Access_assignment_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#access_assignment_definition}.
	 * @param ctx the parse tree
	 */
	void exitAccess_assignment_definition(VDMParser.Access_assignment_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#invariant_definition}.
	 * @param ctx the parse tree
	 */
	void enterInvariant_definition(VDMParser.Invariant_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#invariant_definition}.
	 * @param ctx the parse tree
	 */
	void exitInvariant_definition(VDMParser.Invariant_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#synchronization_definitions}.
	 * @param ctx the parse tree
	 */
	void enterSynchronization_definitions(VDMParser.Synchronization_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#synchronization_definitions}.
	 * @param ctx the parse tree
	 */
	void exitSynchronization_definitions(VDMParser.Synchronization_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#synchronization}.
	 * @param ctx the parse tree
	 */
	void enterSynchronization(VDMParser.SynchronizationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#synchronization}.
	 * @param ctx the parse tree
	 */
	void exitSynchronization(VDMParser.SynchronizationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#permission_predicates}.
	 * @param ctx the parse tree
	 */
	void enterPermission_predicates(VDMParser.Permission_predicatesContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#permission_predicates}.
	 * @param ctx the parse tree
	 */
	void exitPermission_predicates(VDMParser.Permission_predicatesContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#mutex_predicate}.
	 * @param ctx the parse tree
	 */
	void enterMutex_predicate(VDMParser.Mutex_predicateContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#mutex_predicate}.
	 * @param ctx the parse tree
	 */
	void exitMutex_predicate(VDMParser.Mutex_predicateContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#thread_definitions}.
	 * @param ctx the parse tree
	 */
	void enterThread_definitions(VDMParser.Thread_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#thread_definitions}.
	 * @param ctx the parse tree
	 */
	void exitThread_definitions(VDMParser.Thread_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#thread_definition}.
	 * @param ctx the parse tree
	 */
	void enterThread_definition(VDMParser.Thread_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#thread_definition}.
	 * @param ctx the parse tree
	 */
	void exitThread_definition(VDMParser.Thread_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#periodic_thread_definition}.
	 * @param ctx the parse tree
	 */
	void enterPeriodic_thread_definition(VDMParser.Periodic_thread_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#periodic_thread_definition}.
	 * @param ctx the parse tree
	 */
	void exitPeriodic_thread_definition(VDMParser.Periodic_thread_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#periodic_obligation}.
	 * @param ctx the parse tree
	 */
	void enterPeriodic_obligation(VDMParser.Periodic_obligationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#periodic_obligation}.
	 * @param ctx the parse tree
	 */
	void exitPeriodic_obligation(VDMParser.Periodic_obligationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sporadic_obligation}.
	 * @param ctx the parse tree
	 */
	void enterSporadic_obligation(VDMParser.Sporadic_obligationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sporadic_obligation}.
	 * @param ctx the parse tree
	 */
	void exitSporadic_obligation(VDMParser.Sporadic_obligationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#procedural_thread_definition}.
	 * @param ctx the parse tree
	 */
	void enterProcedural_thread_definition(VDMParser.Procedural_thread_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#procedural_thread_definition}.
	 * @param ctx the parse tree
	 */
	void exitProcedural_thread_definition(VDMParser.Procedural_thread_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#traces_definitions}.
	 * @param ctx the parse tree
	 */
	void enterTraces_definitions(VDMParser.Traces_definitionsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#traces_definitions}.
	 * @param ctx the parse tree
	 */
	void exitTraces_definitions(VDMParser.Traces_definitionsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#named_trace_list}.
	 * @param ctx the parse tree
	 */
	void enterNamed_trace_list(VDMParser.Named_trace_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#named_trace_list}.
	 * @param ctx the parse tree
	 */
	void exitNamed_trace_list(VDMParser.Named_trace_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#named_trace}.
	 * @param ctx the parse tree
	 */
	void enterNamed_trace(VDMParser.Named_traceContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#named_trace}.
	 * @param ctx the parse tree
	 */
	void exitNamed_trace(VDMParser.Named_traceContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_definition_list}.
	 * @param ctx the parse tree
	 */
	void enterTrace_definition_list(VDMParser.Trace_definition_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_definition_list}.
	 * @param ctx the parse tree
	 */
	void exitTrace_definition_list(VDMParser.Trace_definition_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_definition_term}.
	 * @param ctx the parse tree
	 */
	void enterTrace_definition_term(VDMParser.Trace_definition_termContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_definition_term}.
	 * @param ctx the parse tree
	 */
	void exitTrace_definition_term(VDMParser.Trace_definition_termContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_definition}.
	 * @param ctx the parse tree
	 */
	void enterTrace_definition(VDMParser.Trace_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_definition}.
	 * @param ctx the parse tree
	 */
	void exitTrace_definition(VDMParser.Trace_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_binding_definition}.
	 * @param ctx the parse tree
	 */
	void enterTrace_binding_definition(VDMParser.Trace_binding_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_binding_definition}.
	 * @param ctx the parse tree
	 */
	void exitTrace_binding_definition(VDMParser.Trace_binding_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_let_def_binding}.
	 * @param ctx the parse tree
	 */
	void enterTrace_let_def_binding(VDMParser.Trace_let_def_bindingContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_let_def_binding}.
	 * @param ctx the parse tree
	 */
	void exitTrace_let_def_binding(VDMParser.Trace_let_def_bindingContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_let_best_binding}.
	 * @param ctx the parse tree
	 */
	void enterTrace_let_best_binding(VDMParser.Trace_let_best_bindingContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_let_best_binding}.
	 * @param ctx the parse tree
	 */
	void exitTrace_let_best_binding(VDMParser.Trace_let_best_bindingContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_repeat_definition}.
	 * @param ctx the parse tree
	 */
	void enterTrace_repeat_definition(VDMParser.Trace_repeat_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_repeat_definition}.
	 * @param ctx the parse tree
	 */
	void exitTrace_repeat_definition(VDMParser.Trace_repeat_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_core_definition}.
	 * @param ctx the parse tree
	 */
	void enterTrace_core_definition(VDMParser.Trace_core_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_core_definition}.
	 * @param ctx the parse tree
	 */
	void exitTrace_core_definition(VDMParser.Trace_core_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_apply_expression}.
	 * @param ctx the parse tree
	 */
	void enterTrace_apply_expression(VDMParser.Trace_apply_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_apply_expression}.
	 * @param ctx the parse tree
	 */
	void exitTrace_apply_expression(VDMParser.Trace_apply_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_concurrent_expression}.
	 * @param ctx the parse tree
	 */
	void enterTrace_concurrent_expression(VDMParser.Trace_concurrent_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_concurrent_expression}.
	 * @param ctx the parse tree
	 */
	void exitTrace_concurrent_expression(VDMParser.Trace_concurrent_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trace_bracketed_expression}.
	 * @param ctx the parse tree
	 */
	void enterTrace_bracketed_expression(VDMParser.Trace_bracketed_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trace_bracketed_expression}.
	 * @param ctx the parse tree
	 */
	void exitTrace_bracketed_expression(VDMParser.Trace_bracketed_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#annotations}.
	 * @param ctx the parse tree
	 */
	void enterAnnotations(VDMParser.AnnotationsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#annotations}.
	 * @param ctx the parse tree
	 */
	void exitAnnotations(VDMParser.AnnotationsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#expression_list}.
	 * @param ctx the parse tree
	 */
	void enterExpression_list(VDMParser.Expression_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#expression_list}.
	 * @param ctx the parse tree
	 */
	void exitExpression_list(VDMParser.Expression_listContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetPSubsetExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetPSubsetExpr(VDMParser.SetPSubsetExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetPSubsetExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetPSubsetExpr(VDMParser.SetPSubsetExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code IfExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterIfExpr(VDMParser.IfExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code IfExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitIfExpr(VDMParser.IfExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapEnumExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMapEnumExpr(VDMParser.MapEnumExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapEnumExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMapEnumExpr(VDMParser.MapEnumExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapDomRestricExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMapDomRestricExpr(VDMParser.MapDomRestricExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapDomRestricExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMapDomRestricExpr(VDMParser.MapDomRestricExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetRangeExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetRangeExpr(VDMParser.SetRangeExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetRangeExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetRangeExpr(VDMParser.SetRangeExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetNotMemberExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetNotMemberExpr(VDMParser.SetNotMemberExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetNotMemberExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetNotMemberExpr(VDMParser.SetNotMemberExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code LogicalImpliesExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterLogicalImpliesExpr(VDMParser.LogicalImpliesExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code LogicalImpliesExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitLogicalImpliesExpr(VDMParser.LogicalImpliesExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code BracketedExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterBracketedExpr(VDMParser.BracketedExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code BracketedExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitBracketedExpr(VDMParser.BracketedExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code LetBestExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterLetBestExpr(VDMParser.LetBestExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code LetBestExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitLetBestExpr(VDMParser.LetBestExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapCompositionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMapCompositionExpr(VDMParser.MapCompositionExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapCompositionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMapCompositionExpr(VDMParser.MapCompositionExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code OldNameExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterOldNameExpr(VDMParser.OldNameExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code OldNameExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitOldNameExpr(VDMParser.OldNameExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SubSeqExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSubSeqExpr(VDMParser.SubSeqExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SubSeqExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSubSeqExpr(VDMParser.SubSeqExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ArithmeticIntegerDivisionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterArithmeticIntegerDivisionExpr(VDMParser.ArithmeticIntegerDivisionExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ArithmeticIntegerDivisionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitArithmeticIntegerDivisionExpr(VDMParser.ArithmeticIntegerDivisionExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RTWaitingExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRTWaitingExpr(VDMParser.RTWaitingExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RTWaitingExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRTWaitingExpr(VDMParser.RTWaitingExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapCompExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMapCompExpr(VDMParser.MapCompExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapCompExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMapCompExpr(VDMParser.MapCompExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetMemberExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetMemberExpr(VDMParser.SetMemberExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetMemberExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetMemberExpr(VDMParser.SetMemberExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PreconditionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterPreconditionExpr(VDMParser.PreconditionExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PreconditionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitPreconditionExpr(VDMParser.PreconditionExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code TupleSelExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterTupleSelExpr(VDMParser.TupleSelExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code TupleSelExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitTupleSelExpr(VDMParser.TupleSelExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RelationalGreaterThanExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRelationalGreaterThanExpr(VDMParser.RelationalGreaterThanExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RelationalGreaterThanExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRelationalGreaterThanExpr(VDMParser.RelationalGreaterThanExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code NarrowExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterNarrowExpr(VDMParser.NarrowExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code NarrowExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitNarrowExpr(VDMParser.NarrowExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RelationalLessThanExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRelationalLessThanExpr(VDMParser.RelationalLessThanExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RelationalLessThanExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRelationalLessThanExpr(VDMParser.RelationalLessThanExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RelationalLessThanEqualExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRelationalLessThanEqualExpr(VDMParser.RelationalLessThanEqualExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RelationalLessThanEqualExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRelationalLessThanEqualExpr(VDMParser.RelationalLessThanEqualExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ArithmeticPlusExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterArithmeticPlusExpr(VDMParser.ArithmeticPlusExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ArithmeticPlusExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitArithmeticPlusExpr(VDMParser.ArithmeticPlusExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code LetExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterLetExpr(VDMParser.LetExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code LetExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitLetExpr(VDMParser.LetExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code LambdaExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterLambdaExpr(VDMParser.LambdaExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code LambdaExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitLambdaExpr(VDMParser.LambdaExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RelationalEqualExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRelationalEqualExpr(VDMParser.RelationalEqualExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RelationalEqualExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRelationalEqualExpr(VDMParser.RelationalEqualExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapRngFilterExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMapRngFilterExpr(VDMParser.MapRngFilterExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapRngFilterExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMapRngFilterExpr(VDMParser.MapRngFilterExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code UnaryExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterUnaryExpr(VDMParser.UnaryExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code UnaryExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitUnaryExpr(VDMParser.UnaryExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code TupleMkExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterTupleMkExpr(VDMParser.TupleMkExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code TupleMkExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitTupleMkExpr(VDMParser.TupleMkExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapUnionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMapUnionExpr(VDMParser.MapUnionExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapUnionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMapUnionExpr(VDMParser.MapUnionExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ArithmeticReminderExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterArithmeticReminderExpr(VDMParser.ArithmeticReminderExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ArithmeticReminderExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitArithmeticReminderExpr(VDMParser.ArithmeticReminderExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RTActExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRTActExpr(VDMParser.RTActExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RTActExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRTActExpr(VDMParser.RTActExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ArithmeticMinusExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterArithmeticMinusExpr(VDMParser.ArithmeticMinusExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ArithmeticMinusExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitArithmeticMinusExpr(VDMParser.ArithmeticMinusExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ArithmeticMultiplicationExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterArithmeticMultiplicationExpr(VDMParser.ArithmeticMultiplicationExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ArithmeticMultiplicationExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitArithmeticMultiplicationExpr(VDMParser.ArithmeticMultiplicationExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetCompExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetCompExpr(VDMParser.SetCompExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetCompExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetCompExpr(VDMParser.SetCompExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PPSelfExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterPPSelfExpr(VDMParser.PPSelfExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PPSelfExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitPPSelfExpr(VDMParser.PPSelfExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code GeneralIsExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterGeneralIsExpr(VDMParser.GeneralIsExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code GeneralIsExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitGeneralIsExpr(VDMParser.GeneralIsExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RTTimeExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRTTimeExpr(VDMParser.RTTimeExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RTTimeExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRTTimeExpr(VDMParser.RTTimeExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ArithmeticDivideExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterArithmeticDivideExpr(VDMParser.ArithmeticDivideExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ArithmeticDivideExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitArithmeticDivideExpr(VDMParser.ArithmeticDivideExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code IotaExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterIotaExpr(VDMParser.IotaExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code IotaExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitIotaExpr(VDMParser.IotaExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code FunctionTypeInstExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterFunctionTypeInstExpr(VDMParser.FunctionTypeInstExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code FunctionTypeInstExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitFunctionTypeInstExpr(VDMParser.FunctionTypeInstExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetInterExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetInterExpr(VDMParser.SetInterExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetInterExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetInterExpr(VDMParser.SetInterExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code QuantifiedExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterQuantifiedExpr(VDMParser.QuantifiedExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code QuantifiedExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitQuantifiedExpr(VDMParser.QuantifiedExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code DefExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterDefExpr(VDMParser.DefExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code DefExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitDefExpr(VDMParser.DefExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapSeqOverrideExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMapSeqOverrideExpr(VDMParser.MapSeqOverrideExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapSeqOverrideExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMapSeqOverrideExpr(VDMParser.MapSeqOverrideExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RelationalNotEqualExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRelationalNotEqualExpr(VDMParser.RelationalNotEqualExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RelationalNotEqualExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRelationalNotEqualExpr(VDMParser.RelationalNotEqualExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code NameExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterNameExpr(VDMParser.NameExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code NameExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitNameExpr(VDMParser.NameExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code IterateExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterIterateExpr(VDMParser.IterateExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code IterateExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitIterateExpr(VDMParser.IterateExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code LogicalAndExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterLogicalAndExpr(VDMParser.LogicalAndExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code LogicalAndExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitLogicalAndExpr(VDMParser.LogicalAndExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code CasesExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterCasesExpr(VDMParser.CasesExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code CasesExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitCasesExpr(VDMParser.CasesExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqEnumExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqEnumExpr(VDMParser.SeqEnumExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqEnumExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqEnumExpr(VDMParser.SeqEnumExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ApplyExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterApplyExpr(VDMParser.ApplyExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ApplyExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitApplyExpr(VDMParser.ApplyExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetDiffExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetDiffExpr(VDMParser.SetDiffExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetDiffExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetDiffExpr(VDMParser.SetDiffExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RTReqExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRTReqExpr(VDMParser.RTReqExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RTReqExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRTReqExpr(VDMParser.RTReqExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RecordMkExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRecordMkExpr(VDMParser.RecordMkExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RecordMkExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRecordMkExpr(VDMParser.RecordMkExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetSubsetExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetSubsetExpr(VDMParser.SetSubsetExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetSubsetExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetSubsetExpr(VDMParser.SetSubsetExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetUnionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetUnionExpr(VDMParser.SetUnionExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetUnionExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetUnionExpr(VDMParser.SetUnionExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RTFinExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRTFinExpr(VDMParser.RTFinExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RTFinExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRTFinExpr(VDMParser.RTFinExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqCompExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqCompExpr(VDMParser.SeqCompExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqCompExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqCompExpr(VDMParser.SeqCompExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SymbolicLitExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSymbolicLitExpr(VDMParser.SymbolicLitExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SymbolicLitExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSymbolicLitExpr(VDMParser.SymbolicLitExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RelationalGreaterThanEqualExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRelationalGreaterThanEqualExpr(VDMParser.RelationalGreaterThanEqualExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RelationalGreaterThanEqualExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRelationalGreaterThanEqualExpr(VDMParser.RelationalGreaterThanEqualExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code LogicalIffExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterLogicalIffExpr(VDMParser.LogicalIffExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code LogicalIffExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitLogicalIffExpr(VDMParser.LogicalIffExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapRngRestrictExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMapRngRestrictExpr(VDMParser.MapRngRestrictExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapRngRestrictExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMapRngRestrictExpr(VDMParser.MapRngRestrictExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PPThreadIdExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterPPThreadIdExpr(VDMParser.PPThreadIdExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PPThreadIdExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitPPThreadIdExpr(VDMParser.PPThreadIdExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PPSameBaseClassExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterPPSameBaseClassExpr(VDMParser.PPSameBaseClassExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PPSameBaseClassExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitPPSameBaseClassExpr(VDMParser.PPSameBaseClassExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapDomFilterExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMapDomFilterExpr(VDMParser.MapDomFilterExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapDomFilterExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMapDomFilterExpr(VDMParser.MapDomFilterExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code UndefinedExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterUndefinedExpr(VDMParser.UndefinedExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code UndefinedExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitUndefinedExpr(VDMParser.UndefinedExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RTActiveExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRTActiveExpr(VDMParser.RTActiveExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RTActiveExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRTActiveExpr(VDMParser.RTActiveExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RecordMuExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterRecordMuExpr(VDMParser.RecordMuExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RecordMuExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitRecordMuExpr(VDMParser.RecordMuExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ArithmeticModuloExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterArithmeticModuloExpr(VDMParser.ArithmeticModuloExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ArithmeticModuloExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitArithmeticModuloExpr(VDMParser.ArithmeticModuloExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetEnumExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSetEnumExpr(VDMParser.SetEnumExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetEnumExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSetEnumExpr(VDMParser.SetEnumExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code LogicalOrExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterLogicalOrExpr(VDMParser.LogicalOrExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code LogicalOrExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitLogicalOrExpr(VDMParser.LogicalOrExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PPIsOfClassExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterPPIsOfClassExpr(VDMParser.PPIsOfClassExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PPIsOfClassExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitPPIsOfClassExpr(VDMParser.PPIsOfClassExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code FieldSelExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterFieldSelExpr(VDMParser.FieldSelExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code FieldSelExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitFieldSelExpr(VDMParser.FieldSelExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqConcatExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqConcatExpr(VDMParser.SeqConcatExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqConcatExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqConcatExpr(VDMParser.SeqConcatExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PPSameClassExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterPPSameClassExpr(VDMParser.PPSameClassExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PPSameClassExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitPPSameClassExpr(VDMParser.PPSameClassExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PPNewExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterPPNewExpr(VDMParser.PPNewExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PPNewExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitPPNewExpr(VDMParser.PPNewExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PPIsOfBaseClassExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterPPIsOfBaseClassExpr(VDMParser.PPIsOfBaseClassExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PPIsOfBaseClassExpr}
	 * labeled alternative in {@link VDMParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitPPIsOfBaseClassExpr(VDMParser.PPIsOfBaseClassExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#bracketed_expression}.
	 * @param ctx the parse tree
	 */
	void enterBracketed_expression(VDMParser.Bracketed_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#bracketed_expression}.
	 * @param ctx the parse tree
	 */
	void exitBracketed_expression(VDMParser.Bracketed_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#let_expression}.
	 * @param ctx the parse tree
	 */
	void enterLet_expression(VDMParser.Let_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#let_expression}.
	 * @param ctx the parse tree
	 */
	void exitLet_expression(VDMParser.Let_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#let_be_expression}.
	 * @param ctx the parse tree
	 */
	void enterLet_be_expression(VDMParser.Let_be_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#let_be_expression}.
	 * @param ctx the parse tree
	 */
	void exitLet_be_expression(VDMParser.Let_be_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#def_expression}.
	 * @param ctx the parse tree
	 */
	void enterDef_expression(VDMParser.Def_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#def_expression}.
	 * @param ctx the parse tree
	 */
	void exitDef_expression(VDMParser.Def_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#if_expression}.
	 * @param ctx the parse tree
	 */
	void enterIf_expression(VDMParser.If_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#if_expression}.
	 * @param ctx the parse tree
	 */
	void exitIf_expression(VDMParser.If_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#elseif_expression}.
	 * @param ctx the parse tree
	 */
	void enterElseif_expression(VDMParser.Elseif_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#elseif_expression}.
	 * @param ctx the parse tree
	 */
	void exitElseif_expression(VDMParser.Elseif_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#cases_expression}.
	 * @param ctx the parse tree
	 */
	void enterCases_expression(VDMParser.Cases_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#cases_expression}.
	 * @param ctx the parse tree
	 */
	void exitCases_expression(VDMParser.Cases_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#cases_expression_alternatives}.
	 * @param ctx the parse tree
	 */
	void enterCases_expression_alternatives(VDMParser.Cases_expression_alternativesContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#cases_expression_alternatives}.
	 * @param ctx the parse tree
	 */
	void exitCases_expression_alternatives(VDMParser.Cases_expression_alternativesContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#cases_expression_alternative}.
	 * @param ctx the parse tree
	 */
	void enterCases_expression_alternative(VDMParser.Cases_expression_alternativeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#cases_expression_alternative}.
	 * @param ctx the parse tree
	 */
	void exitCases_expression_alternative(VDMParser.Cases_expression_alternativeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#others_expression}.
	 * @param ctx the parse tree
	 */
	void enterOthers_expression(VDMParser.Others_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#others_expression}.
	 * @param ctx the parse tree
	 */
	void exitOthers_expression(VDMParser.Others_expressionContext ctx);
	/**
	 * Enter a parse tree produced by the {@code UnaryPlusExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterUnaryPlusExpr(VDMParser.UnaryPlusExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code UnaryPlusExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitUnaryPlusExpr(VDMParser.UnaryPlusExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code UnaryMinusExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterUnaryMinusExpr(VDMParser.UnaryMinusExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code UnaryMinusExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitUnaryMinusExpr(VDMParser.UnaryMinusExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code AbsoluteExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterAbsoluteExpr(VDMParser.AbsoluteExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code AbsoluteExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitAbsoluteExpr(VDMParser.AbsoluteExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code FloorExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterFloorExpr(VDMParser.FloorExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code FloorExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitFloorExpr(VDMParser.FloorExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code NotExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterNotExpr(VDMParser.NotExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code NotExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitNotExpr(VDMParser.NotExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code CardinalityExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterCardinalityExpr(VDMParser.CardinalityExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code CardinalityExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitCardinalityExpr(VDMParser.CardinalityExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PowerSetExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterPowerSetExpr(VDMParser.PowerSetExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PowerSetExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitPowerSetExpr(VDMParser.PowerSetExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetDunionExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterSetDunionExpr(VDMParser.SetDunionExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetDunionExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitSetDunionExpr(VDMParser.SetDunionExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetDinterExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterSetDinterExpr(VDMParser.SetDinterExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetDinterExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitSetDinterExpr(VDMParser.SetDinterExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqHdExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqHdExpr(VDMParser.SeqHdExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqHdExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqHdExpr(VDMParser.SeqHdExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqTlExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqTlExpr(VDMParser.SeqTlExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqTlExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqTlExpr(VDMParser.SeqTlExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqLenExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqLenExpr(VDMParser.SeqLenExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqLenExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqLenExpr(VDMParser.SeqLenExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqElemsExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqElemsExpr(VDMParser.SeqElemsExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqElemsExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqElemsExpr(VDMParser.SeqElemsExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqIndsExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqIndsExpr(VDMParser.SeqIndsExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqIndsExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqIndsExpr(VDMParser.SeqIndsExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqReverseExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqReverseExpr(VDMParser.SeqReverseExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqReverseExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqReverseExpr(VDMParser.SeqReverseExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqDistConcExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterSeqDistConcExpr(VDMParser.SeqDistConcExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqDistConcExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitSeqDistConcExpr(VDMParser.SeqDistConcExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapDomExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterMapDomExpr(VDMParser.MapDomExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapDomExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitMapDomExpr(VDMParser.MapDomExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapRngExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterMapRngExpr(VDMParser.MapRngExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapRngExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitMapRngExpr(VDMParser.MapRngExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapMergeExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterMapMergeExpr(VDMParser.MapMergeExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapMergeExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitMapMergeExpr(VDMParser.MapMergeExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapInverseExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void enterMapInverseExpr(VDMParser.MapInverseExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapInverseExpr}
	 * labeled alternative in {@link VDMParser#unary_expression}.
	 * @param ctx the parse tree
	 */
	void exitMapInverseExpr(VDMParser.MapInverseExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#quantified_expression}.
	 * @param ctx the parse tree
	 */
	void enterQuantified_expression(VDMParser.Quantified_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#quantified_expression}.
	 * @param ctx the parse tree
	 */
	void exitQuantified_expression(VDMParser.Quantified_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#all_expression}.
	 * @param ctx the parse tree
	 */
	void enterAll_expression(VDMParser.All_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#all_expression}.
	 * @param ctx the parse tree
	 */
	void exitAll_expression(VDMParser.All_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#exists_expression}.
	 * @param ctx the parse tree
	 */
	void enterExists_expression(VDMParser.Exists_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#exists_expression}.
	 * @param ctx the parse tree
	 */
	void exitExists_expression(VDMParser.Exists_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#exists_unique_expression}.
	 * @param ctx the parse tree
	 */
	void enterExists_unique_expression(VDMParser.Exists_unique_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#exists_unique_expression}.
	 * @param ctx the parse tree
	 */
	void exitExists_unique_expression(VDMParser.Exists_unique_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#iota_expression}.
	 * @param ctx the parse tree
	 */
	void enterIota_expression(VDMParser.Iota_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#iota_expression}.
	 * @param ctx the parse tree
	 */
	void exitIota_expression(VDMParser.Iota_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#set_enumeration}.
	 * @param ctx the parse tree
	 */
	void enterSet_enumeration(VDMParser.Set_enumerationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#set_enumeration}.
	 * @param ctx the parse tree
	 */
	void exitSet_enumeration(VDMParser.Set_enumerationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#set_comprehension}.
	 * @param ctx the parse tree
	 */
	void enterSet_comprehension(VDMParser.Set_comprehensionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#set_comprehension}.
	 * @param ctx the parse tree
	 */
	void exitSet_comprehension(VDMParser.Set_comprehensionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#set_range_expression}.
	 * @param ctx the parse tree
	 */
	void enterSet_range_expression(VDMParser.Set_range_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#set_range_expression}.
	 * @param ctx the parse tree
	 */
	void exitSet_range_expression(VDMParser.Set_range_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sequence_enumeration}.
	 * @param ctx the parse tree
	 */
	void enterSequence_enumeration(VDMParser.Sequence_enumerationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sequence_enumeration}.
	 * @param ctx the parse tree
	 */
	void exitSequence_enumeration(VDMParser.Sequence_enumerationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sequence_comprehension}.
	 * @param ctx the parse tree
	 */
	void enterSequence_comprehension(VDMParser.Sequence_comprehensionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sequence_comprehension}.
	 * @param ctx the parse tree
	 */
	void exitSequence_comprehension(VDMParser.Sequence_comprehensionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#subsequence}.
	 * @param ctx the parse tree
	 */
	void enterSubsequence(VDMParser.SubsequenceContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#subsequence}.
	 * @param ctx the parse tree
	 */
	void exitSubsequence(VDMParser.SubsequenceContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#map_enumeration}.
	 * @param ctx the parse tree
	 */
	void enterMap_enumeration(VDMParser.Map_enumerationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#map_enumeration}.
	 * @param ctx the parse tree
	 */
	void exitMap_enumeration(VDMParser.Map_enumerationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#maplet}.
	 * @param ctx the parse tree
	 */
	void enterMaplet(VDMParser.MapletContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#maplet}.
	 * @param ctx the parse tree
	 */
	void exitMaplet(VDMParser.MapletContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#map_comprehension}.
	 * @param ctx the parse tree
	 */
	void enterMap_comprehension(VDMParser.Map_comprehensionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#map_comprehension}.
	 * @param ctx the parse tree
	 */
	void exitMap_comprehension(VDMParser.Map_comprehensionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#tuple_constructor}.
	 * @param ctx the parse tree
	 */
	void enterTuple_constructor(VDMParser.Tuple_constructorContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#tuple_constructor}.
	 * @param ctx the parse tree
	 */
	void exitTuple_constructor(VDMParser.Tuple_constructorContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#record_constructor}.
	 * @param ctx the parse tree
	 */
	void enterRecord_constructor(VDMParser.Record_constructorContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#record_constructor}.
	 * @param ctx the parse tree
	 */
	void exitRecord_constructor(VDMParser.Record_constructorContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#tight_record_name}.
	 * @param ctx the parse tree
	 */
	void enterTight_record_name(VDMParser.Tight_record_nameContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#tight_record_name}.
	 * @param ctx the parse tree
	 */
	void exitTight_record_name(VDMParser.Tight_record_nameContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#record_modifier}.
	 * @param ctx the parse tree
	 */
	void enterRecord_modifier(VDMParser.Record_modifierContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#record_modifier}.
	 * @param ctx the parse tree
	 */
	void exitRecord_modifier(VDMParser.Record_modifierContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#record_modification}.
	 * @param ctx the parse tree
	 */
	void enterRecord_modification(VDMParser.Record_modificationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#record_modification}.
	 * @param ctx the parse tree
	 */
	void exitRecord_modification(VDMParser.Record_modificationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#apply}.
	 * @param ctx the parse tree
	 */
	void enterApply(VDMParser.ApplyContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#apply}.
	 * @param ctx the parse tree
	 */
	void exitApply(VDMParser.ApplyContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#field_select}.
	 * @param ctx the parse tree
	 */
	void enterField_select(VDMParser.Field_selectContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#field_select}.
	 * @param ctx the parse tree
	 */
	void exitField_select(VDMParser.Field_selectContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#tuple_select}.
	 * @param ctx the parse tree
	 */
	void enterTuple_select(VDMParser.Tuple_selectContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#tuple_select}.
	 * @param ctx the parse tree
	 */
	void exitTuple_select(VDMParser.Tuple_selectContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#function_type_instantiation}.
	 * @param ctx the parse tree
	 */
	void enterFunction_type_instantiation(VDMParser.Function_type_instantiationContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#function_type_instantiation}.
	 * @param ctx the parse tree
	 */
	void exitFunction_type_instantiation(VDMParser.Function_type_instantiationContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#lambda_expression}.
	 * @param ctx the parse tree
	 */
	void enterLambda_expression(VDMParser.Lambda_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#lambda_expression}.
	 * @param ctx the parse tree
	 */
	void exitLambda_expression(VDMParser.Lambda_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#narrow_expression}.
	 * @param ctx the parse tree
	 */
	void enterNarrow_expression(VDMParser.Narrow_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#narrow_expression}.
	 * @param ctx the parse tree
	 */
	void exitNarrow_expression(VDMParser.Narrow_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#new_expression}.
	 * @param ctx the parse tree
	 */
	void enterNew_expression(VDMParser.New_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#new_expression}.
	 * @param ctx the parse tree
	 */
	void exitNew_expression(VDMParser.New_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#self_expression}.
	 * @param ctx the parse tree
	 */
	void enterSelf_expression(VDMParser.Self_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#self_expression}.
	 * @param ctx the parse tree
	 */
	void exitSelf_expression(VDMParser.Self_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#threadid_expression}.
	 * @param ctx the parse tree
	 */
	void enterThreadid_expression(VDMParser.Threadid_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#threadid_expression}.
	 * @param ctx the parse tree
	 */
	void exitThreadid_expression(VDMParser.Threadid_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#general_is_expression}.
	 * @param ctx the parse tree
	 */
	void enterGeneral_is_expression(VDMParser.General_is_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#general_is_expression}.
	 * @param ctx the parse tree
	 */
	void exitGeneral_is_expression(VDMParser.General_is_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#is_expression}.
	 * @param ctx the parse tree
	 */
	void enterIs_expression(VDMParser.Is_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#is_expression}.
	 * @param ctx the parse tree
	 */
	void exitIs_expression(VDMParser.Is_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_judgement}.
	 * @param ctx the parse tree
	 */
	void enterType_judgement(VDMParser.Type_judgementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_judgement}.
	 * @param ctx the parse tree
	 */
	void exitType_judgement(VDMParser.Type_judgementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#undefined_expression}.
	 * @param ctx the parse tree
	 */
	void enterUndefined_expression(VDMParser.Undefined_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#undefined_expression}.
	 * @param ctx the parse tree
	 */
	void exitUndefined_expression(VDMParser.Undefined_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#precondition_expression}.
	 * @param ctx the parse tree
	 */
	void enterPrecondition_expression(VDMParser.Precondition_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#precondition_expression}.
	 * @param ctx the parse tree
	 */
	void exitPrecondition_expression(VDMParser.Precondition_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#isofbaseclass_expression}.
	 * @param ctx the parse tree
	 */
	void enterIsofbaseclass_expression(VDMParser.Isofbaseclass_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#isofbaseclass_expression}.
	 * @param ctx the parse tree
	 */
	void exitIsofbaseclass_expression(VDMParser.Isofbaseclass_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#isofclass_expression}.
	 * @param ctx the parse tree
	 */
	void enterIsofclass_expression(VDMParser.Isofclass_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#isofclass_expression}.
	 * @param ctx the parse tree
	 */
	void exitIsofclass_expression(VDMParser.Isofclass_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#samebaseclass_expression}.
	 * @param ctx the parse tree
	 */
	void enterSamebaseclass_expression(VDMParser.Samebaseclass_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#samebaseclass_expression}.
	 * @param ctx the parse tree
	 */
	void exitSamebaseclass_expression(VDMParser.Samebaseclass_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sameclass_expression}.
	 * @param ctx the parse tree
	 */
	void enterSameclass_expression(VDMParser.Sameclass_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sameclass_expression}.
	 * @param ctx the parse tree
	 */
	void exitSameclass_expression(VDMParser.Sameclass_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#act_expression}.
	 * @param ctx the parse tree
	 */
	void enterAct_expression(VDMParser.Act_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#act_expression}.
	 * @param ctx the parse tree
	 */
	void exitAct_expression(VDMParser.Act_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#fin_expression}.
	 * @param ctx the parse tree
	 */
	void enterFin_expression(VDMParser.Fin_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#fin_expression}.
	 * @param ctx the parse tree
	 */
	void exitFin_expression(VDMParser.Fin_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#active_expression}.
	 * @param ctx the parse tree
	 */
	void enterActive_expression(VDMParser.Active_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#active_expression}.
	 * @param ctx the parse tree
	 */
	void exitActive_expression(VDMParser.Active_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#req_expression}.
	 * @param ctx the parse tree
	 */
	void enterReq_expression(VDMParser.Req_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#req_expression}.
	 * @param ctx the parse tree
	 */
	void exitReq_expression(VDMParser.Req_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#waiting_expression}.
	 * @param ctx the parse tree
	 */
	void enterWaiting_expression(VDMParser.Waiting_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#waiting_expression}.
	 * @param ctx the parse tree
	 */
	void exitWaiting_expression(VDMParser.Waiting_expressionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#time_expression}.
	 * @param ctx the parse tree
	 */
	void enterTime_expression(VDMParser.Time_expressionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#time_expression}.
	 * @param ctx the parse tree
	 */
	void exitTime_expression(VDMParser.Time_expressionContext ctx);
	/**
	 * Enter a parse tree produced by the {@code NameDesignator}
	 * labeled alternative in {@link VDMParser#state_designator}.
	 * @param ctx the parse tree
	 */
	void enterNameDesignator(VDMParser.NameDesignatorContext ctx);
	/**
	 * Exit a parse tree produced by the {@code NameDesignator}
	 * labeled alternative in {@link VDMParser#state_designator}.
	 * @param ctx the parse tree
	 */
	void exitNameDesignator(VDMParser.NameDesignatorContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapSeqReferenceDesignator}
	 * labeled alternative in {@link VDMParser#state_designator}.
	 * @param ctx the parse tree
	 */
	void enterMapSeqReferenceDesignator(VDMParser.MapSeqReferenceDesignatorContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapSeqReferenceDesignator}
	 * labeled alternative in {@link VDMParser#state_designator}.
	 * @param ctx the parse tree
	 */
	void exitMapSeqReferenceDesignator(VDMParser.MapSeqReferenceDesignatorContext ctx);
	/**
	 * Enter a parse tree produced by the {@code FieldReferenceDesignator}
	 * labeled alternative in {@link VDMParser#state_designator}.
	 * @param ctx the parse tree
	 */
	void enterFieldReferenceDesignator(VDMParser.FieldReferenceDesignatorContext ctx);
	/**
	 * Exit a parse tree produced by the {@code FieldReferenceDesignator}
	 * labeled alternative in {@link VDMParser#state_designator}.
	 * @param ctx the parse tree
	 */
	void exitFieldReferenceDesignator(VDMParser.FieldReferenceDesignatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterStatement(VDMParser.StatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitStatement(VDMParser.StatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#let_statement}.
	 * @param ctx the parse tree
	 */
	void enterLet_statement(VDMParser.Let_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#let_statement}.
	 * @param ctx the parse tree
	 */
	void exitLet_statement(VDMParser.Let_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#local_definition_list}.
	 * @param ctx the parse tree
	 */
	void enterLocal_definition_list(VDMParser.Local_definition_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#local_definition_list}.
	 * @param ctx the parse tree
	 */
	void exitLocal_definition_list(VDMParser.Local_definition_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#local_definition}.
	 * @param ctx the parse tree
	 */
	void enterLocal_definition(VDMParser.Local_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#local_definition}.
	 * @param ctx the parse tree
	 */
	void exitLocal_definition(VDMParser.Local_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#let_be_statement}.
	 * @param ctx the parse tree
	 */
	void enterLet_be_statement(VDMParser.Let_be_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#let_be_statement}.
	 * @param ctx the parse tree
	 */
	void exitLet_be_statement(VDMParser.Let_be_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#def_statement}.
	 * @param ctx the parse tree
	 */
	void enterDef_statement(VDMParser.Def_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#def_statement}.
	 * @param ctx the parse tree
	 */
	void exitDef_statement(VDMParser.Def_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#equals_definition_list}.
	 * @param ctx the parse tree
	 */
	void enterEquals_definition_list(VDMParser.Equals_definition_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#equals_definition_list}.
	 * @param ctx the parse tree
	 */
	void exitEquals_definition_list(VDMParser.Equals_definition_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#equals_definition}.
	 * @param ctx the parse tree
	 */
	void enterEquals_definition(VDMParser.Equals_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#equals_definition}.
	 * @param ctx the parse tree
	 */
	void exitEquals_definition(VDMParser.Equals_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#block_statement}.
	 * @param ctx the parse tree
	 */
	void enterBlock_statement(VDMParser.Block_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#block_statement}.
	 * @param ctx the parse tree
	 */
	void exitBlock_statement(VDMParser.Block_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#dcl_statement}.
	 * @param ctx the parse tree
	 */
	void enterDcl_statement(VDMParser.Dcl_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#dcl_statement}.
	 * @param ctx the parse tree
	 */
	void exitDcl_statement(VDMParser.Dcl_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#assignment_definition}.
	 * @param ctx the parse tree
	 */
	void enterAssignment_definition(VDMParser.Assignment_definitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#assignment_definition}.
	 * @param ctx the parse tree
	 */
	void exitAssignment_definition(VDMParser.Assignment_definitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#general_assignment_statement}.
	 * @param ctx the parse tree
	 */
	void enterGeneral_assignment_statement(VDMParser.General_assignment_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#general_assignment_statement}.
	 * @param ctx the parse tree
	 */
	void exitGeneral_assignment_statement(VDMParser.General_assignment_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#assignment_statement}.
	 * @param ctx the parse tree
	 */
	void enterAssignment_statement(VDMParser.Assignment_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#assignment_statement}.
	 * @param ctx the parse tree
	 */
	void exitAssignment_statement(VDMParser.Assignment_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#multiple_assign_statement}.
	 * @param ctx the parse tree
	 */
	void enterMultiple_assign_statement(VDMParser.Multiple_assign_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#multiple_assign_statement}.
	 * @param ctx the parse tree
	 */
	void exitMultiple_assign_statement(VDMParser.Multiple_assign_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#if_statement}.
	 * @param ctx the parse tree
	 */
	void enterIf_statement(VDMParser.If_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#if_statement}.
	 * @param ctx the parse tree
	 */
	void exitIf_statement(VDMParser.If_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#elseif_statement}.
	 * @param ctx the parse tree
	 */
	void enterElseif_statement(VDMParser.Elseif_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#elseif_statement}.
	 * @param ctx the parse tree
	 */
	void exitElseif_statement(VDMParser.Elseif_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#cases_statement}.
	 * @param ctx the parse tree
	 */
	void enterCases_statement(VDMParser.Cases_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#cases_statement}.
	 * @param ctx the parse tree
	 */
	void exitCases_statement(VDMParser.Cases_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#cases_statement_alternatives}.
	 * @param ctx the parse tree
	 */
	void enterCases_statement_alternatives(VDMParser.Cases_statement_alternativesContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#cases_statement_alternatives}.
	 * @param ctx the parse tree
	 */
	void exitCases_statement_alternatives(VDMParser.Cases_statement_alternativesContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#cases_statement_alternative}.
	 * @param ctx the parse tree
	 */
	void enterCases_statement_alternative(VDMParser.Cases_statement_alternativeContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#cases_statement_alternative}.
	 * @param ctx the parse tree
	 */
	void exitCases_statement_alternative(VDMParser.Cases_statement_alternativeContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#others_statement}.
	 * @param ctx the parse tree
	 */
	void enterOthers_statement(VDMParser.Others_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#others_statement}.
	 * @param ctx the parse tree
	 */
	void exitOthers_statement(VDMParser.Others_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#sequence_for_loop}.
	 * @param ctx the parse tree
	 */
	void enterSequence_for_loop(VDMParser.Sequence_for_loopContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#sequence_for_loop}.
	 * @param ctx the parse tree
	 */
	void exitSequence_for_loop(VDMParser.Sequence_for_loopContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#set_for_loop}.
	 * @param ctx the parse tree
	 */
	void enterSet_for_loop(VDMParser.Set_for_loopContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#set_for_loop}.
	 * @param ctx the parse tree
	 */
	void exitSet_for_loop(VDMParser.Set_for_loopContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#index_for_loop}.
	 * @param ctx the parse tree
	 */
	void enterIndex_for_loop(VDMParser.Index_for_loopContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#index_for_loop}.
	 * @param ctx the parse tree
	 */
	void exitIndex_for_loop(VDMParser.Index_for_loopContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#while_loop}.
	 * @param ctx the parse tree
	 */
	void enterWhile_loop(VDMParser.While_loopContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#while_loop}.
	 * @param ctx the parse tree
	 */
	void exitWhile_loop(VDMParser.While_loopContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#nondeterministic_statement}.
	 * @param ctx the parse tree
	 */
	void enterNondeterministic_statement(VDMParser.Nondeterministic_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#nondeterministic_statement}.
	 * @param ctx the parse tree
	 */
	void exitNondeterministic_statement(VDMParser.Nondeterministic_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#call_statement}.
	 * @param ctx the parse tree
	 */
	void enterCall_statement(VDMParser.Call_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#call_statement}.
	 * @param ctx the parse tree
	 */
	void exitCall_statement(VDMParser.Call_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#return_statement}.
	 * @param ctx the parse tree
	 */
	void enterReturn_statement(VDMParser.Return_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#return_statement}.
	 * @param ctx the parse tree
	 */
	void exitReturn_statement(VDMParser.Return_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pp_call_statement}.
	 * @param ctx the parse tree
	 */
	void enterPp_call_statement(VDMParser.Pp_call_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pp_call_statement}.
	 * @param ctx the parse tree
	 */
	void exitPp_call_statement(VDMParser.Pp_call_statementContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ObjNewExprDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void enterObjNewExprDesignator(VDMParser.ObjNewExprDesignatorContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ObjNewExprDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void exitObjNewExprDesignator(VDMParser.ObjNewExprDesignatorContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ObjApplyDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void enterObjApplyDesignator(VDMParser.ObjApplyDesignatorContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ObjApplyDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void exitObjApplyDesignator(VDMParser.ObjApplyDesignatorContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ObjFieldRefDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void enterObjFieldRefDesignator(VDMParser.ObjFieldRefDesignatorContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ObjFieldRefDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void exitObjFieldRefDesignator(VDMParser.ObjFieldRefDesignatorContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ObjSelfExprDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void enterObjSelfExprDesignator(VDMParser.ObjSelfExprDesignatorContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ObjSelfExprDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void exitObjSelfExprDesignator(VDMParser.ObjSelfExprDesignatorContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ObjNameDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void enterObjNameDesignator(VDMParser.ObjNameDesignatorContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ObjNameDesignator}
	 * labeled alternative in {@link VDMParser#object_designator}.
	 * @param ctx the parse tree
	 */
	void exitObjNameDesignator(VDMParser.ObjNameDesignatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#object_field_reference}.
	 * @param ctx the parse tree
	 */
	void enterObject_field_reference(VDMParser.Object_field_referenceContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#object_field_reference}.
	 * @param ctx the parse tree
	 */
	void exitObject_field_reference(VDMParser.Object_field_referenceContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#object_apply}.
	 * @param ctx the parse tree
	 */
	void enterObject_apply(VDMParser.Object_applyContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#object_apply}.
	 * @param ctx the parse tree
	 */
	void exitObject_apply(VDMParser.Object_applyContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#specification_statement}.
	 * @param ctx the parse tree
	 */
	void enterSpecification_statement(VDMParser.Specification_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#specification_statement}.
	 * @param ctx the parse tree
	 */
	void exitSpecification_statement(VDMParser.Specification_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#start_statement}.
	 * @param ctx the parse tree
	 */
	void enterStart_statement(VDMParser.Start_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#start_statement}.
	 * @param ctx the parse tree
	 */
	void exitStart_statement(VDMParser.Start_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#start_list_statement}.
	 * @param ctx the parse tree
	 */
	void enterStart_list_statement(VDMParser.Start_list_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#start_list_statement}.
	 * @param ctx the parse tree
	 */
	void exitStart_list_statement(VDMParser.Start_list_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#stop_statement}.
	 * @param ctx the parse tree
	 */
	void enterStop_statement(VDMParser.Stop_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#stop_statement}.
	 * @param ctx the parse tree
	 */
	void exitStop_statement(VDMParser.Stop_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#stop_list_statement}.
	 * @param ctx the parse tree
	 */
	void enterStop_list_statement(VDMParser.Stop_list_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#stop_list_statement}.
	 * @param ctx the parse tree
	 */
	void exitStop_list_statement(VDMParser.Stop_list_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#duration_statement}.
	 * @param ctx the parse tree
	 */
	void enterDuration_statement(VDMParser.Duration_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#duration_statement}.
	 * @param ctx the parse tree
	 */
	void exitDuration_statement(VDMParser.Duration_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#cycles_statement}.
	 * @param ctx the parse tree
	 */
	void enterCycles_statement(VDMParser.Cycles_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#cycles_statement}.
	 * @param ctx the parse tree
	 */
	void exitCycles_statement(VDMParser.Cycles_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#always_statement}.
	 * @param ctx the parse tree
	 */
	void enterAlways_statement(VDMParser.Always_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#always_statement}.
	 * @param ctx the parse tree
	 */
	void exitAlways_statement(VDMParser.Always_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#trap_statement}.
	 * @param ctx the parse tree
	 */
	void enterTrap_statement(VDMParser.Trap_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#trap_statement}.
	 * @param ctx the parse tree
	 */
	void exitTrap_statement(VDMParser.Trap_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#recursive_trap_statement}.
	 * @param ctx the parse tree
	 */
	void enterRecursive_trap_statement(VDMParser.Recursive_trap_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#recursive_trap_statement}.
	 * @param ctx the parse tree
	 */
	void exitRecursive_trap_statement(VDMParser.Recursive_trap_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#traps}.
	 * @param ctx the parse tree
	 */
	void enterTraps(VDMParser.TrapsContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#traps}.
	 * @param ctx the parse tree
	 */
	void exitTraps(VDMParser.TrapsContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#exit_statement}.
	 * @param ctx the parse tree
	 */
	void enterExit_statement(VDMParser.Exit_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#exit_statement}.
	 * @param ctx the parse tree
	 */
	void exitExit_statement(VDMParser.Exit_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#error_statement}.
	 * @param ctx the parse tree
	 */
	void enterError_statement(VDMParser.Error_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#error_statement}.
	 * @param ctx the parse tree
	 */
	void exitError_statement(VDMParser.Error_statementContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#identity_statement}.
	 * @param ctx the parse tree
	 */
	void enterIdentity_statement(VDMParser.Identity_statementContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#identity_statement}.
	 * @param ctx the parse tree
	 */
	void exitIdentity_statement(VDMParser.Identity_statementContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetUnionPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterSetUnionPattern(VDMParser.SetUnionPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetUnionPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitSetUnionPattern(VDMParser.SetUnionPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code RecordPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterRecordPattern(VDMParser.RecordPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code RecordPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitRecordPattern(VDMParser.RecordPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetEnumPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterSetEnumPattern(VDMParser.SetEnumPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetEnumPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitSetEnumPattern(VDMParser.SetEnumPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code IgnorePattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterIgnorePattern(VDMParser.IgnorePatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code IgnorePattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitIgnorePattern(VDMParser.IgnorePatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapEnumPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterMapEnumPattern(VDMParser.MapEnumPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapEnumPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitMapEnumPattern(VDMParser.MapEnumPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SymbolicLiteralPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterSymbolicLiteralPattern(VDMParser.SymbolicLiteralPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SymbolicLiteralPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitSymbolicLiteralPattern(VDMParser.SymbolicLiteralPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code BracketedExprPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterBracketedExprPattern(VDMParser.BracketedExprPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code BracketedExprPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitBracketedExprPattern(VDMParser.BracketedExprPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code TupplePattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterTupplePattern(VDMParser.TupplePatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code TupplePattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitTupplePattern(VDMParser.TupplePatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MapMunionPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterMapMunionPattern(VDMParser.MapMunionPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MapMunionPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitMapMunionPattern(VDMParser.MapMunionPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code EmptyMapPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterEmptyMapPattern(VDMParser.EmptyMapPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code EmptyMapPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitEmptyMapPattern(VDMParser.EmptyMapPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqConcatPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterSeqConcatPattern(VDMParser.SeqConcatPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqConcatPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitSeqConcatPattern(VDMParser.SeqConcatPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code PPObjectPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterPPObjectPattern(VDMParser.PPObjectPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PPObjectPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitPPObjectPattern(VDMParser.PPObjectPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqEnumPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterSeqEnumPattern(VDMParser.SeqEnumPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqEnumPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitSeqEnumPattern(VDMParser.SeqEnumPatternContext ctx);
	/**
	 * Enter a parse tree produced by the {@code IdPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void enterIdPattern(VDMParser.IdPatternContext ctx);
	/**
	 * Exit a parse tree produced by the {@code IdPattern}
	 * labeled alternative in {@link VDMParser#pattern}.
	 * @param ctx the parse tree
	 */
	void exitIdPattern(VDMParser.IdPatternContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#maplet_pattern_list}.
	 * @param ctx the parse tree
	 */
	void enterMaplet_pattern_list(VDMParser.Maplet_pattern_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#maplet_pattern_list}.
	 * @param ctx the parse tree
	 */
	void exitMaplet_pattern_list(VDMParser.Maplet_pattern_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#maplet_pattern}.
	 * @param ctx the parse tree
	 */
	void enterMaplet_pattern(VDMParser.Maplet_patternContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#maplet_pattern}.
	 * @param ctx the parse tree
	 */
	void exitMaplet_pattern(VDMParser.Maplet_patternContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#field_pattern_list}.
	 * @param ctx the parse tree
	 */
	void enterField_pattern_list(VDMParser.Field_pattern_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#field_pattern_list}.
	 * @param ctx the parse tree
	 */
	void exitField_pattern_list(VDMParser.Field_pattern_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#field_pattern}.
	 * @param ctx the parse tree
	 */
	void enterField_pattern(VDMParser.Field_patternContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#field_pattern}.
	 * @param ctx the parse tree
	 */
	void exitField_pattern(VDMParser.Field_patternContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pattern_list}.
	 * @param ctx the parse tree
	 */
	void enterPattern_list(VDMParser.Pattern_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pattern_list}.
	 * @param ctx the parse tree
	 */
	void exitPattern_list(VDMParser.Pattern_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#pattern_bind}.
	 * @param ctx the parse tree
	 */
	void enterPattern_bind(VDMParser.Pattern_bindContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#pattern_bind}.
	 * @param ctx the parse tree
	 */
	void exitPattern_bind(VDMParser.Pattern_bindContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SetBind}
	 * labeled alternative in {@link VDMParser#bind}.
	 * @param ctx the parse tree
	 */
	void enterSetBind(VDMParser.SetBindContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SetBind}
	 * labeled alternative in {@link VDMParser#bind}.
	 * @param ctx the parse tree
	 */
	void exitSetBind(VDMParser.SetBindContext ctx);
	/**
	 * Enter a parse tree produced by the {@code SeqBind}
	 * labeled alternative in {@link VDMParser#bind}.
	 * @param ctx the parse tree
	 */
	void enterSeqBind(VDMParser.SeqBindContext ctx);
	/**
	 * Exit a parse tree produced by the {@code SeqBind}
	 * labeled alternative in {@link VDMParser#bind}.
	 * @param ctx the parse tree
	 */
	void exitSeqBind(VDMParser.SeqBindContext ctx);
	/**
	 * Enter a parse tree produced by the {@code TypeBind}
	 * labeled alternative in {@link VDMParser#bind}.
	 * @param ctx the parse tree
	 */
	void enterTypeBind(VDMParser.TypeBindContext ctx);
	/**
	 * Exit a parse tree produced by the {@code TypeBind}
	 * labeled alternative in {@link VDMParser#bind}.
	 * @param ctx the parse tree
	 */
	void exitTypeBind(VDMParser.TypeBindContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_bind}.
	 * @param ctx the parse tree
	 */
	void enterType_bind(VDMParser.Type_bindContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_bind}.
	 * @param ctx the parse tree
	 */
	void exitType_bind(VDMParser.Type_bindContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#bind_list}.
	 * @param ctx the parse tree
	 */
	void enterBind_list(VDMParser.Bind_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#bind_list}.
	 * @param ctx the parse tree
	 */
	void exitBind_list(VDMParser.Bind_listContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MultipleSetBind}
	 * labeled alternative in {@link VDMParser#multiple_bind}.
	 * @param ctx the parse tree
	 */
	void enterMultipleSetBind(VDMParser.MultipleSetBindContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MultipleSetBind}
	 * labeled alternative in {@link VDMParser#multiple_bind}.
	 * @param ctx the parse tree
	 */
	void exitMultipleSetBind(VDMParser.MultipleSetBindContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MultipleSeqBind}
	 * labeled alternative in {@link VDMParser#multiple_bind}.
	 * @param ctx the parse tree
	 */
	void enterMultipleSeqBind(VDMParser.MultipleSeqBindContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MultipleSeqBind}
	 * labeled alternative in {@link VDMParser#multiple_bind}.
	 * @param ctx the parse tree
	 */
	void exitMultipleSeqBind(VDMParser.MultipleSeqBindContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MultipleTypeBind}
	 * labeled alternative in {@link VDMParser#multiple_bind}.
	 * @param ctx the parse tree
	 */
	void enterMultipleTypeBind(VDMParser.MultipleTypeBindContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MultipleTypeBind}
	 * labeled alternative in {@link VDMParser#multiple_bind}.
	 * @param ctx the parse tree
	 */
	void exitMultipleTypeBind(VDMParser.MultipleTypeBindContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#type_bind_list}.
	 * @param ctx the parse tree
	 */
	void enterType_bind_list(VDMParser.Type_bind_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#type_bind_list}.
	 * @param ctx the parse tree
	 */
	void exitType_bind_list(VDMParser.Type_bind_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link VDMParser#name_list}.
	 * @param ctx the parse tree
	 */
	void enterName_list(VDMParser.Name_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link VDMParser#name_list}.
	 * @param ctx the parse tree
	 */
	void exitName_list(VDMParser.Name_listContext ctx);
	/**
	 * Enter a parse tree produced by the {@code QualifiedName}
	 * labeled alternative in {@link VDMParser#name}.
	 * @param ctx the parse tree
	 */
	void enterQualifiedName(VDMParser.QualifiedNameContext ctx);
	/**
	 * Exit a parse tree produced by the {@code QualifiedName}
	 * labeled alternative in {@link VDMParser#name}.
	 * @param ctx the parse tree
	 */
	void exitQualifiedName(VDMParser.QualifiedNameContext ctx);
	/**
	 * Enter a parse tree produced by the {@code IdName}
	 * labeled alternative in {@link VDMParser#name}.
	 * @param ctx the parse tree
	 */
	void enterIdName(VDMParser.IdNameContext ctx);
	/**
	 * Exit a parse tree produced by the {@code IdName}
	 * labeled alternative in {@link VDMParser#name}.
	 * @param ctx the parse tree
	 */
	void exitIdName(VDMParser.IdNameContext ctx);
	/**
	 * Enter a parse tree produced by the {@code NumericLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void enterNumericLiteral(VDMParser.NumericLiteralContext ctx);
	/**
	 * Exit a parse tree produced by the {@code NumericLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void exitNumericLiteral(VDMParser.NumericLiteralContext ctx);
	/**
	 * Enter a parse tree produced by the {@code BooleanLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void enterBooleanLiteral(VDMParser.BooleanLiteralContext ctx);
	/**
	 * Exit a parse tree produced by the {@code BooleanLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void exitBooleanLiteral(VDMParser.BooleanLiteralContext ctx);
	/**
	 * Enter a parse tree produced by the {@code NilLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void enterNilLiteral(VDMParser.NilLiteralContext ctx);
	/**
	 * Exit a parse tree produced by the {@code NilLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void exitNilLiteral(VDMParser.NilLiteralContext ctx);
	/**
	 * Enter a parse tree produced by the {@code CharacterLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void enterCharacterLiteral(VDMParser.CharacterLiteralContext ctx);
	/**
	 * Exit a parse tree produced by the {@code CharacterLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void exitCharacterLiteral(VDMParser.CharacterLiteralContext ctx);
	/**
	 * Enter a parse tree produced by the {@code StringLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void enterStringLiteral(VDMParser.StringLiteralContext ctx);
	/**
	 * Exit a parse tree produced by the {@code StringLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void exitStringLiteral(VDMParser.StringLiteralContext ctx);
	/**
	 * Enter a parse tree produced by the {@code QuoteLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void enterQuoteLiteral(VDMParser.QuoteLiteralContext ctx);
	/**
	 * Exit a parse tree produced by the {@code QuoteLiteral}
	 * labeled alternative in {@link VDMParser#symbolic_literal}.
	 * @param ctx the parse tree
	 */
	void exitQuoteLiteral(VDMParser.QuoteLiteralContext ctx);
}