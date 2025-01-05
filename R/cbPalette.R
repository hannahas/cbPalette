
cbColors <- list(
  cvi_purples = c("#381532", "#4b1b42", "#5d2252", "#702963",
                  "#833074", "#953784", "#a83e95"),
  cb7 = c('red', 'blue', 'grey39', 'lightsteelblue2', 'orange', 'black', 'pink3')
)

#' Generate an actual colour palette from our simple list of colours
#'
#' @param name Name of the color palette we want to use
#' @param n How many colors to use (default to full length of palette)
#' @param all_palettes the list of colour palettes we want to extract our choice from
#' @param type discrete or continuous palette
#'
#' @return a color palette
#' @export
#'
#' @examples
#' cbColors <- list(
#'   cvi_purples = c("#381532", "#4b1b42", "#5d2252", "#702963",
#'                 "#833074", "#953784", "#a83e95"),
#'   cb7 = c('red', 'blue', 'grey39', 'lightsteelblue2', 'orange', 'black', 'pink3')
#' )
#' mypalette <- cvi_palettes("cb7", type = "discrete")
cvi_palettes <- function(name, n, all_palettes = cbColors, type = c("discrete", "continuous")) {
  palette = all_palettes[[name]]
  if (missing(n)) {
    n = length(palette)
  }
  type = match.arg(type)
  out = switch(type,
               continuous = grDevices::colorRampPalette(palette)(n),
               discrete = palette[1:n]
  )
  structure(out, name = name, class = "palette")
}

######################## functions so that {ggplot2} understands what to do with our colour palettes
#' Function for ggplot to recognize palette (colour, for geom_point)
#'
#' @param name color palette to use
#'
#' @return ggplot palette
#' @importFrom ggplot2 ggplot aes
#' @export
#'
#' @examples
#' library(ggplot2)
#' months <- 24
#' person_names <- c("Adam", "Matt", "Sarah", "Ben", "Katie", "Cara", "Bob")
#' df <- expand.grid(month = 1:months, person = person_names)
#' initial_weights <- runif(length(person_names), min = 120, max = 180)
#' weights_map <- setNames(initial_weights, person_names)
#' df$weight <- weights_map[as.character(df$person)]
#' df$weight <- df$weight * (1 + runif(nrow(df), -0.1, 0.1))
#' df$person <- factor(df$person)
#' plt <- ggplot(df, mapping = aes(x = month, y = weight)) +
#' scale_y_continuous(limits = c(100, 230))
#' plt +
#' geom_point(aes(colour = person), size = 3) +
#'   geom_line(aes(color = person), linewidth = 1) +
#'   scale_colour_cvi_d("cb7")
scale_colour_cvi_d = function(name) {
  ggplot2::scale_colour_manual(values = cvi_palettes(name,
                                                     type = "discrete"))
}

#' Function for ggplot to recognize palette (fill, for geom_bar)
#'
#' @param name color palette to use
#'
#' @return ggplot palette
#' @importFrom ggplot2 ggplot aes
#' @export
#'
#' @examples
#' library(ggplot2)
#' months <- 24
#' person_names <- c("Adam", "Matt", "Sarah", "Ben", "Katie", "Cara", "Bob")
#' df <- expand.grid(month = 1:months, person = person_names)
#' initial_weights <- runif(length(person_names), min = 120, max = 180)
#' weights_map <- setNames(initial_weights, person_names)
#' df$weight <- weights_map[as.character(df$person)]
#' df$weight <- df$weight * (1 + runif(nrow(df), -0.1, 0.1))
#' df$person <- factor(df$person)
#' plt <- ggplot(df, mapping = aes(x = month, y = weight)) +
#' scale_y_continuous(limits = c(100, 230))
#' plt +
#' geom_point(aes(colour = person), size = 3) +
#'   geom_line(aes(color = person), linewidth = 1) +
#'   scale_fill_cvi_d("cb7")
scale_fill_cvi_d = function(name) {
  ggplot2::scale_fill_manual(values = cvi_palettes(name,
                                                   type = "discrete"))
}
######################## functions so that {ggplot2} understands what to do with our colour palettes

