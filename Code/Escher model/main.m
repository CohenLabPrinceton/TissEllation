%% For tissues with equal space, simply perform a finite anology to the voronoi transform
RGB = imread('EscherEllipses.tiff'); %read in RGB image representing the three channels  

%find min distance from tissue footprints from each channel to each pixel
distances = bwdist(logical(RGB)); 

%find minimum distance overall
minDistanceTemp = min(distances(:,:,1), distances(:,:,2)); 
minDistance = min(minDistanceTemp, distances(:,:,3));

infiniteTimeResult=zeros(size(distances)); %initialize output image

%determine which channel is min to determine final footprints
infiniteTimeResult(:,:,1) = distances(:,:,1) == minDistance;
infiniteTimeResult(:,:,2) = distances(:,:,2) == minDistance;
infiniteTimeResult(:,:,3) = distances(:,:,3) == minDistance;      

imshow(imresize(infiniteTimeResult,0.1))