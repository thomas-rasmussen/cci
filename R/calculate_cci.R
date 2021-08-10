# Quiets concerns of R CMD check regarding 'no visible binding
# for global variable ...'
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c("cci_codelist_icd8_icd10"))}

#' Calculate CCI
#'
#' @param x data.frame
#' @param id Name of id variable in `x`
#' @param code Name of variable with codes in `x`
#' @param cci Name of CCI variable in return data.table
#' @param keep_groups Logical. Keep individual CCI disease group variables in
#' return data.frame?
#' @param codelist Codelist with CCI disease gorup definitions and weightds used
#' to define the CCI. By default the `cci_codelist_icd8_icd10` codelist that
#' comes with package is used. This is reasonable codelist to use if ´x´ is
#' data from the Danish National Patient Registry. Alternatively, a custom
#' codelist can be provided.
#' @param sks_codes Logical. Convert SKS codes to ICD-10 in data? By default it
#' is assumed that the function is used on Danish registry data where ICD-8 and
#' ICD-10 codes are mixed, and ICD-10 codes have a "D" prefix.
#'
#' @return data.table if `x` data.table. Else, a data.frame
#' @export
#' @import data.table
#' @examples
#' set.seed(1)
#' dat <- data.frame(id = rep(1:10, each = 10), code = sample_codes(100))
#' calculate_cci(dat)
calculate_cci <- function(
    x,
    id = "id",
    code = "code",
    cci = "cci",
    keep_groups = FALSE,
    codelist = cci_codelist_icd8_icd10,
    sks_codes = TRUE) {

  # Input checks
  checkmate::assert_data_frame(x, min.rows = 1)
  checkmate::assert_string(id)
  checkmate::assert_subset(id, choices = names(x))
  checkmate::assert_string(code)
  checkmate::assert_subset(code, choices = names(x))
  checkmate::assert_string(cci)
  checkmate::assert_true(cci == make.names(cci))
  checkmate::assert_logical(keep_groups)
  checkmate::assert_logical(sks_codes)
  codelist <- validate_codelist(codelist)

  x_is_dt <- is.data.table(x)

  x <- as.data.table(x)
  setnames(x, old = c(id, code), new = c("id", "code"))

  # Restrict to unique id/code lines
  x <- unique(x[, list(id, code)])

  # If diagnosis data uses SKS codes, remove "D" prefix from ICD-10 codes.
  if (sks_codes) {
    x <- x[,
               code := ifelse(grepl("^D[a-z]" , code, ignore.case = TRUE),
                              substring(code, 2), code)
               ]
  }

  # Extract variable names, codes, and weights from codelist
  cci_names <- character(0)
  cci_codes <- list()
  cci_weights <- numeric(0)
  for (i in seq_along(codelist)){
    cci_names[i] <- codelist[[i]][["name"]]
    cci_codes[[i]] <- codelist[[i]][["codes"]]
    cci_weights[i] <- codelist[[i]][["weight"]]
  }

  # Convert codes to regular expressions
  codes_regex <- character(0)
  for (i in seq_along(cci_codes)) {
    codes_regex[i] <- paste0(cci_codes[[i]], collapse = "|^")
    codes_regex[i] <- paste0("^", codes_regex[i])
  }

  # Find groups, if any, each code belongs to
  in_group <- function(x, regex, name) {
    x[, (name) := as.integer(grepl(regex, code) > 0)]
  }

  for (i in seq_along(cci_names)) {
    in_group(x, codes_regex[i], cci_names[i])
  }

  # Summarize data to one line per id
  x <- x[, code := NULL][, lapply(.SD, function(x) as.integer(sum(x) > 0)), by = id]

  # Extract corrections from codelist
  corrections <- character()
  for (i in seq_along(codelist)) {
    i_assign0_if <- codelist[[i]][["name"]]
    i_corr <- codelist[[i]][["assign0_if"]]
    if (!is.null(i_corr)) {
      names(i_corr) <- i_assign0_if
      corrections <- c(corrections, i_corr)
    }
  }

  # Make corrections
  for (i in seq_along(corrections)) {
    i_assign0 <- names(corrections)[i]
    i_corr_var <- unname(corrections)[i]
    x <- x[, (i_assign0) := ifelse(get(i_corr_var) == 1, 0, get(i_assign0))]
  }

  # Calculate CCI for each id
  formula <- character(0)
  for (i in seq_along(cci_names)) {
    if (i == 1) {
      formula <- paste0(cci_weights[i], "*", cci_names[i])
    } else {
      formula <- paste0(formula, " + ", cci_weights[i], "*", cci_names[i])
    }
  }

  x <- x[, cci := eval(parse(text = formula))]

  if (!keep_groups) {
  x <- x[, list(id, cci)]
  }

  setnames(x, old = c("id", "cci"), new = c(id, cci))

  if (!x_is_dt) {
    x <- as.data.frame(x)
  }

  x
}
