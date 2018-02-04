latitude_range <- vector()
longitude_range <- vector()

adder = 0.03
second_adder = 0.32

for(i in 1:3)
{
latitude_range <-c(  latitude_range , runif(30 , 28.000000 , 28.280000))

longitude_range <-c(  longitude_range  ,  runif(30 , 77.000000 + adder , 77.000000 + second_adder ))

adder = second_adder + 0.09
second_adder = adder + 0.32

}


adder = 0.03
second_adder = 0.32

for(i in 1:3)
{
  latitude_range <-c(  latitude_range , runif(30 , 28.330000 , 28.65000))
  
  longitude_range <-c(  longitude_range  ,  runif(30 , 77.000000 + adder , 77.000000 + second_adder ))
  
  adder = second_adder + 0.09
  second_adder = adder + 0.32
  
}


adder = 0.03
second_adder = 0.32

for(i in 1:3)
{
  latitude_range <-c(  latitude_range , runif(30 , 28.700000 , 29.000000))
  
  longitude_range <-c(  longitude_range  ,  runif(30 , 77.000000 + adder , 77.000000 + second_adder ))
  
  adder = second_adder + 0.09
  second_adder = adder + 0.32
  
}


dataset <- data.frame(latitude_range , longitude_range)



set.seed(10)
wcss <- vector()


for(i in 1:20)
  wcss[i] <- sum(kmeans(dataset , i)$withinss)

plot(1:20 , wcss , type='b' , main= paste('Elbow trace') , xlab = 'No of cluster' , ylab = 'wcss')



set.seed(30)

kmeans <- kmeans(dataset , 9 , iter.max = 300 , nstart = 10 , algorithm = 'Lloyd')









library('cluster')
clusplot(dataset , 
         kmeans$cluster,
         lines = 0,
         shade = TRUE,
         color=TRUE,
         labels = 2,
         verbose = getOption("verbose"),
         span = TRUE,
         main=paste('cluster of clients'),
         xlab="Latitude",
         ylab="Longitude",
         plotchar= T
         
)  







dataset$cluster <- kmeans$cluster




require(caTools)

set.seed(3422)

g <- runif(nrow(dataset))

dataset<- dataset[order(g),]

dataset$cluster <- as.factor(dataset$cluster)

sapmle_split <- sample.split(dataset$latitude_range , SplitRatio = 0.9)

train_data <- subset(dataset , sapmle_split == TRUE)
test_data <- subset(dataset  , sapmle_split == FALSE)


require(C50)
m1 <- C5.0(train_data[,1:2] , train_data[,3])

prediction <- predict(m1 , test_data)



require(caret)


confusionMatrix(table(prediction  , test_data$cluster))






