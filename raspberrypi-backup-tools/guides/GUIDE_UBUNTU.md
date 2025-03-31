# GUIDE_UBUNTU.md

## Sauvegarder une carte SD

1. Insérer la carte et identifier le périphérique :
   ```bash
   lsblk
   ```
2. Créer l’image avec `dd` :
   ```bash
   sudo dd if=/dev/mmcblk0 of=raspberry_backup.img bs=4M status=progress conv=fsync
   ```

## Réduire l’image avec PiShrink

1. Télécharger PiShrink :
   ```bash
   wget https://raw.githubusercontent.com/Drewsif/PiShrink/master/pishrink.sh
   chmod +x pishrink.sh
   sudo ./pishrink.sh raspberry_backup.img
   ```

## Compresser l’image

```bash
7z a raspberry_backup.7z raspberry_backup.img
```

## Restaurer l’image

```bash
./restore_rpi_img.sh raspberry_backup.7z /dev/mmcblk0
```
