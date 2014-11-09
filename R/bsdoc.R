#' @export
bsdoc = function( title = "untitled", list.definition = getOption("ReporteRs-list-definition") ){
		
	if( missing( title ) )
		stop("title is missing.")
	if( !is.character( title ) )
		stop("title must be a character vector of length 1.")
	if( length( title ) != 1 )
		stop("title must be a character vector of length 1.")
	
	lidef = do.call( list.settings, list.definition )
	
	HTMLPage = .jnew(class.html4r.HTMLPage, title, ifelse(l10n_info()$"UTF-8", "UTF-8", "ISO-8859-1"), lidef )
	.jcall( HTMLPage , "V", "addJavascript", "js/jquery.min.js" )
	.jcall( HTMLPage , "V", "addJavascript", "js/bootstrap.min.js" )
	.jcall( HTMLPage , "V", "addJavascript", "js/docs.min.js" )
	
	.jcall( HTMLPage , "V", "addJavascript", "js/raphael-min.js" )
	.jcall( HTMLPage , "V", "addJavascript", "js/g.raphael-min.js" )
	
	.jcall( HTMLPage , "V", "addStylesheet", "css/bootstrap.min.css" )
	.jcall( HTMLPage , "V", "addStylesheet", "css/docs.min.css" )
	.jcall( HTMLPage , "V", "addStylesheet", "css/bootstrap-theme.css" )
	
	.Object = list( jobj = HTMLPage )
	class( .Object ) = "bsdoc"

	.Object
}
