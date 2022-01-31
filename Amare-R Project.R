
# First Describe the data as:
# Descriptive Statistics R both for the categorical,continuous and Ordinal data types based on the nature of the data set
# Set Working Directory
setwd("C://Toronto//R First Class")
getwd()

#Read in the data
install.packages("readr")
library(readr)
 
install.packages("lessR")
library(lessR)
install.packages("MASS")
library(MASS)
install.packages("vcd")
library(vcd)

mosaic(tbl, shade=TRUE) 

install.packages("corrplot")
library(corrplot)
install.packages('ggplot2') 	 
library(ggplot2)
install.packages("plotrix")
library(plotrix)

install.packages("GGally")
library(GGally)
install.packages("doBy")
library(doBy)
install.packages("psych")
library(psych)

churnersdata<-read_csv("C://Toronto//R First Class//BankChurners.csv")
churnersdata
#structure of data
str(churnersdata)
class(churnersdata)          # "data.frame"
sapply(churnersdata, class)  # Numeric and Character data

list(churnersdata)           # shows the list of all numeric and character data
typeof(churnersdata)         # "list"
#name of columns
names(churnersdata)          # show list of the column names
# Shape of Data
dim(churnersdata)            # dimensions of object and it is  10127X23
 
 
# Checking the head and tail of the data set
head(churnersdata)        # extract (return) first few (default 6) parts
tail(churnersdata)         # extract (return) last few (default 6) parts

#######################################
# Data cleaning and preparation
#######################################
# number of missing values:
colSums(is.na(churnersdata))
 
colMeans(is.na(churnersdata))*100#  shows you percentage of Missing values of columns and 
#there is no missing values. Removing columns not relevant for this data analysis
churnersdata<-churnersdata[,-c(1,22:23)] 
churnersdata
#The 1st,22nd and 23rd columns are not relevant for this data analysis and columns are removed.   
summary(churnersdata)# summary function for numerical columns returns mean and five-number-summary of Min.                                                                                                                  
#1st Qu.,Median, Mean, 3rd Qu and max. values of each numeric columns of the data set. 
# Univariate Analysis (Considering only one column)
# Testing the data either there is duplication or not. The  duplicated(churnersdata) returns FALSE, 
# and hence there is no data duplication in this data set. 
duplicated(churnersdata) 

#Q1.what is the distribution of target(Attrition_Flag)?
#how many missing values we have for Attrition_Flag
sum(is.na(churnersdata$Attrition_Flag))
# There is no  missing value for target,and there is no  drop from the observations. 
# since my target (Attrition_Flag)is categorical variable, 
#I can use it in univariaite Analysis for summarization. I will find frequency and for visualization I plot: 
# pie chart or bar chart 
table(churnersdata$Attrition_Flag)
tbl<-table(churnersdata$Attrition_Flag)
tbl
# Univariate Analysis (Considering only one column(variable)) for continuous Variables 

#Central Tendency of the continuous data set 
 
summary(churnersdata$Months_on_book)
summary(churnersdata$Credit_Limit)
summary(churnersdata$Total_Revolving_Bal)  
summary(churnersdata$Avg_Open_To_Buy)
#Graph for continuous variables 
boxplot(churnersdata$Months_on_book)
boxplot(churnersdata$Credit_Limit)
boxplot(churnersdata$Total_Revolving_Bal)  
boxplot(churnersdata$Avg_Open_To_Buy)

#spread of the continuous variables
hist(churnersdata$Months_on_book)
hist(churnersdata$Credit_Limit)
hist(churnersdata$Total_Revolving_Bal)  
hist(churnersdata$Avg_Open_To_Buy)

#group histogram

qplot(Months_on_book, data = churnersdata, geom = "histogram",fill=Education_Level)

qplot(Months_on_book, data = churnersdata, geom = "histogram",col=Education_Level)

qplot(Credit_Limit, data = churnersdata, geom = "histogram",fill=Marital_Status)
qplot(Credit_Limit, data = churnersdata, geom = "histogram",col=Marital_Status)

#group density
qplot(Months_on_book, data = churnersdata, geom = "density",col=Education_Level)
qplot(Months_on_book, data = churnersdata, geom = "density",fill=Education_Level)

qplot(Credit_Limit, data = churnersdata, geom = "density",col=Card_Category)
qplot(Credit_Limit, data = churnersdata, geom = "density",fill=Card_Category)

