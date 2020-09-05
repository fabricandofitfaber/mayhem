---
title: Contingency Tables
author: fabricandofitfaber
date: '2020-09-05'
slug: contingency-tables
categories:
  - R
tags:
  - contingency tables
  - descriptive statistics
  - olasılık tablosu
---

#Import dataset
```{r}
post <- read.csv('https://raw.githubusercontent.com/fabricandofitfaber/mayhem/master/PostSurvey.csv')
```

#Create contingency table
```{r}
gendsport <- table(post$UT_sport, post$gender)
gendsport
```

#Row percentages
```{r}
prop.table(gendsport,1)
```

#Column percentages
```{r}
prop.table(gendsport,2)
```

# Make grouped bar chart
```{r}
barplot(gendsport,beside=T,legend=T,main='Play Sports by Gender', xlab='Gender',ylab='Frequency')
```

#Make mosaic plot
```{r}
barplot(prop.table(gendsport,2),legend=T,main= 'Play Sports by Gender',xlab='Gender',ylab='Relative Frequency',xlim=c(0,3.5))
```