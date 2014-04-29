#' @title shortcut for default textProperties
#'
#' @description
#' shortcut for textProperties(...)
#' @param ... arguments passed to textProperties
#' @export
#' @examples
#' textNormal()
#' @seealso \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
textNormal = function(...) textProperties( ... )


#' @title shortcut for bold
#'
#' @description
#' shortcut for bold textProperties()
#' @param ... arguments passed to textProperties
#' @export
#' @examples
#' textBold()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
textBold = function(...) textProperties( font.weight = "bold", ... )




#' @title shortcut for italic
#'
#' @description
#' shortcut for italic textProperties()
#' @param ... arguments passed to textProperties
#' @export
#' @examples
#' textItalic()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
textItalic = function( ... ) textProperties( font.style = "italic", ... )


#' @title shortcut for bold italic
#'
#' @description
#' shortcut for bold italic textProperties()
#' @param ... arguments passed to textProperties
#' @export
#' @examples
#' textBoldItalic()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
textBoldItalic = function( ... ) textProperties( font.weight = "bold", font.style = "italic", ... )


#' @title shortcut for right alignment
#'
#' @description
#' shortcut for right alignment parProperties()
#' @param ... arguments passed to parProperties
#' @export
#' @examples
#' parRight()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
parRight = function( ... ) parProperties( text.align = "right", ... )


#' @title shortcut for left alignment
#'
#' @description
#' shortcut for left alignment parProperties()
#' @param ... arguments passed to parProperties
#' @export
#' @examples
#' parLeft()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
parLeft = function( ... ) parProperties( text.align = "left", ... )

#' @title shortcut for centered alignment
#'
#' @description
#' shortcut for center alignment parProperties()
#' @param ... arguments passed to parProperties
#' @export
#' @examples
#' parLeft()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
parCenter = function( ... ) parProperties( text.align = "center", ... )


#' @title shortcut for justified alignment
#'
#' @description
#' shortcut for center alignment parProperties()
#' @param ... arguments passed to parProperties
#' @export
#' @examples
#' parLeft()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
parJustify = function( ... ) parProperties( text.align = "justify", ... )


#' @title shortcut for dotted border
#'
#' @description
#' shortcut for a dotted border borderProperties()
#' @param ... arguments passed to borderProperties
#' @export
#' @examples
#' borderDotted()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
borderDotted = function( ... )  borderProperties( style="dotted", ... )



#' @title shortcut for dashed border
#'
#' @description
#' shortcut for a dashed border borderProperties()
#' @param ... arguments passed to borderProperties
#' @export
#' @examples
#' borderDashed()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderNone}}
#' , \code{\link{borderSolid}}
borderDashed = function( ... )  borderProperties( style="dashed", ... )



#' @title shortcut for no border
#'
#' @description
#' shortcut for no border borderProperties()
#' @param ... arguments passed to borderProperties
#' @export
#' @examples
#' borderNone()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderSolid}}
borderNone = function( ... )  borderProperties( style="none", ... )



#' @title shortcut for solid border
#'
#' @description
#' shortcut for solid border borderProperties()
#' @param ... arguments passed to borderProperties
#' @export
#' @examples
#' borderSolid()
#' @seealso \code{\link{textNormal}}
#' , \code{\link{textBold}}
#' , \code{\link{textItalic}}
#' , \code{\link{textBoldItalic}}
#' , \code{\link{parRight}}
#' , \code{\link{parLeft}}
#' , \code{\link{parCenter}}
#' , \code{\link{parJustify}}
#' , \code{\link{borderDotted}}
#' , \code{\link{borderDashed}}
#' , \code{\link{borderNone}}
borderSolid = function( ... )  borderProperties( style = "solid", ... )
