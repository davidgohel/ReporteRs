# names FlexTable
# update avec un format
# header(1) et header(1)<-
# 

#' @export
FlexTable = function(data, cell_format = cellProperties(), par_format = parProperties(), text_format = textProperties() ){
	out = list()	
	flexTable = .jnew( "org/lysis/reporters/tables/FlexTable" )
	out$jobj = flexTable
	out$ncol = ncol( data )
	out$nrow = nrow( data )
	out$cell_format = cell_format
	out$par_format = par_format
	out$text_format = text_format
	
	class( out ) = c("FlexTable", "FlexElement")
	for(i in 1:nrow( data ) ){
		flexRow = FlexRow()
		for(j in 1:ncol( data ) ){
			pot_obj = pot( format(data[i,j]), format = text_format )
			flexCell = FlexCell( set_of_paragraphs( pot_obj ), parProp = par_format, cellProp = cell_format )
			flexRow[j] = flexCell
		}
		rJava::.jcall( flexTable, "V", "addBody", flexRow$jobj )
	}
	out
}

#' @method length FlexTable
#' @S3method length FlexTable
length.FlexTable <- function(x) {
	return(rJava::.jcall( x$jobj, "I", "size" ))
}

addRowFT = function( x, i, value ){
	if( missing(i) ) stop("row subset argument is missing.")
	if( !is.numeric(i) ) stop("row subset must be defined with a scalar integer argument.")
	if( length(i) != 1 ) stop("row subset length is not of length 1.")
	
	if( !inherits(value, "FlexRow") )
		stop("argument value must be an object of class 'FlexRow'.")
	
	is.body = ifelse( i > 0 , TRUE, FALSE )
	i <- as.integer( abs( i ) )
	
	if( is.body ) {
		.length = length(x)
	} else {
		.length = rJava::.jcall( x$jobj, "I", "headerSize" )
	}
	
	if( i <= .length ) {
		doReplace = TRUE
	} else doReplace = FALSE
	
	if( !doReplace && i != ( .length + 1 ) ){
		stop("Next possible subset is ", ifelse(is.body, "", "-") ,.length + 1 )
	}
	
	if( is.body ){
		if( doReplace )
			rJava::.jcall( x$jobj, "V", "addBody", value$jobj, as.integer(i) )
		else rJava::.jcall( x$jobj, "V", "addBody", value$jobj )
	} else {
		if( doReplace )
			rJava::.jcall( x$jobj, "V", "addHeader", value$jobj, as.integer(i) )
		else rJava::.jcall( x$jobj, "V", "addHeader", value$jobj )
	}
	
	x
}

addCellFT = function( x, i, j, value ){
	if( missing(i) ) stop("row subset argument is missing.")
	if( !is.numeric(i) ) stop("row subset must be defined with a scalar integer argument.")
	if( length(i) != 1 ) stop("row subset length is not of length 1.")

	if( missing(j) ) stop("column subset argument is missing.")
	if( !is.numeric(j) ) stop("column subset must be defined with a scalar integer argument.")
	if( length(j) != 1 ) stop("column subset length is not of length 1.")

	
	if( !inherits(value, "FlexCell") )
		stop("argument value must be an object of class 'FlexCell'.")
	
	is.body = ifelse( i > 0 , TRUE, FALSE )
	i <- as.integer( abs( i ) )
	
	.ncol = x$ncol
	if( is.body ) {
		.length = x$nrow
	} else {
		.length = rJava::.jcall( x$jobj, "I", "headerSize" )
	}
	
	if( i > .length ) {
		stop("argument i refers to a non existing row.")
	} 
	if( j > .ncol ) {
		stop("argument j refers to a non existing column.")
	} 

	
	if( is.body ){
		rJava::.jcall( x$jobj, "V", "setBodyCell", as.integer(i), as.integer(j), value$jobj )
	} else {
		rJava::.jcall( x$jobj, "V", "setHeaderCell", as.integer(i), as.integer(j), value$jobj )
	}
	
	x
}

