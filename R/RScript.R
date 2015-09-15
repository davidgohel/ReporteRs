#' @title RScript object
#'
#' @description Colored RScript object
#' 
#' @param file R script file. Not used if text is provided.
#' @param text character vector. The text to parse. Not used if file is provided.
#' @param comment.properties comment txtProperties object
#' @param roxygencomment.properties roxygencomment txtProperties object
#' @param operators.properties operators txtProperties object
#' @param keyword.properties keyword txtProperties object
#' @param string.properties string txtProperties object
#' @param number.properties number txtProperties object
#' @param functioncall.properties functioncall txtProperties object
#' @param argument.properties argument txtProperties object
#' @param package.properties package txtProperties object
#' @param formalargs.properties formalargs txtProperties object
#' @param eqformalargs.properties eqformalargs txtProperties object
#' @param assignement.properties assignement txtProperties object
#' @param symbol.properties symbol txtProperties object
#' @param slot.properties slot txtProperties object
#' @param default.properties default txtProperties object
#' @param par.properties a parProperties object
#' @examples
#' an_rscript = RScript( text = "ls()
#' x = rnorm(10)" )
#' @seealso \code{\link{addRScript}}
#' @export
RScript = function( file, text
		, comment.properties = textProperties( color = "#A7947D" )
		, roxygencomment.properties = textProperties( color = "#5FB0B8" )
		, symbol.properties = textProperties( color = "black" )
		, operators.properties = textProperties( color = "black" )
		, keyword.properties = textProperties( color = "#4A444D" )
		, string.properties = textProperties( color = "#008B8B", font.style = "italic" )
		, number.properties = textProperties( color = "blue" )
		, functioncall.properties = textProperties( color = "blue" )
		, argument.properties = textProperties( color = "#666666" )
		, package.properties = textProperties( color = "green" )
		, formalargs.properties = textProperties( color = "#424242" )
		, eqformalargs.properties = textProperties( color = "#424242" )
		, assignement.properties = textProperties( color = "black" )
		, slot.properties = textProperties( color = "#F25774" )
		, default.properties = textProperties( color = "black" )
		, par.properties = parProperties() 
		) {
	
	if( !inherits( par.properties, "parProperties" ) ){
		stop("argument 'par.properties' must be an object of class 'parProperties'")
	}
	
	if( !inherits(comment.properties, "textProperties") )
		stop("argument comment.properties must be a textProperties object.")
	
	if( !inherits(roxygencomment.properties, "textProperties") )
		stop("argument roxygencomment.properties must be a textProperties object.")
	
	if( !inherits(operators.properties, "textProperties") )
		stop("argument operators.properties must be a textProperties object.")
	
	if( !inherits(keyword.properties, "textProperties") )
		stop("argument keyword.properties must be a textProperties object.")
	
	if( !inherits(string.properties, "textProperties") )
		stop("argument string.properties must be a textProperties object.")
	
	if( !inherits(number.properties, "textProperties") )
		stop("argument number.properties must be a textProperties object.")
	
	if( !inherits(functioncall.properties, "textProperties") )
		stop("argument functioncall.properties must be a textProperties object.")
	
	if( !inherits(argument.properties, "textProperties") )
		stop("argument argument.properties must be a textProperties object.")
	
	if( !inherits(package.properties, "textProperties") )
		stop("argument package.properties must be a textProperties object.")
	
	if( !inherits(formalargs.properties, "textProperties") )
		stop("argument formalargs.properties must be a textProperties object.")
	
	if( !inherits(eqformalargs.properties, "textProperties") )
		stop("argument eqformalargs.properties must be a textProperties object.")
	
	if( !inherits(assignement.properties, "textProperties") )
		stop("argument assignement.properties must be a textProperties object.")
	
	if( !inherits(symbol.properties, "textProperties") )
		stop("argument symbol.properties must be a textProperties object.")
	
	if( !inherits(slot.properties, "textProperties") )
		stop("argument slot.properties must be a textProperties object.")
	
	if( !inherits(default.properties, "textProperties") )
		stop("argument default.properties must be a textProperties object.")
	
	if( missing( file ) && missing( text ) )
		stop("file OR text must be provided as argument.")
	
	if( !missing( file ) ){
		if( !inherits( file, "character" ) )
			stop("file must be a single character value")
		if( length( file ) != 1 )
			stop("file must be a single character value")		
		if( !file.exists( file ) )
			stop( file, " does not exist")
		
		pot.list = get.pots.from.script( file = file
			, comment.properties = comment.properties
			, roxygencomment.properties = roxygencomment.properties
			, operators.properties = operators.properties
			, keyword.properties = keyword.properties
			, string.properties = string.properties
			, number.properties = number.properties
			, functioncall.properties = functioncall.properties
			, argument.properties = argument.properties
			, package.properties = package.properties
			, formalargs.properties = formalargs.properties
			, eqformalargs.properties = eqformalargs.properties
			, assignement.properties = assignement.properties
			, symbol.properties = symbol.properties
			, slot.properties = slot.properties
			, default.properties = default.properties
		)
	}
	else {
		if( !inherits( text, "character" ) )
			stop("text must be a single character value")
		if( length( text ) != 1 )
			stop("text must be a single character value")		
		
		pot.list = get.pots.from.script( text = text
			, comment.properties = comment.properties
			, roxygencomment.properties = roxygencomment.properties
			, operators.properties = operators.properties
			, keyword.properties = keyword.properties
			, string.properties = string.properties
			, number.properties = number.properties
			, functioncall.properties = functioncall.properties
			, argument.properties = argument.properties
			, package.properties = package.properties
			, formalargs.properties = formalargs.properties
			, eqformalargs.properties = eqformalargs.properties
			, assignement.properties = assignement.properties
			, symbol.properties = symbol.properties
			, slot.properties = slot.properties
			, default.properties = default.properties
		)
	}
	
	
	jparProp = .jParProperties(par.properties)
	
	jRScript = .jnew(class.RScript, jparProp)
	
	for( i in 1:length(pot.list)){
		.jcall( jRScript, "V", "addParagraph", .jpot(pot.list[[i]]) )
	}
	
	out = list()
	out$jobj = jRScript
	class( out ) = c( "RScript", "set_of_paragraphs")
	out
}

#' @export
print.RScript = function(x, ...){
	out = .jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}



#' @title get HTML code from a RScript object
#'
#' @description get HTML code from a RScript object
#' 
#' @param object the \code{RScript} object
#' @param ... further arguments passed to other methods - not used.
#' @return a character value
#' @seealso \code{\link{RScript}}
#' @examples
#' my_rscript = RScript( text = "ls()" )
#' as.html( my_rscript )
#' @export
as.html.RScript = function(object, ...){
	out = .jcall( object$jobj, "S", "getHTML" )
	out
}



