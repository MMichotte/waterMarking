function status = addWatermark(Path_imageSource,Path_watermark)

source=imread(Path_imageSource);
wm_image=imread(Path_watermark); 

% vérification de la taille des l_image
sourceSize = size(source(:,:,1));
wmSize = size(wm_image);

if (sourceSize ~= wmSize)
    status = 'Error: the images have to have the same size!';
    return;
end

% conversion de l_image en Binaire 
if (size(wm_image,3)==3)
    binWm_image=imbinarize(rgb2gray(wm_image));  
else
    binWm_image=imbinarize(wm_image); 
end

figure
subplot(1,2,1)
imshow(source); % displaying objective image
title('Source image');
subplot(1,2,2);
imshow(binWm_image) % displaying image to be hidden
title('Watermark image');

 
r=double(source-mod(source,2)); % suppression des LSB de l_image de base 
finalImage=uint8(r+binWm_image); % remplacement des LSB de l_image de base par les bits de l_image à tatouer 

%{
figure
imshow(finalImage)
title('Invisble watermarked Image');
%}

imwrite(finalImage, 'watermarkedImage.png');

status = 'Image successfully marked!';
end