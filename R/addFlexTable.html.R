#' @title Insert a FlexTable into an html object
#'
#' @description Insert a FlexTable into a \code{\link{html}} object
#' 
#' @param doc \code{\link{html}} object
#' @param flextable the \code{FlexTable} object
#' @param ... further arguments - not used
#' @return a \code{\link{html}} object
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{html}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.docx}}
#' @examples
#' #START_TAG_TEST
#' doc.dirname = "addFlexTable_example"
#' @example examples/html.R
#' @example examples/addPage.R
#' @example examples/addTitle1Level1.R
#' @example examples/FlexTableExample.R
#' @example examples/addFlexTable.R
#' @example examples/addTitle2Level1.R
#' @example examples/agg.mtcars.FlexTable.R
#' @example examples/addFlexTable.R
#' @example examples/writeDoc_directory.R
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

#' @title get HTML code from a FlexTable
#'
#' @description get HTML code from a FlexTable
#' 
#' @param object the \code{FlexTable} object
#' @param ... further arguments passed to other methods 
#' @return a character value
#' @seealso \code{\link{FlexTable}}
#' @examples
#' #START_TAG_TEST
#' @example examples/FlexTableExample.R
#' @example examples/as.html.MyFTable.R
#' @example examples/STOP_TAG_TEST.R
#' @method as.html FlexTable
#' @S3method as.html FlexTable
as.html.FlexTable = function( object, ... ) {
		
	.jcall( object$jobj, "S", "getHTML" )

}

