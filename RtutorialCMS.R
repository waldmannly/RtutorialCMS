
## Basics ----

# comment 

# press cmd + enter to run a line (or press the run button in the top right of this editing panel)
x <- 1 + 1 # assignment 
x 
x %% 2  # mod

y <- 1:10
y^2 
sum(y)

getwd()
setwd('../Desktop/RtutorialCMS')

#There is a ton of information online about how to use R, here are a few links:
#https://rcompanion.org/rcompanion/a_06.html 
#https://www.tutorialspoint.com/r/r_data_types.htm

# Matrices and Vectors in R ---- 
x <- c(1,2,3,4,5,6,7,8,9)

x*x # element wise multiplying of a vector
sum(x*x) # dot product 
x%*%x # dot product

# transform a vector into a matrix
matX <- matrix(x , 3,3)

matX
t(matX) # transpose 

matX * t(matX)  # element wise matrix multiplication 
matX %*% t(matX) # usually matrix mutliplication 


matX<- matrix(c(1,2,1, 0,1,0, 0,0,1), 3)
invmatX <- solve(matX) # get the inverse (if the matrix is singualr it will throw an error)
matX %*% invmatX

solve(matX, c(5,4,3)) # solve for an x vector by passing solve(A, b)

#more operations can be found here
#https://www.statmethods.net/advstats/matrix.html


#Function in R ---- 

squarePlusOne <- function(x){
  return(x^2 +1)
}
squarePlusOne(4)

plot( -50:50,squarePlusOne(-50:50))

#using a function from another R file  (that you made)
source('externalFunction.R')  # you can include the path to the file if you need to
function1(1,2)


#using a function from another R file (that someone else made [and is on CRAN])
#install.packages("<the package's name>")
#library("<the package's name>")
#example below

## Solving ODE's in R ---- 
parameters <- c(a = -8/3,b = -10,c = 28)
state <- c(X = 1,Y = 1,Z = 1)

Lorenz<-function(t, state, parameters) {
   with(as.list(c(state, parameters)),{
     # rate of change
       dX <- a*X + Y*Z
       dY <- b * (Y-Z)
       dZ <- -X*Y + c*Y - Z
      
       # return the rate of change
       list(c(dX, dY, dZ))
       }) # end with(as.list ...
   }

times <- seq(0, 100, by = 0.01)

install.packages("deSolve") #this only needs to be run once (and you need an internet connection)
library(deSolve)
out <- ode(y = state, times = times, func = Lorenz, parms = parameters)
head(out)

par(oma = c(0, 0, 3, 0))
plot(out, xlab = "time", ylab = "-")
plot(out[, "X"], out[, "Z"], pch = ".")
mtext(outer = TRUE, side = 3, "Lorenz model", cex = 1.5)

#derivatives
install.packages("Deriv")
library(Deriv)

g <- function(x) x^5 
gdx <- Deriv(g)
gdx(2)

f <- function(x, y) sin(x) * cos(y)
Deriv(f)


## Reading/writing data sets and some graphing ---- 

pkdata <- read.csv("pokemon.csv", header =T)

head(pkdata) # look at the data (this is the first six entries of the data frame )
nrow(pkdata)
ncol(pkdata)

summary(pkdata)

pkdata[2:19]<- NULL
pkdata["japanese_name"]<- NULL

summary(pkdata)

# if we want to look at just one column from a data frame 
pkdata$name

# sorting data according to a column in R 
pkdata.sorted <- pkdata[order(pkdata$pokedex_number),]


#string manipulations 
install.packages("gdata")
library(gdata)
text <- gsub("\\[|\\]|'|'", "", pkdata$abilities)  # delete weird character formatting 
fixedtext<- trim(unlist(lapply(text, strsplit, split=","))) # combine strings into one array and "trim" spaces from front and back

summary(as.data.frame(fixedtext))

unique(fixedtext)


## statistics in R ---- 

#"base" plot 
plot(pkdata$percentage_male,pkdata$attack)
plot(pkdata$percentage_male,pkdata$weight_kg)
plot(pkdata$base_happiness, pkdata$weight_kg )

df = data.frame(happy = pkdata$base_happiness , weight = pkdata$weight_kg )

cor.test( ~ happy + weight, 
          data=df,
          method = "pearson",
          continuity = TRUE,
          conf.level = 0.95)


## Better graphing in R ---- 
install.packages("ggplot2")
library(ggplot2)

ggplot(, aes(-50:50, squarePlusOne(-50:50))) + geom_line(size =2) + theme_bw()+ labs(y="x^2 +1", x="x", title= "Graph")


p = (ggplot(pkdata, aes(pkdata$is_legendary, pkdata$base_total)) + geom_boxplot() +
       labs(title='Sum of Total Stats Separated by\n Type and Legendary Status') +
       facet_wrap(~ pkdata$type1) + 
       theme_classic())
p


converted <- lapply(pkdata$is_legendary, function(x){
if (x == 1){y <- "yes"}
if (x == 0){y <- "no"}
return(y)
})

pkdataNew <- data.frame(pkdata, is_legendWord = unlist(converted)) 

p = (ggplot(pkdataNew, aes(pkdataNew$is_legendWord, pkdataNew$base_total)) + geom_boxplot() +
       labs(title='Sum of Total Stats Separated by\n Type and Legendary Status') +
       facet_wrap(~ pkdataNew$type1) + labs(x="Is Legendary", y="Total Base Statistics")+
       theme_classic())
p



