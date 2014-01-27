#' @title Insert a title into a docx object
#'
#' @description Add a title into a \code{"docx"} object.
#' 
#' @param doc Object of class \code{"docx"}
#' @param value \code{"character"} value to use as title text
#' @param level \code{"integer"} positive value to use as heading level. 1 for title1, 2 for title2, etc.
#' @param ... further arguments, not used. 
#' @details 
#' 
#' In MS Word, you can use whatever style you want as title formating style. 
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
#' # Create a new document 
#' doc = docx( title = "title" )
#' 
#' # add a title (level 1)
#' doc = addTitle( doc, "My first title", level = 1 )
#' 
#' # add another title (level 2)
#' doc = addTitle( doc, "My first sub-title", level = 2 )
#' doc <- addParagraph(doc, "Hello Word!", "Normal");
#' # Write the object in file "~/document.docx"
#' writeDoc( doc, "~/document.docx" )
#' @seealso \code{\link{docx}}, \code{\link{addParagraph.docx}}
#' , \code{\link{declareTitlesStyles.docx}}, \code{\link{styles.docx}}
#' @method addTitle docx
#' @S3method addTitle docx
addTitle.docx = function( doc, value, level, ... ) {
	if( length( doc$header.styles ) == 0 ){
		stop("You must defined title styles via declareTitlesStyles first.")				
	}
	if( length( doc$header.styles ) < level ){
		stop("level = ", level, ". You defined only ", length( doc$header.styles ), " styles.")				
	}
	
	doc <- addParagraph(doc, value, doc$header.styles[level] );
	doc
}


