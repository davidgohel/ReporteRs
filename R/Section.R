#' @title Insert a slide into a pptx object
#'
#' @description Add a slide into a \code{"pptx"} object.
#' 
#' @param doc Object of class \code{\link{docx}} where section has to be added
#' @param landscape logical value. Specify TRUE to get a section with horizontal page.
#' @param ncol \code{integer} number to specify how many columns the section should contains.
#' @param space_between width in inches of the space between columns of the section.
#' @param columns.only logical value, if set to TRUE, no break page will (continuous section).
#' @param ... further arguments, not used. 
#' @details 
#' This function is a key function ; if no slide has been added into the document object
#' no content (tables, plots, images, text) can be added. 
#' 
#' @return an object of class \code{"docx"}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addSection.docx"
#' @example examples/docx.R
#' @example examples/addSection_example1.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addSection}}
#' @method addSection docx
#' @S3method addSection docx
addSection.docx = function(doc, landscape = FALSE, ncol = 1, space_between = 0.3, columns.only = FALSE , ...) {
	.jcall( doc$obj, "V", "startSection", as.logical( landscape ), 
			as.integer( ncol ), as.integer( space_between*1440 ),
			as.logical( !columns.only ))
	doc
}


#' @title Insert a column break into a docx section
#'
#' @description Insert a page break into a \code{"docx"} section.
#' 
#' @param doc Object of class \code{"docx"} where column break has to be added
#' @param ... further arguments, not used. 
#' @return an object of class \code{"docx"}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addColumnBreak.docx"
#' doc = docx( )
#' doc = addSection(doc, ncol = 2, columns.only = TRUE ) 
#' doc = addParagraph( doc = doc, "Text 1.", "Normal" )
#' doc = addColumnBreak(doc ) 
#' doc = addParagraph( doc = doc, "Text 2.", "Normal" )
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addColumnBreak}}, \code{\link{addSection.docx}}
#' @method addColumnBreak docx
#' @S3method addColumnBreak docx
addColumnBreak.docx = function(doc, ...) {
	
	.jcall( doc$obj, "V", "addColumnBreak" )
	
	doc
}