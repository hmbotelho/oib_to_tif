# oib_to_tif
File conversion using RBioFormats

### Goal
Convert OIB image to size-calibrated TIF

### Original OIB


Note that the pixel size has been set.


### Proof-of-principle: BioFormats command line tools

[Documentation](https://docs.openmicroscopy.org/bio-formats/6.9.1/users/comlinetools/conversion.html)  
[Download link](https://downloads.openmicroscopy.org/bio-formats/6.9.1/artifacts/bftools.zip)  

Run the conversion:
```
bfconvert Image0010_01.oib Image0010_01.ome.tiff
```

![image](https://user-images.githubusercontent.com/7735703/168575691-1d875d42-118d-4e6c-892a-01f6e2377d87.png)

Conversion succeeds. Size metadata is preserved (despite micron-to-centimeter change).

### Using RBioFormats

Let us now try the same with RBioFormats

```{r}
library(RBioFormats)

# read OIB
fname_oib = "Image0010_01.oib"
img = read.image(fname_oib, normalize = FALSE)[,,2]

# save as ome.tiff
fname_tif = sub(".oib", ".ome.tiff", fname_oib)
write.image(img, fname_tif, force = TRUE, pixelType = "uint16")    # Size metadata is partially lost
```

![image](https://user-images.githubusercontent.com/7735703/168575766-904b8028-3bd1-48c4-845d-a69b35571021.png)

Size calibration has been lost. However, units (cm) were preserved.
