#' @title Add a plot into a pptx object
#'
#' @description
#' Add a plot to the current slide of an existing \code{pptx} object.
#'
#' @param doc \code{\link{pptx}} object
#' @param fun plot function. The function will be executed to produce graphics.
#' For \code{grid} or \code{lattice} or \code{ggplot} object, the function
#' should just be print and an extra argument x should specify the object
#' to plot. For traditionnal plots, the function should contain plot instructions. See examples.
#' @param pointsize the default pointsize of plotted text, interpreted as big points (1/72 inch) at res ppi.
#' @param vector.graphic logical scalar, default to TRUE. If TRUE, vector graphics
#' are produced instead of PNG images. Vector graphics in pptx document are DrawingML instructions.
#' @param fontname the default font family to use, default to getOption("ReporteRs-default-font").
#' @param editable logical value - if TRUE vector graphics elements (points, text, etc.) are editable.
#' @param offx optional, x position of the shape (top left position of the bounding box) in inches. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) in inches. See details.
#' @param width optional, width of the shape in inches. See details.
#' @param height optional, height of the shape in inches. See details.
#' @param ... arguments for \code{fun}.
#' @return an object of class \code{\link{pptx}}.
#' @details
#' If arguments offx, offy, width, height are missing, position and dimensions
#' will be defined by the width and height of the next available shape of the slide. This
#' dimensions can be defined in the layout of the PowerPoint template used to create
#' the \code{pptx} object.
#'
#' If arguments offx, offy, width, height are provided, they become position and
#' dimensions of the new shape.
#' @examples
#' #START_TAG_TEST
#' doc.filename = "addPlot_example.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide.R
#' @example examples/addTitle1NoLevel.R
#' @example examples/addBasePlot_nodim.R
#' @example examples/addBasePlot_positiondim.R
#' @example examples/addSlide.R
#' @example examples/addTitle2NoLevel.R
#' @example examples/addggplot.R
#' @example examples/writeDoc_file.R
#' @example examples/STOP_TAG_TEST.R
#' @seealso \code{\link{pptx}}, \code{\link{addPlot}}
#' @import rvg
#' @export
addPlot.pptx = function(doc, fun, pointsize = 11
	, vector.graphic = TRUE, fontname = getOption("ReporteRs-default-font")
	, editable = TRUE, offx, offy, width, height
	, ... ) {

	check.dims = sum( c( !missing( offx ), !missing( offy ), !missing( width ), !missing( height ) ) )
	if( check.dims > 0 && check.dims < 4 ) {
		if( missing( offx ) ) warning("arguments offx, offy, width and height must be all specified: offx is missing")
		if( missing( offy ) ) warning("arguments offx, offy, width and height must be all specified: offy is missing")
		if( missing( width ) ) warning("arguments offx, offy, width and height must be all specified: width is missing")
		if( missing( height ) ) warning("arguments offx, offy, width and height must be all specified: height is missing")
	}
	if( check.dims > 3 ) {
		if( !is.numeric( offx ) ) stop("arguments offx must be a numeric vector")
		if( !is.numeric( offy ) ) stop("arguments offy must be a numeric vector")
		if( !is.numeric( width ) ) stop("arguments width must be a numeric vector")
		if( !is.numeric( height ) ) stop("arguments height must be a numeric vector")

		if( length( offx ) != length( offy )
				|| length( offx ) != length( width )
				|| length( offx ) != length( height ) ){
			stop("arguments offx, offy, width and height must have the same length")
		}
	}

	slide = doc$current_slide

	dirname = tempfile( )
	dir.create( dirname )

	if( check.dims > 3 ){
		if( vector.graphic ){
			vector.pptx.graphic(doc = doc, fun = fun, pointsize = pointsize
				, fontname = fontname, editable = editable
				, offx, offy, width, height, ... )
		} else {
			raster.pptx.graphic (doc = doc, fun = fun, pointsize = pointsize
				, fontname = fontname, offx, offy, width, height, ... )
		}
	} else {
		if( vector.graphic ){
			vector.pptx.graphic(doc = doc, fun = fun, pointsize = pointsize
				, fontname = fontname, editable = editable, ... )
		} else {
			raster.pptx.graphic (doc = doc, fun = fun, pointsize = pointsize
				, fontname = fontname, ... )
		}
	}

	doc
}


