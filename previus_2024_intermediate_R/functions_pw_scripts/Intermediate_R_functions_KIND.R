#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# RStudio Workbench is strictly for use by Public Health Scotland staff and     
# authorised users only, and is governed by the Acceptable Usage Policy https://github.com/Public-Health-Scotland/R-Resources/blob/master/posit_workbench_acceptable_use_policy.md.
#
# This is a shared resource and is hosted on a pay-as-you-go cloud computing
# platform.  Your usage will incur direct financial cost to Public Health
# Scotland.  As such, please ensure
#
#   1. that this session is appropriately sized with the minimum number of CPUs
#      and memory required for the size and scale of your analysis;
#   2. the code you write in this script is optimal and only writes out the
#      data required, nothing more.
#   3. you close this session when not in use; idle sessions still cost PHS
#      money!
#
# For further guidance, please see https://github.com/Public-Health-Scotland/R-Resources/blob/master/posit_workbench_best_practice_with_r.md.
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


library(tidyverse) 
library(palmerpenguins) 

my_funct <- function(num, num2 = 88) {
  
  num * num2
  
}

my_funct(99, 81) 
my_funct("0", 1) 


# Sophie's function 
# palmerpenguins::penguins |>
#   filter(island == input$island_choice) |>
#   ggplot()+
#   geom_point(aes(x=flipper_length_mm,
#                  y=bill_depth_mm,
#                  colour=species)) 

# namespacing the select function cos is very common 
# dplyr::select()

my_penguin_plot <- function(caption = "Brand new plot", configurable_shape) {

  palmerpenguins::penguins |>
    filter(island == "Torgersen") |>
    ggplot()+
    geom_point(aes(x=flipper_length_mm,
                   y=bill_depth_mm,
                   colour=species),
               shape = configurable_shape,
               size = 12
               ) + ggtitle(caption)

}

my_penguin_plot("funky caption", 20)


my_penguin_plot <- function(configurable_shape) {
  
  palmerpenguins::penguins |>
    filter(island == "Torgersen") |>
    ggplot()+
    geom_point(aes(x=flipper_length_mm,
                   y=bill_depth_mm,
                   colour=species),
               shape = configurable_shape,
               size = 12
    )
  
} 

my_penguin_plot(17)

my_penguin_plot <- function(configurable_shape, configurable_size) {
  
  palmerpenguins::penguins |>
    filter(island == "Torgersen") |>
    ggplot()+
    geom_point(aes(x=flipper_length_mm,
                   y=bill_depth_mm,
                   colour=species),
               shape = configurable_shape,
               size = configurable_size
    )
  
} 

my_penguin_plot(17, 4) 

pen_plot <- function(var, island_input, shape_input, size_input){
  
  palmerpenguins::penguins |>
    # filter(island == "Torgersen") |>
    filter(island == island_input) |>
    ggplot() +
    geom_point(aes(x = {{var}},
                    y = bill_depth_mm,
                   colour = species),
               shape = shape_input,
               size = size_input)
  
  
} # function boilerplate

# {{var}} ... is the syntax for telling it to look in the data for this , for var. 
# because data masking breaks down within functions


pen_plot(bill_length_mm, "Torgersen", 1, 3)
pen_plot(bill_length_mm, "Biscoe", 1, 9)
pen_plot(flipper_length_mm, "Dream", 2, 5)

# Much better to name your arguments, so that if you want to change the order, or 
# if you think you'll use the default a lot, 
# all will still work. 
