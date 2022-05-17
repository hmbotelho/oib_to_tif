# oib_to_tif
File conversion using RBioFormats

### Goal
Convert OIB image to size-calibrated TIF

### Original OIB

[OIB file](./Image0010_01.oib)
![image](https://user-images.githubusercontent.com/7735703/168576402-18d1a958-7def-47b1-acc1-285d5e905128.png)

Note that the pixel size has been set.


### Proof-of-principle: BioFormats command line tools

[Documentation](https://docs.openmicroscopy.org/bio-formats/6.9.1/users/comlinetools/conversion.html)  
[Download link](https://downloads.openmicroscopy.org/bio-formats/6.9.1/artifacts/bftools.zip)  

Run the conversion:
```
bfconvert Image0010_01.oib Image0010_01.ome.tif
```
[OME.TIF file (bftools)](./bftools/Image0010_01.ome.tif)

![image](https://user-images.githubusercontent.com/7735703/168576486-0679b1df-228b-4774-ace3-4a08822fb995.png)

Conversion succeeds. Size metadata is preserved (despite micron-to-centimeter change).

### Using RBioFormats

Let us now try the same with RBioFormats

```{r}
library(RBioFormats)
#> Loading required package: rJava
#> BioFormats library version 6.9.1

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
```

[OME.TIF file (RBioFormats)](./rbioformats/Image0010_01.ome.tif)

![image](https://user-images.githubusercontent.com/7735703/168576633-417b9160-463e-439c-8925-0a7b07a40562.png)

Size calibration is included in the OME-XML metadata. However, it is not accessible to Fiji. Units (cm) were preserved, through.


### Conclusion

I believe pixel size calibration is not accessible to Fiji because of this OME-XML metadata field

[OME-XML (bftools)](./bftools/Image0010_01.ome.xml)
`<Pixels BigEndian="false" DimensionOrder="XYCZT" ID="Pixels:0" Interleaved="false" PhysicalSizeX="6.214" PhysicalSizeXUnit="µm" PhysicalSizeY="6.214" PhysicalSizeYUnit="µm" PhysicalSizeZ="1.0" PhysicalSizeZUnit="µm" SignificantBits="12" SizeC="2" SizeT="1" SizeX="512" SizeY="512" SizeZ="1" TimeIncrement="1.0" TimeIncrementUnit="s" Type="uint16">`

[OME-XML (rbioformats)](./rbioformats/Image0010_01.ome.xml)
`<Pixels BigEndian="true" DimensionOrder="XYCZT" ID="Pixels:0" Interleaved="false" SignificantBits="16" SizeC="1" SizeT="1" SizeX="512" SizeY="512" SizeZ="1" Type="uint16">`
