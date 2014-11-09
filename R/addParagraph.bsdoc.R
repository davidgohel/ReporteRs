#' @method addParagraph bsdoc
#' @S3method addParagraph bsdoc
addParagraph.bsdoc = function(doc, value, 
		par.properties = parProperties(), 
		restart.numbering = FALSE, ... ) {

	if( inherits( value, "character" ) ){
		value = gsub("(\\n|\\r)", "", value )
		x = lapply( value, function(x) pot(value = x) )
		value = do.call( "set_of_paragraphs", x )
	}
	if( inherits( value, "pot" ) ){
		value = set_of_paragraphs( value )
	}
	
	if( !inherits(value, "set_of_paragraphs") )
		stop("value must be an object of class pot, set_of_paragraphs or a character vector.")
	
	parset = .jset_of_paragraphs(value, par.properties)
	
	if( restart.numbering ){
		.jcall( doc$jobj, "V", "restartNumbering" )
	}
	
	out = .jcall( doc$jobj, "I", "add" , parset )
	if( out != 1 ){
		stop( "Problem while trying to add paragrahs." )
	}	
	doc
}



