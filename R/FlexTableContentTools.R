

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


getncheckid = function( object, i, j, numrow, partname ){
	
	if( numrow < 1 ) stop("FlexTable object has no ", partname, " row.")
	
	if( missing(i) && missing(j) ) {
		i = 1:numrow
		j = 1:object$numcol
	} else if( missing(i) && !missing(j) ) {
		i = 1:numrow
	} else if( !missing(i) && missing(j) ) {
		j = 1:object$numcol
	}
	
	if( is.numeric (i) ){
		if( any( i < 1 | i > length(object) ) ) stop("invalid ", partname, " row subset - out of bound")
	} else if( is.logical (i) ){
		if( length( i ) != length(object) ) stop("invalid ", partname, " row subset - incorrect length")
		else i = which(i)
	} else if( partname=="body" && is.character (i) ){
		if( any( is.na( object$row_id ) ) ) stop("null row.names")
		else if( !all( is.element(i, object$row_id ) ) ) stop("invalid row.names subset")
		else i = match(i, object$row_id )
	} else if( partname =="body" ) stop("row subset must be a logical vector, an integer vector or a character vector(from row.names).")
	else stop(partname, " row subset must be a logical vector or an integer vector.")
	
	if( is.numeric (j) ){
		if( any( j < 1 | j > object$numcol ) ) stop("invalid ", partname, " columns subset - out of bound")
	} else if( is.logical (j) ){
		if( length( j ) != object$numcol ) stop("invalid ", partname, " columns subset - incorrect length")
		else j = which(j)
	} else if( is.character (j) ){
		if( any( is.na( object$col_id ) ) ) stop("null col.names")
		else if( !all( is.element(j, object$col_id)) ) stop("invalid ", partname, " col.names subset")
		else j = match(j, object$col_id)
	} else stop(partname, " col subset must be a logical vector, an integer vector or a character vector(colnames).")
	
	list( i = i , j = j )
}


