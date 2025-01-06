library(testthat)
library(ggplot2)
library(cbPalette)

test_that("scale_colour_cvi_d applies correct palette", {
  # Assume ggplot2 and your package are loaded

  # Create a simple data frame
  df <- data.frame(x = 1:7, y = 1:7, group = factor(1:7))

  # Create a ggplot object using the palette
  p <- ggplot(df, aes(x, y, color = group)) +
    geom_point() +
    scale_colour_cvi_d("cb7")

  x <- ggplot_build(p)$data
  actual_colours <- x[[1]]$colour

  # Define expected colors
  expected_colours <- c("red", "blue", "grey39", "lightsteelblue2", "orange", "black", "pink3")

  # Check if the actual colors match expected colors
  # expect_equal(actual_colours, expected_colours, tolerance = 1e-2)
  expect_true(setequal(expected_colours, actual_colours))
})

