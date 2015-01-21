#' @title Insert a date shape into a document pptx object
#'
#' @description Insert a date into the current slide of a \code{pptx} object.
#' 
#' @param doc \code{\link{pptx}} object
#' @param value character value to add into the date 
#' shape of the current slide. optionnal. If missing 
#' current date will be used.
#' @param str.format character value to use to format 
#' current date (if \code{value} is missing).
#' @param ... further arguments, not used. 
#' @return a document object
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = pptx( title = "title" )
#' # add a slide with layout "Title Slide"
#' doc = addSlide( doc, slide.layout = "Title Slide" )
#' doc = addTitle( doc, "Presentation title" ) #set the main title
#' doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title
#' 
#' ## add a date on the current slide
#' doc = addDate( doc )
#' 
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' ## add a page number on the current slide but not the default text (slide number)
#' doc = addDate( doc, "Dummy date" )
#' 
#' # Write the object in file "presentation.pptx"
#' writeDoc( doc, "addDate_example.pptx" )
#' #STOP_TAG_TEST
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addFooter.pptx}}, \code{\link{addPageNumber.pptx}}
#' , \code{\link{strptime}},  \code{\link{addDate}}
#' @export
addDate.pptx = function(doc, value, str.format = "%Y-%m-%d", ... ) {
	
	
	slide = doc$current_slide 
	if( missing( value ) )
		out = .jcall( slide, "I", "addDate" , format( Sys.time(), str.format ))
	else {
		if( length( value ) != 1 )
			stop("length of value should be 1.")	
		out = .jcall( slide, "I", "addDate" , as.character(value))
	}
	
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "date") )
	}
		
	
	doc
}



