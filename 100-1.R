# load packages
library(caret)
library(fastDummies)

# load data
data <- read.csv('~/Data.csv', header = TRUE, sep = ',')
head(data)

# seperate data
x <- data[1:3]
y <- data[4]
head(x)
head(y)

# deal with missing data
x_missing <- preProcess(x[2:3], method = 'medianImpute')
x[2:3] <- predict(x_missing, x[2:3])

# get categorical data
# setting as factor gives label encode in sklearn
# using caret dummyVars also works
x <- dummy_cols(x)
y <- dummy_cols(y)

# split dataset
smp_size <- round(0.8 * nrow(x))
set.seed(123)
train_ind <- sample(seq_len(nrow(x)), size = smp_size)
train_x <- x[train_ind,]
test_x <- x[-train_ind,]
train_y <- y[train_ind,]
test_y <- y[-train_ind,]

# feature scaling
scale_train <- preProcess(train_x[2:3], method = 'scale')
scale_test <- preProcess(test_x[2:3], method = 'scale')
train_x[2:3] <- predict(scale_train, train_x[2:3])
test_x[2:3] <- predict(scale_test, test_x[2:3])
# dataset too small and doesn't really work for test x