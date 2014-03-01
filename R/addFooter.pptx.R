#' @title Insert a footer shape into a document pptx object
#'
#' @description Insert a footer shape into the current slide of a \code{pptx} object.
#' 
#' @param doc Object of class \code{"pptx"}
#' @param value character value to add into the footer shape of the current slide. 
#' @param ... further arguments, not used. 
#' @return a document object
#' @examples
#' # Create a new document 
#' doc = pptx( title = "title" )
#' # add a slide with layout "Title Slide"
#' doc = addSlide( doc, slide.layout = "Title Slide" )
#' doc = addTitle( doc, "Presentation title" ) #set the main title
#' doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title
#' 
#' ## add a page number on the current slide
#' doc = addFooter( doc, "Hi!" )
#' 
#' # Write the object in file "presentation.pptx"
#' writeDoc( doc, "presentation.pptx" )
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addDate.pptx}}
#' , \code{\link{addPageNumber.pptx}}, \code{\link{addFooter}} 
#' @method addFooter pptx
#' @S3method addFooter pptx

addFooter.pptx = function(doc, value, ... ) {

	slide = doc$current_slide 
	
#	shapeId = .jcall( doc$current_slide, "S", "getShapeId", "ftr" )
#	if( is.null( shapeId ) ) 
#		stop( "Can't find any shape of type 'Footer' in the layout.")
	
	if( !missing( value ) )
		out = .jcall( slide, "I", "addFooter" , as.character(value))
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "footer") )
	}	
	doc
}

