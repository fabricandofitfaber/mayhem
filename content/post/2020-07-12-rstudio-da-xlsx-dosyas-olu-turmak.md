---
title: RStudio'da .xlsx Dosyası Oluşturmak
author: fabricandofitfaber
date: '2020-07-12'
slug: rstudio-da-xlsx-dosyas-olu-turmak
categories:
  - R
tags:
  - xlsx
---

library(openxlsx)

workbook <- createWorkbook()

addWorksheet(workbook, "birinci_sayfa")
addWorksheet(workbook, "ikinci_sayfa")

writeData(workbook, "birinci_sayfa", mtcars)
writeData(workbook, "ikinci_sayfa", iris)

saveWorkbook(workbook, file = "my_workbook.xlsx", overwrite = TRUE)