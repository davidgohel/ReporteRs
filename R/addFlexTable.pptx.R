#' @title Insert a FlexTable into a docx object
#'
#' @description Insert a FlexTable into a docx object
#' 
#' @param doc docx object
#' @param flextable the \code{FlexTable} object
#' @param ... further arguments - not used
#' @return a docx object
#' @export
#' @seealso \code{\link{FlexTable}}
#' @examples
#' #START_TAG_TEST
#' @example examples/FlexTableExample.R
#' @example examples/addFlexTable.pptx.R
#' @example examples/STOP_TAG_TEST.R
#' @method addFlexTable pptx
#' @S3method addFlexTable pptx
addFlexTable.pptx = function(doc, flextable, ... ) {
			
	out = .jcall( doc$current_slide, "I", "add", flextable$jobj )
	if( isSlideError( out ) ){
		stop( getSlideErrorString( out , "table") )
	}
	doc
}

