OpponentSIFT
The SIFT descriptor uses only information from the intensity
channel. A natural extension is to include the opponent color
space. In this way, we decompose the opponent color space into
three channels (equation 4), each described using a SIFT descriptor.
The information in the O3 channel is equal to the intensity
information, while the other channels describe the color information
in the image. However, these other channels do contain some
intensity information: hence they are not invariant to changes in
light intensity. We term this descriptor OpponentSIFT.

RGBSIFT and rgbSIFT probably work similarly (detect descriptors on all color channels separately)
