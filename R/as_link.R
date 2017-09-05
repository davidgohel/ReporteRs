#' @importFrom htmltools tags
#' @export
#' @title Office Web Viewer
#' @description Produce an iframe linked to Office Web Viewer. It let's you
#' display a Microsoft Office document in a Web browser.
#' @param url file url
#' @param width iframe width - deprecated
#' @param height iframe height - deprecated
office_web_viewer <- function(url, width = "80%", height="500px"){
  tags$p(  tags$span("Download file "),
                      tags$a(basename(url), href = url),
                      tags$span(" - view with"),
                      tags$a("office web viewer", target="_blank",
                                        href = paste0("https://view.officeapps.live.com/op/view.aspx?src=", url)
                      ),
                      style="text-align:center;font-style:italic;color:gray;"
  )
}