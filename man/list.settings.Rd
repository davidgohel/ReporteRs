\name{list.settings}
\alias{list.settings}
\title{format ordered and unordered lists}
\usage{
list.settings(ol.left = cumsum(rep(0.2, 9)), ol.hanging = rep(0.2, 9),
  ol.format = rep("decimal", 9), ol.pattern = paste0("\%", 1:9, "."),
  ul.left = cumsum(rep(0.2, 9)), ul.hanging = rep(0.2, 9),
  ul.format = c("disc", "circle", "square", "disc", "circle", "square",
  "disc", "circle", "square"), ul.pattern = paste0("\%", 1:9, " "))
}
\arguments{
  \item{ol.left}{left indent}

  \item{ol.hanging}{hanging}

  \item{ol.format}{(decimal, upperRoman, lowerRoman,
  upperLetter, lowerLetter, ordinal)}

  \item{ol.pattern}{pattern}

  \item{ul.left}{left indent}

  \item{ul.hanging}{hanging}

  \item{ul.format}{(disc, circle, square)}

  \item{ul.pattern}{pattern}
}
\description{
Create a description used to format ordered and unordered
lists in object documents.
}

