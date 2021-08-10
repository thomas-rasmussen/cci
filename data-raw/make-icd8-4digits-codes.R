library(usethis)
library(tidyverse)
library(rvest)


# Scrape web page with 4-digit ICD-8 codes
dat1 <- read_html("http://www.wolfbane.com/icd/icd8h.htm") %>%
  html_nodes("pre") %>%
  html_text() %>%
  # Clean scraped data
  strsplit(split = "\n") %>%
  as.data.frame() %>%
  slice(3:(n() - 1)) %>%
  rename(text = 1) %>%
  mutate(text = str_squish(text)) %>%
  # Split codes and labels into separate variables
  mutate(
    code = str_split_fixed(text, pattern = " ", n = 2)[, 1],
    label = str_split_fixed(text, pattern = " ", n = 2)[, 2]
  ) %>%
  # Remove dots from codes.
  mutate(code = str_remove_all(code, fixed("."))) %>%
  # Identify chapter labels
  mutate(header = str_detect(code, "-"))

# Calculate how many codes are in each chapter
chapter_info <- dat1 %>%
  mutate(rowid = 1:n()) %>%
  filter(header) %>%
  select(text, rowid) %>%
  mutate(nlines = lead(rowid, default = nrow(dat1) + 1) - rowid) %>%
  select(-rowid)

# Make a vector with chapter labels for each code
chapter_labels <- chapter_info[["text"]]
chapter_nlines <- chapter_info[["nlines"]]
chapter_vector <- character(0)
for (i in seq_along(chapter_labels)) {
  i_labels <- rep(chapter_labels[i], times = chapter_nlines[i])
  chapter_vector <- c(chapter_vector, i_labels)
}

# Add chapter label to codelist
dat2 <- dat1 %>%
  mutate(chapter = chapter_vector) %>%
  filter(!header) %>%
  select(c(code, chapter, label))


icd8_4digits <- as.data.frame(dat2)
use_data(icd8_4digits, overwrite = TRUE)
