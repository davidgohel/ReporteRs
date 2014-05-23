#' @title Add R script into a docx object
#'
#' @description Add R script into a \code{"docx"} object.
#' 
#' @param doc Object of class \code{"docx"} where expressions have to be added
#' @param file R script file. Not used if text is provided.
#' @param text character vector. The text to parse. Not used if file is provided.
#' @param stylename value of the named style to apply to paragraphs in the docx document.
#' Expected value is an existing stylename of the template document used to create the 
#' \code{docx} object. see \code{\link{styles.docx}}.
#' @param comment.properties comment textProperties
#' @param symbol.properties symbol textProperties
#' @param assignement.properties assignement textProperties
#' @param keyword.properties keyword textProperties
#' @param formalargs.properties formalargs textProperties
#' @param eqformalargs.properties eqformalargs textProperties
#' @param functioncall.properties functioncall textProperties
#' @param string.properties string textProperties
#' @param number.properties number textProperties
#' @param argument.properties argument textProperties
#' @param package.properties package textProperties
#' @param bookmark a character value ; id of the Word bookmark to replace by the table. optional
#' @param ... further arguments, not used. 
#' @return an object of class \code{"html"}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addRScript_example.docx"
#' # Create a new document 
#' doc = docx( title = "title" )
#' 
#' doc = addRScript(doc, text = "ls()
#' x = rnorm(10)", stylename = "rRawOutput" )
#' 
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addRScript}}
#' @method addRScript docx
#' @S3method addRScript docx
addRScript.docx = function(doc, file, text
	, comment.properties = textProperties( color = "#008200" )
	, symbol.properties = textProperties( color = "#6599FF" )
	, assignement.properties = textProperties( color = "#666666" )
	, keyword.properties = textProperties( color = "#097054" )
	, formalargs.properties = textProperties( color = "#666666" )
	, eqformalargs.properties = textProperties( color = "#666666" )
	, functioncall.properties = textProperties( color = "#ff1493" )
	, string.properties = textProperties( color = "blue" )
	, number.properties = textProperties( color = "blue" )
	, argument.properties = textProperties( color = "#ff8000" )
	, package.properties = textProperties( color = "#8000ff" )
	, stylename, bookmark
	, ... 
	) {

	if( missing( stylename )) {
		stop("argument 'stylename' is missing")
	} else if( !is.element( stylename , styles( doc ) ) ){
		stop(paste("Style {", stylename, "} does not exists.", sep = "") )
	}
	
	if( !missing( file ) ){
		pot.list = get.pots.from.script( file = file
		    , comment.properties = comment.properties
		    , symbol.properties = symbol.properties
			, assignement.properties = assignement.properties
			, keyword.properties = keyword.properties
			, formalargs.properties = formalargs.properties
			, eqformalargs.properties = eqformalargs.properties
			, functioncall.properties = functioncall.properties
			, string.properties = string.properties
			, number.properties = number.properties
			, argument.properties = argument.properties
			, package.properties = package.properties
			)
	} else {
		pot.list = get.pots.from.script( text = text
		  	, comment.properties = comment.properties
			, symbol.properties = symbol.properties
			, assignement.properties = assignement.properties
			, keyword.properties = keyword.properties
			, formalargs.properties = formalargs.properties
			, eqformalargs.properties = eqformalargs.properties
			, functioncall.properties = functioncall.properties
			, string.properties = string.properties
			, number.properties = number.properties
			, argument.properties = argument.properties
			, package.properties = package.properties
		)
	}
	par = do.call(set_of_paragraphs, pot.list )
	if( missing( bookmark ) )
		doc = addParagraph(doc, value = par, stylename = stylename ) 
	else doc = addParagraph(doc, value = par, stylename = stylename, bookmark = bookmark )
	doc
}
