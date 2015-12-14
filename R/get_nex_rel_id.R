get_next_relid_pptx = function(doc) {
  slide = doc$current_slide
  str_next_id <- rJava::.jcall( slide, "S", "getNextRelID" )
  str_next_id <- gsub(pattern = "(.*)([0-9]+)$", "\\2", str_next_id )
  as.integer(str_next_id)
}

get_next_relid_docx = function(doc) {
  str_next_id <- rJava::.jcall( doc$obj, "S", "getNextRelID" )
  print(str_next_id)
  str_next_id <- gsub(pattern = "(.*)([0-9]+)$", "\\2", str_next_id )
  as.integer(str_next_id)
}
