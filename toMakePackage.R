# Commands to make package
library(devtools)
packageVersion("devtools")
create_package("/Users/ahannah/Desktop/cbPalette")
library(devtools)
# The regexcite directory is an R source package and an RStudio Project.
# Now we make it also a Git repository, with use_git()
use_git()
# Call load_all() to make strsplit1() available for experimentation.
load_all()
# Call str_split1() to see how it works
(x <- "alfa,bravo,charlie,delta")
strsplit1(x, split = ",")
# Run the code in 'testcbPalette.R' to see if cbPalette works
# runCodeHere
# Now make initial commit to Github by running on Terminal:


