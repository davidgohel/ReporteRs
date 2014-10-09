\name{list.format}
\alias{list.format}
\title{format ordered and unordered lists}
\usage{
list.format(ol.left = cumsum(rep(0.2, 9)), ol.hanging = rep(0.2, 9),
  ol.text.align = rep("justify", 9), ol.format = rep("decimal", 9),
  ol.pattern = paste0("\%", 1:9, "."), ul.left = cumsum(rep(0.2, 9)),
  ul.hanging = rep(0.2, 9), ul.text.align = rep("justify", 9),
  ul.format = c("disc", "circle", "square", "disc", "circle", "square",
  "disc", "circle", "square"), ul.pattern = paste0("\%", 1:9, " "))
}
\arguments{
  \item{ol.left}{left indent}

  \item{ol.hanging}{hanging}

  \item{ol.text.align}{text alignment - a single character
  value, expected value is one of 'left', 'right',
  'center', 'justify'.}

  \item{ol.format}{(decimal, upperRoman, lowerRoman,
  upperLetter, lowerLetter, ordinal)}

  \item{ol.pattern}{pattern}

  \item{ul.left}{left indent}

  \item{ul.hanging}{hanging}

  \item{ul.text.align}{text alignment - a single character
  value, expected value is one of 'left', 'right',
  'center', 'justify'.}

  \item{ul.symbol}{symbol}
}
\description{
Create formats to use with ordered and unordered lists
}

