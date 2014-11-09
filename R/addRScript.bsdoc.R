#' @method addRScript bsdoc
#' @S3method addRScript bsdoc
addRScript.bsdoc = function(doc, rscript, file, text, ...) {
	
	if( !missing ( file ) ){
		rscript = RScript( file = file, ... )
	} else if( !missing ( text ) ){
		rscript = RScript( text = text, ... )
	} 
	
	out = .jcall( doc$jobj, "I", "add" , rscript$jobj)
	if( out != 1 ){
		stop( "Problem while trying to add rscript." )
	}
	doc
}

