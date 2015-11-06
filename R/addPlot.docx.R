#' @title Add a plot into a docx object
#'
#' @description
#' Add a plot into the \code{docx} object.
#'
#' @param doc the \code{docx} to use
#' @param fun plot function. The function will be executed to produce graphics.
#' For \code{grid} or \code{lattice} or \code{ggplot} object, the function
#' should just be print and an extra argument x should specify the object
#' to plot. For traditionnal plots, the function should contain plot instructions. See examples.
#' @param width plot width in inches (default value is 6).
#' @param height plot height in inches (default value is 6).
#' @param vector.graphic logical scalar, default to FALSE.
#'
#' DrawingML instructions cannot be read by MS Word 2007.
#' @param bookmark id of the Word bookmark to replace by the plot. optional.
#'
#' \code{bookmark} is a character vector specifying bookmark id to replace by the plot(s).\cr
#'   	If provided, plot(s) will replace the paragraph that contains the bookmark. See \code{\link{bookmark}}.\cr
#'   	If not provided, plot(s) will be added at the end of the document.
#'
#' @param par.properties paragraph formatting properties of the paragraph that contains plot(s). An object of class \code{\link{parProperties}}
#' @param pointsize the default pointsize of plotted text in pixels, default to getOption("ReporteRs-fontsize").
#' @param fontname the default font family to use, default to getOption("ReporteRs-default-font").
#' @param editable logical value - if TRUE vector graphics elements (points, text, etc.) are editable.
#' @param ... arguments for \code{fun}.
#' @return an object of class \code{\link{docx}}.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addPlot_example.docx"
#' @example examples/docx.R
#' @example examples/addTitle1Level1.R
#' @example examples/addBasePlot_vg.R
#' @example examples/addTitle2Level1.R
#' @example examples/addggplot.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{docx}}, \code{\link{addPlot}}, \code{\link{bookmark}}.
#' @importFrom Rcpp sourceCpp
#' @importFrom gdtools raster_view
#' @importFrom Rcpp sourceCpp
#' @importFrom gdtools raster_view
#' @import xml2
#' @export
addPlot.docx = function(doc, fun
		, pointsize = getOption("ReporteRs-fontsize")
		, vector.graphic = F
		, width = 6, height = 6
		, fontname = getOption("ReporteRs-default-font")
		, editable = TRUE
		, bookmark
		, par.properties = parProperties(text.align = "center", padding = 5 )
		, ... ) {

	plotargs = list(...)

	dirname = tempfile( )
	dir.create( dirname )

	if( !vector.graphic ){

		filename = paste( dirname, "/plot%03d.png" ,sep = "" )
		grDevices::png (filename = filename,
				width = width, height = height,
				units = 'in', pointsize = pointsize, res = 300
		)

		fun(...)
		dev.off()

		plotfiles = list.files( dirname , full.names = T )

		for( fi in seq_along( plotfiles ) ){
			if( !missing( bookmark ) && fi== 1 )
				doc = addImage( doc, filename = plotfiles[fi],
						width = width, height = height,
						bookmark = bookmark, ppi = 300, par.properties = par.properties )
			else if( missing( bookmark ) )
				doc = addImage( doc, filename = plotfiles[fi], width = width, height = height,
						ppi = 300, par.properties = par.properties  )
			else stop("bookmark can only be used when one single graph is inserted.")
		}


	} else {
		# one important and painful point is that shape ids must be unique
		# in the whole document
		doc_elt_index = .jcall( doc$obj, "I", "getElementIndex") + 1L

		filename = tempfile( fileext = ".dml")
		filename = normalizePath( filename, winslash = "/", mustWork  = FALSE)

		vg_fonts <- getOption("vg_fonts")

		devPPTX_(file = filename, bg_="purple",
      width = width, height = height,
      offx = 0, offy = 0,
      pointsize = pointsize,
      fontname_serif = vg_fonts$fontname_serif,
      fontname_sans = vg_fonts$fontname_sans,
      fontname_mono = vg_fonts$fontname_mono,
      fontname_symbol = vg_fonts$fontname_symbol,
      type = "wps",
      editable = editable, id = doc_elt_index )

		tryCatch(fun(...),
      finally = dev.off()
    )

		dml_doc = read_xml(filename)
		n_g_elts <- length( xml_find_all(dml_doc, "//*[@id]") )

		dims = as.integer( c( width*72.2 , height*72.2 )* 12700 )
		dml.object = .jnew( class.DrawingML, filename )
		.jcall( dml.object, "V", "setWidth", as.integer( dims[1] ) )
		.jcall( dml.object, "V", "setHeight", as.integer( dims[2] ) )

		if( missing( bookmark ) ){
		  .jcall( doc$obj, "V", "add", dml.object, .jParProperties(par.properties) )
		} else {
			.jcall( doc$obj, "V", "add", dml.object, .jParProperties(par.properties), bookmark )
		}
		.jcall( doc$obj, "V", "incrementElementIndex", as.integer( n_g_elts + 1 ) )

	}

	doc
}

