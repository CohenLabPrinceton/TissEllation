function [outputImage]=normalizeImage(inputImage,fractionPixelsToClip,output8or16bit)
if fractionPixelsToClip >1 || fractionPixelsToClip<0
   error('please choose fraction of Pixels to clip between 0 and 1 (input 2)'); 
end
imsize=size(inputImage);
reshaped=reshape(inputImage,[imsize(1)*imsize(2),1]);
sorted=sort(reshaped);
amax=double(sorted(round(length(sorted)*(max([1-fractionPixelsToClip,fractionPixelsToClip])))));
amin=double(sorted((round(length(sorted)*(min([1-fractionPixelsToClip,fractionPixelsToClip]))))+1));
enhancedImage=mat2gray(inputImage,[amin amax]);

if output8or16bit==16

    outputImage=uint16(enhancedImage*(2^16-1));
    

elseif output8or16bit==8
    outputImage=uint8(enhancedImage*(2^8-1));
else
    error('please choose 8 or 16 for output bit depth (input 3)');
end
end

