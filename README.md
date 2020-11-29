# Projet Traitement des signaux et données : WaterMarking <!-- omit in toc -->

[**M. Michotte**](https://github.com/MMichotte) | [**O. Niyonkuru**](https://github.com/danny00747) | [**M. Valentin**](https://github.com/momo007Dev) | [**P. Tchoupe**](https://github.com/PatrickTchoupe) | [**T. Tekadam**](https://github.com/tresor-ruph)

- [Introduction](#introduction)
- [Répartition des tâches](#répartition-des-tâches)
- [Nos solutions](#nos-solutions)
  - [watermarking sur des images](#watermarking-sur-des-images)
    - [Méthodologie](#méthodologie)
    - [Librairies utilisée](#librairies-utilisée)
    - [Pistes d'améliorations](#pistes-daméliorations)
  - [watermarking sur des sons](#watermarking-sur-des-sons)
    - [Méthodologie](#méthodologie-1)
      - [Ajout du watermark](#ajout-du-watermark)
      - [Extraction et vérification du watermark](#extraction-et-vérification-du-watermark)
      - [Utilisation :](#utilisation-)
    - [Librairies utilisée](#librairies-utilisée-1)
    - [Pistes d'améliorations](#pistes-daméliorations-1)
- [Conclusions](#conclusions)
  - [Générale](#générale)
  - [Martin Michotte](#martin-michotte)
  - [Patrick Tchoupe](#patrick-tchoupe)
  - [Olivier Niyonkuru](#olivier-niyonkuru)
  - [Morgan Valentin](#morgan-valentin)
  - [Trésor Tekadam](#trésor-tekadam)

<div style="page-break-after: always"></div>

## Introduction

Un watermark ou tatouage numérique est un signal ou une information ajoutée à un signal source afin de pouvoir authentifier celui-ci sans pour autant le modifier de manière trop importante.

Le but de ce projet est donc de pouvoir :

1. "watermarquer" un signal.
2. Donner le signal tatoué à une tierce personne afin qu'il le modifie ou non.
3. Analyser le signal tatoué récupéré afin de pouvoir dire s'il est authentique (non-modifié) ou non.

Un signal pouvant être une multitude de choses, nous nous sommes concentré uniquement sur les images et les sons.

## Répartition des tâches

Étant donnée que nous avons deux types de signaux à traiter, nous avons créé deux groupes :

- `images` : **P.Tchoupe**, **M.Valentin**, **T.Tekadam**
- `sons` : **M.Michotte**, **O.Niyonkuru**

Notons que même si nous avons travaillé en deux groupes distincs, nous avons régulièrement organisé des réunions afin de présenter aux autres le travail effectué ainsi que de discuter d'éventuelles modifications/améliorations à apporter.

## Nos solutions

## I. watermarking sur des images

#### Méthodologie

##### Ajout du watermark :

1. Récupération de l'image d'entrée.
2. Récupération de l'image à tatouer.
3. Vérification des tailles des deux images,si elles sont pas égales le reste des étapes ne sera pas éxécuté.
4. Conversion de l'image à tatouer en N/B et ensuite en Binaire.
5. Suppression des LSB de l'image d'entrée (cela n'a pas d'impact sur le rendu de l'image)
6. Remplacement des bits supprimés par ceux de l'image à tatouer.
7. Ecriture de l'image résultante dans l'aborescence (fichier WatermarkedImage).

#### Extraction et vérification du watermark :

1. Récupération de l'image.
2. Extraction des LSB de l'image,ceux ci devraient constituer l'image qui a été tatouée.
3. Comparaison des bits extraits avec l'image tatouée à la base (comparaison bit par bit). Tout logiquement,
   - ✅ Si les images sont égales alors on considère l'image comme **authentique** .
   - ❌ Si les images ne sont pas égales, alors on considère l'image comme étant **non-authentique**.

#### Utilisation :

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

#### Librairies utilisées

Nous n'avons pas utlisé de librairies pour réaliser cette partie

#### Pistes d'améliorations

- Effectuer le tatouage sans tenir compte le taille du watermark : Ici l'idée serait de redimensionner les deux images fournies par l'utilisateur et effectuer le watermarking avec ces nouvelles dimensions
- Watermarker une image avec du texte, texte qui pourrait être le nom de l'auteur de l'image pour des soucis de droits d'auteurs.

## II. watermarking sur des sons

#### Méthodologie

##### Ajout du watermark

1. Récupération du `signal d'entrée`.
2. Création d'un watermark (`wm`) couvrant la totalité de la durée du signal et avec un fréquence de 0.5Hz (< 20Hz) (soit inaudible).
3. Ajout d'un préfix contenant la longueur initial du signal en binaire sur le `wm`.
4. Application d'un filtre passe-haut sur le `signal d'entrée` (afin de ne garder que les fréquences audibles).
5. Ajout du `wm` dans le `signal d'entrée`.
6. Écriture du signal dans un nouveau fichier.

:warning: **Conditions:** le signal ne peut pas durer plus de **40h**[^1]!

##### Extraction et vérification du watermark

1. Récupération du `signal d'entrée`.
2. Extraction et décodage du préfix afin de connaître la longeur du son initial.
   - ❌ Si cette étape échoue => le signal d'origine a été modifié. Il est alors considéré comme étant **non-authentique**.
3. Re-création du watermark avec les configurations standard et les données décodées.
4. Application d'un filtre pass-bas sur le `signal d'entrée` afin d'en extraire le `watermark`.
5. Corrélation entre le `watermark original` et le `watermark extrait` du signal.
   - ✅ Si le taux de correlation est **>= 0.98** alors on considère le signal comme étant **authentique**.
   - ❌ Si le taux de correlation est **< 0.98** alors on considère le signal comme étant **non-authentique**.

##### Utilisation :

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
   `bash checkIntegrity('chemin/vers/votre/signal2.wav') `
   > Des examples d'utilisation sont disponnibles dans le fichier `tests.m`.

#### Librairies utilisée

Aucune librairie externe a été utilisée.

#### Pistes d'améliorations

- Pouvoir ajouter un watermark contenant de l'information tel que le nom de l'auteur de son ou autre.
- Ne pas avoir de contraintes de durée sur le son.

## Conclusions

### Générale

### Martin Michotte

### Patrick Tchoupe

### Olivier Niyonkuru

### Morgan Valentin

### Trésor Tekadam

---

[^1]: La durée du signal converti en nano-secondes étant stocké sur 40 bits, il a fallu limiter la durée maximale du son afin d'éviter un buffer-overflow.
