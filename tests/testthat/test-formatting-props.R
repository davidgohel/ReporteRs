context("formatting properties")

test_that("text properties", {
  skip_if_not(check_valid_java_version())
  tp <- textProperties(color="red", font.weight = "bold",
                       font.style = "italic", underlined = TRUE )
  tp_ <- chprop(tp, font.weight = "normal")
  expect_equal(tp_$font.weight, "normal" )
})

test_that("par properties", {
  skip_if_not(check_valid_java_version())
  pp <- parRight( )
  expect_equal(pp$text.align, "right" )
  pp <- parLeft( )
  expect_equal(pp$text.align, "left" )
  pp_ <- chprop(pp, text.align = "center")
  expect_equal(pp_$text.align, "center" )
})

