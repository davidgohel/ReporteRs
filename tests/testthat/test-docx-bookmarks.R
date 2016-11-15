context("docx bookmarks")
library(xml2)

test_that("bookmark is kept and stylename is used", {

  target_file <- tempfile(fileext = ".docx") # file to produce
  target_dir <- tempfile(fileext = "") # file to produce

  template <- system.file(package = "ReporteRs",
                          "templates/bookmark_example.docx" ) # template example

  doc <- docx( template = template )
  doc <- addParagraph(doc, value = "ipsem",
               stylename = "figurereference",
               bookmark = "DATA")
  writeDoc(doc, target_file)
  unzip(zipfile = target_file, exdir = target_dir )

  doc <- read_xml(file.path(target_dir, "word/document.xml"))

  bkm <- xml_find_first(doc, ".//w:bookmarkStart[@w:name='DATA']")
  expect_false( inherits(bkm, "xml_missing"))

  pstyle <- bkm %>% xml_parent() %>% xml_find_first("w:pPr/w:pStyle")
  expect_equivalent( xml_attr(pstyle, "val"), "figurereference" )

})