addParFT = function( x, i, j, value ){
	if( missing(i) ) stop("row subset argument is missing.")
	if( !is.numeric(i) ) stop("row subset must be defined with a scalar integer argument.")
	if( length(i) != 1 ) stop("row subset length is not of length 1.")
	
	if( missing(j) ) stop("column subset argument is missing.")
	if( !is.numeric(j) ) stop("column subset must be defined with a scalar integer argument.")
	if( length(j) != 1 ) stop("column subset length is not of length 1.")
	
	
	if( !inherits(value, c( "set_of_paragraphs", "pot") ) )
		stop("argument value must be an object of class 'pot' or 'set_of_paragraphs'.")
	if( inherits(value, c( "pot") ) )
		value = set_of_paragraphs(value)
	
	is.body = ifelse( i > 0 , TRUE, FALSE )
	i <- as.integer( abs( i ) )
	
	.ncol = x$ncol
	if( is.body ) {
		.length = x$nrow
	} else {
		.length = rJava::.jcall( x$jobj, "I", "headerSize" )
	}
	
	if( i > .length ) {
		stop("argument i refers to a non existing row.")
	} 
	if( j > .ncol ) {
		stop("argument j refers to a non existing column.")
	}
	ps = ParagraphSection(value, parProp = x$par_format )
	
	if( is.body ){
		rJava::.jcall( x$jobj, "V", "setBodyText", as.integer(i), as.integer(j), ps$jobj )
	} else {
		rJava::.jcall( x$jobj, "V", "setHeaderText", as.integer(i), as.integer(j), ps$jobj )
	}
	
	x
}

#' @method [<- FlexTable
#' @S3method [<- FlexTable
"[<-.FlexTable" = function (x, i, j, value){
	
	
	if( !missing(i) && missing(j) && inherits(value, "FlexRow") ){
		if( length(i) != 1 ) stop("(While trying to insert FlexRow) row subset length is not of length 1.")
		x = addRowFT( x, i, value )
		return(x)
	} else if( !missing(i) && !missing(j) && inherits(value, "FlexCell") ){
		if( length(i) != 1 ) stop("(While trying to insert FlexCell) row subset length is not of length 1.")
		if( length(j) != 1 ) stop("(While trying to insert FlexCell) column subset length is not of length 1.")
		x = addCellFT( x, i, j, value )
		return(x)
	} else if( !missing(i) && !missing(j) && inherits(value, "set_of_paragraphs") ){
		if( length(i) != 1 ) stop("(While trying to insert set_of_paragraphs) row subset length is not of length 1.")
		if( length(j) != 1 ) stop("(While trying to insert set_of_paragraphs) column subset length is not of length 1.")
		x = addParFT( x, i, j, value )
		return(x)
	} 
	
	if( !missing(i) && !missing(j) && inherits(value, c( "data.frame", "matrix") ) ){
		if( !all( dim( value) == c(length(i), length(j)) ) ){
			stop("(While trying to insert data) dimensions of value are not matching with lengths of rows and columns subset.")
		}
		
		for( row_index in i ){
			for( col_index in j ){
				x = addParFT( x
					, row_index, col_index
					, set_of_paragraphs( pot( value[row_index, col_index], format=x$text_format ) ) 
				)
			}
		}
		
	}  
	x
}
#Si un i et pas de j, value doit etre FlexRow
#Si un i et un j, value doit etre set_of_par
#Si plusieurs i et plusieurs j, value doit etre matrix ou data.frame
#si un j et pas de i, value doit etre un vecteur
#

#' @method print FlexTable
#' @S3method print FlexTable
print.FlexTable = function(x, ...){
	out = rJava::.jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}


#' @method update FlexTable
#' @S3method update FlexTable
update.FlexTable = function( x, i, j, value ){
	if( missing(i) && missing(j) ) stop("arguments i and j are missing.")
	
	if( !missing(i) )
		if( !is.numeric(i) ) stop("argument i must be a scalar integer argument.")
	if( !missing(j) )
		if( !is.numeric(j) ) stop("argument j must be a scalar integer argument.")

	if( !missing(i) && missing(j) ){
		j = 1:x$ncol
	} else if( missing(i) && !missing(j) ){
		i = 1:length(x)
	}
	
	if( !inherits( value , "cellProperties" ) ){
		stop("value is not a cellProperties object")
	}
	for( row_index in i ){
		for( col_index in j ){
			jcellProp = .jCellProperties( value )
			jflexcell = rJava::.jcall( x$jobj, "V", "setCellProperties", as.integer( row_index ), as.integer( col_index ), jcellProp  )
		}
	}
	x
}

