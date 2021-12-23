Software has been tested on Matlab R2018b and requires the image processing toolbox. Run times are less than one minute for a standard computer. Installing Matlab can take as long as 30 minutes.

--Collision Model--
Description: Basic collision model for predicting the evolution of tissue forms during expansion and collision, assuming a pinned boundary. 

Input data: H2xy02Circ.tif, H2xy02Rect.tif
example expected output: output.fig
main code: main.m
dependent functions: none

Instructions: Open main.m in Matlab. Example output will simply display an RGB image with green and magenta fill for predicted tissue footprints.


--Engulfment model--
Description: Collision model extended for tissues with different normal velocity vn. This corrects the unphysical property of a faster tissue to grow "through" the slower tissue rather than around it.

Input data: MaskMCF7.tif, MaskMCF10A.tif
example expected output: output.fig
main code: main.m
dependent functions: none

Instructions: Open main.m in Matlab. Example output will simply display an RGB image with green and magenta fill for predicted tissue footprints.



--Escher model--
Description: Tessellation prediction for 3 channels represented by RGB tiff. Input is an RGB tiff and output is printed final tessellation forms. 

Input data: EscherEllipses.tif
example expected output: output.fig
main code: main.m
dependent functions: none

Instructions: Open main.m in Matlab. Example output will simply display an RGB image for predicted final tessellation given initial tissues as per input image



--Experimental data segmentation--
Description: Example of segmentation of two tissue collision experiments. Dye becomes dim late in the experiment, so segmentation is first performed on the phase channel (c1.tif) and the fluorescence channels (c2.tif and c3.tif) are compared to determine tissue

Input data: c1.tif, c2.tif, c3.tif
example expected output: expectedOutput_c1_mask.tif, expectedOutput_c2_mask.tif, expectedOutput_c3_mask.tif,
main code: main.m
dependent functions: TriangleThreshold.m, normalizeImage.m

Instructions: Open main.m in Matlab. Segmented images will save in the directory location as c1_mask.tif, c2_mask.tif, c3_mask.tif and should match expectedOutput_c1_mask.tif, etc. 