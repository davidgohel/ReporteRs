#' @title Insert a FlexTable into a docx object
#'
#' @description Insert a FlexTable into a docx object
#' 
#' @param doc docx object
#' @param flextable the \code{FlexTable} object
#' @param par.properties paragraph formatting properties of the paragraph that contains the table. 
#' An object of class \code{\link{parProperties}}
#' @param bookmark a character vector specifying bookmark id (where to put the table). 
#'   	If provided, table will be add after paragraph that contains the bookmark.
#'   	If not provided, table will be added at the end of the document.
#' @param ... further arguments - not used
#' @return a docx object
#' @seealso \code{\link{FlexTable}}, \code{\link{docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' , \code{\link{addTable.docx}}
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addFlexTable_example.docx"
#' @example examples/docx.R
#' @example examples/addTitle1Level1.R
#' @example examples/FlexTableExample.R
#' @example examples/addFlexTable.R
#' @example examples/addTitle2Level1.R
#' @example examples/agg.mtcars.FlexTable.R
#' @example examples/addFlexTable.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @method addFlexTable docx
#' @S3method addFlexTable docx
addFlexTable.docx = function(doc, flextable
	, par.properties = parProperties(text.align = "left" )
	, bookmark, ... ) {
		
	if( missing( bookmark ) )
		.jcall( doc$obj, "V", "add", flextable$jobj, .jParProperties(par.properties) )
	else .jcall( doc$obj, "V", "add", bookmark, flextable$jobj, .jParProperties(par.properties) )

	doc
}

