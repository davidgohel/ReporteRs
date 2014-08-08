#' @title Cell object for FlexTable
#'
#' @description Create a representation of a cell that can be inserted in a FlexRow.
#' 
#' @param value a content value - a value of type \code{character} or \code{\link{pot}} or \code{\link{set_of_paragraphs}}.
#' @param colspan defines the number of columns the cell should span
#' @param par.properties parProperties to apply to content
#' @param cell.properties cellProperties to apply to content
#' @export
#' @seealso \code{\link{addFlexTable}}, \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' @examples 
#' #START_TAG_TEST
#' @example examples/FlexCell.R
#' @example examples/STOP_TAG_TEST.R
FlexCell = function( value, colspan = 1, par.properties = parProperties(), cell.properties = cellProperties() ) {
	
	if( !inherits( par.properties, "parProperties" ) ){
		stop("argument 'par.properties' must be an object of class 'parProperties'")
	}
	
	if( !inherits( cell.properties, "cellProperties" ) ){
		stop("argument 'cell.properties' must be an object of class 'cellProperties'")
	}
	
	if( missing(value) )
		stop("argument value is missing.")
	
	if( is.null(value) )
		stop("argument value is null.")
	
	if( inherits(value, "character") ){
		value = set_of_paragraphs( value )
	}
	
	if( inherits(value, "pot") )
		value = set_of_paragraphs( value )
	
	if( !inherits(value, "set_of_paragraphs") )
		stop("argument value must be a character vector or an object of class 'set_of_paragraphs'.")
	
	parset = .jnew( class.ParagraphSet, .jParProperties(par.properties) )
	for( pot_index in 1:length( value ) ){
		paragrah = .jnew(class.Paragraph )
		pot_value = value[[pot_index]]
		for( i in 1:length(pot_value)){
			if( is.null( pot_value[[i]]$format ) ) 
				.jcall( paragrah, "V", "addText", pot_value[[i]]$value )
			else .jcall( paragrah, "V", "addText", pot_value[[i]]$value, 
						.jTextProperties( pot_value[[i]]$format) )
		}
		.jcall( parset, "V", "addParagraph", paragrah )
	}
	
	jcellProp = .jCellProperties(cell.properties)

	flexCell = .jnew(class.FlexCell, parset, jcellProp)
	.jcall( flexCell, "V", "setColspan", as.integer( colspan ) )
	
	.Object = list()
	.Object$jobj = flexCell
	.Object$colspan = colspan

	class( .Object ) = c("FlexCell", "FlexElement")

	.Object
}

#' @method print FlexCell
#' @S3method print FlexCell
print.FlexCell = function(x, ...){
	out = .jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}

