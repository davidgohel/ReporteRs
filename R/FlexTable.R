#' @title FlexTable
#'
#' @description Create a representation of a table.
#' FlexTable can be manipulated so that almost any formating can be specified.
#' It allows to insert headers and footers rows with eventually merged cells (see \code{\link{FlexRow}}, \code{\link{addHeaderRow}} and \code{\link{addFooterRow}}).
#' Formating can be done on cells, paragraphs and texts (borders, colors, fonts, etc.), see ?"[<-.FlexTable".
#' Content (formated or not) can be added with the function \code{\link{addFlexCellContent}}.
#' @param data (a \code{data.frame} or \code{matrix} object) to add
#' @param numrow number of row in the table body. 
#' @param numcol number of col in the table body. 
#' @param header.columns logical value - should the colnames be included in the table 
#' as table headers. If FALSE, no headers will be printed unless you 
#' use \code{\link{addHeaderRow}}. 
#' @param add.rownames logical value - should the row.names be included in the table. 
#' @param cell_format default cells formatting properties for any data
#' @param par_format default paragraphs formatting properties for any data
#' @param text_format default texts formatting properties for any data
#' @export
#' @examples
#' #START_TAG_TEST
#' data( data_ReporteRs )
#' 
#' myFlexTable = FlexTable( data = data_ReporteRs
#' 	, span.columns = "col1", header.columns = TRUE
#'  , add.rownames = FALSE )
#' 
#' myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
#' myFlexTable[ 3:4, 4:5] = parProperties( text.align="right" )
#' myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
#' 
#' myFlexTable2 = FlexTable( data=mtcars, header.columns=TRUE, add.rownames=TRUE
#'   , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
#' )
#' 
#' myFlexTable2 = setZebraStyle( myFlexTable2, "#D1E6E7", "#93A8A9" )
#' myFlexTable2 = setFlexBorder(myFlexTable2, inner_v=borderProperties(color="#EDBD3E", style="dotted", width=1)
#'   , inner_h=borderProperties(color="#EDBD3E", style="none", width=0)
#'   , outer_v=borderProperties(color="#EDBD3E", style="solid", width=1)
#'   , outer_h=borderProperties(color="#EDBD3E", style="solid", width=1) )
#' 
#' 
#' newdata = iris[1:10,]
#' myFT3 = FlexTable( numrow = nrow(newdata), numcol =5 )
#' 
#' myFT3 = addFlexCellContent(object = myFT3
#'   , value = newdata
#'   , textProperties = textProperties( color="blue" )
#' )
#' myFT3 = addFlexCellContent(object = myFT3, i = 8:10, j=1:3
#'   , value = matrix( paste( " (", letters[1:9], ")", sep = "" ), ncol = 3 )
#'   , textProperties = textProperties( color="blue" )
#' 	)
#' myFT3 = spanRows( myFT3, j=1, from = 2, to = 5 )
#' myFT3 = spanCols( myFT3, i=6, from = 2, to = 5 )
#' myFT3[ 1:2, 2:3] = textProperties( color="blue" )
#' myFT3[ 3:4, 4:5] = parProperties( text.align="right" )
#' 
#' headerRow = FlexRow( names( newdata )
#' 	, cellProp = cellProperties(
#'         background.color="#527578"
#'       , border.color="orange"
#'       , border.bottom.style="solid"
#'       , border.bottom.width=1)
#'   )
#' myFT3 = addHeaderRow( myFT3, headerRow)
#' 
#' myFT3 = setZebraStyle( myFT3, "#8A949B", "#FAFAFA" )
#' myFT3 = setFlexBorder(myFT3
#'   , inner_v=borderProperties(color="gray", style="solid", width=1)
#'   , inner_h=borderProperties(color="gray", style="solid", width=1)
#'   , outer_v=borderProperties(color="orange", style="solid", width=1)
#'   , outer_h=borderProperties(color="orange", style="solid", width=1) 
#' )
#' 
#' #STOP_TAG_TEST
#' @seealso \code{\link{addFlexTable}}, \code{\link{FlexRow}}, \code{\link{FlexCell}}
#' , \code{\link{addHeaderRow}} and \code{\link{addFooterRow}}
#' , \code{\link{pot}}, \code{\link{set_of_paragraphs}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}} 
FlexTable = function(data, numrow, numcol
	, header.columns = TRUE, add.rownames = FALSE
	, cell_format = cellProperties()
	, par_format = parProperties()
	, text_format = textProperties()
	, header_text_format = textProperties( font.weight= "bold" )
	){
	miss_data = missing( data )
	if( !inherits(text_format, "textProperties") )
		stop("argument text_format must be a textProperties object.")
	if( !inherits(par_format, "parProperties") )
		stop("argument text_format must be a textProperties object.")
	if( !inherits(cell_format, "cellProperties") )
		stop("argument cell_format must be a cellProperties object.")

	if( miss_data && ( missing( numrow ) || missing( numcol ) ) ) {
		stop("numrow and numcol must be defined if no data is provided.")
	} else if( !miss_data && (!missing( numrow ) || !missing( numcol ) ) ) {
		warning("numrow and numcol arguments redefined with data dimensions.")
	}
	
	if( !miss_data ){
		# check data is a data.frame
		if( !is.data.frame( data ) && !is.matrix( data ) )
			stop("data is not a data.frame nor a matrix.")
		
		numrow = nrow( data )
		numcol = ncol( data )
		
		if( numrow < 1 )
			stop("data has 0 row.")

		.row_names = row.names(data)
		
		if( add.rownames ){
			.colnames = c( "", dimnames( data )[[2]] )
			numcol = numcol +1
		} else .colnames = dimnames( data )[[2]]
		if( add.rownames ){
			data = cbind(rownames = .row_names, data )
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
		, .jTextProperties(text_format)
		, .jParProperties(par_format)
		, .jCellProperties(cell_format)
		)

	out$jobj = jFlexTable

	out$cell_format = cell_format
	out$par_format = par_format
	out$text_format = text_format

	class( out ) = c("FlexTable", "FlexElement")

	if( !miss_data && header.columns ){
		headerRow = FlexRow(values = .colnames, textProp = text_format, parProp = par_format, cellProp = cell_format )
		out = addHeaderRow( out, headerRow )
	}
	
	if( !miss_data ){
		addFlexCellContent (out, seq_len(out$numrow), seq_len(out$numcol)
				, value = data
				, textProperties = text_format
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
#' @param value \code{FlexRow} object to insert as an header row
#' @export
#' @seealso \code{\link{FlexTable}}
#' @examples
#' data( data_ReporteRs )
#' myFlexTable = FlexTable( data = data_ReporteRs
#' 		, header.columns=FALSE
#' 		, add.rownames=FALSE )
#' 
#' cp1 = cellProperties(background.color="#EBEBEB")
#' 
#' headerRow = FlexRow()
#' for(i in 1:ncol(data_ReporteRs))
#'    headerRow[i] = FlexCell( pot( names(data_ReporteRs)[i]
#' 		, format=textProperties(font.weight="bold") ), cellProp = cp1 )
#' myFlexTable = addHeaderRow( myFlexTable, headerRow)
#' headerRow2 = FlexRow(names(data_ReporteRs)
#'   , format=textProperties(font.weight="bold") )
#'   , cellProp = cp1 )
#' myFlexTable = addHeaderRow( myFlexTable, headerRow2)
addHeaderRow = function( x, value ){
	
	if( !inherits(value, "FlexRow") )
		stop("argument value must be an object of class 'FlexRow'.")
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
#' @param value \code{FlexRow} object to insert as a footer row
#' @export
#' @seealso \code{\link{FlexTable}}
#' @examples
#' data( data_ReporteRs )
#' myFlexTable = FlexTable( data = data_ReporteRs
#' 		, header.columns=FALSE
#' 		, add.rownames=FALSE )
#' 
#' cp1 = cellProperties(background.color="#EBEBEB")
#' 
#' footerRow = FlexRow()
#' for(i in 1:ncol(data_ReporteRs))
#'    footerRow[i] = FlexCell( pot( paste("footer", i)
#' 		, format = textProperties(font.weight="bold") )
#' 		, cellProp = cp1 )
#' myFlexTable = addFooterRow( myFlexTable, footerRow)
addFooterRow = function( x, value ){
	
	if( !inherits(value, "FlexRow") )
		stop("argument value must be an object of class 'FlexRow'.")
	.weights = weight.FlexRow( value )
	if( .weights != x$numcol ) stop("The 'FlexRow' object has not the correct number of elements or the sum of colspan is different from the number of columns of the dataset.")
	.jcall( x$jobj, "V", "addFooter", value$jobj )
	
	x
}



#' @title modify FlexTable content
#'
#' @description add text into a FlexTable object or Format content of a FlexTable object
#' 
#' @usage \method{[}{FlexTable} (x, i, j) <- value
#' @param x the \code{FlexTable} object
#' @param i vector (integer index, row.names values or boolean vector) for rows. 
#' @param j vector (integer index, col.names values or boolean vector) for columns. 
#' @param value an object of class \code{\link{cellProperties}} or an object of class \code{\link{parProperties}} 
#' or an object of class \code{\link{textProperties}}.
#' @param textProperties formating properties (an object of class \code{textProperties}).
#' @param newpar logical value specifying wether or not the content should be added 
#' as a new paragraph
#' @param byrow logical. If FALSE (the default) content is added by columns
#' , otherwise content is added by rows.
#' @export
#' @seealso \code{\link{addFlexTable}}
#' @examples
#' data( data_ReporteRs )
#' myFlexTable = FlexTable( data = data_ReporteRs
#'   , header.columns = TRUE
#'   , add.rownames = FALSE )
#' myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
#' myFlexTable[ 3:4, 4:5] = parProperties( text.align="right" )
#' myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
#' 
#' myFlexTable[1:4, 1:2, textProperties = textProperties( color="red" )
#'   , newpar = TRUE] = c("A", "B", "C", "D", "E", "F", "G", "H")
#' myFlexTable[1:4, 3
#'   , textProperties = textProperties(vertical.align="superscript")] = c("1", "2", "3", "4")
#' 
#' @rdname FlexTable-assign
#' @method [<- FlexTable
#' @S3method [<- FlexTable
"[<-.FlexTable" = function (x, i, j, value, textProperties, newpar = F, byrow = FALSE){

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
	} else if( is.data.frame( value ) 
			|| is.matrix( value ) 
			|| ( is.vector( value ) && length(i)*length(j) == length(value) )
			){
		if( missing(textProperties))
			textProperties = x$text_format
		
		x = addFlexCellContent (object = x, i = i, j = j
				, value = value
				, textProperties, newpar = newpar, byrow = byrow)
		
	} else if( is.character( value ) && length( value ) == 1 ){
		if( missing(textProperties))
			textProperties = x$text_format
		
		x = addFlexCellContent (object = x, i = i, j = j
				, value = rep( value, length(i)*length(j) )
				, textProperties, newpar = newpar, byrow = byrow)
		
	} else stop("value must be a valid content or an object of class 'textProperties' or 'parProperties' or 'cellProperties'. See details in help file.")
	  
	x
}




addFlexCellContent = function (object, i, j, value, textProperties, newpar = F, byrow = FALSE){

	if( !inherits(textProperties, "textProperties") )
		stop("argument textProperties must be a textProperties object.")
	
	textProp = .jTextProperties( textProperties )

	if( byrow ){
		.jcall( object$jobj, "V", "addBodyText"
			, .jarray( as.integer( i - 1 ) )
			, .jarray( as.integer( j - 1 ) )
			, .jarray( get.formatted.dataset( value ) )
			, textProp
			, as.logical(newpar)
		)
	} else {
		.jcall( object$jobj, "V", "addBodyText"
			, .jarray( as.integer( i - 1 ) )
			, .jarray( as.integer( j - 1 ) )
			, .jarray( t( get.formatted.dataset( value ) ) )
			, textProp
			, as.logical(newpar) 
		)
	}
	object
}

#' @title apply borders scheme to a FlexTable
#'
#' @description apply borders scheme to a FlexTable. A border scheme is 
#' a set of 4 different borders : inner vectical and horizontal
#' , outer vectical and horizontal. 
#' 
#' @param object a \code{FlexTable} object
#' @param inner_h a \code{borderProperties} object
#' @param inner_v a \code{borderProperties} object
#' @param outer_h a \code{borderProperties} object
#' @param outer_v a \code{borderProperties} object
#' @examples 
#' myFlexTable2 = FlexTable( data=mtcars, header.columns=TRUE, add.rownames=TRUE
#'   , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
#' )
#' 
#' myFlexTable2 = setFlexBorder(myFlexTable2, inner_v=borderProperties(style="none")
#'   , inner_h=borderProperties(color="#EDBD3E", style="dotted")
#'   , outer_v=borderProperties(color="#EDBD3E", style="solid")
#'   , outer_h=borderProperties(color="#EDBD3E", style="solid") )
#' 
#' @seealso \code{\link{FlexTable}}
#' @export 
setFlexBorder = function (object, inner_v = borderProperties(), inner_h = borderProperties(), outer_v = borderProperties(), outer_h = borderProperties()){

	if( !inherits(object, "FlexTable") )
		stop("argument object_v must be a FlexTable object.")
	if( !inherits(inner_v, "borderProperties") )
		stop("argument inner_v must be a borderProperties object.")
	if( !inherits(inner_h, "borderProperties") )
		stop("argument inner_v must be a borderProperties object.")
	if( !inherits(outer_v, "borderProperties") )
		stop("argument inner_v must be a borderProperties object.")
	if( !inherits(outer_h, "borderProperties") )
		stop("argument inner_v must be a borderProperties object.")
	
	.jcall( object$jobj , "V", "setBorders"
			, as.jborderProperties( inner_v )
			, as.jborderProperties( inner_h )
			, as.jborderProperties( outer_v )
			, as.jborderProperties( outer_h )
	)
	
	object
}

#' @title color alternate rows on a table
#'
#' @description Zebra striping — coloring alternate rows on a table
#' 
#' @param object a \code{FlexTable} object
#' @param odd background color applied to odd rows - single character value (e.g. "#000000" or "black")
#' @param even background color applied to even rows - single character value (e.g. "#000000" or "black")
#' @examples 
#' myFlexTable2 = FlexTable( data = mtcars, header.columns=TRUE, add.rownames=TRUE
#'   , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
#' )
#' myFlexTable2 = setZebraStyle( myFlexTable2, "#D1E6E7", "#93A8A9" )
#' @seealso \code{\link{FlexTable}}, \code{\link{setRowColors}}, \code{\link{setColColors}}
#' , \code{\link{[<-.FlexTable}}
#' @export 
setZebraStyle = function (object, odd, even){
	
	.jcall( object$jobj , "V", "setOddEvenColor"
			, odd
			, even
		)
	
	object
}

#' @title color rows on a table
#'
#' @description color rows on a table
#' 
#' @param object a \code{FlexTable} object
#' @param i row index
#' @param colors background colors to apply (e.g. "#000000" or "black")
#' @examples 
#' myFlexTable2 = FlexTable( data=mtcars, header.columns=TRUE, add.rownames=TRUE
#'   , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
#' )
#' myFlexTable2 = setRowColors( myFlexTable2, i=5:7, colors=rep( "red", 3) )
#' @seealso \code{\link{FlexTable}}
#' @export 
setRowColors = function (object, i, colors){
	
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

#' @title color columns on a table
#'
#' @description color columns on a table
#' 
#' @param object a \code{FlexTable} object
#' @param j col index
#' @param colors background colors to apply (e.g. "#000000" or "black")
#' @examples 
#' myFlexTable2 = FlexTable( data=mtcars, header.columns=TRUE, add.rownames=TRUE
#'   , cell_format=cellProperties(background.color="#5B7778", border.color="#EDBD3E")
#' )
#' myFlexTable2 = setColColors( myFlexTable2, j=3, colors=rep( "red", nrow(mtcars)) )
#' @seealso \code{\link{FlexTable}}
#' @export 
setColColors = function (object, j, colors){
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
#' @param object a \code{FlexTable} object
#' @param j vector (integer index, col.names values or boolean vector) for columns. 
#' @param from first row to span (its content will be the visible one).  
#' @param to last row to span.  
#' @export
#' @seealso \code{\link{FlexTable}}
#' @export 
spanRows = function (object, j, from, to){

	args.get.indexes = list(object = object)
	if( !missing(j) ) args.get.indexes$j = j
	indexes = do.call(get.indexes.from.arguments, args.get.indexes)
	j = indexes$j
	
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
		
		.jcall( object$jobj , "V", "setRowSpanInstructions"
			, as.integer( colid - 1 )
			, .jarray( as.integer( object$rowspan[, colid ] ) )
		)
	}
	object
}


#' @title Span rows within columns
#'
#' @description Span columns within rows. 
#' 
#' @param object a \code{FlexTable} object
#' @param i vector integer index for columns. 
#' @param from first col to span (its content will be the visible one).  
#' @param to last col to span.  
#' @export
#' @seealso \code{\link{FlexTable}}
#' @export 
spanCols = function (object, i, from, to){
	
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
	
	.jcall( object$jobj , "V", "setColSpanInstructions"
			, as.integer( i - 1 )
			, .jarray( as.integer( object$colspan[i, ] ) )
	)
	
	
	object
}



