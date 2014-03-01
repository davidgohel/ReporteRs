#' @title Insert a page number shape into a document pptx object
#'
#' @description Insert a page number shape into the current slide of a \code{pptx} object.
#' 
#' @param doc Object of class \code{"pptx"}
#' @param value character value to add into the page number shape of the current slide. 
#' optionnal. If missing current slide number will be used.
#' @param ... further arguments, not used. 
#' @return a \code{pptx} document object
#' @examples
#' # Create a new document 
#' doc = pptx( title = "title" )
#' # add a slide with layout "Title Slide"
#' doc = addSlide( doc, slide.layout = "Title Slide" )
#' doc = addTitle( doc, "Presentation title" ) #set the main title
#' doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title
#' 
#' ## add a page number on the current slide
#' doc = addPageNumber( doc )
#' 
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' ## add a page number on the current slide but not the default text (slide number)
#' doc = addPageNumber( doc, value = "Page number text")
#' 
#' # Write the object in file "presentation.pptx"
#' writeDoc( doc, "presentation.pptx" )
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addDate.pptx}}
#' , \code{\link{addPageNumber}} 
#' @method addPageNumber pptx
#' @S3method addPageNumber pptx

addPageNumber.pptx = function(doc, value, ... ) {
	
#	shapeId = .jcall( doc$current_slide, "S", "getShapeId", "sln" )
#	if( is.null( shapeId ) ) 
#		stop( "Can't find any shape of type 'Slide number' in the layout.")
	
#	sln = .jcall( doc$obj, "I", "getSlideNumber" )
	slide = doc$current_slide 
	if( !missing( value ) )
		out = .jcall( slide, "I", "addSlideNumber" , as.character(value))
	else out = .jcall( slide, "I", "addSlideNumber" )
	
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "slide number") )
	}	
	
	doc
}



