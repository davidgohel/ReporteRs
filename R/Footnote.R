#' @title Create a Footnote
#'
#' @description
#' Footnote
#' 
#' @param value text to add to the document as paragraphs: 
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}} 
#' or a character vector.
#' @param par.properties \code{\link{parProperties}} to apply to paragraphs. 
#' @param index.text.properties \code{\link{textProperties}} to apply to note index symbol. 
#' @return an object of class \code{\link{Footnote}}.
#' @export 
Footnote = function( value, par.properties = parProperties(), index.text.properties = textProperties(vertical.align = "superscript") ) {
	
	if( missing( value ) ){
		stop("argument value is missing." )
	} else if( inherits( value, "character" ) ){
		value = gsub("(\\n|\\r)", "", value )
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}
	
	if( inherits( value, "pot" ) ){
		value = set_of_paragraphs( value )
	}

	if( !inherits(value, "set_of_paragraphs") )
		stop("value must be an object of class pot, set_of_paragraphs or a character vector.")
	
	if( !inherits( par.properties, "parProperties" ) ){
		stop("argument par.properties is not a parProperties object." )
	}
	if( !inherits( index.text.properties, "textProperties" ) ){
		stop("argument index.text.properties is not a textProperties object." )
	}
	
	out = list( value = value , par.properties = par.properties, text.properties = index.text.properties )
	class( out ) = "Footnote"
	
	out
}

.jFootnote = function( object ){
	if( !missing( object ) && !inherits( object, "Footnote" ) ){
		stop("argument 'object' must be an object of class 'Footnote'")
	}
	parset = .jnew( class.Footnote, .jParProperties(object$par.properties), .jTextProperties(object$text.properties) )
	value = object$value
	for( pot_index in 1:length( value ) ){
		paragrah = .jnew(class.Paragraph )
		pot_value = value[[pot_index]]
		for( i in 1:length(pot_value)){
			current_value = pot_value[[i]]
			if( is.null( current_value$format ) ) {
				if( is.null( current_value$hyperlink ) )
					.jcall( paragrah, "V", "addText", current_value$value )
				else .jcall( paragrah, "V", "addText", current_value$value, current_value$hyperlink )
			} else {
				jtext.properties = .jTextProperties( current_value$format )
				if( is.null( current_value$hyperlink ) )
					.jcall( paragrah, "V", "addText", current_value$value, jtext.properties )
				else .jcall( paragrah, "V", "addText", current_value$value, jtext.properties, current_value$hyperlink )
			}
		}
		.jcall( parset, "V", "addParagraph", paragrah )
	}
	parset
}

