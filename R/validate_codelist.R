validate_codelist <- function(x) {
  if (class(x) != "codelist") {
    stop(paste0("`x` does not have class \"codelist\""), call. = FALSE)
  }


  # Check that each element of the list is a list
  for (i in seq_along(x)) {
    if (!is.list(x[[i]])) {
      stop(paste0("`x[[", i, "]]` is not a list."), call. = FALSE)
    }
  }

  # Check that each sub-list has the correct names
  correct_names <- c("label", "name", "codes", "weight", "assign0_if")
  correct_names_collapse <- paste0(correct_names, collapse = ", ")
  for (i in seq_along(x)) {
    i_list <- x[[1]]
    i_names <- names(i_list)
    if (any(i_names != correct_names)) {
    stop(
      paste0("`x[[", i,"]]", "`", " does not have names: ", correct_names_collapse),
      call. = FALSE)
    }
  }


  # Check each element of each sublist
  for (i in seq_along(x)) {
    i_label <- x[[i]][["label"]]
    i_name <- x[[i]][["name"]]
    i_codes <- x[[i]][["codes"]]
    i_weight <- x[[i]][["weight"]]
    i_assign0_if <- x[[i]][["assign0_if"]]

    # Check that label is a character vector of length 1
    if (!(is.character(i_label) & length(i_label) == 1)) {
      stop(paste0("`x[[", i,"]][[\"label\"]]` is not character vector of length 1"), call. = FALSE)
    }

    # Check that name is a syntactically valid name
    if (!(is.character(i_name) & length(i_name) == 1)) {
      stop(paste0("`x[[", i,"]][[\"name\"]]` is not character vector of length 1"), call. = FALSE)
    }
    if (i_name != make.names(i_name)) {
      stop(paste0("`x[[", i,"]][[\"name\"]]` is not a syntactically valid name"), call. = FALSE)
    }

    # Check that codes is a character vector
    if (!is.character(i_codes)) {
      stop(paste0("`x[[", i,"]][[\"codes\"]]` is not a character vector"), call. = FALSE)
    }

    # Check that weight is a non-negative numeric value
    if (!(is.numeric(i_weight) & length(i_weight) & i_weight >= 0)) {
      stop(paste0("`x[[", i,"]][[\"weight\"]]` is not a non-negative numeric value"), call. = FALSE)
    }

    # Check that correction is either NULL or a syntactically valid name
    if (!(
        is.null(i_assign0_if) ||
        (is.character(i_assign0_if) & length(i_assign0_if) == 1 & i_assign0_if == make.names(i_assign0_if))
      )) {
      stop(paste0("`x[[", i,"]][[\"assing0_if\"]]` is not NULL or a syntactically valid name"), call. = FALSE)
    }
  }

  # Check that correction names are a subset of names
  var_names <- character()
  assign0_names <- character()
  for (i in seq_along(x)) {
    var_names <- c(var_names, x[[i]][["name"]])
    assign0_names <- c(assign0_names, x[[i]][["assign0_if"]])
  }
  if (!all(assign0_names %in% var_names)) {
    stop(paste0("Correction variables not a subset of variable names"), call. = FALSE)
  }

  x
}
