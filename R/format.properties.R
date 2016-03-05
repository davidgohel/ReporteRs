#' @title shortcuts for formatting properties
#'
#' @description
#' Shortcuts for \code{textProperties}, \code{parProperties},
#' \code{borderProperties} and \code{cellProperties}.
#' @param ... further arguments passed to original functions.
#' @rdname shortcut_properties
#' @aliases shortcut_properties


#' @export
#' @examples
#' textNormal()
#' @rdname shortcut_properties
textNormal = function(...) {textProperties( ... )}


#' @rdname shortcut_properties
#' @export
#' @examples
#' textBold()
textBold = function(...) {textProperties( font.weight = "bold", ... )}




#' @rdname shortcut_properties
#' @export
#' @examples
#' textItalic()
textItalic = function( ... ) {textProperties( font.style = "italic", ... )}


#' @rdname shortcut_properties
#' @export
#' @examples
#' textBoldItalic()
textBoldItalic = function( ... ) {textProperties( font.weight = "bold", font.style = "italic", ... )}


#' @rdname shortcut_properties
#' @export
#' @examples
#' parRight()
parRight = function( ... ) {parProperties( text.align = "right", ... )}


#' @rdname shortcut_properties
#' @export
#' @examples
#' parLeft()
parLeft = function( ... ) {parProperties( text.align = "left", ... )}

#' @rdname shortcut_properties
#' @export
#' @examples
#' parLeft()
parCenter = function( ... ) {parProperties( text.align = "center", ... )}


#' @rdname shortcut_properties
#' @export
#' @examples
#' parLeft()
parJustify = function( ... ) {parProperties( text.align = "justify", ... )}


#' @rdname shortcut_properties
#' @export
#' @examples
#' borderDotted()
borderDotted = function( ... )  {borderProperties( style="dotted", ... )}



#' @rdname shortcut_properties
#' @export
#' @examples
#' borderDashed()
borderDashed = function( ... )  {borderProperties( style="dashed", ... )}



#' @rdname shortcut_properties
#' @export
#' @examples
#' borderNone()
borderNone = function( ... )  {borderProperties( style="none", ... )}



#' @rdname shortcut_properties
#' @export
#' @examples
#' borderSolid()
borderSolid = function( ... )  {borderProperties( style = "solid", ... )}

#' @rdname shortcut_properties
#' @export
#' @examples
#' cellBorderNone()
cellBorderNone = function( ... )  {
  cellProperties( border.left = borderNone(),
                  border.top = borderNone(),
                  border.bottom = borderNone(),
                  border.right = borderNone(),
                  ... )
}

#' @rdname shortcut_properties
#' @export
#' @examples
#' cellBorderBottom()
cellBorderBottom = function( ... )  {
  cellProperties( border.left = borderNone(),
                  border.top = borderNone(),
                  border.bottom = borderSolid(),
                  border.right = borderNone(),
                  ... )
}

#' @rdname shortcut_properties
#' @export
#' @examples
#' cellBorderTop()
cellBorderTop = function( ... )  {
  cellProperties( border.left = borderNone(),
                  border.top = borderSolid(),
                  border.bottom = borderNone(),
                  border.right = borderNone(),
                  ... )
}
#' @rdname shortcut_properties
#' @export
#' @examples
#' cellBorderTB()
cellBorderTB = function( ... )  {
  cellProperties( border.left = borderNone(),
                  border.top = borderSolid(),
                  border.bottom = borderSolid(),
                  border.right = borderNone(),
                  ... )
}

