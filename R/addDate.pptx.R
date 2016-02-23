#' @title Insert a date
#'
#' @description Insert a date into a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @details
#' addDate only works for pptx documents.
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{addFooter}},
#' \code{\link{addPageNumber}}
addDate = function(doc, ...){
  checkHasSlide(doc)
  UseMethod("addDate")
}


#' @param value character value to add into the date
#' shape of the current slide. optionnal. If missing
#' current date will be used.
#' @param str.format character value to use to format
#' current date (if \code{value} is missing).
#' @examples
#' doc.filename = "addDate_example.pptx"
#' @example examples/pptx.R
#' @example examples/addDate_pptx.R
#' @example examples/writeDoc_file.R
#' @export
#' @rdname addDate
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



