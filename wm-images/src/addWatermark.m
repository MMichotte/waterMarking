function addWatermark(Path_imageSource,Path_watermark)

clc; close all;

source=imread(Path_imageSource);
temp1=imresize(source,[1000, 1000]); % redimensionnement de l_image pour mener à bien le tatouage


if (size(temp1,3)==3)
    graySource=rgb2gray(temp1); % conversion de l_image en N/B (2D)
else
    graySource=temp1;
end

figure
subplot(1,2,1)
imshow(graySource); % displaying objective image
title('Objective image');


% traitement de l_image à tatouer

wm_image=imread(Path_watermark); 
temp2=imresize(wm_image,[1000, 1000]); % redimensionnement de l_image pour mener à bien le tatouage

% conversion de l_image en Binaire 

if (size(temp2,3)==3)
    binWm_image=imbinarize(rgb2gray(temp2));  
else
    binWm_image=imbinarize(temp2); 
end


subplot(1,2,2);
imshow(binWm_image) % displaying image to be hidden
title('image to be hidden');

binWm_image=double(binWm_image); 
r=double(graySource-mod(graySource,2)); % suppression des LSB de l_image de base 
finalImage=uint8(r+binWm_image); % remplacement des LSB de l_image de base par les bits de l_image à tatouer 

figure
imshow(finalImage)
title('Invisble watermarked Image');
imwrite(finalImage, 'watermarkedImage.png');

end