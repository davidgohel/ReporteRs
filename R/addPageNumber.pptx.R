#' @title Insert a page number shape into a document pptx object
#'
#' @description Insert a page number shape into the current slide of a \code{pptx} object.
#'
#' @param doc \code{\link{pptx}} object
#' @param value character value to add into the page number shape of the current slide.
#' optionnal. If missing current slide number will be used.
#' @param ... further arguments, not used.
#' @return a \code{\link{pptx}} document object
#' @examples
#' \donttest{
#' doc.filename <- "add_page_number_example.pptx"
#' doc <- pptx( title = "title" )
#' doc <- addSlide( doc, slide.layout = "Title Slide" )
#' # add a page number on the current slide ---
#' doc <- addPageNumber( doc )
#' doc <- addSlide( doc, slide.layout = "Title and Content" )
#' # add a page number with free text ----
#' doc <- addPageNumber( doc, value = "Page number text")
#' writeDoc( doc, file = doc.filename )
#' }
#' @export
#' @seealso \code{\link{addPageNumber}}, \code{\link{addDate}}
#' @export
addPageNumber.pptx = function(doc, value, ... ) {



	slide = doc$current_slide
	if( !missing( value ) ){
		if( length( value ) != 1 )
			stop("length of value should be 1.")

		out = .jcall( slide, "I", "addSlideNumber" , as.character(value))
	} else {

		out = .jcall( slide, "I", "addSlideNumber" )

	}

	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "slide number") )
	}

	doc
}



