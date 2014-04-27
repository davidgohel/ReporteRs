#' @title Write a html object in a html file
#'
#' @description Write the \code{"html"} object in '.html' files located in a specified directory.
#' 
#' @param doc Object of class \code{"html"} that has to be written.
#' @param directory single character value, name of the directory that will contain generated html pages.
#' @param ... further arguments, not used. 
#' @return the function a character vector containing generated html documents filenames.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = html( title = "title" )
#' 
#' # add a page where to add R outputs with title 'page example'
#' doc = addPage( doc, title = "page example" )

#' # add iris dataset as a table in the page
#' doc = addTable(doc, iris )
#' 
#' # write the html object in a directory
#' pages = writeDoc( doc, "writeDoc_example")
#' print( pages ) # print filenames of generated html pages
#' #STOP_TAG_TEST
#' @seealso \code{\link{html}}, \code{\link{writeDoc}}
#' @method writeDoc html
#' @S3method writeDoc html

writeDoc.html = function(doc, directory, ...) {
	www.directory = normalizePath( path.expand(directory) , mustWork=F, winslash="/")
	try( unlink( www.directory, recursive = T ) , silent = TRUE )	
	dir.create( www.directory, recursive = T )
	bootstrap.copy( www.directory, "ReporteRs")	
	
	out = .jcall( doc$obj , "I", "writeDocument", www.directory )
	if( out != 1 ){
		stop( "Problem while trying to write html content onto the disk." )
	}
	htmlfiles = list.files( www.directory, pattern = "\\.html$", full.names=T)
	sort( htmlfiles )
	}



