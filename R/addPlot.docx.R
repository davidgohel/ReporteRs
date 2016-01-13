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
#' @param fontname deprecated. the default font family to use, default to getOption("ReporteRs-default-font").
#' @param fontname_serif,fontname_sans,fontname_mono,fontname_symbol font
#' names for font faces.
#' Used fonts should be available in the operating system.
#' @param editable logical value - if TRUE vector graphics elements (points, text, etc.) are editable.
#' @param bg the initial background colour.
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
#' @import rvg
#' @import xml2
#' @export
addPlot.docx = function(doc, fun,
                        pointsize = getOption("ReporteRs-fontsize"),
                        vector.graphic = FALSE, width = 6, height = 6,
                        fontname = getOption("ReporteRs-default-font"),
                        fontname_serif = "Times New Roman",
                        fontname_sans = "Calibri",
                        fontname_mono = "Courier New",
                        fontname_symbol = "Symbol",
                        editable = TRUE, bookmark,
                        par.properties = parProperties(text.align = "center", padding = 5),
                        bg = "white", ...) {

	plotargs = list(...)

	if (!missing(fontname)) {
	  warning("argument fontname is deprecated; please use",
	          "fontname_serif, fontname_sans ",
	          ",fontname_mono,fontname_symbol instead.",
	          call. = FALSE)
	}

	dirname = tempfile( )
	dir.create( dirname )

	if( !vector.graphic ){

		filename = paste( dirname, "/plot%03d.png" ,sep = "" )
		grDevices::png (filename = filename,
				width = width, height = height,
				units = 'in', pointsize = pointsize, bg = bg,
				res = 300
		)

		fun(...)
		dev.off()

		plotfiles = list.files( dirname , full.names = T )
		if( length( plotfiles ) < 1 )
		  stop("unable to produce a plot")

		if( length( plotfiles ) > 1 )
		  stop( length( plotfiles ),
		        " files have been produced. multiple plot files are not supported")

			if( !missing( bookmark ) )
				doc = addImage( doc, filename = plotfiles,
						width = width, height = height,
						bookmark = bookmark,
						par.properties = par.properties )
			else
				doc = addImage( doc, filename = plotfiles,
            width = width, height = height,
						par.properties = par.properties  )
	} else {
		doc_elt_index = .jcall( doc$obj, "I", "getElementIndex") + 1L

		filename = tempfile( fileext = ".dml")
		filename = normalizePath( filename, winslash = "/", mustWork  = FALSE)

		next_rels_id <- rJava::.jcall( doc$obj, "S", "getNextRelID" )
		next_rels_id <- gsub(pattern = "^rId", "", next_rels_id )
		next_rels_id <- as.integer(next_rels_id)-1
		uid <- basename(tempfile(pattern = ""))
		img_directory <- file.path(tempdir(), uid )

		dml_docx(file = filename,
		         width = width, height = height,
		         bg = bg,
		         id = doc_elt_index,
		         pointsize = pointsize,
		         fontname_serif = fontname_serif,
		         fontname_sans = fontname_sans,
		         fontname_mono = fontname_mono,
		         fontname_symbol = fontname_symbol,
		         editable = editable,
		         next_rels_id = next_rels_id,
		         raster_prefix = img_directory, standalone = TRUE)
		tryCatch(fun(...),
		         finally = dev.off()
		)
		if( !file.exists(filename) )
		  stop("unable to produce a plot")

		raster_files <- list.files(path = getwd(), pattern = paste0("^", uid, "(.*)\\.png$"), full.names = TRUE )
		raster_names <- gsub( pattern = "\\.png$", replacement = "", basename(raster_files) )

		dml_doc = read_xml(filename)
		n_g_elts <- length( xml_find_all(dml_doc, "//*[@id]") )

		dims <- as.integer( c( width*72.2 , height*72.2 )* 12700 )
		dml.object <- .jnew( class.DrawingML, filename )
		.jcall( dml.object, "V", "setWidth", as.integer( dims[1] ) )
		.jcall( dml.object, "V", "setHeight", as.integer( dims[2] ) )

		if( length( raster_files ) > 0 ){
		  dims <- lapply( raster_files, function(x) {
		    .dims <- attr( readPNG(x), "dim" )
		    data.frame(width=.dims[2], height = .dims[1])
		  }
		  )
		  dims <- do.call(rbind, dims)

		  .jcall( doc$obj, "V", "add_png",
		          .jarray(raster_files), .jarray(raster_names),
		          .jarray(dims$width / 72), .jarray(dims$height / 72) )
		  unlink(raster_files, force = TRUE)
		}

		if( missing( bookmark ) ){
		  .jcall( doc$obj, "V", "add", dml.object, .jParProperties(par.properties) )
		} else {
			.jcall( doc$obj, "V", "add", dml.object, .jParProperties(par.properties), bookmark )
		}
		.jcall( doc$obj, "V", "incrementElementIndex", as.integer( n_g_elts + 1 ) )

	}

	doc
}

