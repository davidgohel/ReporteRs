# files 'logo.jpg'
img.file1 = file.path( Sys.getenv("R_HOME"), "doc", "html", "logo.jpg" )

if( file.exists( img.file1 ) && requireNamespace("jpeg", quietly = TRUE) ){
  dims <- attr( jpeg::readJPEG(img.file1), "dim" )
  doc = addTitle( doc, "Add images with width and height", level = 1)
  doc = addImage(doc, img.file1, width = dims[2]/72, height = dims[1]/72)
}
