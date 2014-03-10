#' @title FlexTable
#'
#' @description Create a representation of a table.
#' FlexTable can be manipulated so that almost any formating can be specified.
#' It allows to insert headers and footers rows (with merged cells).
#' Formating can be done on cells, paragraphs and texts (borders, colors, fonts, etc.)
#' 
#' @param data (a \code{data.frame} or \code{matrix} object) to add
#' @param span.columns a character vector specifying columns names where row merging 
#' should be done (if successive values in a column are the same ; if data[p,j]==data[p-1,j] )
#' @param header.columns logical value - should the colnames be included in the table 
#' as table headers. If FALSE, no headers will be printed unless you 
#' use \code{\link{addHeaderRow}}. 
#' @param row.names logical value - should the row.names be included in the table. 
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
#'  , row.names = FALSE )
#' 
#' myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
#' myFlexTable[ 3:4, 4:5] = parProperties( text.align="right" )
#' myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
#' #STOP_TAG_TEST
#' @seealso \code{\link{addFlexTable}}, \code{\link{FlexRow}}, \code{\link{FlexCell}}
#' , \code{\link{pot}}, \code{\link{set_of_paragraphs}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}} 
FlexTable = function(data, span.columns = character(0)
	, header.columns = TRUE, row.names = FALSE
	, cell_format = cellProperties()
	, par_format = parProperties()
	, text_format = textProperties()
	){

	#### data checking
	if( missing( data ) ) stop("data is missing.")
	
	
	# check data is a data.frame
	if( !is.data.frame( data ) && !is.matrix( data ) )
		stop("data is not a data.frame nor a matrix.")
	# check data is a data.frame
	if( nrow( data )<1)
		stop("data has 0 row.")

	#### check span.columns
	if( !missing( span.columns ) ){
		if( !is.character( span.columns ) )
			stop( "span.columns must be a character vector")
		
		.ie.span.columns = is.element( span.columns , names( data ) )
		if( !all ( .ie.span.columns ) ){
			stop("span.columns contains unknown columns names :", paste( span.columns[!.ie.span.columns], collapse = "," ) )
		}	
	}

	if( !inherits(text_format, "textProperties") )
		stop("argument text_format must be a textProperties object.")
	if( !inherits(par_format, "parProperties") )
		stop("argument text_format must be a textProperties object.")
	if( !inherits(cell_format, "cellProperties") )
		stop("argument cell_format must be a cellProperties object.")
	
	.row_names = row.names(data)
	if( row.names ){
		data = cbind(rownames = .row_names, data )
	}
	row.names( data ) = NULL
	
	out = list(
			ncol = ncol( data )
			, nrow = nrow( data )
			, row.names = row.names
			, row_id = .row_names
	)
	
	data = apply( data, 2, function(x) {
				if( is.character( x) || is.factor( x ) ) x
				else if( is.logical( x ) ) ifelse( x, "TRUE", "FALSE" )
				else format(x)
			} )
	.colnames = dimnames( data )[[2]]
	out$col_id = .colnames
	if( row.names ){
		.colnames[1]=""
	}
	
	
	jFlexTable = .jnew( class.FlexTable
		, as.integer( out$nrow ), as.integer( out$ncol )
		, .jarray( as.character( t( data ) ) )
		, .jTextProperties(text_format), .jParProperties(par_format), .jCellProperties(cell_format)
		)

	for(j in span.columns ){
		instructions = list()
		current.col = data[, j]
		groups = cumsum( c(TRUE, current.col[-length(current.col)] != current.col[-1] ) )
		groups.counts = tapply( groups, groups, length )
		
		for(i in 1:length( groups.counts )){
			if( groups.counts[i] == 1 ) 
				instructions[[i]] = 1
			else {
				instructions[[i]] = c(groups.counts[i] , rep(0, groups.counts[i]-1 ) )
			}
		}
		
		.jcall( jFlexTable , "V", "setRowSpanInstructions"
				, as.integer( match( j , .colnames ) - 1 )
				, .jarray( as.integer( unlist( instructions ) ) )
		)

	}
	
	out$jobj = jFlexTable

	out$cell_format = cell_format
	out$par_format = par_format
	out$text_format = text_format

	class( out ) = c("FlexTable", "FlexElement")
	
	if( header.columns ){
		headerRow = FlexRow(values = .colnames, textProp = text_format, parProp = par_format, cellProp = cell_format )
		out = addHeaderRow( out, headerRow )
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
#' 		, row.names=FALSE )
#' 
#' cp1 = cellProperties(background.color="#EBEBEB")
#' 
#' headerRow = FlexRow()
#' for(i in 1:ncol(data_ReporteRs))
#'    headerRow[i] = FlexCell( pot( names(data_ReporteRs)[i]
#' 		, format=textProperties(font.weight="bold") ), cellProp = cp1 )
#' myFlexTable = addHeaderRow( myFlexTable, headerRow)
addHeaderRow = function( x, value ){
	
	if( !inherits(value, "FlexRow") )
		stop("argument value must be an object of class 'FlexRow'.")
	.weights = weight.FlexRow( value )
	if( .weights == x$ncol - 1 ) warning("Did you forget row.names header?")
	if( .weights != x$ncol ) stop("The 'FlexRow' object has not the correct number of elements or the sum of colspan is different from the number of columns of the dataset.")
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
#' 		, row.names=FALSE )
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
	if( .weights != x$ncol ) stop("The 'FlexRow' object has not the correct number of elements or the sum of colspan is different from the number of columns of the dataset.")
	.jcall( x$jobj, "V", "addFooter", value$jobj )
	
	x
}


#' @method length FlexTable
#' @S3method length FlexTable
length.FlexTable <- function(x) {
	return(x$nrow)
}

#' @method print FlexTable
#' @S3method print FlexTable
print.FlexTable = function(x, ...){
	out = .jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}



#' @title Format FlexTable content
#'
#' @description Format content of a FlexTable object
#' 
#' @usage \method{[}{FlexTable} (x, i, j) <- value
#' @param x the \code{FlexTable} object
#' @param i vector (integer index, row.names values or boolean vector) for rows. 
#' @param j vector (integer index, col.names values or boolean vector) for columns. 
#' @param value an object of class \code{\link{cellProperties}} or an object of class \code{\link{parProperties}} 
#' or an object of class \code{\link{textProperties}}.
#' @export
#' @seealso \code{\link{addFlexTable}}
#' @examples
#' data( data_ReporteRs )
#' myFlexTable = FlexTable( data = data_ReporteRs
#' 	, span.columns = "col1"
#' , header.columns = TRUE
#' , row.names = FALSE )
#' myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
#' myFlexTable[ 3:4, 4:5] = parProperties( text.align="right" )
#' myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
#' @rdname FlexTable-assign
#' @method [<- FlexTable
#' @S3method [<- FlexTable
"[<-.FlexTable" = function (x, i, j, value){

	if( missing(i) && missing(j) ) {
		i = 1:length(x)
		j = 1:x$ncol
	} else if( missing(i) && !missing(j) ) {
		i = 1:length(x)
	} else if( !missing(i) && missing(j) ) {
		j = 1:x$ncol
	} 
	
	if( is.numeric (i) ){
		if( any( i < 1 | i > length(x) ) ) stop("invalid row subset - out of bound")
	} else if( is.logical (i) ){
		if( length( i ) != length(x) ) stop("invalid row subset - incorrect length")
		else i = ( 1:length(x) )[i]
	} else if( is.character (i) ){
		if( !all( is.element(i, x$row_id)) ) stop("invalid row.names subset")
		else i = match(i, x$row_id)
	} else stop("row subset must be a logical vector, an integer vector or a character vector(row.names).")
	
	if( is.numeric (j) ){
		if( any( j < 1 | j > x$ncol ) ) stop("invalid col subset - out of bound")
	} else if( is.logical (j) ){
		if( length( j ) != x$ncol ) stop("invalid col subset - incorrect length")
		else j = ( 1:x$ncol )[j]
	} else if( is.character (j) ){
		if( !all( is.element(j, x$col_id)) ) stop("invalid col.names subset")
		else j = match(j, x$col_id)
	} else stop("col subset must be a logical vector, an integer vector or a character vector(row.names).")
	
	
	if( inherits(value, c("textProperties", "parProperties", "cellProperties")) ){
		
		if( inherits(value, "textProperties" ) ){
			x = updateTextProperties.FlexTable( x=x, i=i, j=j, value=value )
		} else if( inherits(value, "parProperties" ) ){
			x = updateParProperties.FlexTable( x=x, i=i, j=j, value=value )
		} else {
			x = updateCellProperties.FlexTable( x=x, i=i, j=j, value=value )
		}

	} else stop("value must be an object of class 'textProperties' or 'parProperties' or 'cellProperties'.")
	  
	x
}



#' @title Replace FlexTable content 
#'
#' @description Replace cells contents of a FlexTable object 
#' with one or more paragraph of texts.
#' 
#' @param object a \code{FlexTable} object
#' @param i vector (integer index, row.names values or boolean vector) for rows. 
#' @param j vector (integer index, col.names values or boolean vector) for columns. 
#' @param value a \code{\link{pot}} or a \code{\link{set_of_paragraphs}} object to insert as new cell content. 
#' @export
#' @seealso \code{\link{addFlexTable}}
#' @examples
#' data( data_ReporteRs )
#' myFlexTable = FlexTable( data = data_ReporteRs
#' 	, span.columns = "col1"
#' , header.columns = TRUE
#' , row.names = FALSE )
#' myFlexTable = setFlexCellContent( myFlexTable
#' , i = 1, j = 1
#' , pot("Hello World", format = textProperties( color="red" ) )
#' )
#' @export 
setFlexCellContent = function (object, i, j, value){
	
	if( missing(i) && missing(j) ) {
		i = 1:length(object)
		j = 1:object$ncol
	} else if( missing(i) && !missing(j) ) {
		i = 1:length(object)
	} else if( !missing(i) && missing(j) ) {
		j = 1:object$ncol
	} 

	if( is.numeric (i) ){
		if( any( i < 1 | i > length(object) ) ) stop("invalid row subset - out of bound")
	} else if( is.logical (i) ){
		if( length( i ) != length(object) ) stop("invalid row subset - incorrect length")
		else i = ( 1:length(object) )[i]
	} else if( is.character (i) ){
		if( !all( is.element(i, object$row_id)) ) stop("invalid row.names subset")
		else i = match(i, object$row_id)
	} else stop("row subset must be a logical vector, an integer vector or a character vector(from row.names).")
	
	if( is.numeric (j) ){
		if( any( j < 1 | j > object$ncol ) ) stop("invalid col subset - out of bound")
	} else if( is.logical (j) ){
		if( length( j ) != object$ncol ) stop("invalid col subset - incorrect length")
		else j = ( 1:object$ncol )[j]
	} else if( is.character (j) ){
		if( !all( is.element(j, object$col_id)) ) stop("invalid col.names subset")
		else j = match(j, object$col_id)
	} else stop("col subset must be a logical vector, an integer vector or a character vector(row.names).")
	
	
	if( inherits(value, c("pot", "set_of_paragraphs") ) ){
		for( row_index in i )
			for( col_index in j)
				object = updateContent.FlexTable( x = object, i = row_index, j = col_index, value = value )
	} else {
		stop("value must be an object of class 'pot' or 'set_of_paragraphs'.")
	}
	
	object
}





#' @title Add content in a FlexTable  
#'
#' @description add texts or paragraphs in cells contents of a FlexTable object 

#' @param object a \code{FlexTable} object
#' @param i vector (integer index, row.names values or boolean vector) for rows. 
#' @param j vector (integer index, col.names values or boolean vector) for columns. 
#' @param value text values or values that have a \code{format} method 
#' returning character value.
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
#' 	, span.columns = "col1"
#' 	, header.columns = TRUE
#' 	, row.names = FALSE )
#' myFlexTable = addFlexCellContent( myFlexTable
#' 	, i = 1:4, j = 1
#' 	, value = c("A", "B", "C", "D")
#' 	, textProperties = textProperties( color="red" )
#' 	)
#' myFlexTable = addFlexCellContent( myFlexTable
#' 	, i = 1:4, j = 2
#' 	, value = c("E", "F", "G", "H")
#' 	, textProperties = textProperties( color="red" )
#' 	, newpar = TRUE
#' 	)
#' @export 
addFlexCellContent = function (object, i, j, value, textProperties, newpar = F, byrow = FALSE){
	
	if( missing(i) && missing(j) ) {
		i = 1:length(object)
		j = 1:object$ncol
	} else if( missing(i) && !missing(j) ) {
		i = 1:length(object)
	} else if( !missing(i) && missing(j) ) {
		j = 1:object$ncol
	}
	
	if( is.numeric (i) ){
		if( any( i < 1 | i > length(object) ) ) stop("invalid row subset - out of bound")
	} else if( is.logical (i) ){
		if( length( i ) != length(object) ) stop("invalid row subset - incorrect length")
		else i = ( 1:length(object) )[i]
	} else if( is.character (i) ){
		if( !all( is.element(i, object$row_id)) ) stop("invalid row.names subset")
		else i = match(i, object$row_id)
	} else stop("row subset must be a logical vector, an integer vector or a character vector(from row.names).")
	
	if( is.numeric (j) ){
		if( any( j < 1 | j > object$ncol ) ) stop("invalid col subset - out of bound")
	} else if( is.logical (j) ){
		if( length( j ) != object$ncol ) stop("invalid col subset - incorrect length")
		else j = ( 1:object$ncol )[j]
	} else if( is.character (j) ){
		if( !all( is.element(j, object$col_id)) ) stop("invalid col.names subset")
		else j = match(j, object$col_id)
	} else stop("col subset must be a logical vector, an integer vector or a character vector(row.names).")
	
	value = format( value )
	if( !is.character( value ) ){
		stop("value must be a character vector or must have a format method returning a string value.")
	} 
	
	if( !inherits(textProperties, "textProperties") )
		stop("argument textProperties must be a textProperties object.")
	
	textProp = .jTextProperties( textProperties )
	if( byrow ){
		for( row_index in i ){
			for( col_index in j){
				.jcall( object$jobj, "V", "addBodyText"
						, as.integer( row_index - 1 ) #i
						, as.integer( col_index - 1 ) #j
						, value[ (row_index-1) * object$ncol + col_index ] #par
						, textProp #tp
						, as.logical(newpar) #newPar
					)
			}
		}
	} else {
		for( col_index in j){
			for( row_index in i ){
				.jcall( object$jobj, "V", "addBodyText"
						, as.integer( row_index - 1 ) #i
						, as.integer( col_index - 1 ) #j
						, value[ (col_index - 1) + row_index ] #par
						, textProp #tp
						, as.logical(newpar) #newPar
				)
			}
		}
	}
	object
}







updateCellProperties.FlexTable = function( x, i, j, value ){
	if( missing(i) && missing(j) ) stop("arguments i and j are missing.")
	
	if( !missing(i) )
		if( !is.numeric(i) ) stop("argument i must be an integer argument.")
	if( !missing(j) )
		if( !is.numeric(j) ) stop("argument j must be an integer argument.")
	
	if( !missing(i) && missing(j) ){
		j = 1:x$ncol
	} else if( missing(i) && !missing(j) ){
		i = 1:length(x)
	}
	
	if( !inherits( value , "cellProperties" ) ){
		stop("value is not a cellProperties object")
	}
	jcellProp = .jCellProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setCellProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jcellProp  )
	
	x
}

updateParProperties.FlexTable = function( x, i, j, value ){
	if( missing(i) && missing(j) ) stop("arguments i and j are missing.")
	
	if( !missing(i) )
		if( !is.numeric(i) ) stop("argument i must be an integer argument.")
	if( !missing(j) )
		if( !is.numeric(j) ) stop("argument j must be an integer argument.")
	
	if( !missing(i) && missing(j) ){
		j = 1:x$ncol
	} else if( missing(i) && !missing(j) ){
		i = 1:length(x)
	}
	
	if( !inherits( value , "parProperties" ) ){
		stop("value is not a parProperties object")
	}
	
	jparProp = .jParProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setParProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jparProp  )
	
	x
}

