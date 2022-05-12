# oib_to_tif
File conversion using RBioFormats

### Goal
Convert OIB image to size-calibrated TIF

### Original OIB

![image](https://user-images.githubusercontent.com/7735703/168130021-7992b533-e4d3-4432-8b9b-bd75c951a14e.png)

Note that the pixel size has been set.


### R code

```{r}
library(RBioFormats)

# read OIB
fname_oib = "Image0010_01.oib"
img = read.image(fname_oib, normalize = FALSE)[,,2]

# Get image metadata
pixelWidth <- as.numeric(img@metadata$globalMetadata$`[Reference Image Parameter] WidthConvertValue`)
pixelHeight <- as.numeric(img@metadata$globalMetadata$`[Reference Image Parameter] HeightConvertValue`)
pixelsizeunit <- img@metadata$globalMetadata$`[Reference Image Parameter] WidthUnit`

# save as tif
fname_tif = sub(".oib", ".tif", fname_oib)
write.image(img, fname_tif, force = TRUE, pixelType = "uint16")     # pixel size metadata is lost...
```

### TIF version
![image](https://user-images.githubusercontent.com/7735703/168130144-029d7840-1afa-41bb-a19a-f6156b9026d7.png)

Size calibration has been lost.

Is there a way to keep the metadata in the TIF version?
