#' @title Insert a paragraph into an bsdoc object
#'
#' @description
#' Insert paragraph(s) of text into a \code{bsdoc} object
#' 
#' @param doc \code{\link{bsdoc}} object where paragraph has to be added
#' @param value text to add to the document as paragraphs: 
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}} 
#' or a character vector.
#' @param par.properties \code{\link{parProperties}} to apply to paragraphs.
#' @param restart.numbering boolean value. If \code{TRUE}, next numbered 
#' list counter will be set to 1.
#' @param ... further arguments, not used. 
#' @return an object of class \code{\link{bsdoc}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addParagraph_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/addTitle1Level1.R
#' @example examples/addParagraph_hello_nostylename.R
#' @example examples/addTitle2Level1.R
#' @example examples/pot1_example.R
#' @example examples/pot2_example.R
#' @example examples/set_of_paragraphs_example.R
#' @example examples/addParagraph_sop_nostylename.R
#' @example examples/addTitle3Level1.R
#' @example examples/lists_doc.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}
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
	
	if( !inherits( par.properties, "parProperties" ) ){
		stop("argument 'par.properties' must be an object of class 'parProperties'")
	}
	
	if( restart.numbering ){
		.jcall( doc$jobj, "V", "restartNumbering" )
	}
	
	out = .jcall( doc$jobj, "I", "add" , parset )
	if( out != 1 ){
		stop( "Problem while trying to add paragrahs." )
	}	
	doc
}



