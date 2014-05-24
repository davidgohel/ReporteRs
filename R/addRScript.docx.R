#' @title Add R script into a docx object
#'
#' @description Add R script into a \code{"docx"} object.
#' 
#' @param doc Object of class \code{"docx"} where expressions have to be added
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
#' @param stylename value of the named style to apply to paragraphs in the docx document.
#' Expected value is an existing stylename of the template document used to create the 
#' \code{docx} object. see \code{\link{styles.docx}}.
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
	, comment.properties = textProperties( color = "#A7947D" )
	, roxygencomment.properties = textProperties( color = "#5FB0B8" )
	, symbol.properties = textProperties( color = "black" )
	, operators.properties = textProperties( color = "black" )
	, keyword.properties = textProperties( color = "#4A444D" )
	, string.properties = textProperties( color = "#008B8B", font.style = "italic" )
	, number.properties = textProperties( color = "blue" )
	, functioncall.properties = textProperties( color = "#823C3C" )
	, argument.properties = textProperties( color = "#F25774" )
	, package.properties = textProperties( color = "green" )
	, formalargs.properties = textProperties( color = "#424242" )
	, eqformalargs.properties = textProperties( color = "#424242" )
	, assignement.properties = textProperties( color = "black" )
	, slot.properties = textProperties( color = "#F25774" )
	, default.properties = textProperties( color = "black" )
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
	} else {
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
	par = do.call(set_of_paragraphs, pot.list )
	if( missing( bookmark ) )
		doc = addParagraph(doc, value = par, stylename = stylename ) 
	else doc = addParagraph(doc, value = par, stylename = stylename, bookmark = bookmark )
	doc
}
