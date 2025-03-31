#!/bin/bash

# Script complet de backup + réduction + compression

IMG_NAME="raspberry_backup.img"
DEVICE="/dev/mmcblk0"
OUTPUT_DIR="$HOME/rpi_backup"

mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR" || exit 1

echo "📤 Création de l'image brute..."
sudo dd if="$DEVICE" of="$IMG_NAME" bs=4M status=progress conv=fsync

if [ ! -f ./pishrink.sh ]; then
    echo "⬇️ Téléchargement de PiShrink..."
    wget https://raw.githubusercontent.com/Drewsif/PiShrink/master/pishrink.sh
    chmod +x pishrink.sh
fi

echo "📉 Réduction de l'image avec PiShrink..."
sudo ./pishrink.sh "$IMG_NAME"

echo "🗜️ Compression en .7z..."
7z a "${IMG_NAME%.img}.7z" "$IMG_NAME"

echo "✅ Sauvegarde terminée dans : $OUTPUT_DIR"
