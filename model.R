####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################

# Importing libraries
library(RCurl) # for downloading the iris CSV file
library(randomForest)
library(caret)

# Importing the Iris data set
bankn <- read.csv(text = getURL("https://raw.githubusercontent.com/Subramaniam-dot/shiny/master/banknoteauth.csv") )

# Performs stratified random split of the data set
TrainingIndex <- createDataPartition(bankn$class, p=0.8, list = FALSE)
TrainingSet <- bankn[TrainingIndex,] # Training Set
TestingSet <- bankn[-TrainingIndex,] # Test Set

write.csv(TrainingSet, "training.csv")
write.csv(TestingSet, "testing.csv")

TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

# Building Random forest model

model <- randomForest(as.factor(class) ~ ., data = TrainSet, ntree = 500, mtry = 4, importance = TRUE)

# Save model to RDS file
saveRDS(model, "model.rds")

