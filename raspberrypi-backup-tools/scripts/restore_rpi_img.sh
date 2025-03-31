#!/bin/bash

# Script complet de restauration d'image compressée

IMG_PATH="$1"
DEVICE="$2"
TEMP_DIR="/tmp/rpi_restore"

if [ -z "$IMG_PATH" ] || [ -z "$DEVICE" ]; then
  echo "❌ Utilisation : $0 chemin/image.img(.gz/.xz/.7z) /dev/sdX"
  exit 1
fi

echo "⚠️ ATTENTION : le périphérique $DEVICE sera ENTIEREMENT EFFACE !"
read -rp "Continuer ? (oui/N) " confirm
if [[ "$confirm" != "oui" ]]; then
  echo "❌ Abandon."
  exit 1
fi

mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR" || exit 1

EXT="${IMG_PATH##*.}"
IMG_EXTRACTED="raspberry_restored.img"

case "$EXT" in
  img) cp "$IMG_PATH" "$IMG_EXTRACTED" ;;
  gz) gunzip -c "$IMG_PATH" > "$IMG_EXTRACTED" ;;
  xz) xz -dc "$IMG_PATH" > "$IMG_EXTRACTED" ;;
  7z) 7z e "$IMG_PATH" -o"$TEMP_DIR"; IMG_EXTRACTED=$(ls *.img | head -n 1) ;;
  *) echo "❌ Format non reconnu : .$EXT"; exit 1 ;;
esac

echo "💾 Écriture sur $DEVICE..."
sudo dd if="$IMG_EXTRACTED" of="$DEVICE" bs=4M status=progress conv=fsync

echo "✅ Restauration terminée !"
