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
#' @seealso \code{\link{addFlexTable}}, \code{\link{FlexRow}}, \code{\link{FlexCell}}
#' , \code{\link{pot}}, \code{\link{set_of_paragraphs}}, \code{\link{addFlexTable.docx}}
#' , \code{\link{addFlexTable.pptx}}, \code{\link{addFlexTable.html}} 
#' @examples
#' data( data_ReporteRs )
#' myFlexTable = FlexTable( data = data_ReporteRs
#' 	, span.columns = "col1"
#' 	, header.columns = TRUE
#'  , row.names = FALSE )
#' myFlexTable[ 1:2, 2:3] = textProperties( color="red" )
#' myFlexTable[ 4:5, 4:5] = parProperties( text.align="right" )
#' myFlexTable[ 1:2, 5:6] = cellProperties( background.color="#F2969F")
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
	

	if( row.names ){
		data = cbind(rownames = row.names(data), data )
	}
	row.names( data ) = NULL
	
	out = list(
			ncol = ncol( data )
			, nrow = nrow( data )
	)
	
	data = apply( data, 2, function(x) {
				if( is.character( x) || is.factor( x ) ) x
				else if( is.logical( x ) ) ifelse( x, "TRUE", "FALSE" )
				else format(x)
			} )
	.colnames = dimnames( data )[[2]]
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
		headerRow = FlexRow()
		for( j in 1:out$ncol )
			headerRow[j] = FlexCell(pot( .colnames[j], text_format )
				, parProp = par_format, cellProp = cell_format )
		
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
#' @param i vector integer index for rows. 
#' @param j vector integer index for columns. 
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
#' myFlexTable[ 4:5, 4:5] = parProperties( text.align="right" )
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
	
	if( !is.numeric(i) ) stop("argument i must be an integer argument.")
	if( !is.numeric(j) ) stop("argument j must be an integer argument.")
	
	
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
#' @description Replace a cell content of a FlexTable object 
#' with one or more paragraph of texts.
#' 
#' @param object a \code{FlexTable} object
#' @param i vector integer index for rows. It must be a single value. 
#' @param j vector integer index for columns. It must be a single value.
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
	
	if( missing(i) || missing(j) ){
		stop("argument i and j can't be missing when inserting content.")
	} 
	if( !is.numeric(i) || length( i ) != 1 ) stop("argument i must be a single integer argument.")
	if( !is.numeric(j) || length( j ) != 1 ) stop("argument j must be a single integer argument.")

	if( inherits(value, c("pot", "set_of_paragraphs") ) ){
		object = updateContent.FlexTable( x=object, i=i, j=j, value=value )
	} else {
		stop("value must be an object of class 'pot' or 'set_of_paragraphs'.")
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

