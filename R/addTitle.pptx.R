#' @title Insert a title into a pptx object
#'
#' @description Add a title into a \code{\link{pptx}} object.
#' 
#' @param doc \code{\link{pptx}} object
#' @param value \code{"character"} value to use as title text
#' @param ... further arguments, not used. 
#' 
#' @return an object of class \code{\link{pptx}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addTitle_example.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1NoLevel.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{addTitle}}, \code{\link{addSlide.pptx}}
#' @export
addTitle.pptx = function( doc, value, ... ) {

	slide = doc$current_slide 
	out = .jcall( slide, "I", "addTitle", value )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "title(or crttitle)") )
	}
	doc
}


