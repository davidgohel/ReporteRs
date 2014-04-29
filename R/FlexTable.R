#' @title FlexTable creation
#'
#' @description Create an object of class \code{FlexTable}.
#' 
#' FlexTable can be manipulated so that almost any formating can be specified.
#' It allows to insert headers and footers rows with eventually merged cells 
#' (see \code{\link{addHeaderRow}} and \code{\link{addFooterRow}}).
#' 
#' Formating can be done on cells, paragraphs and texts (borders, colors, fonts, etc.)
#' , see \code{\link{alterFlexTable}}.
#' @param data (a \code{data.frame} or \code{matrix} object) to add
#' @param numrow number of row in the table body. Mandatory if data is missing. 
#' @param numcol number of col in the table body. Mandatory if data is missing. 
#' @param header.columns logical value - should the colnames be included in the table 
#' as table headers. If FALSE, no headers will be printed unless you 
#' use \code{\link{addHeaderRow}}. 
#' @param add.rownames logical value - should the row.names be included in the table. 
#' @param body.cell.props default cells formatting properties for table body
#' @param body.par.props default paragraphs formatting properties for table body
#' @param body.text.props default texts formatting properties for table body
#' @param header.cell.props default cells formatting properties for table headers
#' @param header.par.props default paragraphs formatting properties for table headers
#' @param header.text.props default texts formatting properties for table headers
#' @note The classical workflow would be to create a FlexTable, to add headers rows 
#' (see \code{\link{addHeaderRow}}) and eventually footers 
#' rows (see \code{\link{addFooterRow}}).
#' 
#' Additionnal texts can be added with subscript syntax (see \code{\link{alterFlexTable}}).
#' 
#' Texts, paragraphs and cells properties can be modified with subscript syntax 
#' (see \code{\link{alterFlexTable}}).
#' 
#' Cells background colors can also be modified with functions \code{\link{setRowsColors}}
#' , \code{\link{setColumnsColors}} and \code{\link{setZebraStyle}}.
#' 
#' Merging cells can be done with functions \code{\link{spanFlexTableRows}} and \code{\link{spanFlexTableColumns}}.
#' @export
#' @examples
#' #START_TAG_TEST
#' @example examples/FlexTableExample.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
FlexTable = function(data, numrow, numcol
	, header.columns = TRUE, add.rownames = FALSE
	, body.cell.props = cellProperties()
	, body.par.props = parProperties()
	, body.text.props = textProperties()
	, header.cell.props = cellProperties()
	, header.par.props = parProperties()
	, header.text.props = textProperties( font.weight= "bold" )
){
	miss_data = missing( data )
	if( !inherits(body.text.props, "textProperties") )
		stop("argument body.text.props must be a textProperties object.")
	if( !inherits(body.par.props, "parProperties") )
		stop("argument body.text.props must be a textProperties object.")
	if( !inherits(body.cell.props, "cellProperties") )
		stop("argument body.cell.props must be a cellProperties object.")

	if( miss_data && ( missing( numrow ) || missing( numcol ) ) ) {
		stop("numrow and numcol must be defined if no data is provided.")
	} else if( !miss_data && (!missing( numrow ) || !missing( numcol ) ) ) {
		warning("numrow and numcol arguments redefined with data dimensions.")
	}
	
	if( !miss_data ){
		# check data is a data.frame
		if( !is.data.frame( data ) && !is.matrix( data ) && !is.table( data ) )
			stop("data is not a data.frame nor a matrix.")
		
		if( is.table( data ) ) {
			if( length( dim( data ) ) > 2 )
				stop("data dimensions cannot be > 2.")
			else if( length( dim( data ) ) < 2 ){
				data = matrix( unclass( data )
					, dimnames = list( names( data ), "" )
			  		, nrow = dim( data )
			        )
			}
			else {
			  data = matrix( unclass( data )
			    , dimnames = dimnames( data )
				, nrow = dim( data )[1]
                )
		  }
		}
		if( !is.data.frame( data ) ) 
			data = as.data.frame( data )
		
		numrow = nrow( data )
		numcol = ncol( data )
		
		if( numrow < 1 )
			stop("data has 0 row.")
		
		.row_names = row.names(data)
		
		if( add.rownames ){
			.colnames = c( "", dimnames( data )[[2]] )
			numcol = numcol + 1
			data = cbind(rownames = .row_names, data )
		} else {
			.colnames = dimnames( data )[[2]]
		}
		
		row.names( data ) = NULL
		data = apply( data, 2, function(x) {
				if( is.character( x) ) x
				else if( is.factor( x ) ) as.character( x )
				else if( is.logical( x ) ) ifelse( x, "TRUE", "FALSE" )
				else format(x)
			} )
	} else {
		.row_names = rep(NA, numrow )
		.colnames = rep(NA, numcol )
		data = matrix("", nrow = numrow, ncol = numcol )
	}

	
	out = list(
		numcol = numcol
		, numrow = numrow
		, add.rownames = add.rownames
		, row_id = .row_names
		, col_id = .colnames
		, colspan = matrix(1, nrow = numrow, ncol = numcol )
		, rowspan = matrix(1, nrow = numrow, ncol = numcol )
	)
		
	jFlexTable = .jnew( class.FlexTable
		, as.integer( out$numrow ), as.integer( out$numcol )
		, .jTextProperties(body.text.props)
		, .jParProperties(body.par.props)
		, .jCellProperties(body.cell.props)
		)

	out$jobj = jFlexTable

	out$body.cell.props = body.cell.props
	out$body.par.props = body.par.props
	out$body.text.props = body.text.props
	out$header.cell.props = header.cell.props
	out$header.par.props = header.par.props
	out$header.text.props = header.text.props
	
	class( out ) = c("FlexTable", "FlexElement")

	if( !miss_data && header.columns ){
		headerRow = FlexRow(values = .colnames, text.properties = header.text.props, par.properties = header.par.props, cell.properties = header.cell.props )
		out = addHeaderRow( out, headerRow )
	}
	
	if( !miss_data ){
		addFlexCellContent (out, seq_len(out$numrow), seq_len(out$numcol)
				, value = data
				, textProperties = body.text.props
				, newpar = F
				, byrow = FALSE 
		)
	}
	
	out
}

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
#' @seealso \code{\link{FlexTable}}, \code{\link{addFooterRow}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' @examples
#' #START_TAG_TEST
#' @example examples/addHeaderRowDefaults.R
#' @example /examples/addHeaderRowFormats.R
#' @example /examples/addHeaderRowComplex.R 
#' @example /examples/setFlexTableBorders1.R
#' @example examples/STOP_TAG_TEST.R
#' @export
addHeaderRow = function( x, value, colspan, text.properties, par.properties, cell.properties ){
	
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
		
		value = FlexRow( values = value, colspan = colspan
			, text.properties = text.properties, par.properties = par.properties, cell.properties = cell.properties
			)
	} 
	
	.weights = weight.FlexRow( value )
	if( .weights == x$numcol - 1 ) warning("Did you forget the rownames header?")
	if( .weights != x$numcol ) stop("The 'FlexRow' object has not the correct number of elements or the sum of colspan is different from the number of columns of the dataset.")
	.jcall( x$jobj, "V", "addHeader", value$jobj )
	
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
#' @seealso \code{\link{addHeaderRow}}, \code{\link{FlexTable}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' @examples
#' #START_TAG_TEST
#' @example examples/addFooterRowDefaults.R
#' @example examples/addFooterRowComplex.R
#' @example examples/STOP_TAG_TEST.R
addFooterRow = function( x, value, colspan, text.properties, par.properties, cell.properties ){

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
		
		value = FlexRow( values = value, colspan = colspan
				, text.properties = text.properties, par.properties = par.properties, cell.properties = cell.properties
		)
	} 

	.weights = weight.FlexRow( value )
	if( .weights != x$numcol ) stop("The 'FlexRow' object has not the correct number of elements or the sum of colspan is different from the number of columns of the dataset.")
	.jcall( x$jobj, "V", "addFooter", value$jobj )
	
	x
}



