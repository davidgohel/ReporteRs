#' @title Add a plot into an html object
#'
#' @description
#' Add a plot into the \code{html} object.
#' 
#' @param doc Object of class \code{"html"} where paragraph has to be added
#' @param fun plot function
#' @param width plot width in inches (default value is 6).
#' @param height plot height in inches (default value is 6).
#' @param vector.graphic logical scalar, default to FALSE. If TRUE, vector graphics 
#' are produced instead of PNG images. If TRUE, vector graphics are 
#' RaphaelJS instructions(transformed as SVG). 
#' @param pointsize the default pointsize of plotted text in pixels, default to 12.
#' @param fontname the default font family to use, default to getOption("ReporteRs-default-font").
#' @param ... arguments for \code{fun}.
#' @return an object of class \code{"html"}.
#' @examples
#' #START_TAG_TEST
#' require( ggplot2 )
#' # Create a new document 
#' doc = html( title = "title" )
#' 
#' # add a page where to add R plots with title 'Plots'
#' doc = addPage( doc, title = "Plots" )
#' # Add a base plot
#' doc = addPlot( doc, fun = plot
#' 		, x = rnorm( 100 )
#' 		, y = rnorm (100 )
#' 		, main = "base plot main title"
#' 	)
#' myplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species
#' 	, size = Petal.Width, alpha = I(0.7))
#' doc = addPlot( doc
#' 		, print
#' 		, width = 6, height = 7
#' 		, x = myplot #this argument MUST be named, print is expecting argument 'x'
#' 	)
#' 
#' doc = addPlot( doc, print
#' 		, width = 6, height = 7
#' 		, x = myplot, vector.graphic = FALSE
#' 	)
#' 
#' ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
#' trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
#' group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
#' weight <- c(ctl, trt)
#' lm.D9 <- lm(weight ~ group)
#' doc = addPlot( doc, function() plot( lm.D9 )
#' 		, width = 6, height = 7
#' 		, x = myplot, vector.graphic = FALSE
#' 	)
#' # write the html object in a directory
#' pages = writeDoc( doc, "addPlot_example")
#' print( pages ) # print filenames of generated html pages
#' #STOP_TAG_TEST
#' @seealso \code{\link{html}}, \code{\link{addPlot}}
#' @method addPlot html
#' @S3method addPlot html
addPlot.html = function(doc, fun, pointsize=getOption("ReporteRs-fontsize"), vector.graphic = T, width=6, height=6, fontname = getOption("ReporteRs-default-font"), ... ) {

	
	plotargs = list(...)

	dirname = tempfile( )
	dir.create( dirname )
	
	if( !vector.graphic ){
	
		filename = paste( dirname, "/plot%03d.png" ,sep = "" )
		grDevices::png (filename = filename
				, width = width, height = height, units = 'in'
				, pointsize = pointsize, res = 300
		)
#		grDevices::png (filename = filename
#				, width = width*72.2, height = height*72.2
#				, pointsize = pointsize
#		)
		
		fun_res = try( fun(...), silent = T )
		dev.off()
		plotfiles = list.files( dirname , full.names = T )
		
		jimg = .jnew(class.html4r.ImagesList, as.integer( width*72.2 ), as.integer( height*72.2 ) )
		
		for( i in 1:length( plotfiles ) ){
			.tempfile <- tempfile()
			base64::encode(plotfiles[i], .tempfile)
			.jcall( jimg, "V", "addImage", as.character(paste(readLines(.tempfile), collapse = "\n")) )
			unlink(.tempfile)
		}
		out = .jcall( doc$current_slide, "I", "add", jimg )
		if( out != 1 ){
			stop( "Problem while trying to add plot." )
		}
	} else {
		filename = file.path( dirname, "plot", fsep = "/" )
		env = raphael( file = filename,width=width*72.2
			, height = height*72.2
			, ps=pointsize, fontname = fontname
			, canvas_id = as.integer(doc$canvas_id) )
		fun(...)
		dev.off()

		plot_ids = get("plot_ids", envir = env )
		doc$canvas_id = get("canvas_id", envir = env )
		
		jimg = .jnew( class.html4r.RaphaelList )
		
		for(i in 1:length( plot_ids ) ){
			file = as.character(paste(readLines(plot_ids[[i]]$filename), collapse = "\n"))
			div.id = plot_ids[[i]]$div.id
			
			.jcall( jimg, "V", "addSlide", as.character(div.id), file )
		}
		out = .jcall( doc$current_slide, "I", "add", jimg )
		if( out != 1 ){
			stop( "Problem while trying to add plot." )
		}
		
	}
	doc
}
