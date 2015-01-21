#' @title Insert a FlexTable into an bsdoc object
#'
#' @description Insert a FlexTable into a \code{\link{bsdoc}} object
#' 
#' @param doc \code{\link{bsdoc}} object
#' @param flextable the \code{FlexTable} object
#' @param par.properties paragraph formatting properties of the paragraph that contains the table. 
#' An object of class \code{\link{parProperties}}
#' @param ... further arguments - not used
#' @return a \code{\link{bsdoc}} object
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{bsdoc}}
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addFlexTable_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/addTitle1Level1.R
#' @example examples/FlexTableExample.R
#' @example examples/addFlexTable.R
#' @example examples/addTitle2Level1.R
#' @example examples/agg.mtcars.FlexTable.R
#' @example examples/addFlexTable.R
#' @example examples/addTitle3Level1.R
#' @example examples/setFlexTableBackgroundColors.R
#' @example examples/addFlexTable.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @export
addFlexTable.bsdoc = function(doc, flextable, 
		par.properties = parProperties(text.align = "left" ), ... ) {
	
	.jcall( flextable$jobj, "V", "setParProperties", .jParProperties(par.properties) )
	
	out = .jcall( doc$jobj, "I", "add", flextable$jobj )
	if( out != 1 ){
		stop( "Problem while trying to add FlexTable." )
	}

	doc
}

