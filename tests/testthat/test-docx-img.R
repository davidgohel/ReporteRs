context("docx images")

png(filename = "img.png", width = 4*72, height = 4*72)
plot.new()
points(.5,.5)
dev.off()

test_that("[docx] image with no size generate an error", {
  doc <- docx( )
  doc <- try( addImage(doc, "img.png"), silent = TRUE)
  expect_is(doc, "try-error" )
})

test_that("[docx] image with size generate no error", {
  doc <- docx( )
  doc <- try( addImage(doc, "img.png",
                       width = 4, height = 4 ), silent = TRUE)
  expect_is(doc, "docx" )
})


unlink("img.png", force = TRUE)
