#' @title Insert a footer shape into a document pptx object
#'
#' @description Insert a footer shape into the current slide of a \code{pptx} object.
#'
#' @param doc \code{\link{pptx}} object
#' @param value character value to add into the footer shape of the current slide.
#' @param ... further arguments, not used.
#' @return a document object
#' @examples
#' doc = pptx( )
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' doc = addFooter( doc, "Hi!" )
#' writeDoc( doc, file = "ex_footer.pptx" )
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addDate.pptx}}
#' , \code{\link{addPageNumber.pptx}}
#' @export
addFooter.pptx = function(doc, value, ... ) {

	slide = doc$current_slide

	if( missing( value ) ) stop("value is missing")

	if( length( value ) != 1 )
		stop("length of value should be 1.")

	out = .jcall( slide, "I", "addFooter" , as.character(value))

	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "footer") )
	}
	doc
}

