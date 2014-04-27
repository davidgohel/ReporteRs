#' @title Insert a slide into a pptx object
#'
#' @description Add a slide into a \code{"pptx"} object.
#' 
#' @param doc Object of class \code{"pptx"} where slide has to be added
#' @param slide.layout layout name of the slide to create. See \code{\link{slide.layouts.pptx}}
#' @param bookmark \code{"integer"} page number to specify where slide has to be replaced with a new empty one.
#' @param ... further arguments, not used. 
#' @details 
#' This function is a key function ; if no slide has been added into the document object
#' no content (tables, plots, images, texts) can be added. 
#' 
#' If creating a slide of type "Title and Content", only one content can be added because there is only one content shape in the layout.
#' If creating a slide of type "Two Content", two content can be added because there are 2 content shapes in the layout.
#' 
#' Content shapes are boxes with dotted borders that hold content in its place on a slide layout. 
#' If you need a new layout, create it in PowerPoint :
#' 
#' On the View tab, in the Presentation Views group, click Slide Master. 
#' 
#' read \url{http://office.microsoft.com/en-us/powerpoint-help/create-a-new-custom-layout-HA010079650.aspx} 
#' 
#' read \url{http://office.microsoft.com/en-us/powerpoint-help/change-a-placeholder-HA010064940.aspx}
#' 
#' Function \code{slide.layouts} returns available layout names of the template used when pptx object has been created.
#' It is important to know that when using addParagraph.pptx, paragraph and defaut font formats will be defined 
#' by the properties of the shape of the \code{slide.layout} where content will be added. 
#' For example, if you set the shape formating properties to a 'no bullet', paragraphs of texts won't have any bullet.
#' 
#' Also when using addPlot, plot dimensions will be the shape dimensions. It means that if you want to change plot dimensions
#' , this has to be done in the PowerPoint template used when creating the \code{pptx} object. 
#' @return an object of class \code{"pptx"}.
#' @examples 
#' #START_TAG_TEST
#' # Create a new document 
#' doc = pptx( title = "title" )
#' 
#' # add a slide with layout "Title Slide"
#' doc = addSlide( doc, slide.layout = "Title Slide" )
#' doc = addTitle( doc, "Presentation title" ) #set the main title
#' doc = addSubtitle( doc , "This document is generated with ReporteRs.")#set the sub-title
#' 
#' 
#' # add a slide with layout "Title and Content" then add content
#' doc = addSlide( doc, slide.layout = "Title and Content" )
#' doc = addTitle( doc, "Iris sample dataset", level = 1 )
#' doc = addTable( doc, iris[ 1:10,] )
#' 
#' 
#' # add a slide with layout "Two Content" then add content
#' doc = addSlide( doc, slide.layout = "Two Content" )
#' doc = addTitle( doc, "Two Content demo", level = 1 )
#' doc = addTable( doc, iris[ 46:55,] )
#' doc = addParagraph(doc, "Hello Word!" )
#' 
#' # to see available layouts :
#' slide.layouts( doc )
#' 
#' # Write the object in file "addSlide_example.pptx"
#' writeDoc( doc, "addSlide_example.pptx" )
#' #STOP_TAG_TEST
#' @seealso \code{\link{addTitle.pptx}}, \code{\link{slide.layouts}}
#' , \code{\link{pptx}}, \code{\link{addSlide}}
#' @method addSlide pptx
#' @S3method addSlide pptx
addSlide.pptx = function( doc, slide.layout, bookmark, ... ) {
	if( length( doc$styles ) == 0 ){
		stop("You must defined layout in your pptx template.")				
	}
	if( !is.element( slide.layout, doc$styles ) ){
		stop("Slide layout '", slide.layout, "' does not exist in defined layouts.")				
	}
	if( missing( bookmark ) )
		slide = .jnew(class.pptx4r.SlideContent, slide.layout, doc$obj )
	else {
		slide = .jnew(class.pptx4r.SlideContent, slide.layout, doc$obj, as.integer(bookmark) )		
	}
	doc$current_slide = slide
	
	# start plot element id after the max number of shape into the pptx
	# just in case of - want to make sure element id unique into a slide
	# as rules are not that clear
	doc$plot_first_id = .jcall( slide, "I", "getmax_shape"  ) + 1
	doc
}