#Box plot
qplot(churnersdata$Months_on_book,geom = "boxplot")
qplot("Months_on_book",iris$Months_on_book,geom = "boxplot") 
qplot(churnersdata$Months_on_book,"Months_on_book",geom = "boxplot")

#Group box plot(Card-Category Vs Months_on_Book)
qplot(churnersdata$Card_Category,churnersdata$Months_on_book,geom = "boxplot")
qplot(churnersdata$Card_Category,churnersdata$Months_on_book,geom = "boxplot",col=churnersdata$Card_Category)
qplot(churnersdata$Card_Category,churnersdata$Months_on_book,geom = "boxplot",fill=churnersdata$Card_Category)
qplot(churnersdata$Card_Category,churnersdata$Months_on_book,geom = "boxplot",fill=churnersdata$Card_Category,col=churnersdata$Card_Category)
qplot(churnersdata$Months_on_book,churnersdata$Card_Category,geom = "boxplot")
qplot(churnersdata$Months_on_book,churnersdata$Card_Category,geom = "boxplot",col=churnersdata$Card_Category)
qplot(churnersdata$Months_on_book,churnersdata$Card_Category,geom = "boxplot",fill=churnersdata$Card_Category)

#Group box plot(Income_Category Vs Credit_Limit)

qplot(churnersdata$Income_Category,churnersdata$Credit_Limit,geom = "boxplot")
qplot(churnersdata$Income_Category,churnersdata$Credit_Limit,geom = "boxplot",col=churnersdata$Income_Category)
qplot(churnersdata$Income_Category,churnersdata$Credit_Limit,geom = "boxplot",fill=churnersdata$Income_Category)
qplot(churnersdata$Income_Category,churnersdata$Credit_Limit,geom = "boxplot",fill=churnersdata$Income_Category,col=churnersdata$Income_Category)
qplot(churnersdata$Credit_Limit,churnersdata$Income_Category,geom = "boxplot")
qplot(churnersdata$Credit_Limit,churnersdata$Income_Category,geom = "boxplot",col=churnersdata$Income_Category)
qplot(churnersdata$Credit_Limit,churnersdata$Income_Category,geom = "boxplot",fill=churnersdata$Income_Category)

# pie chart(visualization for Categorical Bank Churners data set)

summary(churnersdata)
freq1 <- c(1013, 451,3128, 2013, 516,1487,1519)
lbls <- c("College", "Doctorate", "Graduate", "High School", "Post_Graduate","Uneducated","unknown")
pie(freq1, labels = lbls, main="Pie Education_Level of Customers")

# Pie Chart with Percentages
freq1 <-c(1013, 451,3128, 2013, 516,1487,1519)
pct <- round(freq1/sum(freq1)*100)
pct
lbls <- c("College", "Doctorate", "Graduate", "High School", "Post_Graduate","Uneducated","unknown")
lbls <- paste(lbls, pct) 
lbls

lbls <- paste(lbls,"%",sep="") 
lbls
pie(pct,labels = lbls, col=rainbow(length(lbls)),
    main="Pie chart: Education_Level of Customers")

#Stacked Bar Plot (Categorical Vs. Categorical)

counts <- table(Attrition_Flag$vs, Attrition_Flag$Card_Category) 
counts
class(counts)

barplot(counts, main="Attrition_Flag and VS",
        xlab="Card_Category", col=c("darkblue","red"),
        legend = rownames(counts))
# Grouped Bar Plot(Categorical Vs. Categorical)
counts <- table(Attrition_Flag$vs, Attrition_Flag$Card_Category)
barplot(counts, main="Attrition_Flag and VS",
        xlab="Card_Category", col=c("darkblue","red"),
        legend = rownames(counts), beside=TRUE) 
par(mar = c(1, 1, 1, 1))
plot(1:30)

# Bi variate analysis for the continuous Vs Categorical data and group visualization 
qplot(Months_on_book, data = churnersdata, geom = "histogram",fill=Attrition_Flag)
qplot(Months_on_book, data = churnersdata, geom = "histogram",col=Attrition_Flag)
#group density
qplot(Months_on_book, data = churnersdata, geom = "density",col=Attrition_Flag)
qplot(Months_on_book, data = churnersdata, geom = "density",fill=Attrition_Flag)

