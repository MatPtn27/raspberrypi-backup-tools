# GUIDE_MACOS.md

## Sauvegarder la carte SD

1. Identifier la carte :
   ```bash
   diskutil list
   ```
2. Démonter le disque :
   ```bash
   diskutil unmountDisk /dev/diskX
   ```
3. Créer l’image avec `dd` :
   ```bash
   sudo dd if=/dev/rdiskX of=~/raspberry_backup.img bs=1m
   ```

## Compresser l’image

```bash
gzip ~/raspberry_backup.img
```

## Réduire avec PiShrink (optionnel)

> macOS ne supporte pas PiShrink directement. Transfère l’image sur une machine Ubuntu et utilise le script.
