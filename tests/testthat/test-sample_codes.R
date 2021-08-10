test_that("sample_codes correctly checks function arguments", {
  value <- 5L
  expect_error(sample_codes(n = 5L), NA)
  expect_error(sample_codes(n = 5), NA)
  expect_error(sample_codes(n = 5.0), NA)
  expect_error(sample_codes(n = 05), NA)
  expect_error(sample_codes(n = 1e1), NA)
  expect_error(sample_codes(n = value), NA)
  expect_error(sample_codes(n = 0))
  expect_error(sample_codes(n = -1))
  expect_error(sample_codes(n = "1"))
  expect_error(sample_codes(n = c(2, 3)))
  expect_error(sample_codes(n = NULL))
  expect_error(sample_codes(n = NA))
  expect_error(sample_codes(n = Inf))

  value <- "icd10_cm_2020"
  expect_error(sample_codes(code_sources = c("icd8_4digits", "icd10_cm_2020")), NA)
  expect_error(sample_codes(code_sources = "icd8_4digits"), NA)
  expect_error(sample_codes(code_sources = value), NA)
  expect_error(sample_codes(code_sources = c("not in set")))
  expect_error(sample_codes(code_sources = 1))
  expect_error(sample_codes(code_sources = NULL))
  expect_error(sample_codes(code_sources = NA))
  expect_error(sample_codes(code_sources = Inf))

  value <- 5L
  expect_error(sample_codes(max_code_length = 1L), NA)
  expect_error(sample_codes(max_code_length = 10), NA)
  expect_error(sample_codes(max_code_length = 5.0), NA)
  expect_error(sample_codes(max_code_length = 05), NA)
  expect_error(sample_codes(max_code_length = 1e1), NA)
  expect_error(sample_codes(max_code_length = value), NA)
  expect_error(sample_codes(max_code_length = 0))
  expect_error(sample_codes(max_code_length = -1))
  expect_error(sample_codes(max_code_length = "1"))
  expect_error(sample_codes(max_code_length = c(2, 3)))
  expect_error(sample_codes(max_code_length = NULL))
  expect_error(sample_codes(max_code_length = NA))
  expect_error(sample_codes(max_code_length = Inf))
})

test_that("sample_codes return character vector", {
  checkmate::expect_character(sample_codes())
})

test_that("return vector has the same length as the value of n", {
  expect_identical(length(sample_codes(n = 10L)), 10L)
})
