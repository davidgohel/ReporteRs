#' @importFrom shiny tableOutput
#' @importFrom shiny markRenderFunction
#' @importFrom shiny installExprFunction
#' @title FlexTable output for shiny
#'
#' @description Creates a reactive FlexTable that is suitable for
#' assigning to a \code{tableOutput} slot.
#' @param expr An expression that returns a \code{FlexTable} object.
#' @param ... not used
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#' @export
renderFlexTable <- function(expr, ..., env=parent.frame(), quoted=FALSE) {
  func = NULL
  installExprFunction(expr, "func", env, quoted)

  markRenderFunction(tableOutput, function() {
    data <- func()
    return(as.html(data))
  })
}