#' @title modify FlexTable content
#'
#' @description add text into a FlexTable object or Format content of a FlexTable object
#' 
#' @usage \method{[}{FlexTable} (x, i, j, text.properties, newpar = F, byrow = FALSE) <- value
#' @param x the \code{FlexTable} object
#' @param i vector (integer index, row.names values or boolean vector) for rows selection. 
#' @param j vector (integer index, col.names values or boolean vector) for columns selection. 
#' or an object of class \code{\link{textProperties}}.
#' @param text.properties formating properties (an object of class \code{textProperties}).
#' @param newpar logical value specifying wether or not the content should be added 
#' as a new paragraph
#' @param byrow logical. If FALSE (the default) content is added by columns
#' , otherwise content is added by rows.
#' @param value an object of class \code{\link{cellProperties}} or an object of class \code{\link{parProperties}} 
#' @export
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' , \code{\link{FlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' @examples
#' #START_TAG_TEST
#' @example examples/FlexTable.mtcars.R
#' @example examples/FlexTable.mtcars.alterProps.R
#' @example examples/FlexTable.mtcars.alterContent.R
#' @example examples/STOP_TAG_TEST.R
#' @rdname FlexTable-alter
#' @aliases alterFlexTable
#' @method [<- FlexTable
#' @S3method [<- FlexTable
"[<-.FlexTable" = function (x, i, j, text.properties, newpar = F, byrow = FALSE, value){

	args.get.indexes = list(object = x)
	if( !missing(i) ) args.get.indexes$i = i
	if( !missing(j) ) args.get.indexes$j = j
	indexes = do.call(get.indexes.from.arguments, args.get.indexes)
	i = indexes$i
	j = indexes$j

	if( inherits(value, c("textProperties", "parProperties", "cellProperties")) ){
		if( inherits(value, "textProperties" ) ){
			x = updateTextProperties.FlexTable( x=x, i=i, j=j, value=value )
		} else if( inherits(value, "parProperties" ) ){
			x = updateParProperties.FlexTable( x=x, i=i, j=j, value=value )
		} else {
			x = updateCellProperties.FlexTable( x=x, i=i, j=j, value=value )
		}
	} else if( is.character( value ) && length( value ) == 1 ){
		if( missing(text.properties))
			text.properties = x$body.text.props
		
		x = addFlexCellContent (object = x, i = i, j = j
				, value = rep( value, length(i)*length(j) )
				, text.properties, newpar = newpar, byrow = byrow)
		
	} else if( is.data.frame( value ) 
			|| is.matrix( value ) || is.table( value ) 
			|| ( is.vector( value ) )
			){
		
		if( is.table(value) ) value = as.matrix(value)
		
		if( missing(text.properties))
			text.properties = x$body.text.props
		if( is.vector( value ) && length(i)*length(j) != length(value) )
			stop("value has length ", length(value), " and selection length is ", length(i)*length(j))
		else if( ( is.matrix( value ) || is.data.frame( value ) ) && length(i)*length(j) != prod(dim(value)) )
			stop("value has ", prod(dim(value)), " elements and selection length is ", length(i)*length(j))
		
		x = addFlexCellContent (object = x, i = i, j = j
				, value = value
				, text.properties, newpar = newpar, byrow = byrow)
		
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
#' @param inner.horizontal a \code{borderProperties} object
#' @param inner.vertical a \code{borderProperties} object
#' @param outer.horizontal a \code{borderProperties} object
#' @param outer.vertical a \code{borderProperties} object
#' @param body a logical value (default to TRUE), specifies 
#' to apply scheme to table body
#' @param header a logical value (default to TRUE), specifies 
#' to apply scheme to table header
#' @param footer a logical value (default to FALSE), specifies 
#' to apply scheme to table footer
#' @examples 
#' #START_TAG_TEST
#' @example examples/FlexTable.mtcars.R
#' @example examples/setFlexTableBorders1.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' , \code{\link{alterFlexTable}}, \code{\link{FlexTable}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' @export 
setFlexTableBorders = function (object
  , inner.vertical = borderProperties(), inner.horizontal = borderProperties()
  , outer.vertical = borderProperties(), outer.horizontal = borderProperties()
  , body = TRUE, header = TRUE, footer = FALSE
){

	if( !inherits(object, "FlexTable") )
		stop("argument object_v must be a FlexTable object.")
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
			, as.jborderProperties( inner.vertical )
			, as.jborderProperties( inner.horizontal )
			, as.jborderProperties( outer.vertical )
			, as.jborderProperties( outer.horizontal )
		)
	if( header )
		.jcall( object$jobj , "V", "setHeaderBorders"
				, as.jborderProperties( inner.vertical )
				, as.jborderProperties( inner.horizontal )
				, as.jborderProperties( outer.vertical )
				, as.jborderProperties( outer.horizontal )
		)
	if( footer )
		.jcall( object$jobj , "V", "setFooterBorders"
				, as.jborderProperties( inner.vertical )
				, as.jborderProperties( inner.horizontal )
				, as.jborderProperties( outer.vertical )
				, as.jborderProperties( outer.horizontal )
		)	
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
#' #START_TAG_TEST
#' @example examples/FlexTable.mtcars.R
#' @example examples/setZebraStyle.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{FlexTable}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' @export 
setZebraStyle = function (object, odd, even){
	.jcall( object$jobj , "V", "setOddEvenColor"
			, odd
			, even
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
#' #START_TAG_TEST
#' @example examples/FlexTable.mtcars.R
#' @example examples/setRowsColors.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{FlexTable}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' @export 
setRowsColors = function (object, i, colors){
	
	args.get.indexes = list(object = object)
	if( !missing(i) ) args.get.indexes$i = i
	indexes = do.call(get.indexes.from.arguments, args.get.indexes)
	i = indexes$i
	
	if( !is.character( colors ) ) {
		stop("color must be a character value.")
	} else if( any( !is.color(colors) ) ){
		stop("colors must be valid colors.")
	}
	if( length( colors ) == 1 ) colors = rep(colors, length(i) )
	if( length( colors ) != length(i) ) stop("expected ", length(i) , " colors")
	
	.jcall( object$jobj , "V", "setRowsColors"
		, .jarray( as.integer( i - 1 ) )
		, .jarray( as.character( colors ) )
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
#' #START_TAG_TEST
#' @example examples/FlexTable.mtcars.R
#' @example examples/setColumnsColors.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{FlexTable}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' @export 
setColumnsColors = function (object, j, colors){
	args.get.indexes = list(object = object)
	if( !missing(j) ) args.get.indexes$j = j
	indexes = do.call(get.indexes.from.arguments, args.get.indexes)
	j = indexes$j
	
	if( !is.character( colors ) ) {
		stop("colors must be a character value.")
	} else if( any( !is.color(colors) ) ){
		stop("colors must be valid colors.")
	}
	if( length( colors ) == 1 ) colors = rep(colors, length(j) )
	if( length( colors ) != length(j) ) stop("expected ", length(j) , " colors")
	
	.jcall( object$jobj , "V", "setColumnsColors"
			, .jarray( as.integer( j - 1 ) )
			, .jarray( as.character( colors ) )
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
#' #START_TAG_TEST
#' @example examples/FlexTable.pbc.header.R
#' @example examples/spanFlexTableRows.R
#' @example examples/STOP_TAG_TEST.R
#' @export
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{FlexTable}}, \code{\link{spanFlexTableColumns}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' @export 
spanFlexTableRows = function (object, j, from, to, runs ){

	args.get.indexes = list(object = object)
	if( !missing(j) ) args.get.indexes$j = j
	indexes = do.call(get.indexes.from.arguments, args.get.indexes)
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
		for( colid in j  )object$rowspan[, colid ] = weights
		
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
#' @examples 
#' #START_TAG_TEST
#' @example examples/FlexTable.pbc.header.R
#' @example examples/spanFlexTableRows.R
#' @example examples/STOP_TAG_TEST.R
#' @export
#' @seealso \code{\link{addHeaderRow}}, \code{\link{addFooterRow}}
#' , \code{\link{alterFlexTable}}, \code{\link{setFlexTableBorders}}
#' , \code{\link{spanFlexTableRows}}, \code{\link{FlexTable}}
#' , \code{\link{setRowsColors}}, \code{\link{setColumnsColors}}, \code{\link{setZebraStyle}}
#' , \code{\link{addFlexTable}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}}
#' @export 
spanFlexTableColumns = function (object, i, from, to){
	
	if( missing(i) && is.numeric (i) && length(i) != 1 ) {
		stop("invalid argument i, it must be a unique positive integer.")
	} 
	if( missing( from ) || missing( to ) ) {
		stop("argument from and to cannot be missing.")
	}
	.seq = seq( from, to, by = 1 )
	
	colspan = object$colspan[i,]
	colspan[.seq] = c( length(.seq), integer(length(.seq) - 1) )
	if( sum( colspan ) != object$numcol ) stop("col spanning not possible")
	else object$colspan[i, ] = colspan
	
	merged.rows = which( object$rowspan != 1 )
	merged.cols = which( object$colspan != 1 )
	overlaps = intersect(merged.rows, merged.cols)
	if( length( overlaps ) > 0 )
		stop("span overlappings, some merged cells are already merged with other cells.")
	
	.jcall( object$jobj , "V", "setColSpanInstructions"
			, as.integer( i - 1 )
			, .jarray( as.integer( object$colspan[i, ] ) )
	)
	
	
	object
}
