#' @title Add a plot into an html object
#'
#' @description
#' Add a plot into the \code{html} object.
#' 
#' @param doc Object of class \code{html} where paragraph has to be added
#' @param fun plot function. The function will be executed to produce graphics. 
#' For \code{grid} or \code{lattice} or \code{ggplot} object, the function 
#' should just be print and an extra argument x should specify the object 
#' to plot. For traditionnal plots, the function should contain plot instructions. See examples.
#' @param width plot width in inches (default value is 6).
#' @param height plot height in inches (default value is 6).
#' @param vector.graphic logical scalar, default to FALSE. If TRUE, vector graphics 
#' are produced instead of PNG images. If TRUE, vector graphics are 
#' RaphaelJS instructions(transformed as SVG). 
#' @param pointsize the default pointsize of plotted text in pixels, default to 12.
#' @param fontname the default font family to use, default to getOption("ReporteRs-default-font").
#' @param par.properties paragraph formatting properties of the paragraph that contains images. 
#' An object of class \code{\link{parProperties}}
#' @param ... arguments for \code{fun}.
#' @return an object of class \code{\link{html}}.
#' @examples
#' #START_TAG_TEST
#' doc.dirname = "addPlot_example"
#' @example examples/html.R
#' @example examples/addPage.R
#' @example examples/addTitle1Level1.R
#' @example examples/addBasePlot_vg.R
#' @example examples/addTitle2Level1.R
#' @example examples/addggplot.R
#' @example examples/addTitle3Level1.R
#' @example examples/addLMPlot.R
#' @example examples/writeDoc_directory.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{addPlot}}, \code{\link{add.plot.interactivity}}
#' @method addPlot html
#' @S3method addPlot html
addPlot.html = function(doc, fun, pointsize=getOption("ReporteRs-fontsize"), vector.graphic = T, width=6, height=6, 
		fontname = getOption("ReporteRs-default-font"), 
		par.properties = parCenter( padding = 5 ), ... ) {

	
	plotargs = list(...)

	dirname = tempfile( )
	dir.create( dirname )
	
	pixelsize = FontMetric( fontname, pointsize )$info[3]

	if( !vector.graphic ){
	
		filename = paste( dirname, "/plot%03d.png" ,sep = "" )
		grDevices::png (filename = filename
				, width = width, height = height, units = 'in'
				, pointsize = pixelsize, res = 300
		)
		
		fun_res = try( fun(...), silent = T )
		dev.off()
		plotfiles = list.files( dirname , full.names = T )
		doc = addImage( doc, plotfiles, width = width*72, height = height*72, par.properties = par.properties )
	} else {
		filename = file.path( dirname, "plot", fsep = "/" )
		env = raphael( file = filename,width=width*72.2
			, height = height*72.2
			, ps=pixelsize, fontname = fontname
			, canvas_id = as.integer(doc$canvas_id) )
		fun(...)
		last_canvas_id = .C("get_current_canvas_id", (dev.cur()-1L), 0L)[[2]]
		.C("trigger_last_post_commands", (dev.cur()-1L) )
		
		dev.off()
		plot_ids = get("plot_ids", envir = env )
		if( last_canvas_id < 0 ) stop("unexpected error, could not find device information.")
		else doc$canvas_id = last_canvas_id;

		jimg = .jnew( class.html4r.RAPHAELGraphics, .jParProperties(par.properties)  )
		
		for(i in 1:length( plot_ids ) ){
			file = as.character(paste(readLines(plot_ids[[i]]$filename), collapse = "\n"))
			div.id = plot_ids[[i]]$div.id
			
			.jcall( jimg, "V", "registerGraphic", as.character(div.id), file )
		}
		out = .jcall( doc$current_slide, "I", "add", jimg )
		if( out != 1 ){
			stop( "Problem while trying to add plot." )
		}
		
	}
	doc
}



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
#' @seealso \code{\link{html}}, \code{\link{addPlot}}, \code{\link{add.plot.interactivity}}
#' , \code{\link{addPlot.html}}
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
