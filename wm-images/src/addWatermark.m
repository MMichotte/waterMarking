function addWatermark(Path_imageSource,Path_watermark)

clc; close all;

initial=imread(Path_imageSource);
source=imresize(initial,[1000, 1000]); % redimensionnement de l_image pour mener à bien le tatouage

figure
subplot(1,2,1)
imshow(source); % displaying objective image
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
 
r=double(source-mod(source,2)); % suppression des LSB de l_image de base 
finalImage=uint8(r+binWm_image); % remplacement des LSB de l_image de base par les bits de l_image à tatouer 

figure
imshow(finalImage)
title('Invisble watermarked Image');
imwrite(finalImage, 'watermarkedImage.png');

end