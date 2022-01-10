 import "package:lodash.dart" as _ ; final numberIsFinite = ( Number . isFinite || ( param ) { return identical ( , "number" ) && global . isFinite ( param ) ; } ) ; isNumber ( dynamic param ) { return identical ( , "number" ) && numberIsFinite ( param ) ; }
 /**
 * Check if the value is a String
 *
 * @name isString
 * 
 * 
 */
 final isString = _ . isString ;
 /**
 * Check if `param` is defined.
 *
 * 
 * 
 */
 isDefined ( dynamic param ) { return ! identical ( , "undefined" ) ; }