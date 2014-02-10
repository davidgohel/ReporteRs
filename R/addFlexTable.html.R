#' @method addFlexTable html
#' @S3method addFlexTable html
addFlexTable.html = function(doc, flextable ) {
			
	
	out = rJava::.jcall( doc$current_slide, "I", "add", flextable$jobj )
	if( out != 1 ){
		stop( "Problem while trying to add FlexTable." )
	}

	doc
}

