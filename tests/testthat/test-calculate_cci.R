test_that("both data.frame and data.table can be used", {
  dat <- data.frame(id = rep(1, each = 10), code = sample_codes(10))
  expect_error(calculate_cci(dat), NA)
  expect_error(calculate_cci(data.table::as.data.table(dat)), NA)
})

test_that("returns data.frame or data.table", {
  dat <- data.frame(id = rep(1, each = 10), code = sample_codes(10))
  checkmate::expect_data_frame(calculate_cci(dat))
  checkmate::expect_data_table(calculate_cci(data.table::as.data.table(dat)))
})

test_that("empty `x` throws error", {
  dat <- data.frame()
  expect_error(calculate_cci(dat))
})

test_that("non-default variable names" , {
  # Non-default id name
  dat <- data.frame(id1 = 1, code = "I23")
  expect_error(test <- calculate_cci(dat, id = "id1"), NA)
  expect_identical(c("id1", "cci"), names(test))

  # Non-default code name
  dat <- data.frame(id = 1, code1 = "I23")
  expect_error(test <- calculate_cci(dat, code = "code1"), NA)
  expect_identical(c("id", "cci"), names(test))
  expect_equal(test[["cci"]], 1)

  # Non-default cci name
  dat <- data.frame(id = 1, code = "I23")
  expect_error(test <- calculate_cci(dat, cci = "cci1"), NA)
  expect_identical(c("id", "cci1"), names(test))

  # Non-default everything
  dat <- data.frame(id1 = 1, code1 = "I23")
  expect_error(test <- calculate_cci(dat, id = "id1", code = "code1", cci = "cci1"), NA)
  expect_identical(c("id1", "cci1"), names(test))
  expect_equal(test[["cci1"]], 1)
})

test_that("the keep_group argument works", {
  dat <- data.frame(id = 1, code = "I23")
  expect_error(test <- calculate_cci(dat, keep_groups = TRUE), NA)
  expect_identical(c("id", paste0("cci", 1:19), "cci"), names(test))
})

test_that("speciying variables not in 'x' throws error", {
  dat <- data.frame(id = 1, code = "123")
  expect_error(calculate_cci(dat, code = "code1"))
  expect_error(calculate_cci(dat, id = "id1"))
})

test_that("(sub)codes are correctly allocated to CCI disease groups", {
  dat <- data.frame(id = 1, code = "I2")
  expect_equal(calculate_cci(dat)[, "cci"], 0)
  dat <- data.frame(id = 1, code = "I23")
  expect_equal(calculate_cci(dat)[, "cci"], 1)
  dat <- data.frame(id = 1, code = "I230")
  expect_equal(calculate_cci(dat)[, "cci"], 1)
})

test_that("SKS codes are correctly handled using the sks_codes argument", {
  dat <- data.frame(
    id = 1,
    code = c("DI23")
  )
  expect_equal(calculate_cci(dat, sks_codes = FALSE)[, "cci"], 0)
  expect_equal(calculate_cci(dat, sks_codes = TRUE)[, "cci"], 1)
})

test_that("correct CCI scores are calculated", {
  # Small random test to check that function gives correct results.
  dat <- data.frame(
    id = rep(1:3, each = 2),
    code = c("12345", "abcde", "195", "C80", "E100", "K71")
  )
  test <- calculate_cci(dat)
  expect_equal(test[, "id"], c(1, 2, 3))
  expect_equal(test[, "cci"], c(0, 6, 2))
})

test_that("corrections are implemented correctly", {
  dat <- data.frame(id = c(1, 1), code = c("K73", "K72"))
  expect_equal(calculate_cci(dat)[, "cci"], 3)
})
