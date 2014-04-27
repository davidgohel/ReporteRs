#' @title Insert a FlexTable into a docx object
#'
#' @description Insert a FlexTable into a docx object
#' 
#' @param doc docx object
#' @param flextable the \code{FlexTable} object
#' @param ... further arguments - not used
#' @return a docx object
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{html}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addTable.html}}
#' @examples
#' #START_TAG_TEST
#' @example examples/FlexTableExample.R
#' @example examples/addFlexTable.html.R
#' @example examples/STOP_TAG_TEST.R
#' @method addFlexTable html
#' @S3method addFlexTable html
addFlexTable.html = function(doc, flextable, ... ) {
			
	
	out = .jcall( doc$current_slide, "I", "add", flextable$jobj )
	if( out != 1 ){
		stop( "Problem while trying to add FlexTable." )
	}

	doc
}

