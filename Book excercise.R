library(tidyverse)
library(palmerpenguins)
library(nycflights13)
library(gapminder)
library(ggrepel)
library(scales)
library(here)

# Aesthetic Mappings

view(mpg)

glimpse(mpg)

#3 variable visualisation scatterplot 
ggplot(mpg,aes(x = displ, y= hwy, color = class)) +
  geom_point()
# Visualisation class using channel of shape
ggplot(mpg,aes(x = displ, y= hwy, shape = class)) +
  geom_point()
# Visualisation class using channel of size
ggplot(mpg, aes(x = displ, y = hwy, size = class)) +
  geom_point()
# Visualisation class using intensity through alpha
ggplot(mpg, aes(x = displ, y = hwy, alpha = class)) +
  geom_point()

# Define the color of the points
ggplot(mpg, aes(x = displ, y = hwy)) + 
geom_point(color = "blue")
#we can add transparency to the color
ggplot(mpg, aes(x = displ, y = hwy,alpha=class)) + 
  geom_point(color = "blue")

# Exercises
 #Create a scatterplot of hwy versus displ where the points are pink filled-in triangles.
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(color = "blue", fill = 'blue' ,shape=17)

# Why did the following code not result in a plot with blue points?

# Answer
# color = "blue" inside aes(), ggplot thinks "blue" is a categorical variable.

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, color = "blue"))

# How to fix it

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy), color = "blue")

# What does the stroke aesthetic do? What shapes does it work with? (Hint: Use ?geom_point.)
ggplot(mpg, aes(x = displ, y = hwy,)) + 
  geom_point(color = "blue", fill = 'blue' ,shape=17,stroke = 5)
# Stroke change the size of the marks

# What happens if you map an aesthetic to something other than a variable name, like aes(color = displ < 5)? Note, you’ll also need to specify x and y.

ggplot(mpg, aes(x = displ, y = hwy, color = displ <5)) + 
  geom_point(shape=17)
# It use the color to crate a boolean variable 

# GEOMETRIC OBJECTS
#Track a regression line
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_smooth(method = 'loess')

# add more variables

ggplot(mpg,aes(x = displ,y = hwy,shape = drv)) +
  geom_smooth()

#Here, geom_smooth() separates the cars into three lines based on their drv valuegeom_smooth()
ggplot(mpg, aes(x = displ, y = hwy, linetype = drv)) + 
  geom_smooth()

# overlapping the regression to the scatterplot

ggplot(mpg,aes(x = displ,y = hwy,color = drv)) +
  geom_point()+
  geom_smooth(aes(linetype = drv))


ggplot(mpg,aes(x = displ,y = hwy,color = drv)) +
  
  geom_smooth(aes(color = drv),show.legend = FALSE)

# we can assign color to the geom_points

ggplot(mpg,aes(x=displ,y=hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth()

# can specifiy a class to be highlighted in the chart using filter 
ggplot(mpg,aes(x = displ,y = hwy)) +
  geom_point() +
  geom_point(data = mpg |> filter (class == '2seater'),color = 'red') +
  geom_point(
    data = mpg |> filter(class == "2seater"), 
    shape = "circle open", size = 3, color = "red"
  )

# Histplot 
ggplot(mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 2)

# densityplot  
ggplot(mpg, aes(x = hwy)) +
  geom_density()

#boxplot
ggplot(mpg, aes(x = hwy)) +
  geom_boxplot()

#the ggridges package is useful for making ridgeline plots, which can be useful for visualizing the density of a numerical variable for different levels of a categorical variable.
install.packages('ggridges')
library(ggridges)

ggplot(mpg, aes(x = hwy, y = drv, fill = drv, color = drv)) +
  geom_density_ridges(alpha = 0.5, show.legend = FALSE)

# Excercises

# What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
# Line
ggplot(mpg,aes(x = displ,y= hwy)) +
  geom_line() #smooth for a smooth line
# boxplot
ggplot(mpg,aes(x = displ,y= hwy)) +
  geom_boxplot()
# histplot
ggplot(mpg,aes(x = displ)) +
  geom_histogram(binwidth = 2)

#What does show.legend = FALSE do here? What happens if you remove it? 

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(color = drv), show.legend = TRUE)

# legend can be removed using FALSE
ggplot(mpg,aes(x = displ,y= hwy)) +
  geom_smooth(se = TRUE)
#SE add the standard error

# Re-create the R code necessary to generate the following graphs. Note that wherever a categorical variable is used in the plot, it’s drv.
ggplot(mpg,aes(x = displ,y = hwy)) +
  geom_point(aes(size = drv)) +
  geom_smooth(se = FALSE)
# add linetype
ggplot(mpg,aes(x = displ,y = hwy)) +
  geom_point(aes(size = drv)) +
  geom_smooth(aes(linetype = drv),se = FALSE)
# add color
ggplot(mpg,aes(x = displ,y = hwy)) +
  geom_point(aes(color = drv),size = 1) +
  geom_smooth(aes(linetype = drv),se = FALSE)
#scatterplot 

ggplot(mpg, aes(x = displ, y = hwy,color = drv)) +
  geom_point(shape = 1,size = 3,stroke = 1.5)

#Facet splits a plot into subplots that each display one subset of the data based on a categorical variable.
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~cyl)

# "free_x" will allow for different scales across rows, and "free_y" will allow for different scales across columns.

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl, scales = "free_y")
