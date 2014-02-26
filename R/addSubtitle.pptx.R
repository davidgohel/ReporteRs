#' @title Insert a addSubtitle shape into a pptx object
#'
#' @description Add a addSubtitle shape into a \code{"pptx"} object.
#' 
#' @param doc Object of class \code{"pptx"}
#' @param value \code{"character"} value to use as subtitle text
#' @param ... further arguments, not used. 
#' 
#' @return an object of class \code{"pptx"}.
#' 
#' @details
#' Subtitle shape only exist in slide of type 'Title Slide'.
#' @examples
#' # Create a new document 
#' doc = pptx( title = "title" )
#' 
#' # add a slide with layout "Title Slide"
#' doc = addSlide( doc, slide.layout = "Title Slide" )
#' doc = addTitle( doc, "Presentation title" ) #set the main title
#' doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title
#' 
#' # Write the object in file "presentation.pptx"
#' writeDoc( doc, "presentation.pptx" )
#' @seealso \code{\link{pptx}}, \code{\link{addSubtitle}}
#' @method addSubtitle pptx
#' @S3method addSubtitle pptx
addSubtitle.pptx = function( doc, value, ... ) {
	
	slide = doc$current_slide 
	out = rJava::.jcall( slide, "I", "addSubTitle", value )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "subtitle") )
	}
	doc
}


