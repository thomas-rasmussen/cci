#' Print method for codelists
#'
#' @param x a codelist
#' @param ... Other arguments
#'
#' @export
#'
#' @examples
#' print(cci_codelist_icd10)
print.codelist <- function(x, ...) {
  cat("Codelist definition of CCI:\n")
  for (i in seq_along(x)) {
    i_label <- x[[i]][["label"]]
    i_name <- x[[i]][["name"]]
    i_codes <- x[[i]][["codes"]]
    i_weight <- x[[i]][["weight"]]
    i_assign0 <- x[[i]][["assign0_if"]]
    cat(paste0(i_label, ":\n"))
    cat(paste0("- name:", i_name, "\n"))
    cat(paste0("- weight:", i_weight, "\n"))
    cat(paste0("- corrections:", i_assign0, "\n"))
    cat(paste0("- codes: ", paste0(i_codes, collapse = " "), "\n"))

  }
}
