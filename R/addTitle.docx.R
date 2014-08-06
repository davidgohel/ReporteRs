#' @title Insert a title into a docx object
#'
#' @description Add a title into a \code{"docx"} object.
#' 
#' @param doc Object of class \code{"docx"}
#' @param value \code{"character"} value to use as title text
#' @param level \code{"integer"} positive value to use as 
#' heading level. 1 for title1, 2 for title2, etc. Default to 1.
#' @param ... further arguments, not used. 
#' @details 
#' 
#' In MS Word, you can use whatever style you want as title formatting style. 
#' But to be considered as entries for a Table of Content, used styles must be 'title' styles. 
#' Theses are always available in MS Word list styles.
#' When template is read, ReporteRs try to guess what are theses styles. 
#' If it does not succeed, you will see that error when addTitle will be called:
#' 
#' Error in addHeader(...\cr
#' You must defined title styles via declareTitlesStyles first.
#' 
#' You have to use function \code{\link{declareTitlesStyles.docx}} to indicate 
#' which available styles are meant to be used as titles styles. A side effect is that you 
#' will be able then to add a table of content in your Word document.
#' @return an object of class \code{"docx"}.
#' @examples
#' #START_TAG_TEST
#' # Create a new document 
#' doc = docx( title = "title" )
#' 
#' # add a title (level 1)
#' doc = addTitle( doc, "My first title", level = 1 )
#' 
#' # add another title (level 2)
#' doc = addTitle( doc, "My first sub-title", level = 2 )
#' doc = addParagraph(doc, "Hello Word!", stylename = "Normal")
#' 
#' # Write the object in file "addTitle_example.docx"
#' writeDoc( doc, "addTitle_example.docx" )
#' #STOP_TAG_TEST
#' @seealso \code{\link{docx}}, \code{\link{addParagraph.docx}}
#' , \code{\link{declareTitlesStyles.docx}}, \code{\link{styles.docx}}
#' @method addTitle docx
#' @S3method addTitle docx
addTitle.docx = function( doc, value, level = 1, ... ) {
	if( length( doc$header.styles ) == 0 ){
		stop("You must defined title styles via declareTitlesStyles first.")				
	}
	if( length( doc$header.styles ) < level ){
		stop("level = ", level, ". You defined only ", length( doc$header.styles ), " styles.")				
	}
	if( !is.numeric( level ) )
		stop("level must be an integer vector of length 1.")
	if( length( level ) != 1 )
		stop("level must be an integer vector of length 1.")
	
	doc = addParagraph(doc = doc, value, stylename = doc$header.styles[level] );
	doc
}


