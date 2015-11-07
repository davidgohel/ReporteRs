context("file creation")

test_that("docx can be written", {
  file <- tempfile(fileext = ".docx")
  doc <- docx()
  doc <- writeDoc(doc = doc, file = file)
  expect_true(file.exists(file))
})

test_that("pptx can be written", {
  file <- tempfile(fileext = ".pptx")
  doc <- pptx()
  doc <- writeDoc(doc = doc, file = file)
  expect_true(file.exists(file))
})

test_that("bsdoc can be written", {
  file <- tempfile(fileext = ".html")
  doc <- bsdoc()
  doc <- writeDoc(doc = doc, file = file)
  expect_true(file.exists(file))
})
