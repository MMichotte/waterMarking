function status = checkIntegrity(Path_watermarkedImage,Path_OriginalImage)

% vérification du watermark de l_image renvoyé par un tiers

watermarkedImage=imread(Path_watermarkedImage);
image_extracted=mod(watermarkedImage,2); % division modulaire image watermarked pour obtenir tous ses LSB


original_wm=imread(Path_OriginalImage);

% vérifie la dimension de l_image avant conversion en binaire

if (size(original_wm,3)==3)
    bin_originalWm=imbinarize(rgb2gray(original_wm)); % conversion watermark pour une comparaison.
else
    bin_originalWm=imbinarize(original_wm); % conversion image tatouee pour une comparaison.
end


% On vérifie que l_image n-a pas été altéré
try 

    if image_extracted==bin_originalWm
    status = 'Watermark not altered!';
    return

    else 
    status = 'Watermark altered!';
    return

    end
catch error
    status = 'Watermark altered!';
    return;
end
end