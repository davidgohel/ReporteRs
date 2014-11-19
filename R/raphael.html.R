#' @title get HTML code from a plot
#'
#' @description
#' get HTML code from a plot
#' 
#' @param fun plot function
#' @param width plot width in inches (default value is 6).
#' @param height plot height in inches (default value is 6).
#' @param pointsize the default pointsize of plotted text in points, default to 12.
#' @param fontname the default font family to use, default to getOption("ReporteRs-default-font").
#' @param canvas_id canvas id - an integer - unique id in the web page
#' @param par.properties paragraph formatting properties of the paragraph that contains images. 
#' An object of class \code{\link{parProperties}}
#' @param ... arguments for \code{fun}.
#' @return an html string. 
#' @examples
#' #START_TAG_TEST
#' @example examples/raphael.html.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addPlot}}, \code{\link{add.plot.interactivity}}
#' , \code{\link{addPlot.bsdoc}}
#' @export 
raphael.html = function( fun, pointsize=getOption("ReporteRs-fontsize"), 
	width=6, height=6, fontname = getOption("ReporteRs-default-font"), 
	canvas_id = 0, 
	par.properties = parCenter( padding = 5 ), 
	... ) {
	
	plotargs = list(...)
	
	dirname = tempfile( )
	dir.create( dirname )
	pointsize = FontMetric( fontname, pointsize )$info[3]
	
	filename = file.path( dirname, "plot", fsep = "/" )
	env = raphael( file = filename,width=width*72.2
			, height = height*72.2
			, ps=pointsize, fontname = fontname
			, canvas_id = as.integer(canvas_id) )
	fun(...)
	.C("trigger_last_post_commands", (dev.cur()-1L) )
	dev.off()
	plot_ids = get("plot_ids", envir = env )
	
	jimg = .jnew( class.html4r.RAPHAELGraphics, .jParProperties(par.properties)  )
	
	for(i in 1:length( plot_ids ) ){
		file = as.character(paste(readLines(plot_ids[[i]]$filename), collapse = "\n"))
		div.id = plot_ids[[i]]$div.id
		
		.jcall( jimg, "V", "registerGraphic", as.character(div.id), file )
	}
	js.code = .jcall( jimg, "S", "getJS" )
	out = .jcall( jimg, "S", "getHTML" )
	out = paste( out, "<script type=\"text/javascript\">", sep = "" )
	out = paste( out, js.code, sep = "" )
	out = paste( out, "</script>", sep = "" )
	attr( out, "div_id" ) = sapply( plot_ids, function(x) x$div.id )
	attr( out, "js_id" ) = sapply( plot_ids, function(x) x$js.plotid )
	out
}
