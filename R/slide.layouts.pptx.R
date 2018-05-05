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
#' This can be useful to check available shapes.
#' @examples
#' if( check_valid_java_version() ){
#' \donttest{
#' doc.filename = "addFlexTable_example.pptx"
#' doc = pptx( title = "title" )
#' layouts = slide.layouts(doc)
#' layouts
#'
#' # loop over layout names to plot each slide style
#' for(i in layouts ){
#'   slide.layouts(doc, i )
#'   title(sub = i )
#' }
#' }
#' }
#' @seealso \code{\link{pptx}}, \code{\link{addSlide.pptx}}, \code{\link{slide.layouts}}
#' @export
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
