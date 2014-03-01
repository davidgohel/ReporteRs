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
#' # Create a new document 
#' doc = pptx( title = "title" )
#' slide.layouts(doc)
#' 
#' # plot the layout "Two Content"
#' slide.layouts(doc, layout = "Two Content" )
#' @seealso \code{\link{pptx}}, \code{\link{addSlide.pptx}}, \code{\link{slide.layouts}}
#' @method slide.layouts pptx
#' @S3method slide.layouts pptx

slide.layouts.pptx = function( doc, layout, ... ) {
	layout.names = .jcall( doc$obj, "[S", "getStyleNames" )
	if( !missing( layout ) ){
		if( !is.character(layout) ) stop("layout must be a single string value.")
		if( length(layout) != 1 ) stop("layout must be a single string value.")
		if( !is.element(layout, layout.names)) stop("layout does not exists in layout names of the template pptx file.")
		plotSlideLayout( doc, layout )
	}
	layout.names
}
