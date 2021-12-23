function [BW]=TriangleThreshold(inputImage)

[lehisto,~]=imhist(inputImage);
% 
% [level]=triangle_th(gaussBlur,256);

num_bins=256;

 
    [~,xmax]=max(lehisto);
    xmax=round(mean(xmax));   %can have more than a single value!
    h=lehisto(xmax);
    
%   Find location of first and last non-zero values.
%   Values<h/10000 are considered zeros.
    indi=find(lehisto>h/10000);
    fnz=indi(1);
    lnz=indi(end);

%   Pick side as side with longer tail. Assume one tail is longer.
    lspan=xmax-fnz;
    rspan=lnz-xmax;
    if rspan>lspan  % then flip lehisto
        lehisto=fliplr(lehisto');
        a=num_bins-lnz+1;
        b=num_bins-xmax+1;
        isflip=1;
    else
        lehisto=lehisto';
        isflip=0;
        a=fnz;
        b=xmax;
    end
    
%   Compute parameters of the straight line from first non-zero to peak
%   To simplify, shift x axis by a (bin number axis)
    m=h/(b-a);
    
%   Compute distances
    x1=0:(b-a);
    y1=lehisto(x1+a);
    beta=y1+x1/m;
    x2=beta/(m+1/m);
    y2=m*x2;
    L=((y2-y1).^2+(x2-x1).^2).^0.5;

%   Obtain threshold as the location of maximum L.    
    level=find(max(L)==L);
    level=a+mean(level);
    
%   Flip back if necessary
    if isflip
        level=num_bins-level+1;
    end
    
    level=level/num_bins;

BW=imbinarize(inputImage,level);

end