
cbColors <- list(
  cvi_purples = c("#381532", "#4b1b42", "#5d2252", "#702963",
                  "#833074", "#953784", "#a83e95"),
  cb7 = c('red', 'blue', 'grey39', 'lightsteelblue2', 'orange', 'black', 'pink3')
)

# function that generates an actual colour palette from our simple list of colours
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
scale_colour_cvi_d = function(name) {
  ggplot2::scale_colour_manual(values = cvi_palettes(name,
                                                     type = "discrete"))
}
scale_fill_cvi_d = function(name) {
  ggplot2::scale_fill_manual(values = cvi_palettes(name,
                                                   type = "discrete"))
}
######################## functions so that {ggplot2} understands what to do with our colour palettes

