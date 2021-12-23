circ=imread('H2xy02Circ.tif')<0.9; %mask 1 from tissue collision initial condition
rect=imread('H2xy02Rect.tif')<0.9; %mask 2 from tissue collision initial condition

pixelSize = 8*1.825; %microns per pixel of input masks
vn = 29.5; %speed in microns/h

timeOfExpt = 72; %in hours

T_circ = bwdist(circ)*pixelSize/vn; %Time map of mask 1
T_rect = bwdist(rect)*pixelSize/vn; %Time map of mask 2

SS_circ = T_circ < T_rect; %steady state form of tissue 1
SS_rect = T_rect <= T_circ; %steady state form of tissue 2

for time=1:timeOfExpt %loop in time, 1 per hour
   thisCirc = SS_circ &  T_circ <= time; %form of tissue 1 at this timepoint
   thisRect = SS_rect &  T_rect <= time; %form of tissue 2 at this timepoint
    
   imshow(cat(3,thisCirc,thisRect,thisCirc)*255) %displays the tissue overlay
    
end