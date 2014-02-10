#' @export 
FlexRow = function( ){
	.Object = list()
	.Object$jobj = rJava::.jnew("org/lysis/reporters/tables/FlexRow")
	class( .Object ) = c("FlexRow", "FlexElement")
	.Object
}

#' @method length FlexRow
#' @S3method length FlexRow
length.FlexRow <- function(x) {
	return(rJava::.jcall( x$jobj, "I", "size" ))
}


#' @method [<- FlexRow
#' @S3method [<- FlexRow
"[<-.FlexRow" = function (x, i, j, value){
	if( missing(i) ) stop("subset argument is missing.")
	if( !is.numeric(i) ) stop("subset must be defined with a scalar integer argument.")
	if( length(i) != 1 ) stop("subset length is not of length 1.")
	
	i <- as.integer(i)
	
	doReplace = FALSE
	if( i <= length(x) ) {
		doReplace = TRUE
	} else if( i != ( length(x) + 1 ) ){
		stop("Next possible subset is ", length(x) + 1 )
	}
	if( doReplace ){
		rJava::.jcall( x$jobj, "V", "add", value$jobj, as.integer(i -1) )		
	} else {
		rJava::.jcall( x$jobj, "V", "add", value$jobj )
	}
	x
}


#' @method print FlexRow
#' @S3method print FlexRow
print.FlexRow = function(x, ...){
	out = rJava::.jcall( x$jobj, "S", "toString" )
	cat(out)
	invisible()
}
