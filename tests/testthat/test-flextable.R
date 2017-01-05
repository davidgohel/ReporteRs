context("FlexTable")

library(xml2)

pptx_doc <- function(flextable){
  target_file <- tempfile(fileext = ".pptx")
  target_dir <- tempfile(fileext = "")

  doc <- pptx( )
  doc <- addSlide( doc, "Title and Content" )
  doc <- addFlexTable(doc, flextable = flextable)
  writeDoc(doc, target_file)

  unzip(zipfile = target_file, exdir = target_dir )
  target_dir
}


test_that("header rows", {

  row1 <- c("Sepal", "Petal", "")
  row2 <- c("Length", "Width", "Length", "Width", "Species")

  ft1 <- FlexTable( data = iris[46:55, ], header.columns = FALSE )
  ft1 <- addHeaderRow( ft1, value = row1, colspan = c( 2, 2, 1) )
  ft1 <- addHeaderRow( ft1, value = row2 )

  ft2 <- FlexTable( data = iris[46:55, ], header.columns = TRUE )
  ft2 <- addHeaderRow( ft2, value = row1, colspan = c( 2, 2, 1), first = TRUE )



  target_dir <- pptx_doc(flextable = ft1)

  doc <- read_xml(file.path(target_dir, "ppt/slides/slide1.xml"))

  xml_path_0 <- c("/p:sld/p:cSld/p:spTree/p:graphicFrame/a:graphic/a:graphicData",
                      "/a:tbl/a:tr[1]",
                      "/a:tc/a:txBody/a:p/a:r/a:t")

  xml_path_ <- paste(xml_path_0, collapse = "")
  hvalues <- xml_find_all(doc, xml_path_) %>% xml_text()
  expect_equal( hvalues, row1 )

  xml_path_1 <- xml_path_0[2] <- "/a:tbl/a:tr[2]"
  xml_path_ <- paste(xml_path_0, collapse = "")
  hvalues <- xml_find_all(doc, xml_path_) %>% xml_text()
  expect_equal( hvalues, row2 )


  target_dir <- pptx_doc(flextable = ft2)

  doc <- read_xml(file.path(target_dir, "ppt/slides/slide1.xml"))

  xml_path_0 <- c("/p:sld/p:cSld/p:spTree/p:graphicFrame/a:graphic/a:graphicData",
                  "/a:tbl/a:tr[1]",
                  "/a:tc/a:txBody/a:p/a:r/a:t")

  xml_path_ <- paste(xml_path_0, collapse = "")
  hvalues <- xml_find_all(doc, xml_path_) %>% xml_text()
  expect_equal( hvalues, row1 )

  xml_path_1 <- xml_path_0[2] <- "/a:tbl/a:tr[2]"
  xml_path_ <- paste(xml_path_0, collapse = "")
  hvalues <- xml_find_all(doc, xml_path_) %>% xml_text()
  expect_equal( hvalues, names(iris) )

})


