context("docx bookmarks")
library(xml2)

test_that("bookmark is kept and stylename is used", {

  skip_if_not(check_valid_java_version())
  target_file <- tempfile(fileext = ".docx") # file to produce
  target_dir <- tempfile(fileext = "") # file to produce

  template <- system.file(package = "ReporteRs",
                          "templates/bookmark_example.docx" ) # template example

  doc <- docx( template = template )
  doc <- addParagraph(doc, value = "ipsem",
               stylename = "figurereference",
               bookmark = "DATA") %>%
    addPlot(fun = function(x) barplot(1:9), bookmark = "PLOT")
  writeDoc(doc, target_file)
  unzip(zipfile = target_file, exdir = target_dir )

  doc <- read_xml(file.path(target_dir, "word/document.xml"))

  bkm <- xml_find_first(doc, ".//w:bookmarkStart[@w:name='PLOT']")
  expect_false( inherits(bkm, "xml_missing"))

  bkm <- xml_find_first(doc, ".//w:bookmarkStart[@w:name='DATA']")
  expect_false( inherits(bkm, "xml_missing"))

  pstyle <- bkm %>% xml_parent() %>% xml_find_first("w:pPr/w:pStyle")
  expect_equivalent( xml_attr(pstyle, "val"), "figurereference" )

})

test_that("manipulate bookmark", {

  skip_if_not(check_valid_java_version())
  template <- system.file(package = "ReporteRs",
                          "templates/bookmark_example.docx" ) # template example

  doc <- docx( template = template )
  expect_equal(sort( list_bookmarks(doc) ),  c("AUTHOR", "DATA", "PLOT", "REVIEWER"))

  doc <- deleteBookmark(doc, "AUTHOR")
  expect_equal(sort( list_bookmarks(doc) ),  c("DATA", "PLOT", "REVIEWER"))

  doc <- deleteBookmark(doc, c("DATA") )
  doc <- deleteBookmark(doc, c("PLOT") )
  doc <- deleteBookmark(doc, c("REVIEWER") )
  expect_equal(sort( list_bookmarks(doc) ),  character(0))
})


test_that("delete content", {

  skip_if_not(check_valid_java_version())
  target_file <- tempfile(fileext = ".docx") # file to produce
  target_dir <- tempfile(fileext = "") # file to produce

  template <- system.file(package = "ReporteRs",
                          "templates/bookmark_example.docx" ) # template example

  doc <- docx( template = template )
  doc <- deleteBookmarkNextContent(doc, "PLOT")
  doc <- deleteBookmarkNextContent(doc, "PLOT")
  writeDoc(doc, target_file)

  unzip(zipfile = target_file, exdir = target_dir )

  doc <- read_xml(file.path(target_dir, "word/document.xml"))

  p_bkm <- xml_find_first(doc, ".//w:bookmarkStart[@w:name='PLOT']") %>% xml_parent()
  next_str <- xml_find_first(doc, paste0( xml_path(p_bkm), "/following-sibling::w:p") ) %>% xml_text()

  expect_equal(next_str, "Below a table")
})


