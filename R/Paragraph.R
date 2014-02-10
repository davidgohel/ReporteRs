#' @export
Paragraph = function(value) {
	if( !inherits( value, "pot" ) ){
		stop("argument 'value' must be an object of class 'pot'")
	}
	paragrah = .jnew("org/lysis/reporters/texts/Paragraph")
	for( i in 1:length(value)){
		current_value = value[[i]]
		if( is.null( current_value$format ) ) 
			rJava::.jcall( paragrah, "V", "addText", current_value$value )
		else {
			textProp = .jTextProperties( current_value$format )
			rJava::.jcall( paragrah, "V", "addText", current_value$value, textProp )
		}
	}
	out = list()
	out$jobj = paragrah
	class( out ) = "Paragraph"
	out
}
#' @method print Paragraph
#' @S3method print Paragraph
print.Paragraph = function(x, ...){
	rJava::.jcall( x$jobj, "S", "toString" )
}



