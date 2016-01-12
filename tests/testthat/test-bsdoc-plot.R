context("bsdoc plot")

dummy_plot <- function(){
  plot.new()
  points(.5,.5)
}

test_that("[vg] no size generate no error", {
  doc <- bsdoc( )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      vector.graphic = TRUE), silent = TRUE)
  expect_is(doc, "bsdoc" )
})
test_that("[raster] no size generate no error", {
  doc <- bsdoc( )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      vector.graphic = FALSE), silent = TRUE)
  expect_is(doc, "bsdoc" )
})

test_that("[vg] size generate no error", {
  doc <- bsdoc( )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      width = 4, height = 4,
                      vector.graphic = TRUE),
              silent = TRUE)
  expect_is(doc, "bsdoc" )
})

test_that("[raster] size generate no error", {
  doc <- bsdoc( )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      width = 4, height = 4,
                      vector.graphic = FALSE),
              silent = TRUE)
  expect_is(doc, "bsdoc" )
})

