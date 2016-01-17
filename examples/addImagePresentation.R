img.file = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )

if( file.exists( img.file ) && requireNamespace("jpeg", quietly = TRUE) ){

  dims <- attr( jpeg::readJPEG(img.file), "dim" )
  doc <- addSlide( doc, "Title and Content" )
  doc <- addTitle( doc, "Add images" )
  doc <- addImage(doc, img.file, width = dims[2]/72, height = dims[1]/72)
}
