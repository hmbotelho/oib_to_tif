library(RBioFormats)

# read OIB
fname_oib = "../Image0010_01.oib"
oib <- read.image(fname_oib, normalize = FALSE, subset = list(C = 2))

# Check pixel size calibration (before)
globalMetadata(oib, pattern = "WidthConvertValue|HeightConvertValue|WidthUnit")
# $`[Reference Image Parameter] WidthUnit`
# [1] "um"
# 
# $`[Reference Image Parameter] HeightConvertValue`
# [1] "6.214"
# 
# $`[Reference Image Parameter] WidthConvertValue`
# [1] "6.214"

# save as ome.tif
fname_tif = sub(".oib", ".ome.tif", sub("../","",fname_oib))
write.image(oib, fname_tif, force = TRUE)

# Check pixel size calibration (after saving)
tif <- read.image(fname_tif, normalize = FALSE)

globalMetadata(tif, pattern = "WidthConvertValue|HeightConvertValue|WidthUnit")
# $`[Reference Image Parameter] WidthUnit`
# [1] "um"
# 
# $`[Reference Image Parameter] HeightConvertValue`
# [1] "6.214"
# 
# $`[Reference Image Parameter] WidthConvertValue`
# [1] "6.214"