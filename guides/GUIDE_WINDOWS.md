# GUIDE_WINDOWS.md

## Sauvegarder la carte SD Raspberry Pi

1. Télécharger [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/) et [7-Zip](https://www.7-zip.org/)
2. Insérer la carte SD dans un lecteur
3. Lancer **Win32 Disk Imager**
4. Sélectionner la lettre de la carte SD (ex: `F:`)
5. Choisir un nom pour l’image : `raspberry_backup.img`
6. Cliquer sur **Read** pour créer l’image

## Compresser l’image

- Clic droit > **7-Zip > Ajouter à l’archive…**
- Choisir `Format : 7z` et compression : **Ultra**

## Réduction avec PiShrink (optionnel)

> Windows ne supporte pas PiShrink nativement. Tu peux utiliser **WSL avec Ubuntu** et suivre le guide Linux.
