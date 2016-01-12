context("add images options")

png(filename = "img.png", width = 4*72, height = 4*72)
plot.new()
points(.5,.5)
dev.off()

test_that("[pptx] image with no position nor size generate no error", {
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addImage(doc, "img.png"), silent = TRUE)
  expect_is(doc, "pptx" )
})

test_that("[pptx] image with no position but size generate no error", {
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addImage(doc, img.file1,
                       width = 1.39, height = 1.05 ), silent = TRUE)
  expect_is(doc, "pptx" )
})

test_that("[pptx] image with position and size generate no error", {
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addImage(doc, img.file1,
                       offx = 0, offy = 0,
                       width = 1.39, height = 1.05 ), silent = TRUE)
  expect_is(doc, "pptx" )
})

test_that("[pptx] image with position but no size generate an error", {
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try(addImage(doc, img.file1,
                      offx = 0, offy = 0), silent = TRUE)
  expect_is(doc, "try-error" )
})

unlink("img.png", force = TRUE)
