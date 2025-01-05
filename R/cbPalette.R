
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
plt + 
  geom_point(aes(color = person), size = 3) + 
  geom_line(aes(color = person), size = 1)

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

######################## testing: call them in the same way we would with any scale_*() function in {ggplot2}
plt +
  geom_point(aes(colour = person), size = 3) +
  geom_line(aes(color = person), size = 1) +
  scale_colour_cvi_d("cb7")
######################## testing: call them in the same way we would with any scale_*() function in {ggplot2}

