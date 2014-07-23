chBodyCellProperties = function( x, i, j, value ){
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

chBodyParProperties = function( x, i, j, value ){
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

chBodyTextProperties = function( x, i, j, value ){
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

chHeaderTextProperties = function( x, i, j, value ){
	
	if( !inherits( value , "textProperties" ) ){
		stop("value is not a textProperties object")
	}
	
	jtextProp = .jTextProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setHeaderTextProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jtextProp  )
	x
}

chHeaderCellProperties = function( x, i, j, value ){
	
	if( !inherits( value , "cellProperties" ) ){
		stop("value is not a cellProperties object")
	}
	
	jcellProp = .jCellProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setHeaderCellProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jcellProp  )
	x
}

chHeaderParProperties = function( x, i, j, value ){
	
	if( !inherits( value , "parProperties" ) ){
		stop("value is not a parProperties object")
	}
	
	jparProp = .jParProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setHeaderParProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jparProp  )
	x
}

chFooterTextProperties = function( x, i, j, value ){
	
	if( !inherits( value , "textProperties" ) ){
		stop("value is not a textProperties object")
	}
	
	jtextProp = .jTextProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setFooterTextProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jtextProp  )
	x
}

chFooterCellProperties = function( x, i, j, value ){
	
	if( !inherits( value , "cellProperties" ) ){
		stop("value is not a cellProperties object")
	}
	
	jcellProp = .jCellProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setFooterCellProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jcellProp  )
	x
}

chFooterParProperties = function( x, i, j, value ){
	
	if( !inherits( value , "parProperties" ) ){
		stop("value is not a parProperties object")
	}
	
	jparProp = .jParProperties( value )
	jflexcell = .jcall( x$jobj, "V", "setFooterParProperties"
			, .jarray( as.integer( i-1 ) )
			, .jarray( as.integer( j-1 ) )
			, jparProp  )
	x
}

