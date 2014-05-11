#' @title Insert a FlexTable into a pptx object
#'
#' @description Insert a FlexTable into a pptx object
#' 
#' @param doc docx object
#' @param flextable the \code{FlexTable} object
#' @param ... further arguments - not used
#' @return a pptx object
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{pptx}}
#' , \code{\link{addFlexTable.html}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addTable.pptx}}
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addFlexTable_example.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1Level1.R
#' @example examples/FlexTableExample.R
#' @example examples/addFlexTable.R
#' @example examples/addSlide.R
#' @example examples/addTitle2Level1.R
#' @example examples/agg.mtcars.FlexTable.R
#' @example examples/addFlexTable.R
#' @example examples/writeDoc_file.R
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

