# setwd("~/Downloads/mch/")
# 
# dataset <- read.csv("Dataset_For_Hospitals.csv")
# 
# dataset <- dataset[ ,2:3]
# 
# set.seed(30)
# 
# kmeans <- kmeans(dataset , 9 , iter.max = 300 , nstart = 10 , algorithm = 'Lloyd')
# 
# 
# dataset$cluster <- kmeans$cluster
# 
# dataset$cluster <- as.factor(dataset$cluster)
# 
# require(C50)
# 
# classifier <- C5.0(dataset[,1:2] , dataset[,3])
# 
# 
# 
# sethashtohospital <- function(hashcode)
# {
#   
#   dataset$hashcode_id <- hashcode
#   assign('dataset',dataset,envir=.GlobalEnv)
#   
# }
# 
# 
# prediction <- function(latitude_range , longitude_range)
# {
#     test_data <- data.frame(latitude_range , longitude_range)
# 
#     predicted <- predict(classifier , test_data)  
#     
#     all_hosp <- subset(dataset , dataset$cluster == predicted)
#         
#     
#     all_hosp$distance <- (((all_hosp$latitude_range - latitude_range)^2) +((all_hosp$longitude_range - longitude_range)^2))
#     
#     all_hosp <- (all_hosp[order(all_hosp$distance) , ])
#     
#     return(all_hosp)   
# }
# 
# 
# 
# 
# 
# 
# 
# 
# 

