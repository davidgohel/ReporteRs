#' @title Add a slide into a document object
#'
#' @description Add a slide into a document object
#'
#' @param doc document object
#' @param ... further arguments passed to other methods
#' @return a document object
#' @details
#' \code{addSlide} only works with pptx documents. See \code{\link{addSlide.pptx}} for examples.
#' @export
#' @seealso \code{\link{pptx}}, \code{\link{slide.layouts}}
addSlide = function(doc, ...){
  UseMethod("addSlide")
}


#' @param slide.layout layout name of the slide to create. See \code{\link{slide.layouts.pptx}}
#' @param bookmark \code{"integer"} page number to specify where slide has to be replaced with a new empty one.
#' @details
#' This function is a key function ; if no slide has been added into the document object
#' no content (tables, plots, images, text) can be added.
#'
#' If creating a slide of type "Title and Content", only one content can be added because there is only one content shape in the layout.
#' If creating a slide of type "Two Content", two content can be added because there are 2 content shapes in the layout.
#'
#' Content shapes are boxes with dotted borders that hold content in its place on a slide layout.
#' If you need a new layout, create it in PowerPoint :
#'
#' On the View tab, in the Presentation Views group, click Slide Master.
#'
#' Function \code{slide.layouts} returns available layout names of the template used when pptx object has been created.
#' It is important to know that when using addParagraph.pptx, paragraph and defaut font formats will be defined
#' by the properties of the shape of the \code{slide.layout} where content will be added.
#' For example, if you set the shape formatting properties to a 'no bullet', paragraphs of text won't have any bullet.
#'
#' Also when using addPlot, plot dimensions will be the shape dimensions. It means that if you want to change plot dimensions
#' , this has to be done in the PowerPoint template used when creating the \code{pptx} object.
#' @examples
#' doc.filename = "addSlide_example.pptx"
#' @example examples/pptx.R
#' @example examples/addSlide_example.R
#' @example examples/writeDoc_file.R
#' @example examples/addSlide_replace_example.R
#' @rdname addSlide
#' @export
addSlide.pptx = function( doc, slide.layout, bookmark, ... ) {
	if( length( doc$styles ) == 0 ){
		stop("You must defined layout in your pptx template.")
	}
	if( !missing( bookmark ) ) {
		if( length( bookmark ) != 1 )
			stop("bookmark must be a positive unique integer")
		if( !is.numeric( bookmark ) )
			stop("bookmark must be a positive unique integer")
		if( bookmark < 1 )
			stop("bookmark must be a positive unique integer")

	}
	if( !is.element( slide.layout, doc$styles ) ){
		stop("Slide layout '", slide.layout, "' does not exist in defined layouts.")
	}

	layout.description = .jcall( doc$obj,
		paste0("L", class.pptx4r.LayoutDescription, ";"),
		"getLayoutProperties",
		as.character(slide.layout)
		)
	if( missing( bookmark ) ) {
		slide.part = try( .jcall( doc$obj,
				paste0("L", class.pptx4r.SlidePart, ";"),
				"getNewSlide",
				as.character(slide.layout)
				),
			silent = T)
		if( inherits( slide.part, "try-error")) {
			.reg = regexpr(pattern = "java\\.lang\\.Exception: ", slide.part)
			msg = substring( text = slide.part, first = .reg + attr( .reg, "match.length") )
			stop(msg)
		}
		slideindex = .jcall( doc$obj, "I", "getSlideNumber" )

	} else {
		slide.part = try( .jcall( doc$obj,
				paste0("L", class.pptx4r.SlidePart, ";"),
				"getAndReInitExistingSlide",
				as.character(slide.layout), as.integer(bookmark)
				),
			silent = T)
		if( inherits( slide.part, "try-error")) {
			.reg = regexpr(pattern = "java\\.lang\\.Exception: ", slide.part)
			msg = substring( text = slide.part, first = .reg + attr( .reg, "match.length") )
			stop(msg)
		}
		slideindex = as.integer(bookmark)
	}

	slide = try( .jnew(class.pptx4r.SlideContent,
			slide.part, doc$obj, layout.description),
		silent = T)

	if( inherits( slide, "try-error")) {
		.reg = regexpr(pattern = "java\\.lang\\.Exception: ", slide)
		msg = substring( text = slide, first = .reg + attr( .reg, "match.length") )
		stop(msg)
	}

	# mainly for addPageNumber
	.jcall( slide, "V", "setSlideIndex", slideindex )

	doc$current_slide = slide

	# start plot element id after the max number of shape into the pptx
	# just in case of - want to make sure element id unique into a slide
	# as rules are not that clear
	doc$plot_first_id = .jcall( slide, "I", "getmax_shape"  ) + 1
	doc
}
