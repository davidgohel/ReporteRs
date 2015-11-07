context("dml plots")

plot_fun = function( ){
  barplot(1:10, col = 1:10)
}
plot_fun_invalid = function( ){
  barplot(1:10, col = 1:10)
  plot(1:10)
}

test_that("docx can get dml graph", {
  file <- tempfile(fileext = ".docx")
  doc <- docx()
  doc <- addPlot(doc, fun = plot_fun, vector.graphic = TRUE )
  doc <- writeDoc(doc = doc, file = file)
  expect_true(file.exists(file))
})

test_that("docx cannot get 2 dml graphs", {
  file <- tempfile(fileext = ".docx")
  doc <- docx()
  expect_error(doc <- addPlot(doc, fun = plot_fun_invalid, vector.graphic = TRUE ))
})

test_that("pptx can get dml graph", {
  file <- tempfile(fileext = ".pptx")
  doc <- pptx()
  doc <- addSlide(doc, "Title and Content")
  doc <- addPlot(doc, fun = plot_fun, vector.graphic = TRUE )
  doc <- writeDoc(doc = doc, file = file)
  expect_true(file.exists(file))
})

test_that("pptx cannot get 2 dml graphs", {
  file <- tempfile(fileext = ".pptx")
  doc <- pptx()
  doc <- addSlide(doc, "Title and Content")
  expect_error(doc <- addPlot(doc, fun = plot_fun_invalid, vector.graphic = TRUE ) )
})

test_that("bsdoc can get svg graph", {
  file <- tempfile(fileext = ".html")
  doc <- bsdoc()
  doc <- addPlot(doc, fun = plot_fun, vector.graphic = TRUE )
  doc <- writeDoc(doc = doc, file = file)
  expect_true(file.exists(file))
})

test_that("bsdoc cannot get 2 svg graphs", {
  file <- tempfile(fileext = ".html")
  doc <- bsdoc()
  expect_error(doc <- addPlot(doc, fun = plot_fun_invalid, vector.graphic = TRUE ) )
})