# bivarate Data visualization using scatter plot(continous Vs continous)

qplot(Months_on_book, Credit_Limit, data=churnersdata)
qplot(Months_on_book, Credit_Limit, data=churnersdata,col="red")

# Visualization of the categorical data set-2
#or use aggregate function to prove that there is no missing values for the target variable 
tbl<-aggregate(churnersdata$Attrition_Flag,list(churnersdata$Attrition_Flag),length)

tbl
count<-table(churnersdata$Attrition_Flag)
count

freq1 <- c(count[1], count[2])
lbls <- c("Attrited Customer", "Existing Customer")
pct <- round(freq1/sum(freq1)*100)

lbls <- paste(lbls, pct) # add percents to labels and by default separate them by space
lbls <- paste(lbls,"%", sep="") # ad % to labels
pie(freq1,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Attrition_Flag")
# As per the data set and pie chart,you can see we have 84% existing customer and 16% attrited customer.
# Simple Bar Plot for Attrition-Flag(1)

tb<-aggregate(churnersdata$Attrition_Flag,list(churnersdata$Attrition_Flag),length)
tb
count <- table(churnersdata$Attrition_Flag)
count
barplot(c(count[1], count[2]), main="Attrition_Flag",
ylab="Number",col=c("Blue","Yellow"),horiz = FALSE,
legend = rownames(count),beside=TRUE) 
# Simple Bar Plot for Education_Level
tb2<-aggregate(churnersdata$Education_Level,list(churnersdata$Education_Level),length)
tb2
count <- table(churnersdata$Education_Level)
count
barplot(c(count[1], count[2],count[3],count[4],count[5],count[6],count[7]), main="Education_Level",
        ylab="Number",col =c("Yellow","Black","Blue","Green","Gold","Grey","Red"),horiz = TRUE,
        legend = rownames(count),besides=TRUE) 

# Simple Bar Plot for Marital_Status
tb3<-aggregate(churnersdata$Marital_Status,list(churnersdata$Marital_Status),length)
tb3
count <- table(churnersdata$Marital_Status)
count
barplot(c(count[1], count[2],count[3],count[4],count[5]), main="Marital_Status",
        ylab="Number",col =c("Gray","Blue","Red","Gold") ,horiz = FALSE,
        legend = rownames(count),corner=TRUE) 
# Simple Bar Plot for Income_Category

tb4<-aggregate(churnersdata$Income_Category,list(churnersdata$Income_Category),length)
tb4
count <- table(churnersdata$Income_Category)
count
barplot(c(count[1], count[2],count[3],count[4],count[5],count[6]), main="Income_Category",
        ylab="Number",col = 'Red',horiz = FALSE,
      legend = rownames(count),besides=TRUE) 

# Simple Bar Plot for Card_Category

tb5<-aggregate(churnersdata$Card_Category,list(churnersdata$Card_Category),length)
tb5
count <- table(churnersdata$Card_Category)

count
barplot(c(count[1], count[2],count[3],count[4]), main="Card_Category",
        ylab="Number",col =c("Gold","Blue","Black","Red"),horiz = FALSE,
       legend = rownames(count),beside=TRUE) 

#  Simple Bar Plot for Gender

tb6<-aggregate(churnersdata$Gender,list(churnersdata$Gender),length)
tb6
count <- table(churnersdata$Gender)
count
barplot(c(count[1], count[2]), main="Gender",
        ylab="Number",col =c("Gold", "Blue"), horiz = FALSE,
        legend = rownames(count)) 

# Bivariate analysis of Categorical Vs Categorical variables and Pearson's Chi-squared test
# Contingency table Categorical data summary and Chi-square test for the independence 
# Independence of Income Category over Attrition_Flag
# Using two way_table for the bivariate analysis using xtabs() function  

#Q2.Is Income_Category is independent  on attrition Flag of customers at 5% significance level?  
# target(Attrition_Flag)?
tbl <- table(churnersdata$Attrition_Flag,churnersdata$Income_Category)
tbl
tbl <-tbl[2:6,2:6]    
tbl
chisq.test(tbl)
 
#Explanation: 

# Pearson's Chi-squared test, tbl X-squared = 12.832, df = 5, p-value = 0.025.Since the value of P(0.025)is 
# less than 0.05
#since p-value is less than 5% we reject null hypotheses and conclude there is a statistically association between 
# attribution Flag and income category at 5% significant level.

#Q3.Is Gender of the customer independent on Customer Attrition_Flag? 

tb2 <- table(churnersdata$Attrition_Flag,churnersdata$Gender)
tb2
tb2 <-tbl[2:3,2:3]    
tb2
chisq.test(tb2)

#Explanation: 
#Pearson's Chi-squared test, data:  tb2 X-squared = 13.866, df = 1, p-value = 0.0001964. Since the value of P( 0.0001964)is less than 0.05
# since p-value is less than 5% we reject null hypotheses and conclude there is a statistically association between Customer Gender and attribution Flag at 5% significant level.

#Q4.Is the Marital_Status of a customer independent on  Customer Attrition_Flag?   
tb3 <- table(churnersdata$Attrition_Flag,churnersdata$Marital_Status)
tb3
tb3 <-tbl[2:4,2:4]    
tb3
chisq.test(tb3)
#Explanation 
#Pearson's Chi-squared test,X-squared = 6.0561, df = 3, p-value = 0.1089. Since the value of P( 0.1089)is greater than 0.05
# since p-value is greater than 5% we can accept the null hypotheses and conclude there no clear evidence that there is no statistically association between Customer Gender and attribution Flag at 5% significant level.

#Q5.Is Education_Level of customers independent on Customer Attrition_Flag? 

tb4 <- table(churnersdata$Attrition_Flag,churnersdata$Education_Level)
tb4
tb4 <-tbl[2:7,2:7]    
tb4
chisq.test(tb4)

#Explanation 
# Pearson's Chi-squared test,X-squared = 12.511, df = 6, p-value = 0.05149. Because of  the value of P( 0.05149)is 
#greater than 0.05 attrition flag is dependent on Education_Level of the customers.
# since p-value is greater than 5% we can accept the null hypotheses and conclude there no clear enough evidence that 
#there is no statistically association 
# between Customer Gender and attribution Flag at 5% significant level.

# B. Summarization of the categorical data set
 summary(churnersdata) #this is for continouds data
table(Attrition_Flag$cyl) #finding frequency of each level

tbl<-table(churnersdata$Attrition_Flag,df$Education_Level) #Two-way table (contingency tables) :showing frequency of combination of two categorical variables
tbl
# Stacked Bar Plot with Colors and Legend for bi variate data set 

tbl<-table(churnersdata$Attrition_Flag,df$Education_Level)
tbl
count<-tbl1[2:1,2:2]
count

barplot(count, main="Attrition_Flag Vs. Education_Level",
        xlab="Attrition_Flag", col=c("darkblue","red"),
        legend = rownames(count))
 
tbl<-table(churnersdata $Attrition_Flag,churnersdata$Gender)

tbl
count<-tbl[2:3,2:3]
count
barplot(count, main="Attrition_Flag Vs. Gender",
        xlab="Attrition_Flag", col=c("darkblue","red"),
        legend = rownames(count))
 
 ###################################
#Correlation test for the continuous variables of Bank churn data set
###################################
str(churnersdata) ## Shows Both categorical and continuous data columns and only continuous data columns considered for 
#correlation test for the dependency or statistical relation between to continuous variables
cor(na.omit(churnersdata))
churnersdata<-na.omit(churnersdata)

 
# Q6: customer stayed Months_on_book has correlation with customers Credit_Limit
cor(churnersdata$Months_on_book,churnersdata$Credit_Limit) "Correlation coefficient (r)"= 0.007507009
# Correlation coefficient(r) value is is 0.007507009. This shows that the two variables(Months_on_book and Credit_Limit)are positively
# correlation but the value of r shows that the variables have weak positive correlation.That means, if Months_on_book of the customer increases,
#Credit_Limit of the customer also increase. 
 
plot(churnersdata$Months_on_book,churnersdata$Credit_Limit)
plot(churnersdata$Months_on_book,churnersdata$Credit_Limit, type="p",
     main="Months_on_book vs Credit_Limit",
     sub = "scatter plot",
     xlab = "Months_on_book", ylab = "Credit_Limit",
     col=10,
     pch=16, cex=1.5)
# Generic x y plotting 

qplot(Months_on_book, Credit_Limit, data=churnersdata)
qplot(Months_on_book, Credit_Limit, data=churnersdata,col="red")

cor(churnersdata$Months_on_book,churnersdata$Credit_Limit,method = "spearman")#"spearman"= 0.006869865
cor(churnersdata$Months_on_book,churnersdata$Credit_Limit,method = "kendall")#"kendall"=0.004765154

# Q7: Is Customers Avg_Open_To_Buy has correlation with customers Credit_Limit?  

cor(churnersdata$Avg_Open_To_Buy,churnersdata$Credit_Limit)  "Correlation coefficient (r)"= 0.9959805

plot(churnersdata$Avg_Open_To_Buy,churnersdata$Credit_Limit)
plot(churnersdata$Avg_Open_To_Buy,churnersdata$Credit_Limit, type="p",
     main="Avg_Open_To_Buyvs Credit_Limit",
     sub = "scatter plot",
     xlab = "Avg_Open_To_Buy", ylab = "Credit_Limit",
     col=10,
     pch=16, cex=1.5)

# Generic x y plotting 
 
qplot(Avg_Open_To_Buy, Credit_Limit, data=churnersdata)
qplot(Avg_Open_To_Buy, Credit_Limit, data=churnersdata,col="red")

# Use data from numeric vectors
x <- 1:10; y = x^2
#by using ggplot()

plot(x, y, type="b", 
     pch=19, col="red", xlab="x", ylab="y=x^2")

#by using qplot from ggplot2
# Basic plot
qplot(x,y)
# Add line

qplot(x, y, geom=c("point", "line"))
# Add color

qplot(x, y, geom=c("point", "line"),col="Red")

qplot(Credit_Limit, Avg_Open_To_Buy, data = churnersdata, geom = c("point", "line"))

# Correlation coefficient (r)"= 0.9959805 shows that the variables(Avg_Open_To_Buy and Credit_Limit) are 
# high positive correlation.There fore, accept the hypothesis that the two variables has statistical association.  
# This means, one variable increase also make the other variable to increase and one decrease results to decrease.  

# Q8:Total_Trans_Amt by customer is has correlation with Credit_Limit of the customer

cor(churnersdata$Total_Trans_Amt,churnersdata$Credit_Limit) "Correlation coefficient (r)"= 0.1717302

plot(churnersdata$Total_Trans_Amt,churnersdata$Credit_Limit)
plot(churnersdata$Total_Trans_Amt,churnersdata$Credit_Limit, type="p",
     main="Total_Trans_Amt vs Credit_Limit",
     sub = "scatter plot",
     xlab = "Total_Trans_Amt", ylab = "Credit_Limit",
     col=10,
     pch=10, cex=1.5)
 
#Correlation coefficient (r)"= 0.1717302 shows that the variables(Total_Trans_Amt and Credit_Limit) are 
# weak positive correlation. This means, one variable increase also make the other variable to increase and one 
# decrease, the other variable also decrease.  

# Q9:Total_Revolving_Balance of the customer transaction  has correlation with Credit_Limit of the customer?
cor(churnersdata$Total_Revolving_Bal,churnersdata$Credit_Limit)  "Correlation coefficient (r)"= 0.04249261

plot(churnersdata$Total_Revolving_Bal,churnersdata$Credit_Limit)
plot(churnersdata$Total_Revolving_Bal,churnersdata$Credit_Limit, type="p",
     main="Total_Revolving_Bal vs Credit_Limit",
     sub = "scatter plot",
     xlab = "Total_Revolving_Bal", ylab = "Credit_Limit",
     col=10,
     pch=16, cex=1.5)
 
#Correlation coefficient (r)"= 0.04249261 shows that the variables(Total_Revolving_Bal and Credit_Limit) are weak positive correlation.
# This means, one variable increase also make the other variable to increase and one decrease, the other variable also decreases.

# Q10:Total_Trans_Ct of the customer transaction  has correlation with Credit_Limit of the customer?
cor(churnersdata$Total_Trans_Ct,churnersdata$Credit_Limit) "Correlation coefficient (r)"=0.07592691
  
plot(churnersdata$Total_Trans_Ct,churnersdata$Credit_Limit)
plot(churnersdata$Total_Trans_Ct,churnersdata$Credit_Limit, type="p",
     main="Total_Trans_Ct vs Credit_Limit",
     sub = "scatter plot",
     xlab = "Total_Trans_Ct", ylab = "Credit_Limit",
     col=10,
     pch=16, cex=1.5)
   
