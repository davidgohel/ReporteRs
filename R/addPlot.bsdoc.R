#' @import rvg
#' @title Add a plot into an bsdoc object
#'
#' @description
#' Add a plot into the \code{bsdoc} object.
#'
#' @param doc Object of class \code{bsdoc} where paragraph has to be added
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
#' @param par.properties paragraph formatting properties of the paragraph that contains plot(s). An object of class \code{\link{parProperties}}
#' @param ... arguments for \code{fun}.
#' @return an object of class \code{\link{bsdoc}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addPlot_bsdoc/example.html"
#' @example examples/bsdoc.R
#' @example examples/addTitle1Level1.R
#' @example examples/addBasePlot_vg.R
#' @example examples/addTitle2Level1.R
#' @example examples/addggplot.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{bsdoc}}, \code{\link{addPlot}}
#' @export
addPlot.bsdoc = function(doc, fun, pointsize=getOption("ReporteRs-fontsize"),
		vector.graphic = T, width=6, height=6,
		fontname = getOption("ReporteRs-default-font"),
		par.properties = parCenter( padding = 5 ), ... ) {


	plotargs = list(...)

	dirname = tempfile( )
	dir.create( dirname )


	if( !vector.graphic ){

		filename = paste( dirname, "/plot%03d.png" ,sep = "" )
		grDevices::png (filename = filename
				, width = width, height = height, units = 'in'
				, pointsize = pointsize, res = 300
		)

		fun_res = try( fun(...), silent = T )
		dev.off()
		plotfiles = list.files( dirname , full.names = T )
		doc = addImage( doc, plotfiles, width = width, height = height,
				par.properties = par.properties, ppi = 300 )
	} else {
	  filename = tempfile( fileext = ".svg")
	  filename = normalizePath( filename, winslash = "/", mustWork  = FALSE)

		rvg( file = filename, width = width, height = height,
		     pointsize = pointsize, canvas_id = as.integer(doc$canvas_id) )
		tryCatch(fun(...),
		         finally = dev.off()
		)
    doc$canvas_id = doc$canvas_id + 1

		jimg = .jnew( class.html4r.SVGContent, .jParProperties(par.properties), filename, width*72, height*72 )

		out = .jcall( doc$jobj, "I", "add", jimg )
		if( out != 1 ){
			stop( "Problem while trying to add plot." )
		}

	}
	doc
}

