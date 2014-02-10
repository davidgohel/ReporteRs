#' @export
ParagraphSection = function(value, parProp ) {
	if( !inherits( parProp, "parProperties" ) ){
		stop("argument 'parProp' must be an object of class 'parProperties'")
	}
	
	if( !inherits( value, "set_of_paragraphs" ) ){
		stop("argument 'value' must be an object of class 'set_of_paragraphs'")
	}
	
	jparProp = .jParProperties(parProp)
	
	paragraphsSection = .jnew("org/lysis/reporters/texts/ParagraphsSection", jparProp)
	for( i in 1:length(value)){
		current_value = Paragraph(value[[i]])
		rJava::.jcall( paragraphsSection, "V", "addParagraph", current_value$jobj )
	}
	
	out = list()
	out$jobj = paragraphsSection
	out$size = rJava::.jcall( paragraphsSection, "I", "size" )
	class( out ) = "ParagraphSection"
	out
}

#' @method length ParagraphSection
#' @S3method length ParagraphSection
length.ParagraphSection = function(x){
	x$size
}

#' @method print ParagraphSection
#' @S3method print ParagraphSection
print.ParagraphSection = function(x, ...){
	out = rJava::.jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}



