# files 'logo.jpg' and 'logosm.jpg' only exist in R for Windows
img.file1 = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )

if( file.exists( img.file1 ) && requireNamespace("jpeg", quietly = TRUE) ){

  dims <- attr( jpeg::readJPEG(img.file1), "dim" )
  doc = addSlide( doc, "Title and Content" )
  doc = addTitle( doc, "Add images" )
  doc = addImage(doc, img.file1, width = dims[2]/72, height = dims[1]/72)
}
