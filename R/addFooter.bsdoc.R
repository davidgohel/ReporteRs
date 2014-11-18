#' @title Add text in footer of a \code{bsdoc} object
#'
#' @description Add text in footer of a \code{bsdoc} object. The function has 
#' the same behaviour than addParagraph, except that its content will be 
#' written in the footer part of the \code{bsdoc} instead of the body of 
#' the document.
#' 
#' @param doc \code{\link{bsdoc}} object
#' @param value text to add to in the footer as paragraphs: 
#' an object of class \code{\link{pot}} or \code{\link{set_of_paragraphs}} 
#' or a character vector.
#' @param par.properties \code{\link{parProperties}} to apply to paragraphs.
#' @param restart.numbering boolean value. If \code{TRUE}, next numbered 
#' list counter will be set to 1.
#' @param ... further arguments, not used. 
#' @return a \code{bsdoc} object
#' @examples
#' #START_TAG_TEST
#' 
#' # Create a new document 
#' doc = bsdoc( title = "title" )
#' 
#' doc = addFooter( doc, value = pot( "Code licensed under ", 
#'     format = textProperties(color="gray") ) + 
#'   pot("GPL-3", format = textProperties(color="#428bca"), 
#'     hyperlink = "https://gnu.org/licenses/gpl.html" ) + 
#'   pot(".", format = textProperties(color="gray") ), 
#' par.properties = parCenter( padding = 2 ) 
#' )
#'  
#' # write the html object in a directory
#' writeDoc( doc, "addFooter/example.html")
#' #STOP_TAG_TEST
#' @export
#' @seealso \code{\link{bsdoc}}
#' @method addFooter bsdoc
#' @S3method addFooter bsdoc
addFooter.bsdoc = function(doc, value, 
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
	
	.jcall( doc$jobj, "V", "addToFooter" , parset )
	
	doc
}
