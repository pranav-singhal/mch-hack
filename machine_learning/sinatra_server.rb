require 'sinatra'
require 'rinruby'
require 'securerandom'
require 'json'



R.eval "setwd('~/Downloads/mch/')"
R.eval "dataset <- read.csv('Dataset_For_Hospitals.csv')"

R.eval "dataset <- dataset[ ,2:3]"

R.eval "set.seed(30)"

R.eval "kmeans <- kmeans(dataset , 9 , iter.max = 300 , nstart = 10 , algorithm = 'Lloyd')"

R.eval "all_hosp <- vector()"

R.eval "dataset$cluster <- kmeans$cluster"

R.eval "dataset$cluster <- as.factor(dataset$cluster)"

R.eval "require(C50)"

R.eval "library(rjson)"

R.eval "classifier <- C5.0(dataset[,1:2] , dataset[,3])"

R.eval "prediction <- function(latitude_range , longitude_range)
 {
 test_data <- data.frame(latitude_range , longitude_range)
 predicted <- predict(classifier , test_data)
 all_hosp <- subset(dataset , dataset$cluster == predicted)
 all_hosp$distance <- (((all_hosp$latitude_range - latitude_range)^2) +((all_hosp$longitude_range - longitude_range)^2))
 all_hosp <- (all_hosp[order(all_hosp$distance) , ])

 all_hosp <- as.character(toJSON(unname(split(all_hosp, 1:nrow(all_hosp)))))

 assign('all_hosp',all_hosp,envir=.GlobalEnv)

 }"


 post '/first' do

   arr = []
   270.times do
    sha = SecureRandom.hex
    arr << sha
   end


   R.assign "hospital_hash" , arr


  R.eval "dataset$hashcode_id <- hospital_hash"
  R.eval "assign('dataset',dataset,envir=.GlobalEnv)"




 end

get '/' do

    R.eval "prediction(28.456608 , 77.4983687)"

    data = R.pull("all_hosp")


    puts data




    return data

end
