library(RBioFormats)


# read OIB
fname_oib = "Image0010_01.oib"
img = read.image(fname_oib, normalize = FALSE)[,,2]


# Get image metadata
# pixelWidth <- as.numeric(img@metadata$globalMetadata$`[Reference Image Parameter] WidthConvertValue`)
# pixelHeight <- as.numeric(img@metadata$globalMetadata$`[Reference Image Parameter] HeightConvertValue`)
# pixelsizeunit <- img@metadata$globalMetadata$`[Reference Image Parameter] WidthUnit`


# save as ome.tif
fname_tif = sub(".oib", ".ome.tiff", fname_oib)
write.image(img, fname_tif, force = TRUE, pixelType = "uint16")
