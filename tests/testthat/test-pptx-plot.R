context("pptx plot")

library(ggplot2)

dummy_plot <- function(){
  plot.new()
  points(.5,.5)
}

test_that("[vg] no position no size generate no error", {
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addPlot(doc, fun = dummy_plot, vector.graphic = TRUE), silent = TRUE)
  expect_is(doc, "pptx" )
})

test_that("[raster] no position no size generate no error", {
  skip_on_os("solaris")
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      vector.graphic = FALSE), silent = TRUE)
  expect_is(doc, "pptx" )
})

test_that("[vg] no position but size generate no error", {
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      width = 4, height = 4, vector.graphic = TRUE),
              silent = TRUE)
  expect_is(doc, "pptx" )
})

test_that("[raster] no position but size generate no error", {
  skip_on_os("solaris")
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      width = 4, height = 4, vector.graphic = FALSE),
              silent = TRUE)
  expect_is(doc, "pptx" )
})

test_that("[vg] position and size generate no error", {
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      offx = 0, offy = 0,
                      width = 4, height = 4, vector.graphic = TRUE),
              silent = TRUE)
  expect_is(doc, "pptx" )
})

test_that("[raster] position and size generate no error", {
  skip_on_os("solaris")
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      offx = 0, offy = 0,
                      width = 4, height = 4, vector.graphic = FALSE),
              silent = TRUE)
  expect_is(doc, "pptx" )
})

test_that("[vg] position but no size generate an error", {
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      offx = 0, offy = 0, vector.graphic = TRUE),
              silent = TRUE)
  expect_is(doc, "try-error" )
})

test_that("[raster] position but no size generate an error", {
  skip_on_os("solaris")
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addPlot(doc, fun = dummy_plot,
                      offx = 0, offy = 0, vector.graphic = FALSE),
              silent = TRUE)
  expect_is(doc, "try-error" )
})

test_that("[vg] test raster", {
  myplot <- qplot(Sepal.Length, Petal.Length,
                   data = iris, color = Petal.Width,
                   alpha = I(0.7) )
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- try( addPlot(doc, fun = print,
                      x = myplot,
                      vector.graphic = TRUE), silent = TRUE)
  expect_is(doc, "pptx" )
})



test_that("raster plot is referenced in relationships", {
  skip_on_os("solaris")
  myplot <- qplot(Sepal.Length, Petal.Length,
                  data = iris, color = Petal.Width,
                  alpha = I(0.7) )
  target_file <- tempfile(fileext = ".pptx")
  target_dir <- tempfile(fileext = "")
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- addPlot(doc, fun = print,
                 x = myplot,
                 vector.graphic = TRUE)
  writeDoc(doc, target_file)

  unzip(zipfile = target_file, exdir = target_dir )
  rels <- get_relationship(file.path(target_dir, "ppt/slides/_rels/slide1.xml.rels"))
  expect_equal( sum( grepl( "image$", rels$type ) ), 1 )


  # vg with a raster
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- addPlot(doc, fun = print,
                 x = myplot,
                 vector.graphic = TRUE)
  writeDoc(doc, target_file)

  unzip(zipfile = target_file, exdir = target_dir )
  rels <- get_relationship(file.path(target_dir, "ppt/slides/_rels/slide1.xml.rels"))
  expect_equal( sum( grepl( "image$", rels$type ) ), 1 )
})


test_that("vg plot is not referenced in relationships", {
  skip_on_os("solaris")
  myplot <- qplot(Sepal.Length, Petal.Length, data = iris )
  target_file <- tempfile(fileext = ".pptx")
  target_dir <- tempfile(fileext = "")
  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- addPlot(doc, fun = print,
                 x = myplot,
                 vector.graphic = TRUE)
  writeDoc(doc, target_file)

  unzip(zipfile = target_file, exdir = target_dir )
  rels <- get_relationship(file.path(target_dir, "ppt/slides/_rels/slide1.xml.rels"))
  expect_equal( sum( grepl( "image$", rels$type ) ), 0 )
})
