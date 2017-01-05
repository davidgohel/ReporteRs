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
docx_doc <- function(flextable){
  target_file <- tempfile(fileext = ".docx")
  target_dir <- tempfile(fileext = "")

  doc <- docx( )
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




  target_dir <- docx_doc(flextable = ft1)

  doc <- read_xml(file.path(target_dir, "word/document.xml"))

  header_rows <- xml_find_all(doc, "/w:document/w:body/w:tbl/w:tr[./w:trPr/w:tblHeader]")
  hvalues <- lapply( paste0( sapply(header_rows, xml_path), "/w:tc/w:p/w:r/w:t" ),
          function(x) xml_find_all(doc, x) %>% xml_text() )
  expect_equal( hvalues[[1]], row1 )
  expect_equal( hvalues[[2]], row2 )


  target_dir <- docx_doc(flextable = ft2)

  doc <- read_xml(file.path(target_dir, "word/document.xml"))

  header_rows <- xml_find_all(doc, "/w:document/w:body/w:tbl/w:tr[./w:trPr/w:tblHeader]")
  hvalues <- lapply( paste0( sapply(header_rows, xml_path), "/w:tc/w:p/w:r/w:t" ),
                     function(x) xml_find_all(doc, x) %>% xml_text() )
  expect_equal( hvalues[[1]], row1 )
  expect_equal( hvalues[[2]], names(iris) )

})

test_that("footer rows", {

  row1 <- c("Sepal", "Petal", "")
  ft1 <- vanilla.table( data = head( iris, n = 3 ) )
  ft1 <- addFooterRow( ft1, value = row1, colspan = c( 2, 2, 1) )

  target_dir <- pptx_doc(flextable = ft1)

  doc <- read_xml(file.path(target_dir, "ppt/slides/slide1.xml"))

  xml_path_0 <- c("/p:sld/p:cSld/p:spTree/p:graphicFrame/a:graphic/a:graphicData",
                  "/a:tbl/a:tr[5]",
                  "/a:tc/a:txBody/a:p/a:r/a:t")

  xml_path_ <- paste(xml_path_0, collapse = "")
  hvalues <- xml_find_all(doc, xml_path_) %>% xml_text()
  expect_equal( hvalues, row1 )



  target_dir <- docx_doc(flextable = ft1)

  doc <- read_xml(file.path(target_dir, "word/document.xml"))
  all_rows <- xml_find_all(doc, "/w:document/w:body/w:tbl/w:tr")
  hvalues <- lapply( paste0( sapply(tail(all_rows, n = 1), xml_path), "/w:tc/w:p/w:r/w:t" ),
                     function(x) xml_find_all(doc, x) %>% xml_text() )
  expect_equal( hvalues[[1]], row1 )
})



test_that("annotate table", {

  data_ <- data.frame(x = character(3), y = character(3))
  ft1 <- vanilla.table( data = data_ )
  ft1[1,1:2] <- "Hi"
  ft1[2,1] <- pot("Yep", textBold())
  ft1[3,2] <- "Yo"
  ft1[1,1, to = "header"] <- "zzz"
  ft1[1,2, to = "header"] <- pot("aaa", textBold())

  target_dir <- pptx_doc(flextable = ft1)
  doc <- read_xml(file.path(target_dir, "ppt/slides/slide1.xml"))
  xml_path_0 <- c("/p:sld/p:cSld/p:spTree/p:graphicFrame/a:graphic/a:graphicData",
                  "/a:tbl/a:tr",
                  "/a:tc")
  xml_path_ <- paste(xml_path_0, collapse = "")
  hvalues <- xml_find_all(doc, xml_path_) %>% xml_text()
  expect_equal( hvalues, c("xzzz", "yaaa", "Hi", "Hi", "Yep", "", "", "Yo") )


  target_dir <- docx_doc(flextable = ft1)
  doc <- read_xml(file.path(target_dir, "word/document.xml"))
  hvalues <- xml_find_all(doc, "/w:document/w:body/w:tbl/w:tr/w:tc/w:p") %>% xml_text()
  expect_equal( hvalues, c("xzzz", "yaaa", "Hi", "Hi", "Yep", "", "", "Yo") )
})



