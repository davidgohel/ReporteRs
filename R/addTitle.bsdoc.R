#' @method addTitle bsdoc
#' @S3method addTitle bsdoc
addTitle.bsdoc = function( doc, value, level = 1, ... ) {

	if( !is.numeric( level ) )
		stop("level must be an integer vector of length 1.")
	if( length( level ) != 1 )
		stop("level must be an integer vector of length 1.")
	if( is.character( value ) )
		jtitle = .jnew(class.html4r.Title, as.character(value), as.integer(level)  )
	else jtitle = .jnew(class.html4r.Title, .jpot(value), as.integer(level)  )
	out = .jcall( doc$jobj , "I", "add", jtitle )
	if( out != 1 ){
		stop( "Problem while trying to add title." )
	}
	doc
}


