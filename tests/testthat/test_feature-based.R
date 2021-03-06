context("Test Overlapping")

test_that("multiclass.result", {

  aux = featurebased(Species ~ ., iris, measures="F1", summary="return")
  aux = 1/(max((1/aux$F1) - 1) + 1)
  expect_equal(aux, 0.05862828)

  aux = featurebased(Species ~ ., iris, measures="F1v", summary="return")
  aux = 1/(mean((1/aux$F1v) - 1) + 1)
  expect_equal(aux, 0.009504561)

  aux = featurebased(Species ~ ., iris, measures="F2", summary="mean")
  expect_equal(as.numeric(aux$F2), 0.006381766)

  aux = featurebased(Species ~ ., iris, measures="F3", summary="mean")
  expect_equal(as.numeric(aux$F3), 0.123333333)

  aux = featurebased(Species ~ ., iris, measures="F4", summary="mean")
  expect_equal(as.numeric(aux$F4), 0.043333333)
})

test_that("binary.result", {

  iris = iris[1:100,]
  iris$Species = factor(iris$Species)

  aux = featurebased(Species ~ ., iris, measures="F1", summary="return")
  aux = 1/(max((1/aux$F1) - 1) + 1)
  expect_equal(aux, 0.059118951)

  aux = featurebased(Species ~ ., iris, measures="F1v", summary="return")
  aux = 1/(mean((1/aux$F1v) - 1) + 1)
  expect_equal(aux, 0.009593841)

  aux = featurebased(Species ~ ., iris, measures="F2", summary="mean")
  expect_equal(as.numeric(aux$F2), 0)

  aux = featurebased(Species ~ ., iris, measures="F3", summary="mean")
  expect_equal(as.numeric(aux$F3), 0)

  aux = featurebased(Species ~ ., iris, measures="F4", summary="mean")
  expect_equal(as.numeric(aux$F4), 0)
})

test_that("validation.error",{

  expect_error(featurebased(Species ~ ., iris, measures="L1"))
  expect_error(featurebased(Species ~ ., iris, measures="L2", summary="abc"))

  expect_error(featurebased(speed ~ ., cars))
  expect_error(featurebased(speed ~ ., cars, measures="L1"))
  expect_error(featurebased(speed ~ ., cars, measures="L2", summary="abc"))
})
