#' @method addFlexTable bsdoc
#' @S3method addFlexTable bsdoc
addFlexTable.bsdoc = function(doc, flextable, ... ) {
	
	out = .jcall( doc$jobj, "I", "add", flextable$jobj )
	if( out != 1 ){
		stop( "Problem while trying to add FlexTable." )
	}

	doc
}

