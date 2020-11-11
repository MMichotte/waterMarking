# Watermarking sur des sons

## Notre solution 

### Ajout du watermark
1. Récupération du signal d'entrée.
2. Création d'un watermark (wm) couvrant la totalité de la durée du signal et avec un fréquence < 20Hz (soit inaudible).
3. Ajout d'un préfix contenant la longueur initial du signal en binaire sur le wm.
4. Application d'un filtre passe-haut sur le signal d'entrée (afin de ne garder que les fréquences audibles).
5. Ajout du wm dans le signal d'entrée.
6. Écriture du signal dans un nouveau fichier. 

:warning: **Conditions:** le signal ne peut pas durer plus de **40h**! 

### Extraction et vérification du watermark
1. Récupération du signal d'entrée.
2. Extraction et décodage du préfix afin de connaître la longeur du son initial.
   - ❌ Si cette étape échoue => le signal d'origine a été modifié. Il est alors considéré comme étant **non-authentique**.
3. Re-création du watermark avec les configurations standard et les données décodées.
4. Application d'un filtre pass-bas sur le signal d'entrée afin d'en extraire le watermark.
5. Corrélation entre le watermark original et le watermark extrait du signal.
   - ✅ Si le taux de correlation est **>= 0.98** alors on considère le signal comme étant **authentique**.
   - ❌ Si le taux de correlation est **< 0.98** alors on considère le signal comme étant **non-authentique**. 


## Utilisation :

1. Ouvrez le dossier `wm-sounds` dans `MatLab`.
2. Ajouter le dossier `src` ainsi que tous ses sous-dossier au `Path`:
   - Click-droit sur `src` > `Add to Path` > `Selected Folders and Subfolder`  
   - **OU :** exécutez la cmd suivante : `addpath(genpath('src'));`
3. Afin de **watermarker** un siganl:
    ```bash
    addWatermark('chemin/vers/votre/signal.wav')
    ```
4. Libre a vous ensuite de modifier (ou non) ce signal avec des outils comme `Audacity` ou autre.
5. Afin de **verifier l'authenticité** d'un signal:
    ```bash
    checkIntegrity('chemin/vers/votre/signal2.wav')
    ```
> Des examples d'utilisation sont disponnibles dans le fichier `tests.m`. 
