library(devtools)
library(usethis)
library(data.table)

# Download ICD-10 (CM) codes, 2020 version.
url <- "https://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10CM/2020/icd10cm_codes_2020.txt"
dat1 <- fread(input = url, sep = "\n", header = FALSE)[
  , `:=`(code = trimws(substr(V1, 1, 8)), label = trimws(substr(V1, 9, nchar(V1))))
][, V1 := NULL]

icd10_cm_2020 <- as.data.frame(dat1)
use_data(icd10_cm_2020, overwrite = TRUE)
