# Watermarking sur des images

## Notre solution

### Ajout du watermark

1. Récupération de l'image d'entrée.
2. Récupération de l'image à tatouer.
3. Redimensionnement des deux images pour un tatouage correct.
4. Conversion de l'image à tatouer en N/B et ensuite en Binaire.
5. Suppression des LSB de l'image d'entrée (cela n'a pas d'impact sur le rendu de l'image)
6. Remplacement des bits supprimés par ceux de l'image à tatouer.
7. Ecriture de l'image résultante dans l'aborescence (fichier WatermarkedImage).

### Extraction et vérification du watermark

1. Récupération de l'image.
2. Extraction des LSB de l'image,ceux ci devraient l'image qui a été tatouée.
3. Comparaison des bits extraits avec l'image tatouée à la base (comparaison bit par bit). Tout logiquement,
   - ✅ Si les images sont égales alors on considère l'image comme **authentique** .
   - ❌ Si les images ne sont pas égales, alors on considère l'image comme étant **non-authentique**.

## Utilisation :

1. Ouvrez le dossier `wm-images` dans `MatLab`.
2. Ajouter le dossier `src` ainsi que tous ses sous-dossier au `Path`:
   - Click-droit sur `src` > `Add to Path` > `Selected Folders and Subfolder`
   - **OU :** exécutez la cmd suivante : `addpath(genpath('src'));`
3. Afin de **watermarker** un siganl:
   ```bash
   addWatermark('chemin/vers/votre/imageDeBase','chemin/vers/votre/image_A_Tatouer')
   ```
4. Libre a vous ensuite de modifier (ou non) l'image résultante.
5. Afin de **verifier l'authenticité** d'une image tatouée:
   ```bash
    checkIntegrity('chemin/vers/votre/Image','chemin/vers/votre/WatermarkDeBase')
   ```
   > Des examples d'utilisation sont disponnibles dans le fichier `test.m`.
