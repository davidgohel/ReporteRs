#' @method length FlexTable
#' @S3method length FlexTable
length.FlexTable = function(x) {
	return(x$numrow)
}

#' @method print FlexTable
#' @S3method print FlexTable
print.FlexTable = function(x, ...){
	
	cat("FlexTable object with", x$numrow, "row(s) and", x$numcol, "column(s).\n")
	cat("Row ids:", paste( head( x$row_id ), collapse = ", " ), " ... \n" )
	cat("Col ids:", paste( head( x$col_id ), collapse = ", " ), " ... \n" )
	
	if( is.jnull(x$jobj ) ) cat("java object is null. Object need to be rebuild.\n")
	
	invisible()
}

#' @method str FlexTable
#' @S3method str FlexTable
str.FlexTable = function(object, ...){
	
	print( object )
	
	invisible()
}


get.formatted.dataset = function( dataset ){
	
	format_reporters = function(x) {
		if( is.character( x) ) x
		else if( is.factor( x ) ) as.character( x )
		else if( is.logical( x ) ) ifelse( x, "TRUE", "FALSE" )
		else {
			gsub("^\\s+|\\s+$", "", format(x) )
		}
	}
	
	if( is.data.frame( dataset  ) || is.matrix(dataset) )
		data = apply( dataset, 2, format_reporters )
	else if( is.vector( dataset ) ) data = format_reporters(dataset)
	else stop("unknow format")
	data
}

get.indexes.from.arguments = function( object, i, j){
	
	if( missing(i) && missing(j) ) {
		i = 1:object$numrow
		j = 1:object$numcol
	} else if( missing(i) && !missing(j) ) {
		i = 1:object$numrow
	} else if( !missing(i) && missing(j) ) {
		j = 1:object$numcol
	}
	
	if( is.numeric (i) ){
		if( any( i < 1 | i > length(object) ) ) stop("invalid row subset - out of bound")
	} else if( is.logical (i) ){
		if( length( i ) != length(object) ) stop("invalid row subset - incorrect length")
		else i = which(i)
	} else if( is.character (i) ){
		if( any( is.na( object$row_id ) ) ) stop("null row.names")
		else if( !all( is.element(i, object$row_id ) ) ) stop("invalid row.names subset")
		else i = match(i, object$row_id )
	} else stop("row subset must be a logical vector, an integer vector or a character vector(from row.names).")
	
	if( is.numeric (j) ){
		if( any( j < 1 | j > object$numcol ) ) stop("invalid col subset - out of bound")
	} else if( is.logical (j) ){
		if( length( j ) != object$numcol ) stop("invalid col subset - incorrect length")
		else j = which(j)
	} else if( is.character (j) ){
		if( any( is.na( object$col_id ) ) ) stop("null col.names")
		else if( !all( is.element(j, object$col_id)) ) stop("invalid col.names subset")
		else j = match(j, object$col_id)
	} else stop("col subset must be a logical vector, an integer vector or a character vector(row.names).")
	
	list( i = i , j = j )
}

addFlexCellContent = function (object, i, j, value, textProperties, newpar = F, byrow = FALSE){
	
	if( !inherits(textProperties, "textProperties") )
		stop("argument textProperties must be a textProperties object.")
	
	jtext.properties = .jTextProperties( textProperties )
	
	if( byrow ){
		.jcall( object$jobj, "V", "addBodyText"
				, .jarray( as.integer( i - 1 ) )
				, .jarray( as.integer( j - 1 ) )
				, .jarray( get.formatted.dataset( value ) )
				, jtext.properties
				, as.logical(newpar)
		)
	} else {
		.jcall( object$jobj, "V", "addBodyText"
				, .jarray( as.integer( i - 1 ) )
				, .jarray( as.integer( j - 1 ) )
				, .jarray( t( get.formatted.dataset( value ) ) )
				, jtext.properties
				, as.logical(newpar) 
		)
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
		j = 1:x$numcol
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
		j = 1:x$numcol
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
		j = 1:x$numcol
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

addContent.FlexTable = function( x, i, j, value ){
	if( missing(i) && missing(j) ) stop("arguments i and j are missing.")
	
	if( !missing(i) )
		if( !is.numeric(i) ) stop("argument i must be an integer argument.")
	if( !missing(j) )
		if( !is.numeric(j) ) stop("argument j must be an integer argument.")
	
	if( !missing(i) && missing(j) ){
		j = 1:x$numcol
	} else if( missing(i) && !missing(j) ){
		i = 1:x$numrow
	}
	
	if( inherits(value, c( "pot") ) )
		value = set_of_paragraphs(value)
	
	if( !inherits(value, c( "set_of_paragraphs", "pot") ) )
		stop("argument value must be an object of class 'pot' or 'set_of_paragraphs'.")
	
	ps = ParagraphSection( value, x$body.par.props )
	.jcall( x$jobj, "V", "setBodyText"
			, as.integer( i-1 ), as.integer( j-1 ), ps$jobj  )
	
	x
}

