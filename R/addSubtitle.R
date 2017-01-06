#' @title Add a subtitle shape into a document object
#'
#' @description Add a subtitle shape into a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @export
#' @seealso \code{\link{pptx}}
addSubtitle <- function(doc, ...){
  checkHasSlide(doc)
  UseMethod("addSubtitle")
}

#' @title Insert a addSubtitle shape into a pptx object
#'
#' @description Add a addSubtitle shape into a \code{\link{pptx}} object.
#'
#' @param value \code{"character"} value to use as subtitle text
#'
#' @details
#' Subtitle shape only exist in slide of type 'Title Slide'.
#' @rdname addSubtitle
#' @examples
#' \donttest{
#' doc.filename = "addSubtitle_example.pptx"
#' doc <- pptx()
#' doc <- addSlide( doc, slide.layout = "Title Slide" )
#' #set the main title
#' doc <- addTitle( doc, "Presentation title" )
#' #set the sub-title
#' doc <- addSubtitle( doc , "This document is generated with ReporteRs.")
#' writeDoc( doc, file = doc.filename )
#' }
#' @export
addSubtitle.pptx = function( doc, value, ... ) {

	slide = doc$current_slide
	out = .jcall( slide, "I", "addSubTitle", value )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "subtitle") )
	}
	doc
}


