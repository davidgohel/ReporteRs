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
#' are produced instead of PNG images. If TRUE, SVG is produced.
#' @param pointsize the default pointsize of plotted text in pixels, default to 12.
#' @param fontname deprecated. the default font family to use, default to getOption("ReporteRs-default-font").
#' @param fontname_serif,fontname_sans,fontname_mono,fontname_symbol font
#' names for font faces.
#' Used fonts should be available in the operating system.
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
#' @import rvg
#' @export
addPlot.bsdoc = function(doc, fun, pointsize=getOption("ReporteRs-fontsize"),
		vector.graphic = T, width=6, height=6,
		fontname = getOption("ReporteRs-default-font"),
		fontname_serif = "Times New Roman",
		fontname_sans = "Calibri",
		fontname_mono = "Courier New",
		fontname_symbol = "Symbol",
		par.properties = parCenter( padding = 5 ), ... ) {

  if (!missing(fontname)) {
    warning("argument fontname is deprecated; please use",
            "fontname_serif, fontname_sans ",
            ",fontname_mono,fontname_symbol instead.",
            call. = FALSE)
  }

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
		if( length( plotfiles ) > 1 )
		  stop( length( plotfiles ),
		        " files have been produced. multiple plot files are not supported")
		if( length( plotfiles ) < 1 )
		  stop("unable to produce a plot")

		doc = addImage( doc, plotfiles, width = width, height = height,
				par.properties = par.properties )
	} else {
	  filename = tempfile( fileext = ".svg")
	  filename = normalizePath( filename, winslash = "/", mustWork  = FALSE)

	  dsvg( file = filename, width = width, height = height,
		     pointsize = pointsize, canvas_id = as.integer(doc$canvas_id),
		     fontname_serif = fontname_serif,
		     fontname_sans = fontname_sans,
		     fontname_mono = fontname_mono,
		     fontname_symbol = fontname_symbol
		     )
		tryCatch(fun(...), finally = dev.off() )
	  if( !file.exists(filename) )
	    stop("unable to produce a plot")

    doc$canvas_id = doc$canvas_id + 1

		jimg = .jnew( class.html4r.SVGContent, .jParProperties(par.properties), filename, width*72, height*72 )

		out = .jcall( doc$jobj, "I", "add", jimg )
		if( out != 1 ){
			stop( "Problem while trying to add plot." )
		}

	}
	doc
}

