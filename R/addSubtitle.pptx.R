#' @title Insert a addSubtitle shape into a pptx object
#'
#' @description Add a addSubtitle shape into a \code{\link{pptx}} object.
#'
#' @param doc \code{\link{pptx}} object
#' @param value \code{"character"} value to use as subtitle text
#' @param ... further arguments, not used.
#'
#' @return an object of class \code{\link{pptx}}.
#'
#' @details
#' Subtitle shape only exist in slide of type 'Title Slide'.
#' @examples
#' doc.filename = "addSubtitle_example.pptx"
#' @example examples/pptx.R
#' @example examples/addSubtitle.pptx.R
#' @example examples/writeDoc_file.R
#' @seealso \code{\link{pptx}}, \code{\link{addSubtitle}}
#' @export
addSubtitle.pptx = function( doc, value, ... ) {

	slide = doc$current_slide
	out = .jcall( slide, "I", "addSubTitle", value )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "subtitle") )
	}
	doc
}


