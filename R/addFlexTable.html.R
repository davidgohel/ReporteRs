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
#' data( data_ReporteRs )
#' 
#' myFlexTable = FlexTable( data = data_ReporteRs, span.columns = "col1"
#' 	, header.columns = TRUE, row.names=FALSE )
#' 
#' myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
#' myFlexTable[ 4:5, 4:5] = parProperties( text.align="right" )
#' myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
#' 
#' myFlexTable = setFlexCellContent( myFlexTable, 3, 6, pot("Hello"
#' 	, format=textProperties(font.weight="bold") ) + pot("World"
#' 	, format=textProperties(font.weight="bold", vertical.align="superscript") ) )
#' 
#' doc = html( title = "title" )
#' doc = addPage( doc, title = "Example" )
#' doc = addFlexTable( doc, flextable = myFlexTable )
#' writeDoc( doc, directory = "addFlexTable_example")
#' #STOP_TAG_TEST
#' @method addFlexTable html
#' @S3method addFlexTable html
addFlexTable.html = function(doc, flextable, ... ) {
			
	
	out = .jcall( doc$current_slide, "I", "add", flextable$jobj )
	if( out != 1 ){
		stop( "Problem while trying to add FlexTable." )
	}

	doc
}

