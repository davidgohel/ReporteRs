#' @export 
FlexCell = function( value
		, colspan = 1, rowspan = 1
		, parProp, cellProp ) {
	
	if( !inherits( parProp, "parProperties" ) ){
		stop("argument 'parProp' must be an object of class 'parProperties'")
	}
	
	if( !inherits( cellProp, "cellProperties" ) ){
		stop("argument 'cellProp' must be an object of class 'cellProperties'")
	}
	
	if( missing(value) )
		stop("argument value is missing.")

	if( inherits(value, "character") ){
		value = set_of_paragraphs( value )
	}
	
	if( !inherits(value, "set_of_paragraphs") )
		stop("argument value must be a character vector or an object of class 'set_of_paragraphs'.")
	
	paragraphsSection = ParagraphSection(value, parProp = parProp )
	
	jcellProp = .jCellProperties(cellProp)

	flexCell = .jnew("org/lysis/reporters/tables/FlexCell", paragraphsSection$jobj, jcellProp)
	rJava::.jcall( flexCell, "V", "setColspan", as.integer( colspan ) )
	rJava::.jcall( flexCell, "V", "setRowspan", as.integer( rowspan ) )
	
	.Object = list()
	.Object$jobj = flexCell
	.Object$rowspan = rowspan
	.Object$colspan = colspan

	class( .Object ) = c("FlexCell", "FlexElement")

	.Object
}

#' @method print FlexCell
#' @S3method print FlexCell
print.FlexCell = function(x, ...){
	out = rJava::.jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}

