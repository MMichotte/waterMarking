function checkIntegrity(Path_watermarkedImage,Path_OriginalImage)

watermarkedImage=imread(Path_watermarkedImage);
image_extracted=mod(watermarkedImage,2); % division modulaire image watermarked pour obtenir tous ses LSB


% check the integrity of the watermark

original_wm=imread(Path_OriginalImage);
temp1=imresize(original_wm,[1000 1000]);

% checking the size of the image
if (size(temp1,3)==3)
    bin_originalWm=imbinarize(rgb2gray(temp1)); % conversion image tatouee pour une comparaison.
else
    bin_originalWm=imbinarize(temp1); % conversion image tatouee pour une comparaison.
end


try 

    if image_extracted==bin_originalWm
    disp('Watermark not altered!')
    return

    else 
    disp('Watermark altered!')
    return

    end
catch error
    disp('Watermark altered!');
    return;
end
end