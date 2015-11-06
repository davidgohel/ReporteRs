#' @importFrom gdtools str_extents
#' @title Row object for FlexTable
#'
#' @description Create a representation of a row that can be inserted in a FlexTable.
#' For internal usage.
#'
#' @param values Optional. a character vector to use as text content, the row will contain as many cells as there are in \code{values}.
#' @param text.properties Optional. textProperties to apply to each cell. Used only if values are not missing.
#' @param par.properties Optional. parProperties to apply to each cell. Used only if values are not missing.
#' @param cell.properties Optional. cellProperties to apply to each cell. Used only if values are not missing.
#' @param colspan integer Optional. vector specifying for each element the number of columns to span for each corresponding value (in \code{values}).
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{alterFlexRow}}
#' , \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' @examples
#' #
#' @example examples/FlexRow1.R
#' @example examples/FlexRow2.R
FlexRow = function( values, colspan, text.properties = textProperties(),
	par.properties = parProperties(), cell.properties = cellProperties() ){

	.Object = list()

	if( !missing ( values ) ){
		if( !is.character( values ) ) stop("argument 'values' must be a character vector.")

		str_width <- str_extents(paste0(" ", values, " "), fontname = text.properties$font.family, fontsize = text.properties$font.size )
		str_width <- max( str_width[,1], na.rm = TRUE )
		vertical.extra.space = str_width + cell.properties$padding.left +
				cell.properties$padding.left +
				par.properties$padding.left + par.properties$padding.right +
				cell.properties$border.left.width +
				cell.properties$border.right.width
		.Object$jobj = .jnew(class.FlexRow, as.integer(vertical.extra.space) )
	} else {
		.Object$jobj = .jnew(class.FlexRow)
	}

	class( .Object ) = "FlexRow"

	if( !missing ( values ) ){

		if( missing( colspan ) ) colspan = rep(1, length( values ) )
		if( length( colspan ) != length( values ) ) stop("Length of colspan is different from length of values.")
		if( any( is.na( values ) ) ) values[is.na(values)] = "NA"
		for(i in 1:length( values ) )
			.Object[i] = FlexCell( value = pot( values[i], format = text.properties )
				, colspan = colspan[i]
				, par.properties = par.properties
				, cell.properties = cell.properties
				)
	}
	.Object
}

#' @export
length.FlexRow = function(x) {
	return(.jcall( x$jobj, "I", "size" ))
}

weight.FlexRow = function(x) {
	return(.jcall( x$jobj, "I", "weight" ))
}

#' @title modify FlexRow content
#'
#' @description add or replace FlexCell into a FlexRow object
#'
#' @param x the \code{FlexRow} object
#' @param i a single integer value.
#' @param value an object of class \code{\link{FlexCell}}
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{addFlexTable}}, \code{\link{FlexRow}}
#' , \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' @examples
#' #
#' @example examples/FlexRow2.R
#' @rdname FlexRow-alter
#' @aliases alterFlexRow
#' @export
"[<-.FlexRow" = function (x, i, value){
	if( missing(i) ) stop("subset argument is missing.")
	if( !is.numeric(i) ) stop("subset must be defined with a scalar integer argument.")
	if( length(i) != 1 ) stop("subset length is not of length 1.")

	i = as.integer(i)

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


#' @export
print.FlexRow = function(x, ...){
	out = .jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}
