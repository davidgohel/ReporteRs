#' @title Row object for FlexTable
#'
#' @description Create a representation of a row that can be inserted in a FlexTable.
#' 
#' @param values Optional. a character vector to use as text content, the row will contain as many cells as there are in \code{values}.
#' @param textProp Optional. textProperties to apply to each cell. Used only if values are not missing.
#' @param parProp Optional. parProperties to apply to each cell. Used only if values are not missing.
#' @param cellProp Optional. cellProperties to apply to each cell. Used only if values are not missing.
#' @param colspan integer Optional. vector specifying for each element the number of columns to span for each corresponding value (in \code{values}). 
#' @export
#' @seealso \code{\link{addFlexTable}}
#' @examples
#' #START_TAG_TEST
#' ## example 1
#' headerRow = FlexRow()
#' headerRow[1] = FlexCell( "Column 1", cellProp = cellProperties(background.color="#527578")  )
#' headerRow[2] = FlexCell( "Column 2", cellProp = cellProperties(background.color="#527578")  )
#' 
#' ## example 2
#' headerRow = FlexRow( c("Column 1", "Column 2")
#' 	, cellProp = cellProperties(background.color="#527578") )
#' #STOP_TAG_TEST
FlexRow = function( values, colspan, textProp = textProperties(), parProp = parProperties(), cellProp = cellProperties()){
	.Object = list()
	.Object$jobj = .jnew(class.FlexRow)
	class( .Object ) = c("FlexRow", "FlexElement")
	
	if( !missing ( values ) ){
		if( !is.character( values ) ) stop("argument 'values' must be a character vector.")
		if( missing( colspan ) ) colspan = rep(1, length( values ) )
		if( length( colspan ) != length( values ) ) stop("Length of colspan is different from length of values.")
		for(i in 1:length( values ) )
			.Object[i] = FlexCell( value = pot( values[i], format = textProp )
				, colspan = colspan[i]
				, parProp = parProp
				, cellProp = cellProp 
				)
	}
	.Object
}

#' @method length FlexRow
#' @S3method length FlexRow
length.FlexRow <- function(x) {
	return(.jcall( x$jobj, "I", "size" ))
}

weight.FlexRow <- function(x) {
	return(.jcall( x$jobj, "I", "weight" ))
}

#' @method [<- FlexRow
#' @S3method [<- FlexRow
"[<-.FlexRow" = function (x, i, j, value){
	if( missing(i) ) stop("subset argument is missing.")
	if( !is.numeric(i) ) stop("subset must be defined with a scalar integer argument.")
	if( length(i) != 1 ) stop("subset length is not of length 1.")
	
	i <- as.integer(i)
	
	doReplace = FALSE
	if( i <= length(x) ) {
		doReplace = TRUE
	} else if( i != ( length(x) + 1 ) ){
		stop("Next possible subset is ", length(x) + 1 )
	}
	if( doReplace ){
		.jcall( x$jobj, "V", "add", value$jobj, as.integer(i -1) )		
	} else {
		.jcall( x$jobj, "V", "add", value$jobj )
	}
	x
}


#' @method print FlexRow
#' @S3method print FlexRow
print.FlexRow = function(x, ...){
	out = .jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}
