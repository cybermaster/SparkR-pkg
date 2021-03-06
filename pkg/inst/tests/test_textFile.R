context("the textFile() function")

# JavaSparkContext handle
sc <- sparkR.init()

mockFile = c("Spark is pretty.", "Spark is awesome.")

test_that("textFile() on a local file returns an RDD", {
  fileName <- tempfile(pattern="spark-test", fileext=".tmp")
  writeLines(mockFile, fileName)

  rdd <- textFile(sc, fileName)
  expect_that(class(rdd), is_equivalent_to("RDD"))
  expect_true(count(rdd) > 0)
  expect_true(count(rdd) == 2)

  unlink(fileName)
})

test_that("textFile() followed by a collect() returns the same content", {
  fileName <- tempfile(pattern="spark-test", fileext=".tmp")
  writeLines(mockFile, fileName)

  rdd <- textFile(sc, fileName)
  expect_equal(collect(rdd), as.list(mockFile))

  unlink(fileName)
})
