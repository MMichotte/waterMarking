function addWatermark(Path_imageSource,Path_watermark)

clc;
close all;

source=imread(Path_imageSource);
temp1=imresize(source,[1000, 1000]); % resizing taken image
if (size(temp1,3)==3)
    graySource=rgb2gray(temp1); % converting rgb image to gray image
else
    graySource=temp1;
end

figure
subplot(1,2,1)
imshow(graySource); % displaying objective image
title('Objective image');

wm_image=imread(Path_watermark); % image to be hidden
temp2=imresize(wm_image,[1000, 1000]); % resizing hidden image
if (size(temp2,3)==3)
    binWm_image=imbinarize(rgb2gray(temp2)); % converting rbg to binary 
else
    binWm_image=imbinarize(temp2); % converting rbg to binary 
end


subplot(1,2,2);
imshow(binWm_image) % displaying image to be hidden
title('image to be hidden');

binWm_image=double(binWm_image); % increasing range to double
r=double(graySource-mod(graySource,2)); % removal of LSB bits 
finalImage=uint8(r+binWm_image); % adding LSB bit from image to be hidden

figure
imshow(finalImage)
title('Invisble watermarked Image');
imwrite(finalImage, 'watermarkedImage.png');

end