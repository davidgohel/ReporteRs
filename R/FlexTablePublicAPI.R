#' @title add header in a FlexTable
#'
#' @description add a header row in a FlexTable
#'
#' @param x a \code{FlexTable} object
#' @param value \code{FlexRow} object to insert as an header row or a
#' character vector specifying labels to use as columns labels.
#' @param colspan integer vector. Optional. Applies only when argument \code{value}
#' is a character vector. Vector specifying the number of columns to span
#' for each corresponding value (in \code{values}).
#' @param text.properties Optional. textProperties to apply to each cell.
#' Used only if values are not missing. Default is the value of argument
#' \code{header.text.props} provided to funtion \code{FlexTable} when object
#' has been created
#' @param par.properties Optional. parProperties to apply to each cell.
#' Used only if values are not missing. Default is the value of argument
#' \code{header.par.props} provided to funtion \code{FlexTable} when object
#' has been created
#' @param cell.properties Optional. cellProperties to apply to each cell.
#' Used only if values are not missing. Default is the value of argument
#' \code{header.cell.props} provided to funtion \code{FlexTable} when object
#' has been created
#' @param first if \code{TRUE}, row will be inserted as first row
#' @seealso \code{\link{FlexTable}}, \code{\link{addFooterRow}}
#' , \code{\link{alterFlexTable}}
#' @examples
#' #
#' @example examples/addHeaderRowDefaults.R
#' @example /examples/addHeaderRowFormats.R
#' @export
addHeaderRow = function( x, value, colspan,
		text.properties, par.properties, cell.properties,
		first = F ){

	if( !inherits(x, c("FlexTable") ) )
		stop("x must be a FlexTable object.")

	if( !is.character(value) && !inherits(value, "FlexRow") )
		stop("argument value must be an object of class 'FlexRow' or a character vector.")

	if( is.character(value) ){
		if( missing( colspan ) )
			colspan = rep( 1, length( value ) )
		if( missing( text.properties ) )
			text.properties = x$header.text.props
		if( missing( par.properties ) )
			par.properties = x$header.par.props
		if( missing( cell.properties ) )
			cell.properties = x$header.cell.props

		if( !inherits( text.properties , "textProperties" ) ){
			stop("text.properties is not a textProperties object")
		}
		if( !inherits( par.properties , "parProperties" ) ){
			stop("par.properties is not a parProperties object")
		}
		if( !inherits( cell.properties , "cellProperties" ) ){
			stop("cell.properties is not a cellProperties object")
		}

		value = FlexRow( values = value, colspan = colspan,
			text.properties = text.properties,
			par.properties = par.properties,
			cell.properties = cell.properties )
	}

	.weights = weight.FlexRow( value )
	if( .weights == x$numcol - 1 ) warning("Did you forget the rownames header?")
	if( .weights != x$numcol ) stop("The 'FlexRow' object has not the correct number of elements or the sum of colspan is different from the number of columns of the dataset.")


	headers = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getHeader" )
	if( !first )
		.jcall( headers, "V", "add", value$jobj )
	else .jcall( headers, "V", "insert", value$jobj )

	x
}
#' @title add footer in a FlexTable
#'
#' @description add a footer row in a FlexTable
#'
#' @param x a \code{FlexTable} object
#' @param value \code{FlexRow} object to insert as a footer row or a
#' character vector specifying labels to use as columns labels.
#' @param colspan integer vector. Optional. Applies only when argument \code{value}
#' is a character vector. Vector specifying the number of columns to span
#' for each corresponding value (in \code{values}).
#' @param text.properties Optional. textProperties to apply to each cell. Used only if values are not missing.
#' @param par.properties Optional. parProperties to apply to each cell. Used only if values are not missing.
#' @param cell.properties Optional. cellProperties to apply to each cell. Used only if values are not missing.
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{addHeaderRow}}
#' , \code{\link{alterFlexTable}}
#' @examples
#' #
#' @example examples/addFooterRowDefaults.R
#' @example examples/addFooterRowComplex.R
addFooterRow = function( x, value, colspan, text.properties, par.properties, cell.properties ){

	if( !inherits(x, c("FlexTable") ) )
		stop("x must be a FlexTable object.")

	if( !is.character(value) && !inherits(value, "FlexRow") )
		stop("argument value must be an object of class 'FlexRow' or a character vector.")

	if( is.character(value) ){
		if( missing( colspan ) )
			colspan = rep( 1, length( value ) )
		if( missing( text.properties ) )
			text.properties = x$header.text.props
		if( missing( par.properties ) )
			par.properties = x$header.par.props
		if( missing( cell.properties ) )
			cell.properties = x$header.cell.props

		if( !inherits( text.properties , "textProperties" ) ){
			stop("text.properties is not a textProperties object")
		}
		if( !inherits( par.properties , "parProperties" ) ){
			stop("par.properties is not a parProperties object")
		}
		if( !inherits( cell.properties , "cellProperties" ) ){
			stop("cell.properties is not a cellProperties object")
		}

		value = FlexRow( values = value, colspan = colspan,
			text.properties = text.properties,
			par.properties = par.properties,
			cell.properties = cell.properties )

	}

	.weights = weight.FlexRow( value )
	if( .weights != x$numcol ) stop("The 'FlexRow' object has not the correct number of elements or the sum of colspan is different from the number of columns of the dataset.")


	footer = .jcall( x$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getFooter" )
	.jcall( footer, "V", "add", value$jobj )


#	.jcall( x$jobj, "V", "addFooter", value$jobj )

	x
}



#' @title alter FlexTable content and format
#'
#' @description add text or format a FlexTable object.
#'
#' @usage \method{[}{FlexTable} (x, i, j, text.properties, newpar = F, byrow = FALSE, to = "body", side = "top") <- value
#' @param x the \code{FlexTable} object
#' @param i vector (integer index, row.names values or boolean vector) for rows selection.
#' @param j vector (integer index, col.names values or boolean vector) for columns selection.
#' @param text.properties formatting properties (an object of class \code{textProperties}).
#' Used only when \code{value} is a \code{data.frame}, a \code{maxtrix} or a vector. It
#' will be used to format added text.
#' @param newpar logical value specifying wether or not the content should be added
#' as a new paragraph (therefore added on a new line).
#' @param byrow logical. If \code{FALSE} (the default) content is added by columns
#' , otherwise content is added by rows.
#' @param to specify on which part of the FlexTable to apply the \code{value}, must be one of the following
#' values \dQuote{body} (default) or \dQuote{header} or \dQuote{footer}
#' @param side used only when value is a \code{\link{borderProperties}}, specify on which side to
#' apply the properties. It must be one of \dQuote{bottom}, \dQuote{top}, \dQuote{left}, \dQuote{right}.
#' @param value see details.
#' @details
#'
#' Use \code{ft_object[1:4, 2:3] <- value} to perform the operation
#' on the body subset of of the FlexTable.
#'
#' Use \code{ft_object[] <- value} to perform the operation
#' on the whole part (body, header or footer) of the FlexTable.
#'
#' Use \code{ft_object[1, 2, to = "header"] <- value} to perform the operation
#' on the header subset of the FlexTable.
#'
#' Use \code{ft_object[1, 2, , to = "footer"] <- value} to perform the operation
#' on the footer subset of the FlexTable.
#'
#' To \strong{format content}, argument \code{value} (the right side of the \code{<-}) should
#' be one of the following:
#' \itemize{
#' 		\item{\emph{for table cells: }}{an object of class \code{\link{cellProperties}}}
#' 		\item{\emph{for paragraphs contained in table cells: }}{an object of class \code{\link{parProperties}}}
#' 		\item{\emph{for text contained in table cells: }}{an object of class \code{\link{textProperties}}}
#' 		\item{\emph{for borders of table cells: }}{an object of class \code{\link{borderProperties}}}
#' }
#'
#' To \strong{add content}, there are two options:
#'
#' \itemize{
#' 		\item{\emph{option 1: }}{value should be a \code{data.frame}
#' 			or a \code{matrix} or a \code{vector} with as many elements
#' 			as defined by the selection.}
#' 		\item{\emph{option 2: }}{value is a \code{\link{pot}} object,
#' 			its value will be added in all cells defined by the selection.}
#' }
#'
#' If dealing with \code{borderProperties} objects, use also argument
#' \code{side} to specify on which side of cells to apply border
#' properties.
#'
#' @seealso \code{\link{FlexTable}}, \code{\link{borderProperties}}
#' , \code{\link{cellProperties}}, \code{\link{parProperties}}
#' , \code{\link{textProperties}}
#' @examples
#' #
#' @example examples/FlexTable.mtcars.R
#' @example examples/FlexTable.mtcars.alterProps.R
#' @example examples/FlexTable.mtcars.alterContent.R
#' @example examples/FlexTableAPIFullDemo.R
#' @rdname FlexTable-alter
#' @aliases alterFlexTable
#' @export
"[<-.FlexTable" = function( x, i, j, text.properties, newpar = F, byrow = FALSE,
		to = "body", side = "top", value ){

	args.get.indexes = list(object = x)
	if( !missing(i) ) args.get.indexes$i = i
	if( !missing(j) ) args.get.indexes$j = j
	args.get.indexes$partname = to

	indexes = do.call(getncheckid, args.get.indexes)
	i = indexes$i
	j = indexes$j

	if( missing(text.properties) && to == "body" )
		text.properties = x$body.text.props
	else if( missing(text.properties) )
		text.properties = x$header.text.props
	if( inherits(value, "textProperties" ) ||
	    inherits(value, "borderProperties" ) ||
	    inherits(value, "parProperties" ) ||
	    inherits(value, "cellProperties" )
	    ){
	   x <- chprop(x, value, i, j, to = to, side = side)
	} else if( is.character( value ) && length( value ) == 1 ){

		switch(to,
				body = {
					x = addFlexCellContent (object = x, i = i, j = j
						, value = rep( value, length(i)*length(j) )
						, text.properties, newpar = newpar, byrow = byrow)
				},
				header = {
					x = addContentToMetaRows (object = x, i = i, j = j
						, value = rep( value, length(i)*length(j) ), to = "header"
						, text.properties, newpar = newpar, byrow = byrow)
				},
				footer =  {
					x = addContentToMetaRows (object = x, i = i, j = j
						, value = rep( value, length(i)*length(j) ), to = "footer"
						, text.properties, newpar = newpar, byrow = byrow)
				}, stop("to should be one of 'body', 'header', 'footer'.")
		)
	} else if( inherits( value , "pot") ){
		switch(to,
				body = {
					x = addFlexBodyPot (x = x, i = i, j = j, value = value, newpar = newpar)
				},
				header = {
					x = addPotToMetaRows (x = x, i = i, j = j, value = value, to = "header", newpar = newpar)
				},
				footer =  {
					x = addPotToMetaRows (x = x, i = i, j = j, value = value, to = "footer", newpar = newpar)
				}, stop("to should be one of 'body', 'header', 'footer'.")
		)


	} else if( is.data.frame( value ) || is.matrix( value ) || is.table( value ) || ( is.vector( value ) ) ){

		if( is.table( value ) ) {
			if( length( dim( value ) ) < 2 ){
				value = matrix( unclass( value ), dimnames = list( names( value ), "" ), nrow = dim( value ) )
			}
			else {
				value = matrix( unclass( value ), dimnames = dimnames( value ), nrow = dim( value )[1] )
			}
		}

		if( is.vector( value ) && length(i)*length(j) != length(value) )
			stop("value has length ", length(value), " and selection length is ", length(i)*length(j))
		else if( ( is.matrix( value ) || is.data.frame( value ) ) && length(i)*length(j) != prod(dim(value)) )
			stop("value has ", prod(dim(value)), " elements and selection length is ", length(i)*length(j))

		switch(to,
				body = {
					x = addFlexCellContent (object = x, i = i, j = j, value = value,
							text.properties, newpar = newpar, byrow = byrow )
				},
				header = {
					x = addContentToMetaRows (object = x, i = i, j = j,
							value = value, to = "header",
							text.properties, newpar = newpar, byrow = byrow )
				},
				footer =  {
					x = addContentToMetaRows (object = x, i = i, j = j,
							value = value, to = "footer",
							text.properties, newpar = newpar, byrow = byrow )
				}, stop("to should be one of 'body', 'header', 'footer'.")
		)
	} else stop("unknown type of assigned value. See details in help file.")

	x
}









#' @title change grid lines of a FlexTable
#'
#' @description apply borders scheme to a FlexTable. A border scheme is
#' a set of 4 different borders: inner vectical and horizontal
#' , outer vectical and horizontal.
#'
#' @param object a \code{FlexTable} object
#' @param inner.horizontal a \code{\link{borderProperties}} object
#' @param inner.vertical a \code{\link{borderProperties}} object
#' @param outer.horizontal a \code{\link{borderProperties}} object
#' @param outer.vertical a \code{\link{borderProperties}} object
#' @param body a logical value (default to TRUE), specifies
#' to apply scheme to table body
#' @param header a logical value (default to TRUE), specifies
#' to apply scheme to table header
#' @param footer a logical value (default to FALSE), specifies
#' to apply scheme to table footer
#' @examples
#' #
#' @example examples/FlexTable.mtcars.R
#' @example examples/setFlexTableBorders1.R
#' @seealso \code{\link{FlexTable}}
#' @export
setFlexTableBorders = function (object
		, inner.vertical = borderProperties(), inner.horizontal = borderProperties()
		, outer.vertical = borderProperties(), outer.horizontal = borderProperties()
		, body = TRUE, header = TRUE, footer = FALSE
){
	if( !inherits(object, "FlexTable") )
		stop("argument object must be a FlexTable object.")

	if( !inherits(inner.vertical, "borderProperties") )
		stop("argument inner.vertical must be a borderProperties object.")
	if( !inherits(inner.horizontal, "borderProperties") )
		stop("argument inner.horizontal must be a borderProperties object.")
	if( !inherits(outer.vertical, "borderProperties") )
		stop("argument outer.vertical must be a borderProperties object.")
	if( !inherits(outer.horizontal, "borderProperties") )
		stop("argument outer.horizontal must be a borderProperties object.")

	if( body )
		.jcall( object$jobj , "V", "setBodyBorders"
				, .jborderProperties( inner.vertical )
				, .jborderProperties( inner.horizontal )
				, .jborderProperties( outer.vertical )
				, .jborderProperties( outer.horizontal )
		)
	if( header ){
		headers = .jcall( object$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getHeader" )
		.jcall( headers , "V", "setBorderGrid"
				, .jborderProperties( inner.vertical )
				, .jborderProperties( inner.horizontal )
				, .jborderProperties( outer.vertical )
				, .jborderProperties( outer.horizontal )
		)
	}
	if( footer ){
		footers = .jcall( object$jobj, "Lorg/lysis/reporters/tables/MetaRows;", "getFooter" )
		.jcall( footers , "V", "setBorderGrid"
				, .jborderProperties( inner.vertical )
				, .jborderProperties( inner.horizontal )
				, .jborderProperties( outer.vertical )
				, .jborderProperties( outer.horizontal )
		)
	}
	object
}

#' @title FlexTable rows zebra striping
#'
#' @description applies background color to alternate rows (zebra striping).
#' Set a color if row index is odd and another if row index is even.
#'
#' @param object a \code{FlexTable} object
#' @param odd background color applied to odd row indexes - single character value (e.g. "#000000" or "black")
#' @param even background color applied to even row indexes - single character value (e.g. "#000000" or "black")
#' @examples
#' #
#' @example examples/FlexTable.mtcars.R
#' @example examples/setZebraStyle.R
#' @seealso \code{\link{FlexTable}}
#' @export
setZebraStyle = function (object, odd, even){
	if( !inherits(object, "FlexTable") )
		stop("argument object must be a FlexTable object.")
	if( !is.color( odd ) )
		stop("odd must be a valid color." )
	if( !is.color( even ) )
		stop("even must be a valid color." )

	if( length( odd ) != 1 ) stop("odd must be of length 1")
	if( length( even ) != 1 ) stop("even must be of length 1")

  color_compounds <- get_color_compounds(c(even, odd))

	.jcall( object$jobj , "V", "setOddEvenColor",
	        .jarray( color_compounds$r ),
	        .jarray( color_compounds$g ),
	        .jarray( color_compounds$b ),
	        .jarray( color_compounds$a )
	)

	object
}

#' @title applies background colors to rows of a FlexTable
#'
#' @description applies background colors to rows of a FlexTable
#'
#' @param object a \code{FlexTable} object
#' @param i vector (integer index, row.names values or boolean vector) for rows selection.
#' @param colors background colors to apply (e.g. "#000000" or "black")
#' @examples
#' #
#' @example examples/FlexTable.mtcars.R
#' @example examples/setRowsColors.R
#' @seealso \code{\link{FlexTable}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' @export
setRowsColors = function (object, i, colors){

	if( !inherits(object, "FlexTable") )
		stop("argument object must be a FlexTable object.")

	args.get.indexes = list(object = object)
	if( !missing(i) ) args.get.indexes$i = i
	args.get.indexes$partname = "body"
	indexes = do.call(getncheckid, args.get.indexes)
	i = indexes$i

	if( !is.character( colors ) ) {
		stop("color must be a character value.")
	} else if( any( !is.color(colors) ) ){
		stop("colors must be valid colors.")
	}
	if( length( colors ) == 1 ) colors = rep(colors, length(i) )
	if( length( colors ) != length(i) ) stop("expected ", length(i) , " colors")
	color_compounds <- get_color_compounds(colors)

	.jcall( object$jobj , "V", "setRowsColors",
	        .jarray( as.integer( i - 1 ) ),
	        .jarray( color_compounds$r ),
	        .jarray( color_compounds$g ),
	        .jarray( color_compounds$b ),
	        .jarray( color_compounds$a )
	      )

	object
}

#' @title applies background colors to columns of a FlexTable
#'
#' @description applies background colors to columns of a FlexTable
#'
#' @param object a \code{FlexTable} object
#' @param j vector (integer index, col.names values or boolean vector) for columns selection.
#' @param colors background colors to apply (e.g. "#000000" or "black")
#' @examples
#' #
#' @example examples/FlexTable.mtcars.R
#' @example examples/setColumnsColors.R
#' @seealso \code{\link{setRowsColors}}, \code{\link{FlexTable}}, \code{\link{setZebraStyle}}
#' @export
setColumnsColors = function (object, j, colors){
	if( !inherits(object, "FlexTable") )
		stop("argument object must be a FlexTable object.")

	args.get.indexes = list(object = object)
	if( !missing(j) ) args.get.indexes$j = j
	args.get.indexes$partname = "body"
	indexes = do.call(getncheckid, args.get.indexes)
	j = indexes$j

	if( !is.character( colors ) ) {
		stop("colors must be a character value.")
	} else if( any( !is.color(colors) ) ){
		stop("colors must be valid colors.")
	}
	if( length( colors ) == 1 ) colors = rep(colors, length(j) )
	if( length( colors ) != length(j) ) stop("expected ", length(j) , " colors")

	color_compounds <- get_color_compounds(colors)

	.jcall( object$jobj , "V", "setColumnsColors",
	        .jarray( as.integer( j - 1 ) ),
	        .jarray( color_compounds$r ),
	        .jarray( color_compounds$g ),
	        .jarray( color_compounds$b ),
	        .jarray( color_compounds$a )
	)

	object
}

#' @title applies background colors to cells of a FlexTable
#'
#' @description applies background colors to cells of a FlexTable
#'
#' @param object a \code{FlexTable} object
#' @param i vector (integer index, row.names values or boolean vector) for rows selection.
#' @param j vector (integer index, col.names values or boolean vector) for columns selection.
#' @param colors background colors to apply (e.g. "#000000" or "black"). a character vector
#' of colors with as many elements as defined by the selection.
#' @param to specify on which part of the FlexTable to apply colors, must be one of the following
#' values "body" (default) or "header" or "footer"
#' @examples
#' #
#' @example examples/setFlexTableBackgroundColors.R
#' @seealso \code{\link{FlexTable}}, \code{\link{is.color}}
#' @export
setFlexTableBackgroundColors = function (object, i, j, colors, to = "body"){
	if( !inherits(object, "FlexTable") )
		stop("argument object must be a FlexTable object.")

	args.get.indexes = list(object = object)
	if( !missing(i) ) args.get.indexes$i = i
	if( !missing(j) ) args.get.indexes$j = j
	args.get.indexes$partname = to

	indexes = do.call(getncheckid, args.get.indexes)
	i = indexes$i
	j = indexes$j


	if( !is.character( colors ) ) {
		stop("colors must be a character value.")
	} else if( any( !is.color(colors) ) ){
		stop("colors must be valid colors.")
	}
	if( length( colors ) == 1 ) colors = rep(colors, length(j)*length(i) )
	if( length( colors ) != length(j)*length(i) ) stop("expected ", length(j)*length(i) , " colors")

	switch(to,
		body = {
			object = chBodyBackgroundColor( x=object, i=i, j=j, value=colors )
		},
		header = {
			object = chHeaderBackgroundColor( x=object, i=i, j=j, value=colors )
		},
		footer =  {
			object = chFooterBackgroundColor( x=object, i=i, j=j, value=colors )
		}, stop("to should be one of 'body', 'header', 'footer'.")
	)

	object
}


#' @title Span rows within columns
#'
#' @description Span rows within columns.
#'
#' @note Overlappings of horizontally merged cells and vertically merged cells are forbidden.
#' @param object a \code{FlexTable} object
#' @param j vector (integer index, col.names values or boolean vector) for columns selection.
#' @param from index of the first row to span (its content will be the visible one).
#' @param to index of the last row to span.
#' @param runs a vector of size \code{numrow} of FlexTable. If provided, successive
#' runs of equal values will indicate to merge corresponding rows.
#' @examples
#' #
#' @example examples/spanFlexTableRows.R
#' @export
#' @seealso \code{\link{FlexTable}}, \code{\link{spanFlexTableColumns}}
#' @export
spanFlexTableRows = function (object, j, from, to, runs ){

	if( !inherits(object, "FlexTable") )
		stop("argument object must be a FlexTable object.")

	args.get.indexes = list(object = object)
	if( !missing(j) ) args.get.indexes$j = j
	args.get.indexes$partname = "body"

	indexes = do.call(getncheckid, args.get.indexes)
	j = indexes$j

	if( !missing( runs ) ){
		if( is.factor( runs) ) runs = as.character( runs )
		if( !is.vector( runs ) ) stop("argument runs must be a vector.")
		.rle = rle( runs )
		weights = unlist( lapply( .rle$lengths
						, function(x) {
							if( x < 2 )
								return(1)
							else
								return( c(x, rep(0, x-1 ) ) )
						} ) )
		if( sum( weights ) != object$numrow )
			stop("row spanning not possible, runs has wrong dimension")
		for( colid in j  ) object$rowspan[, colid ] = weights

	} else {

		if( missing( from ) || missing( to ) ) {
			stop("argument from and to cannot be missing.")
		}

		if( !is.numeric( from ) ) {
			stop("argument from must be an positive integer value.")
		}
		if( !is.numeric( to ) ) {
			stop("argument to must be an positive integer value.")
		}

		.seq = seq( from, to, by = 1 )
		for( colid in j ){
			rowspan = object$rowspan[,colid]
			rowspan[.seq] = c( length(.seq), integer(length(.seq) - 1) )
			if( sum( rowspan ) != object$numrow ) stop("row spanning not possible")
			else object$rowspan[, colid ] = rowspan
		}
	}

	merged.rows = which( object$rowspan != 1 )
	merged.cols = which( object$colspan != 1 )
	overlaps = intersect(merged.rows, merged.cols)
	if( length( overlaps ) > 0 )
		stop("span overlappings, some merged cells are already merged with other cells.")

	for( colid in j ){
		.jcall( object$jobj , "V", "setRowSpanInstructions"
				, as.integer( colid - 1 )
				, .jarray( as.integer( object$rowspan[, colid ] ) )
		)
	}
	object
}


#' @title Span columns within rows
#'
#' @description Span columns within rows.
#'
#' @note Overlappings of horizontally merged cells and vertically merged cells are forbidden.
#' @param object a \code{FlexTable} object
#' @param i vector (integer index, row.names values or boolean vector) for rows selection.
#' @param from index of the first column to span (its content will be the visible one).
#' @param to index of the last column to span.
#' @param runs a vector of size \code{numcol} of FlexTable. If provided, successive
#' runs of equal values will indicate to merge corresponding columns.
#' @examples
#' #
#' @example examples/spanFlexTableColumns.R
#' @export
#' @seealso \code{\link{spanFlexTableRows}}, \code{\link{FlexTable}}
#' @export
spanFlexTableColumns = function (object, i, from, to, runs ){

	if( !inherits(object, "FlexTable") )
		stop("argument object must be a FlexTable object.")
	args.get.indexes = list(object = object)

	if( !missing(i) ) args.get.indexes$i = i
	args.get.indexes$partname = "body"
	indexes = do.call(getncheckid, args.get.indexes)
	rowid = indexes$i
	if( !missing( runs ) ){
		if( is.factor( runs) ) runs = as.character( runs )
		if( !is.vector( runs ) ) stop("argument runs must be a vector.")
		.rle = rle( runs )
		weights = unlist( lapply( .rle$lengths
			, function(x) {
				if( x < 2 )
					return(1)
				else
					return( c(x, rep(0, x-1 ) ) )
			} ) )
		if( sum( weights ) != object$numcol )
			stop("column spanning not possible, runs has wrong dimension")
		object$colspan[rowid, ] = matrix( rep( weights, each = length(rowid)), nrow = length(rowid), byrow = F )
	} else if( missing( from ) || missing( to ) ) {
		stop("argument from and to cannot be missing.")
	} else {
		.seq = seq( from, to, by = 1 )
		object$colspan[rowid, .seq] = t( apply( object$colspan[rowid, , drop = F], 1 , function( x, .seq ){
				x[.seq] = c( length(.seq), integer(length(.seq) - 1) )
			}, .seq = .seq ) )
	}

	merged.rows = which( object$rowspan != 1 )
	merged.cols = which( object$colspan != 1 )
	overlaps = intersect(merged.rows, merged.cols)
	if( length( overlaps ) > 0 )
		stop("span overlappings, some merged cells are already merged with other cells.")

	for(i in rowid){
		.jcall( object$jobj , "V", "setColSpanInstructions"
				, as.integer( i - 1 )
				, .jarray( as.integer( object$colspan[i, ] ) )
		)
	}

	object
}


#' @title set columns widths of a FlexTable
#'
#' @description set columns widths of a FlexTable in inches.
#'
#' @param object a \code{FlexTable} object
#' @param widths a numeric vector specifying columns widths in inches.
#' @examples
#' #
#' @example examples/setFlexTableWidths.R
#' @seealso \code{\link{FlexTable}}
#' @export
setFlexTableWidths = function (object, widths ){

	if( !inherits(object, "FlexTable") )
		stop("argument object must be a FlexTable object.")
	if( !is.numeric( widths ) )
		stop("argument widths must be a numeric vector.")
	if( length(widths) != object$numcol )
		stop("argument widths must be a vector of length ", object$numcol, ".")

	.jcall( object$jobj, "V", "setWidths", .jarray( as.double(widths) ) )

	object
}