get.graph.dims = function( doc ){
	slide = doc$current_slide
	id = .jcall( slide, "I", "getNextShapeIndex"  )
	maxid = .jcall( slide, "I", "getmax_shape"  )
	if( maxid-id < 1 ) stop( getSlideErrorString( shape_errors["NOROOMLEFT"] , "plot") )


	LayoutName = .jcall( slide, "S", "getLayoutName" )
	layout_description = .jcall( doc$obj, paste0("L", class.pptx4r.LayoutDescription, ";"), "getLayoutProperties", LayoutName )

	dims = .jcall( layout_description, "[I", "getContentDimensions", as.integer(id) )
	widths = dims[3] / 914400
	heights = dims[4] / 914400
	offxs = dims[1] / 914400
	offys = dims[2] / 914400
	data.frame( widths = widths, heights = heights, offxs = offxs, offys = offys )
}

vector.pptx.graphic = function(doc, fun, pointsize = 11
		, fontname = getOption("ReporteRs-default-font")
		, editable = TRUE, offx, offy, width, height
		, ... ) {
	slide = doc$current_slide

	check.dims = sum( c( !missing( offx ), !missing( offy ), !missing( width ), !missing( height ) ) )
	if( check.dims < 4 ){
		data.dims = get.graph.dims( doc )
		width = data.dims$widths
		height = data.dims$heights
		offx = data.dims$offxs
		offy = data.dims$offys
	}

	filename = tempfile( fileext = ".dml")
	filename = normalizePath( filename, winslash = "/", mustWork  = FALSE)

	vg_fonts <- getOption("vg_fonts")
	next_rels_id <- get_next_relid_pptx(doc)-1
	uid <- basename(tempfile(pattern = ""))
	img_directory = file.path(getwd(), uid )

	dml_pptx(file = filename, width = width, height = height,
	         offx = offx, offy = offy,
	         pointsize = pointsize,
	         fontname_serif = vg_fonts$fontname_serif,
	         fontname_sans = vg_fonts$fontname_sans,
	         fontname_mono = vg_fonts$fontname_mono,
	         fontname_symbol = vg_fonts$fontname_symbol,
	         editable = editable,
	         next_rels_id = next_rels_id,
	         raster_base_path = img_directory)
	tryCatch(fun(...),
	         finally = dev.off()
	)
	raster_files <- list.files(path = getwd(), pattern = paste0("^", uid, "(.*)\\.png$"), full.names = TRUE )
	raster_names <- gsub( pattern = "\\.png$", replacement = "", basename(raster_files) )
	dml.object = .jnew( class.DrawingML, filename )
	if( length( raster_files ) > 0 ){
	  .jcall( slide, "I", "add_png", .jarray(raster_files), .jarray(raster_names) )
	  unlink(raster_files, force = TRUE)
	}

	if( check.dims < 4 ){
	  out = .jcall( slide, "I", "add", dml.object )
	} else {
	  out = .jcall( slide, "I", "add", dml.object, width, height, offx, offy )
	}
	if( isSlideError( out ) ){
	  stop( getSlideErrorString( out , "dml") )
	}
	unlink(filename, force = TRUE)

	doc
}

raster.pptx.graphic = function(doc, fun, pointsize = 11
		, fontname = getOption("ReporteRs-default-font")
		, offx, offy, width, height
		, ... ) {
	slide = doc$current_slide
	plot_first_id = doc$plot_first_id

	check.dims = sum( c( !missing( offx ), !missing( offy ), !missing( width ), !missing( height ) ) )

	if( check.dims < 4 ){
		data.dims = get.graph.dims( doc )
		width = data.dims$widths
		height = data.dims$heights
		offx = data.dims$offxs
		offy = data.dims$offys
	}

	plotargs = list(...)

	dirname = tempfile( )
	dir.create( dirname )
	filename = paste( dirname, "/plot%03d.png" ,sep = "" )
	grDevices::png (filename = filename
			, width = width[1], height = height[1], units = 'in'
			, pointsize = pointsize, res = 300
	)

	fun(...)
	dev.off()
	plotfiles = list.files( dirname , full.names = T )
	for( i in seq_along( plotfiles ) ){
		if( check.dims > 3 ){
			doc = addImage( doc, plotfiles[i], offx = offx, offy = offy,
					width=width, height=height, ppi = 300 )
		} else if( !missing(offx) && !missing(offy) && missing(width) && missing(height) ){
			doc = addImage( doc, plotfiles[i], offx = offx, offy = offy, ppi = 300 )
		}  else if( check.dims < 1 ){
			doc = addImage( doc, plotfiles[i], ppi = 300 )
		} else {
			doc = addImage( doc, plotfiles[i], ppi = 300 )
		}
	}

	doc
}
