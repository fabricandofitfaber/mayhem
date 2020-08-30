---
title: Numberology
author: fabricandofitfaber
date: '2020-08-30'
slug: numberology
categories:
  - R
tags:
  - ggplot2
---

---
title: 'Numberology'
author: fabricandofitfaber
date: '2020-08-30'
slug: ''
categories:
  - R
tags:
  - plot
  - R Markdown
Description: ''
Tags: [tidyverse]
Categories: [R]
DisableComments: no
---

## https://gofile.io/d/OIeaLH (Veri Seti)


```{r}
colnames(umf)[1] <- "ID"
colnames(umf)[2] <- "Number100"
colnames(umf)[4] <- "L_M"
```

# library(tidyverse)

```{r}
umf %>%
  ggplot(aes(value)) +
  geom_histogram(binwidth=.5, colour="red", fill="grey") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  scale_x_continuous(breaks = umf$value)
```

```{r}
umf %>%
  ggplot(aes(value, color_class)) +
  geom_line(alpha = .5, color = "gray") +
  geom_point(aes(color = factor(color_class))) +
  geom_text(aes(label = color_class), hjust = 1,
            check_overlap = TRUE) +
  theme(legend.position = "none")
```

```{r}
umf %>%
  group_by(color_class) %>%
  summarize(n_value = n(),
            avg_rating = mean(value)) %>%
  ggplot(aes(color_class, avg_rating)) +
  geom_line() +
  geom_point(aes(size = n_value)) +
  theme(legend.position = "right") +
  labs(x = "Color",
       y = "Average Number")
```

```{r}
umf %>%
  group_by(color_class) %>%
  summarize(n_L_M = n(),
            avg_rating = mean(L_M)) %>%
  ggplot(aes(color_class, avg_rating)) +
  geom_line() +
  geom_point(aes(size = n_L_M)) +
  theme(legend.position = "right") +
  labs(x = "Color",
       y = "Average Number")
```

## library(glue)

```{r}
umf %>%
  arrange(desc(value)) %>%
  head(25) %>%
  mutate(name = glue("{ L_M } { color_class }"),
         name = fct_reorder(name, value)) %>%
  ggplot(aes(value, name)) +
  geom_point() 
```