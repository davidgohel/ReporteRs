#' @title Insert a FlexTable into a docx object
#'
#' @description Insert a FlexTable into a docx object
#' 
#' @param doc docx object
#' @param flextable the \code{FlexTable} object
#' @param parStyle paragraph formatting properties of the paragraph that contains the table. An object of class \code{\link{parProperties}}
#' @param bookmark a character vector specifying bookmark id (where to put the table). 
#'   	If provided, table will be add after paragraph that contains the bookmark.
#'   	If not provided, table will be added at the end of the document.
#' @param ... further arguments - not used
#' @return a docx object
#' @export
#' @seealso \code{\link{FlexTable}}
#' @examples
#' data( data_ReporteRs )
#' myFlexTable = FlexTable( data = data_ReporteRs ,span.columns="col1", header.columns=TRUE, row.names=FALSE )
#' myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
#' myFlexTable[ 4:5, 4:5] = parProperties( text.align="right" )
#' myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
#' myFlexTable = setFlexCellContent( myFlexTable, 3, 6, pot("Hello", format=textProperties(font.weight="bold") ) + pot("World", format=textProperties(font.weight="bold", vertical.align="superscript") ) )
#' doc = docx( title = "title" )
#' doc = addFlexTable( doc, myFlexTable )
#' writeDoc( doc, "document.docx")
#' @method addFlexTable docx
#' @S3method addFlexTable docx
addFlexTable.docx = function(doc, flextable
	, parStyle = parProperties(text.align = "left" )
	, bookmark, ... ) {
		
	if( missing( bookmark ) )
		rJava::.jcall( doc$obj, "V", "add", flextable$jobj, .jParProperties(parStyle) )
	else rJava::.jcall( doc$obj, "V", "add", bookmark, flextable$jobj, .jParProperties(parStyle) )

	doc
}

