%%

%tif stacks made by passing writeMode 'append' to imwrite
writeMode = cell([1000,1]);
writeMode(:) = {'append'};
writeMode(1)= {'overWrite'};

frames = length(imfinfo('c1.tif')); %find number of frames in input image
    
for jj=1:frames
    clc
    disp([ num2str(jj) '/' num2str(frames)]);

    %read in the data
    thisfluor1 = imread('c2.tif',jj);
    thisfluor2 = imread('c3.tif',jj);
    thisphase = imread('c1.tif',jj);

    %resize the phase data to match the fluor data
    phaseResized = imresize(thisphase,size(thisfluor1));
    
    %calculate the gradient analogous to "find edges" command in Fiji
    edges=normalizeImage(imgradient(phaseResized),0,8);
    
    %Threshold the image to find the overall tissue mask
    phaseMask = TriangleThreshold(edges);

    %manually subtract out the background from the fluorescence channels
    fluor1Background = median(thisfluor1(phaseMask==0));
    fluor1BackSub = thisfluor1-fluor1Background;

    fluor2Background = median(thisfluor2(phaseMask==0));
    fluor2BackSub = thisfluor2-fluor2Background;

    %Find whether fluor 1 or fluor 2 is brighter at each pixel of the image
    fluor1Greater = (fluor1BackSub > fluor2BackSub);
    fluor2Greater = (fluor2BackSub >= fluor1BackSub);

    %use the overall mask to mask out the background
    fluor1Greater(phaseMask==0)=0;
    fluor2Greater(phaseMask==0)=0;

    %keep only the largest contiguous regions and fill holes
    fluor1Filt = bwareafilt(fluor1Greater,1,4);
    fluor2Filt = bwareafilt(fluor2Greater,1,4);
    fluor1FiltFilled = imfill(fluor1Filt,'holes');
    fluor2FiltFilled = imfill(fluor2Filt,'holes');

    combinedMask = fluor1FiltFilled | fluor2FiltFilled;
    
    %save the data as tif stacks
    imwrite(combinedMask,'c1_mask.tif','writeMode', writeMode{jj},'compression','none');
    imwrite(fluor1FiltFilled,'c2_mask.tif','writeMode', writeMode{jj},'compression','none');
    imwrite(fluor2FiltFilled,'c3_mask.tif','writeMode', writeMode{jj},'compression','none');
end

