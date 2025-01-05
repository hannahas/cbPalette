
<!-- README.md is generated from README.Rmd. Please edit that file -->

**NOTE: The str_split_one is a toy package created for expository
purposes, for the second edition of [R Packages](https://r-pkgs.org). It
is not meant to actually be useful. If you want a package for factor
handling, please see [stringr](https://stringr.tidyverse.org),
[stringi](https://stringi.gagolewski.com/),
[rex](https://cran.r-project.org/package=rex), and
[rematch2](https://cran.r-project.org/package=rematch2).**

# regexcite

<!-- badges: start -->
<!-- badges: end -->

The goal of regexcite is to make regular expressions more exciting! It
provides convenience functions to make some common tasks with string
manipulation and regular expressions a bit easier.

## Installation

You can install the development version of regexcite from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jennybc/regexcite")
```

## Usage

A fairly common task when dealing with strings is the need to split a
single string into many parts. This is what `base::strplit()` and
`stringr::str_split()` do.

``` r
(x <- "alfa,bravo,charlie,delta")
#> [1] "alfa,bravo,charlie,delta"
strsplit(x, split = ",")
#> [[1]]
#> [1] "alfa"    "bravo"   "charlie" "delta"
stringr::str_split(x, pattern = ",")
#> [[1]]
#> [1] "alfa"    "bravo"   "charlie" "delta"
```

Notice how the return value is a **list** of length one, where the first
element holds the character vector of parts. Often the shape of this
output is inconvenient, i.e. we want the un-listed version.

That’s exactly what `regexcite::str_split_one()` does.

``` r
library(cbPalette)

str_split_one(x, pattern = ",")
#> [1] "alfa"    "bravo"   "charlie" "delta"
```

Use `str_split_one()` when the input is known to be a single string. For
safety, it will error if its input has length greater than one.

`str_split_one()` is built on `stringr::str_split()`, so you can use its
`n` argument and stringr’s general interface for describing the
`pattern` to be matched.

``` r
str_split_one(x, pattern = ",", n = 2)
#> [1] "alfa"                "bravo,charlie,delta"

y <- "192.168.0.1"
str_split_one(y, pattern = stringr::fixed("."))
#> [1] "192" "168" "0"   "1"
```

Let’s test the cbPalette part

``` r
library(ggplot2)
######################## Make data frame for plot ######################
# Set the seed for reproducibility
set.seed(123)

# Define the number of months
months <- 24
# Define person names
person_names <- c("Adam", "Matt", "Sarah", "Ben", "Katie", "Cara", "Bob")

# Create a data frame with repeating months and corresponding person names
df <- expand.grid(month = 1:months, person = person_names)

# Assign initial weights randomly within a realistic range, say 120 to 180 lbs
initial_weights <- runif(length(person_names), min = 120, max = 180)

# Map initial weights to persons
weights_map <- setNames(initial_weights, person_names)

# Assign base weight to each person
df$weight <- weights_map[as.character(df$person)]

# Apply a personal variation (~20%)
df$weight <- df$weight * (1 + runif(nrow(df), -0.1, 0.1))

# Apply monthly fluctuation (~10%)
monthly_fluctuation <- 0.1

# Modify weights per month to introduce mild fluctuations
for (i in 1:nrow(df)) {
  # Simulate monthly weight fluctuation
  fluctuation <- df$weight[i] * runif(1, -monthly_fluctuation, monthly_fluctuation)
  df$weight[i] <- df$weight[i] + fluctuation
}

# Convert 'person' column to a factor to make it categorical
df$person <- factor(df$person)
######################## Make data frame for plot ######################

######################## Make ggplot object ######################
plt <- ggplot(df, mapping = aes(x = month, y = weight)) +
scale_y_continuous(limits = c(100, 230))
######################## Make ggplot object ######################

######################## Example plot with default ggplot colors ######################
normalPlot <- plt +
  geom_point(aes(color = person), size = 3) +
  geom_line(aes(color = person), linewidth = 1)
print(normalPlot)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

``` r
######################## Example plot with default ggplot colors ######################

######################## testing: call them in the same way we would with any scale_*() function in {ggplot2}
cbPlot <- plt +
 geom_point(aes(colour = person), size = 3) +
  geom_line(aes(color = person), linewidth = 1) +
  scale_colour_cvi_d("cb7")
print(cbPlot)
```

<img src="man/figures/README-unnamed-chunk-5-2.png" width="100%" />

``` r
######################## testing: call them in the same way we would with any scale_*() function in {ggplot2}
```
