#' @title Insert a title into a pptx object
#'
#' @description Add a title into a \code{"pptx"} object.
#' 
#' @param doc Object of class \code{"pptx"}
#' @param value \code{"character"} value to use as title text
#' @param ... further arguments, not used. 
#' 
#' @return an object of class \code{"pptx"}.
#' @examples
#' # Create a new document 
#' doc = pptx( title = "title" )
#' 
#' # add a slide with layout "Title and Content"
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' 
#' # Here we fill the title shape with "My title"
#' doc = addTitle( doc, "My title" )
#' 
#' # Write the object in file "~/presentation.pptx"
#' writeDoc( doc, "~/presentation.pptx" )
#' @seealso \code{\link{pptx}}, \code{\link{addTitle}}, \code{\link{addSlide.pptx}}
#' @method addTitle pptx
#' @S3method addTitle pptx
addTitle.pptx = function( doc, value, ... ) {

	slide = doc$current_slide 
	out = rJava::.jcall( slide, "I", "addTitle", value )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "title(or crttitle)") )
	}
	doc
}


