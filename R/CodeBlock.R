#' @title Code Block Object
#'
#' @description Code Block Object. A code block object is a block of text
#' treated as verbatim text in a document object.
#'
#' @param file script file. Not used if text is provided.
#' @param text character vector. The text to parse. Not used if file is provided.
#' @param text.properties default textProperties object
#' @param par.properties default parProperties object
#' @examples
#' cb_example <- CodeBlock( text = "ls -a\nwhich -a ls" )
#' @seealso \code{\link{addCodeBlock}}
#' @export
CodeBlock = function( file, text, text.properties = textProperties( color = "#A7947D" ),
		par.properties = parProperties( text.align = "left", shading.color = "#5FB0B8" ) ) {

	if( !inherits( par.properties, "parProperties" ) ){
		stop("argument 'par.properties' must be an object of class 'parProperties'")
	}

	if( !inherits(text.properties, "textProperties") )
		stop("argument text.properties must be a textProperties object.")


	if( !missing( file ) ){
		if( !inherits( file, "character" ) )
			stop("file must be a single character value")
		if( length( file ) != 1 )
			stop("file must be a single character value")
		if( !file.exists( file ) )
			stop( file, " does not exist")

		text = readLines( file )
		text = paste(text, collapse = "\n")
	}
	else {
		if( !inherits( text, "character" ) )
			stop("text must be a single character value")
		if( length( text ) != 1 )
			stop("text must be a single character value")
	}

	jparProp = .jParProperties(par.properties)
	potValue = pot(text, text.properties )
	jCodeBlock = .jnew(class.CodeBlock, jparProp)

	.jcall( jCodeBlock, "V", "addParagraph", .jpot( potValue ) )

	out = list()
	out$jobj = jCodeBlock
	class( out ) = c( "CodeBlock", "set_of_paragraphs")
	out
}


