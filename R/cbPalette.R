#' Generate an actual colour palette from our simple list of colours
#'
#' @return a color palette
#' @export
#'
#' @examples
#' mypalette <- cbPalette()
cbPalette <- function() {
  palette = c('red', 'blue', 'grey39', 'lightsteelblue2', 'orange', 'black', 'pink3')
  n = length(palette)
  print(n)
  out = palette[1:n]
  structure(out, class = "palette")
}

######################## functions so that {ggplot2} understands what to do with our colour palettes
#' Function for ggplot to recognize palette (colour, for geom_point)
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
#'   scale_colour_cb()
scale_colour_cb = function() {
  ggplot2::scale_colour_manual(values = cbPalette())
}

#' Function for ggplot to recognize palette (fill, for geom_bar)
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
#'   scale_fill_cb()
scale_fill_cb = function() {
  ggplot2::scale_fill_manual(values = cbPalette())
}
