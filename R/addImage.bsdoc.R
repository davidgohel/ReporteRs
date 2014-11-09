#' @method addImage bsdoc
#' @S3method addImage bsdoc
addImage.bsdoc = function(doc, filename, width, height, ... ) {

	slide = doc$jobj
	if( missing( width ) && missing(height) ){
		stop("width and height cannot be missing")
	}
	
	for( i in 1:length( filename ) ){
		jimg = .jnew(class.Image , filename[i] )
		if( !missing( width ) && !missing(height) )
			.jcall( jimg, "V", "setDim", as.integer(width), as.integer(height) )
		out = .jcall( slide, "I", "add", jimg )
		if( out != 1 )
			stop( "Problem while trying to add image(s)." )
	}
	
	
	doc
}
