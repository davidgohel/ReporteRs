context("bsdoc images")

png(filename = "img.png", width = 4*72, height = 4*72)
plot.new()
points(.5,.5)
dev.off()

test_that("[bsdoc] image with no size generate an error", {
  doc <- bsdoc( )
  doc <- try( addImage(doc, "img.png"), silent = TRUE)
  expect_is(doc, "try-error" )
})

test_that("[bsdoc] image with size generate no error", {
  doc <- bsdoc( )
  doc <- try( addImage(doc, "img.png",
                       width = 4, height = 4 ), silent = TRUE)
  expect_is(doc, "bsdoc" )
})


unlink("img.png", force = TRUE)
