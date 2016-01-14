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
#' @param fontname deprecated. the default font family to use, default to getOption("ReporteRs-default-font").
#' @param fontname_serif,fontname_sans,fontname_mono,fontname_symbol font
#' names for font faces.
#' Used fonts should be available in the operating system.
#' @param editable logical value - if TRUE vector graphics elements (points, text, etc.) are editable.
#' @param offx optional, x position of the shape (top left position of the bounding box) in inches. See details.
#' @param offy optional, y position of the shape (top left position of the bounding box) in inches. See details.
#' @param width optional, width of the shape in inches. See details.
#' @param height optional, height of the shape in inches. See details.
#' @param bg the initial background colour.
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
addPlot.pptx = function(doc, fun, pointsize = 11,
                        vector.graphic = TRUE,
                        fontname = getOption("ReporteRs-default-font"),
                        fontname_serif = "Times New Roman", fontname_sans = "Calibri",
                        fontname_mono = "Courier New", fontname_symbol = "Symbol",
                        editable = TRUE, offx, offy, width, height, bg = "white", ... ) {

  if (!missing(fontname)) {
    warning("argument fontname is deprecated; please use",
            "fontname_serif, fontname_sans ",
            ",fontname_mono,fontname_symbol instead.",
            call. = FALSE)
  }

  off_missing <- ( missing( offx ) || missing( offy ) )
  ext_missing <- ( missing( width ) || missing( height ) )

  if( !off_missing && ext_missing ){
    stop("width and height must be provided if offx and offy are provided")
  }

  free_layout <- FALSE
  if( off_missing && ext_missing ){
    position <- next_shape_pos( doc )
    offx_ <- position$offx
    offy_ <- position$offy
    width_ <- position$width
    height_ <- position$height
  } else if( off_missing && !ext_missing ){
    position <- next_shape_pos( doc )
    offx_ <- position$offx
    offy_ <- position$offy
    width_ <- width
    height_ <- height
  } else {
    offx_ <- offx
    offy_ <- offy
    width_ <- width
    height_ <- height
    free_layout <- TRUE
  }

  slide = doc$current_slide

  dirname = tempfile( )
  dir.create( dirname )

  if (free_layout && vector.graphic) {
    doc <- vector.pptx.graphic(
      doc = doc, fun = fun, pointsize = pointsize,
      fontname_serif = fontname_serif, fontname_sans = fontname_sans,
      fontname_mono = fontname_mono, fontname_symbol = fontname_symbol,
      editable = editable,
      offx_, offy_, width_, height_,
      bg = bg, free_layout = free_layout,
      ...
    )
  } else if (free_layout && !vector.graphic) {
    doc <- raster.pptx.graphic (
      doc = doc, fun = fun, pointsize = pointsize,
      offx = offx_, offy = offy_, width = width_, height = height_,
      bg = bg, free_layout = free_layout,
      ...
    )
  } else if (!free_layout && vector.graphic) {
    doc <- vector.pptx.graphic(
      doc = doc, fun = fun, pointsize = pointsize,
      fontname_serif = fontname_serif, fontname_sans = fontname_sans,
      fontname_mono = fontname_mono, fontname_symbol = fontname_symbol,
      editable = editable,
      offx_, offy_, width_, height_,
      bg = bg, free_layout = free_layout,
      ...
    )
  } else {
    doc <- raster.pptx.graphic (
      doc = doc, fun = fun, pointsize = pointsize,
      offx = offx_, offy = offy_, width = width_, height = height_,
      bg = bg, free_layout = free_layout,
      ...
    )
  }

  doc
}


#' @importFrom png readPNG
vector.pptx.graphic = function(doc, fun, pointsize = 11,
                               fontname_serif, fontname_sans,
                               fontname_mono, fontname_symbol,
                               editable = TRUE,
                               offx, offy, width, height, bg = "white",
                               free_layout = FALSE,
                               ... ) {
  slide = doc$current_slide

  filename = tempfile( fileext = ".dml")
  filename = normalizePath( filename, winslash = "/", mustWork  = FALSE)

  next_rels_id <- rJava::.jcall( slide, "S", "getNextRelID" )
  next_rels_id <- gsub(pattern = "(.*)([0-9]+)$", "\\2", next_rels_id )
  next_rels_id <- as.integer(next_rels_id) - 1
  uid <- basename(tempfile(pattern = ""))
  raster_dir <- tempdir()
  img_directory <- file.path(raster_dir, uid )

  dml_pptx(file = filename,
           width = width, height = height,
           offx = offx, offy = offy,
           pointsize = pointsize,
           fontname_serif = fontname_serif, fontname_sans = fontname_sans,
           fontname_mono = fontname_mono, fontname_symbol = fontname_symbol,
           editable = editable,
           bg = bg,
           next_rels_id = next_rels_id,
           raster_prefix = img_directory
  )
  tryCatch(fun(...), finally = dev.off() )
  if( !file.exists(filename) )
    stop("unable to produce a plot")


  raster_files <- list.files(path = raster_dir, pattern = paste0("^", uid, "(.*)\\.png$"), full.names = TRUE )
  raster_names <- gsub( pattern = "\\.png$", replacement = "", basename(raster_files) )
  dml.object = .jnew( class.DrawingML, filename )
  if( length( raster_files ) > 0 ){
    dims <- lapply( raster_files, function(x) {
      .dims <- attr( readPNG(x), "dim" )
      data.frame(width=.dims[2], height = .dims[1])
      }
    )
    dims <- do.call(rbind, dims)
    .jcall( slide, "I", "add_png",
            .jarray(raster_files), .jarray(raster_names),
            .jarray(dims$width / 72), .jarray(dims$height / 72) )
    unlink(raster_files, force = TRUE)
  }

  out = .jcall( slide, "I", "add", dml.object, width, height, offx, offy )
  if( isSlideError( out ) ){
    stop( getSlideErrorString( out , "dml") )
  }
  unlink(filename, force = TRUE)

  doc
}

raster.pptx.graphic = function(doc, fun, pointsize = 11,
                               offx, offy,
                               width, height,
                               bg = bg,
                               free_layout = FALSE,
                               ... ) {
  plotargs = list(...)

  dirname = tempfile( )
  dir.create( dirname )
  filename = paste( dirname, "/plot.png" ,sep = "" )

  grDevices::png (filename = filename,
                  width = width, height = height, units = 'in',
                  pointsize = pointsize, res = 300, bg = bg
  )

  tryCatch(fun(...), finally = dev.off() )

  if( !file.exists(filename) )
      stop("unable to produce a plot")
  jimg = .jnew(class.Image , filename, .jfloat( width ), .jfloat( height ) )
  out = .jcall( doc$current_slide, "I", "add", jimg, .jfloat( offx ), .jfloat( offy ), free_layout )

  unlink(filename, force = TRUE)

  doc
}
