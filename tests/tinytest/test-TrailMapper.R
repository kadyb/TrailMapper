library("terra")
library("TrailMapper")

DEM = system.file("DEM.tif", package = "TrailMapper")
DEM = rast(DEM)

boundary = system.file("boundary.gpkg", package = "TrailMapper")
boundary = vect(boundary)
boundary$ID = 1 # this is now required to work

cl = centerline(boundary, smooth = 0)
tr = transects(cl, boundary, interval = 2)
pt_smp = get_values(DEM, tr$centers)
tr_smp = get_values(DEM, tr$transects)


expect_equal(nrow(tr$transects), 9,
             info = "Exactly 9 transects are generated")

expect_equal(nrow(tr$transects), nrow(tr$centers),
             info = "Transects and central points have the same number of rows")

expect_identical(tr$transects$ID, tr$centers$ID,
                 info = "Transect and central points IDs are identical")

expect_identical(names(cl), c("length", "sinuosity"),
                 info = "Centerline have the expected columns")

expect_identical(names(tr$transects), c("ID", "width"),
                 info = "Transects have the expected columns")

expect_identical(names(pt_smp), c("ID", "DEM"),
                 info = "Central points have the expected columns")

expect_identical(names(tr_smp), c("ID", "x", "y", "DEM"),
                 info = "Transects points have the expected columns")

## distance between points
d = distance(tr$centers, sequential = TRUE)
expect_equal(median(d), 2,
             info = "Given distance between the points is met")
