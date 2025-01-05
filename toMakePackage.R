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
# cd ~/Desktop/cbPalette
# git init
# git add .
# git commit -m "Initial commit"
# git remote add origin https://github.com/hannahas/cbPalette.git
# git push -u origin master

# Now check - this doesn't work for me, what am I doing wrong?
# diff --git a/R/cbPalette.R b/R/cbPalette.R

# Check
check()

# Got warning about not declaring ggplot2, so lets do that
use_package("ggplot2")
# That warning disappeared now, great!

# To configure a valid license for the package, call use_mit_license()
use_mit_license()

# open R/strsplit1.R in the source editor and put the cursor somewhere in the strsplit1() function definition.
# Now do Code > Insert roxygen skeleton.
# modify it
# trigger the conversion of this new roxygen comment into man/strsplit1.Rd with document()
document()

# preview help files for the functions I wrote them for
?strsplit1
?cvi_palettes
?scale_colour_cvi_d
?scale_fill_cvi_d

check()
# Getting error about function

rm(list = c("cvi_palettes"))
check()

install()

# Got an error about lazyLoad
# Error: lazy-load database '/Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/library/cbPalette/R/cbPalette.rdb' is corrupt

# Try restarting R and rebuilding
devtools::build()
devtools::install()

# No errors, woo!

# Now attach and use package
library(cbPalette)
x <- "alfa,bravo,charlie,delta"
strsplit1(x, split = ",")
# To test colorblind palette plot, use the testcbPalette.R script - it works!

# Make a formal unit test
use_testthat()

use_test("cbPalette")
# This command creates test-cbPalette.R, which I've edited according to H Wickham instructions

# Now check() will run test-cbPalette.R as part of the check
# It passes!

use_package("stringr")

# Editing the function inside strsplit1.R
# Now I need to rename the file
rename_files("strsplit1", "str_split_one")

# Update the roxygen tag, and update the test-cbPalette.R (Wickham guide)
document()

# Try out the new str_split_one() function by simulating package installation via load_all()
load_all()
str_split_one("a, b, c", pattern = ", ")

