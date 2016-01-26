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

  if( free_layout )
    out = .jcall( slide, "I", "add", dml.object, width, height, offx, offy )
  else
    out = .jcall( slide, "I", "add", dml.object)

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
