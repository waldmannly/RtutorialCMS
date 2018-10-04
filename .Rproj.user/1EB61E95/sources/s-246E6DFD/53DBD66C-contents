
## Basics ----

# comment 

# press cmd + enter to run a line (or press the run button in the top right of this editing panel)
x <- 1 + 1 # assignment 
x 
x %% 2  # mod

getwd()
setwd('../Desktop/RtutorialCMS')


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

#more operations can be found here
#https://www.statmethods.net/advstats/matrix.html


#Function in R ---- 

squarePlusOne <- function(x){
  return(x^2 +1)
}
squarePlusOne(4)

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




## Reading/writing data sets and some graphing ---- 

pkdata <- read.csv("pokemon.csv", header =T)

head(pkdata) # look at the data 


plot(pkdata$base_happiness, pkdata$weight_kg )
plot(pkdata$percentage_male,pkdata$attack)
plot(pkdata$percentage_male,pkdata$weight_kg)

pkdata.sorted <- pkdata[order(pkdata$pokedex_number),]


unique( sapply(unlist(pkdata$abilities), paste) )

## statistics in R ---- 










