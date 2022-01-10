
 // import isString from 'd2-utilizr/lib/isString';

 // import isDefined from 'd2-utilizr/lib/isDefined';

 // import isNumber from 'd2-utilizr/lib/isNumber';
 import "package:loglevel.dart" as log ; import "d2_utils.helper.dart" show isDefined , isNumber , isString ; import "../interfaces/rules-engine.types.dart" show ProgramRule , Variable ;
 /**
 * 
 * 
 * 
 */
 final orderRulesByPriority = ( List < ProgramRule > programRules ) => programRules . concat ( ) . sort ( ( ProgramRule a , ProgramRule b ) => a . priority && b . priority ? a . priority - b . priority : ! a . priority && ! b . priority ? 0 : ! a . priority ? 1 : - 1 ) ;
 /**
 * 
 * 
 */
 final convertToNumber = ( dynamic dataValue ) => isString ( dataValue ) ? ! isNumber ( dataValue ) ? null : Number ( dataValue ) : dataValue ; final DataByTypeMapping = { : ( dynamic value ) => isString ( value ) ? identical ( value , "true" ) : value , : convertToNumber , : convertToNumber , : convertToNumber , : convertToNumber , : convertToNumber , : ( dynamic value ) => true } ;
 /**
 * 
 * 
 */
 final convertDataByType = ( dynamic dataValue , String valueType ) { if ( ! identical ( dataValue , 0 ) && ! identical ( dataValue , false ) && ! dataValue ) { return null ; } return DataByTypeMapping [ valueType ] ? DataByTypeMapping [ valueType ] ( dataValue ) : dataValue ; } ;
 /**
 *  Replace variable name with its respective value
 * 
 * 
 * 
 */
 final replaceVariables = /* String */ ( String expression , Map < String , Variable > variablesHash ) { String evalExpression = expression ; if ( evalExpression . includes ( "{" ) ) {
 // Get every variable name in the expression;
 final variablesInexpression = evalExpression . match ( new RegExp ( r'[A#CV]\{[\w -_.]+}' ) ) ; ( variablesInexpression || [ ] ) . forEach ( ( expressionVariable ) {
 // Strip away any prefix and postfix signs from the variable name
 final strippedExprVar = expressionVariable . replace ( "#{" , "" ) . replace ( "A{" , "" ) . replace ( "C{" , "" ) . replace ( "V{" , "" ) . replace ( "}" , "" ) ; if ( isDefined ( variablesHash [ strippedExprVar ] ) ) {
 // Replace all occurrences of the variable name(hence using regex replacement):
 evalExpression = evalExpression . replace ( new RegExp ( variablesHash [ strippedExprVar ] . variablePrefix + "\\{" + strippedExprVar + "\\}" , "g" ) , variablesHash [ strippedExprVar ] . variableValue ) ; } else { } } ) ; }
 // Check if it has enviroment variable
 if ( evalExpression . includes ( "V{" ) ) {
 // Get every variable name in the expression;
 final variablesInexpression = evalExpression . match ( new RegExp ( r'V{\w+.?\w*}' ) ) ; variablesInexpression . forEach ( ( expressionVariable ) {
 // Strip away any prefix and postfix signs from the variable name
 final strippedExprVar = expressionVariable . replace ( "V{" , "" ) . replace ( "}" , "" ) ; if ( isDefined ( variablesHash [ strippedExprVar ] ) && identical ( variablesHash [ strippedExprVar ] . variablePrefix , "V" ) ) {
 //Replace all occurrences of the variable name(hence using regex replacement):
 evalExpression = evalExpression . replace ( new RegExp ( "V{" + strippedExprVar + "}" , "g" ) , variablesHash [ strippedExprVar ] . variableValue ) ; } else { } } ) ; }
 // Check if it has enviroment variable

 // if (evalExpression.includes('A{')) {

 //   // Get every variable name in the expression;

 //   const variablesInexpression = evalExpression.match(/A{\w+.?\w*}/g);

 //   (variablesInexpression || []).forEach((expressionVariable) => {

 //     // Strip away any prefix and postfix signs from the variable name

 //     const strippedExprVar = expressionVariable

 //       .replace('A{', '')

 //       .replace('}', '');

 //     if (

 //       isDefined(variablesHash[strippedExprVar]) &&

 //       variablesHash[strippedExprVar].variablePrefix === 'A'

 //     ) {

 //       //Replace all occurrences of the variable name(hence using regex replacement):

 //       evalExpression = evalExpression.replace(

 //         new RegExp('A{' + strippedExprVar + '}', 'g'),

 //         variablesHash[strippedExprVar].variableValue

 //       );

 //     } else {

 //       // log.warn(

 //       //   `Expression ${evalExpression} conains attribute  ${strippedExprVar} - but this attribute is not defined.`

 //       // );

 //     }

 //   });

 // }
 return evalExpression ; } ; final determineValueType = ( dynamic value ) { var valueType = "TEXT" ; if ( identical ( value , "true" ) || identical ( value , "false" ) ) { valueType = "BOOLEAN" ; } else if ( isNumber ( value ) || ! isNaN ( value ) ) { if ( ! identical ( value % 1 , 0 ) ) { valueType = "NUMBER" ; } else { valueType = "INTEGER" ; } } return valueType ; } ; final addQuotesToString = ( dynamic value ) => isNumber ( value ) ? value : '''\'${ value}\'''' ; final processValue = ( dynamic value , String type ) { if ( isString ( value ) ) { value = trimQuotes ( value ) ; } final convertFnName = mapTypeToInterfaceFnName [ type ] ; if ( ! convertFnName ) {
 // log.warn(`Error in converting this value of type ${type}`);
 return value ; } final convertedValue = addQuotesToString ( inputValueFnConverters [ convertFnName ] ( value ) ) ; return convertedValue ; } ;