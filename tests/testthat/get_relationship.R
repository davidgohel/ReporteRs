get_relationship <- function( x ) {
  doc <- read_xml( x = x )
  children <- xml_children( doc )
  ns <- xml_ns( doc )
  id <- sapply( children, xml_attr, attr = "Id", ns)
  type <- sapply( children, xml_attr, attr = "Type", ns)
  target <- sapply( children, xml_attr, attr = "Target", ns)
  data.frame(id = id, type = type, target = target, stringsAsFactors = FALSE )
}
