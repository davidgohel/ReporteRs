context("docx plot")

library(ggplot2)

dummy_plot <- function(){
  plot.new()
  points(.5,.5)
}

test_that("[vg] no size generate no error", {
  doc <- docx( )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      vector.graphic = TRUE), silent = TRUE)
  expect_is(doc, "docx" )
})
test_that("[raster] no size generate no error", {
  doc <- docx( )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      vector.graphic = FALSE), silent = TRUE)
  expect_is(doc, "docx" )
})

test_that("[vg] size generate no error", {
  doc <- docx( )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      width = 4, height = 4,
                      vector.graphic = TRUE),
              silent = TRUE)
  expect_is(doc, "docx" )
})

test_that("[raster] size generate no error", {
  doc <- docx( )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      width = 4, height = 4,
                      vector.graphic = FALSE),
              silent = TRUE)
  expect_is(doc, "docx" )
})

test_that("[vg] test raster", {
  myplot <- qplot(Sepal.Length, Petal.Length,
                  data = iris, color = Petal.Width,
                  alpha = I(0.7) )
  doc <- docx( )
  doc <- try( addPlot(doc, fun = print,
                      x = myplot,
                      vector.graphic = TRUE), silent = TRUE)
  expect_is(doc, "docx" )
})
