%% 2 tissue collision with different normal velocity vn
MCF10A = imread('MaskMCF10A.tif'); %initial tissue footprint for fast tissue
MCF7 = imread('MaskMCF7.tif'); %initial tissue footprint for slow tissue

pixelSize=1.825*2; % in microns, to scale the image
interval = 6; %in hours, interval for which simulation is reset

velocity_MCF7=7; %in microns/h, normal velocity vn of slow tissue
velocity_MCF10A=40; %in microns/h, normal velocity vn of fast tissue

T_MCF10A = bwdist(MCF10A)*pixelSize/velocity_MCF10A; %Time map of fast tissue
T_MCF7 = bwdist(MCF7)*pixelSize/velocity_MCF7; %Time map of slow tissue

SS_10A = T_MCF10A<T_MCF7; %steady state form of fast tissue
SS_7 = T_MCF7<T_MCF10A; %steady state form of slow tissue

time=0; %initialize time

segmented_10A = T_MCF10A<=time & SS_10A; %initial footprint of fast tissue
segmented_7 = T_MCF7<=time & SS_7; %initial footprint of slow tissue

overlay = cat(3,uint8(segmented_10A*255),uint8(segmented_7*255),uint8(segmented_10A*255));
%overlay tissue footprints as RGB image green/magenta
imshow(overlay)

%uncomment below to save image 
%imwrite(overlay,['fixedEnvelopeModel_t' num2str(time) '.png'])


for time = interval:interval:120 %calculate new steady state footprints every interval hours

segmented_10A = T_MCF10A<=interval & SS_10A; %footprint of tissue at time
segmented_7 = T_MCF7<=interval & SS_7;

overlay = cat(3,uint8(segmented_10A*255),uint8(segmented_7*255),uint8(segmented_10A*255));
%overlay tissue footprints as RGB image green/magenta
imshow(overlay)

%uncomment below to save image 
%imwrite(overlay,['fixedEnvelopeModel_t' num2str(time) '.png'])

MCF10A = segmented_10A; %reset initial condition as the current condition
MCF7 = segmented_7;

T_MCF10A = bwdist(MCF10A)*pixelSize/velocity_MCF10A; %recalculate the time map
T_MCF7 = bwdist(MCF7)*pixelSize/velocity_MCF7;

SS_10A = T_MCF10A<T_MCF7; %recalculate the steady state forms
SS_7 = T_MCF7<T_MCF10A;

end