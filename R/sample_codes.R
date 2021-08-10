# Quiets concerns of R CMD check regarding 'no visible binding
# for global variable ...'
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c("icd8_4digits", "icd10_cm_2020"))
}

#' Sample codes
#'
#' Sample ICD-8 and/or ICD-10 codes. The codes are sampled with replacement.
#'
#' @param n positive integer. Number of codes to sample.
#' @param code_sources Character vector. Character vector with dataset names
#' from the package form which codes are sampled. By default codes are sampled
#' from the `icd8_4digits` and `icd10_cm_2020` dataset that is included in the
#' package. The complete list of datasets from which it is possible to sample
#' is: `icd8_4digits` and `icd10_cm_2020`.
#' @param max_code_length positive integer. Maximum length of codes to sample.
#' By default, the sampled codes are shortened to length 4.
#'
#' @return character vector of length `n`.
#' @export
#'
#' @examples
#' sample_codes(5L)
sample_codes <- function(
  n = 1L,
  code_sources = c("icd8_4digits", "icd10_cm_2020"),
  max_code_length = 4) {

  # Input checks
  checkmate::assert_count(n, positive = TRUE)
  checkmate::assert_subset(code_sources, c("icd8_4digits", "icd10_cm_2020"))
  checkmate::assert_count(max_code_length, positive = TRUE)

  # Sample codes
  codes <- character(0)
  for (i in seq_along(code_sources)) {
    codes <- c(codes, eval(parse(text = paste0(code_sources[i], "[, \"code\"]"))))
  }
  x <- sample(codes, n, replace = TRUE)

  # Shorten codes
  substr(x, 1, max_code_length)
}
