#Import dataset (code below only works if file is in working directory)
post <- read.csv('PostSurvey.csv')

#Create contingency table
gendsport <- table(post$UT_sport, post$gender)
gendsport

#Row percentages
prop.table(gendsport,1)

#Column percentages
prop.table(gendsport,2)

#Make grouped bar chart
barplot(gendsport,beside=T,legend=T,main='Play Sports by Gender', xlab='Gender',ylab='Frequency')

#Make mosaic plot
barplot(prop.table(gendsport,2),legend=T,main= 'Play Sports by Gender',xlab='Gender',ylab='Relative Frequency',xlim=c(0,3.5))