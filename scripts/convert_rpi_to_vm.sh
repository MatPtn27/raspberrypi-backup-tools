#!/bin/bash

# Script de conversion .img vers .vdi / .vmdk / .qcow2

IMG_PATH="$1"
TARGET_FORMAT="${2:-vdi}"
TEMP_DIR="/tmp/rpi_vm"

if [ -z "$IMG_PATH" ]; then
  echo "❌ Utilisation : $0 chemin/image.img(.gz/.xz/.7z) [vdi|vmdk|qcow2]"
  exit 1
fi

mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR" || exit 1

EXT="${IMG_PATH##*.}"
case "$EXT" in
  img) cp "$IMG_PATH" image.img ;;
  gz) gunzip -c "$IMG_PATH" > image.img ;;
  xz) xz -dc "$IMG_PATH" > image.img ;;
  7z) 7z e "$IMG_PATH" -o"$TEMP_DIR" ;;
  *) echo "❌ Format non supporté : .$EXT"; exit 1 ;;
esac

IMG_FILE=$(ls *.img | head -n 1)
OUT_FILE="rpi_vm.$TARGET_FORMAT"

case "$TARGET_FORMAT" in
  vdi) VBoxManage convertfromraw "$IMG_FILE" "$OUT_FILE" --format VDI ;;
  vmdk) qemu-img convert -f raw -O vmdk "$IMG_FILE" "$OUT_FILE" ;;
  qcow2) qemu-img convert -f raw -O qcow2 "$IMG_FILE" "$OUT_FILE" ;;
  *) echo "❌ Format inconnu : $TARGET_FORMAT"; exit 1 ;;
esac

echo "✅ Image convertie : $OUT_FILE"
