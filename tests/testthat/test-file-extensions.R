context("file extensions")

test_that("pptx extension must be pptx", {
  skip_if_not(check_valid_java_version())
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  res <- try( writeDoc(doc, "doc_1.pptx"), silent = TRUE )
  expect_null( res )

  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  res <- try( writeDoc(doc, "doc_1.ppt"), silent = TRUE )
  expect_is( res, "try-error" )
})

test_that("docx extension must be docx", {
  skip_if_not(check_valid_java_version())
  doc <- docx( )
  res <- try( writeDoc(doc, "doc_2.docx"), silent = TRUE )
  expect_null( res )

  doc <- docx( )
  res <- try( writeDoc(doc, "doc_2.doc"), silent = TRUE )
  expect_is( res, "try-error" )
})


unlink(list.files(pattern = "^doc_"), force = TRUE, recursive = TRUE)

