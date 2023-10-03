library(readxl)

data <- read_excel("Book1.xlsx")

library(mice)

#Multivariate Imputation using pmm method


data = data.frame(data)

set.seed(1)

data2 = mice(data[,-c(1:4)], method = "pmm",  maxit = 10, m = 10)

data3 = complete(data2)

#all information are true for the following variables
summary(data3)

data3$Short_3 <- TRUE
data3$Short_4 <- TRUE
data3$Short_6 <- TRUE

#they are all true, so no useful for modeling

data_filled <- data.frame(data[,1:4], data3)

write.csv(data_filled, file = "data_filled.csv")

train_data <- data_filled[data_filled$TrainVal == "Train_60", ]
val_data <- data_filled[data_filled$TrainVal == "Val_40", ]



head(train_data)


model1 <- glm(target~., data = train_data[,-c(1,4)], family = binomial(link="logit"))

summary(model1)

predict_train <- predict(model1, type = "response")

predict_class <- round(predict_train )


confusion_mat_train <- table(predict_class, train_data$target)
confusion_mat_train

library(caret)

#show some measures
confusionMatrix(factor(predict_class), factor(train_data$target), positive = "1")

#ROC curve with auc 

library(pROC)

r = roc(train_data$target, predict_train)

plot(r, col = "red", print.auc = TRUE, main = "Logistic ROC for train data")


predict_val <- predict(model1, val_data, type = "response")

predict_class <- round(predict_val )


confusion_mat_val <- table(predict_class, val_data$target)
confusion_mat_val

#show some measures
confusionMatrix(factor(predict_class), factor(val_data$target), positive = "1")

#ROC curve with auc 

r2 = roc(val_data$target, predict_val)

plot(r2, col = "red", print.auc = TRUE, main = "Logistic ROC for validation data")





