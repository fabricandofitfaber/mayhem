---
title: Frequency Tables
author: fabricandofitfaber
date: '2020-09-06'
slug: frequency-tables
categories:
  - R
tags:
  - Frequency Tables
  - Pie Charts
  - Bar Charts
---

## Import dataset
```{r}
med <- read.csv('https://raw.githubusercontent.com/fabricandofitfaber/mayhem/master/MedicalData.csv')
```

## Create and view frequency table of age groups
```{r}
agetab <- table(med$Age)
agetab
```

## View table proportions
```{r}
prop.table(agetab)
```

## Create bar chart
```{r}
barplot(agetab,main='Age Distribution',xlab='Age Group',ylab='Frequency',ylim=c(0,100))
```

## Re-order age categories
```{r}
med$Age <- factor(med$Age, levels=c('young adult','adult','older adult'))
```

## Re-run bar chart
```{r}
agetab <- table(med$Age)
barplot(agetab,main='Age Distribution',xlab='Age Group',ylab='Frequency',ylim=c(0,100))
```