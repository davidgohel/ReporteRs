#' @title Get layout names of a pptx document 
#'
#' @description Get layout names that exist into the template used when pptx has been created.
#' 
#' @param doc Object of class \code{pptx} to extract layout names from.
#' @param layout optional single string value, one of the layout names
#' @param ... further arguments, not used. 
#' @details 
#' Available names are layout names of the template document (e.g. Title and Content
#' , Two Content, etc.).
#' If layout is specified, the layout representation will be produced in a plot. 
#' This can be usefull to check available shapes.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addFlexTable_example.pptx"
#' @example examples/pptx.R
#' @example examples/slide.layouts_1.R
#' @example examples/slide.layouts_2.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{addSlide.pptx}}, \code{\link{slide.layouts}}
#' @method slide.layouts pptx
#' @S3method slide.layouts pptx
slide.layouts.pptx = function( doc, layout, ... ) {
	
	if( length( doc$styles ) == 0 ){
		stop("You must defined layout in your pptx template.")				
	}
	
	
	if( !missing( layout ) ){
		if( !is.element( layout, doc$styles ) ){
			stop("Slide layout '", layout, "' does not exist in defined layouts.")				
		}
		if( !is.character(layout) ) stop("argument 'layout' must be a single string value.")
		if( length(layout) != 1 ) stop("argument 'layout' must be a single string value.")
		if( !is.element(layout, doc$styles)) {
			stop(shQuote(layout), 
			" does not exists in the of available layout names of the template pptx file. ",
			"Use slide.layouts(", deparse(substitute(doc)), ") to list them."	)
		}
		plotSlideLayout( doc, layout )
	}
	doc$styles
}
