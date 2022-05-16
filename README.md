# oib_to_tif
File conversion using RBioFormats

### Goal
Convert OIB image to size-calibrated TIF

### Original OIB

![image](https://user-images.githubusercontent.com/7735703/168576402-18d1a958-7def-47b1-acc1-285d5e905128.png)

Note that the pixel size has been set.


### Proof-of-principle: BioFormats command line tools

[Documentation](https://docs.openmicroscopy.org/bio-formats/6.9.1/users/comlinetools/conversion.html)  
[Download link](https://downloads.openmicroscopy.org/bio-formats/6.9.1/artifacts/bftools.zip)  

Run the conversion:
```
bfconvert Image0010_01.oib Image0010_01.ome.tiff
```

![image](https://user-images.githubusercontent.com/7735703/168576486-0679b1df-228b-4774-ace3-4a08822fb995.png)

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

![image](https://user-images.githubusercontent.com/7735703/168576529-da0c7265-c4ec-4df6-a796-dca71ab29246.png)

Size calibration has been lost. However, units (cm) were preserved.
