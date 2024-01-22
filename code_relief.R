# http://dwtkns.com/srtm/ source for altitude in France
# https://www.data.gouv.fr/fr/datasets/contours-des-regions-francaises-sur-openstreetmap/ source for shape of france
library(terra)
library(sf)

# Put all files in tiff_files
tiff_files <- list.files(path = "data", pattern = "\\.tif$", full.names = TRUE)
shape_france=read_sf("data/regions-20180101.shp")

# Read all rasters
rasters <- lapply(tiff_files, rast)

# Merge all tiff
combined_raster <- do.call(merge, rasters)

# Cut the shape of France
relief_france_raster <- mask(combined_raster, shape_france)

# Save data
writeRaster(relief_france_raster, "relief_france_raster.tif", overwrite=TRUE)
