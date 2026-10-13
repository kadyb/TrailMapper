library("terra")
library("TrailMapper")

DEM = system.file("DEM.tif", package = "TrailMapper")
DEM = rast(DEM)

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

output = sample_transects(DEM, boundary, interval = 2, smooth = NULL)


expect_equal(nrow(output$transects), 9,
             info = "Exactly 9 transects are generated")

expect_equal(nrow(output$transects), nrow(output$central_points),
             info = "Transects and central points have the same number of rows")

expect_identical(output$transects$ID, output$central_points$ID,
                 info = "Transect and central points IDs are identical")

expect_identical(names(output$centerline), c("length", "sinuosity"),
                 info = "Centerline have the expected columns")

expect_identical(names(output$transects), c("ID", "width"),
                 info = "Transects have the expected columns")

expect_identical(names(output$central_points), c("ID", "DEM"),
                 info = "Central points have the expected columns")

expect_identical(names(output$transects_points), c("ID", "x", "y", "DEM"),
                 info = "Transects points have the expected columns")

## distance between points
pts = output$central_points
d = distance(pts, sequential = TRUE)
expect_equal(median(d), 2,
             info = "Given distance between the points is met")