updateTextProperties.FlexTable = function( x, i, j, value ){
	if( missing(i) && missing(j) ) stop("arguments i and j are missing.")
	
	if( !missing(i) )
		if( !is.numeric(i) ) stop("argument i must be an integer argument.")
	if( !missing(j) )
		if( !is.numeric(j) ) stop("argument j must be an integer argument.")
	
	if( !missing(i) && missing(j) ){
		j = 1:x$ncol
	} else if( missing(i) && !missing(j) ){
		i = 1:length(x)
	}
	
	if( !inherits( value , "textProperties" ) ){
		stop("value is not a textProperties object")
	}
	
	jtextProp = .jTextProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setTextProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jtextProp  )
	
	x
}


updateContent.FlexTable = function( x, i, j, value ){
	if( missing(i) && missing(j) ) stop("arguments i and j are missing.")
	
	if( !missing(i) )
		if( !is.numeric(i) ) stop("argument i must be an integer argument.")
	if( !missing(j) )
		if( !is.numeric(j) ) stop("argument j must be an integer argument.")
	
	if( !missing(i) && missing(j) ){
		j = 1:x$ncol
	} else if( missing(i) && !missing(j) ){
		i = 1:length(x)
	}
	
	if( inherits(value, c( "pot") ) )
		value = set_of_paragraphs(value)
	
	if( !inherits(value, c( "set_of_paragraphs", "pot") ) )
		stop("argument value must be an object of class 'pot' or 'set_of_paragraphs'.")
	
	ps = ParagraphSection( value, x$par_format )
	.jcall( x$jobj, "V", "setBodyText"
			, as.integer( i-1 ), as.integer( j-1 ), ps$jobj  )
	
	x
}

#setInnerBorder = function( border.width = 1, border.style = "solid", border.color = "black"){
#
#	if( is.numeric( border.width ) ) {
#		if( as.integer( border.width ) < 0 || !is.finite( as.integer( border.width ) ) ) stop("invalid border.width : ", border.width )
#	} else {
#		stop("border.width must be a integer value >= 0")
#	}
#	
#	if( is.character( border.style ) ) {
#		match.arg( border.style, choices = border.styles, several.ok = F )
#	} else {
#		stop("border.style must be a character value.")
#	}
#	
#	if( !is.color( border.color ) )
#		stop("border.color must be a valid color.")
#	
#	
#}