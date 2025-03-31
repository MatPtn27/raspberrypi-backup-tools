#!/bin/bash

# Script pour monter une image .img et accéder à BOOT + ROOT

IMG_PATH="$1"
TEMP_DIR="/mnt/rpi_mount"
MOUNT_BOOT="$TEMP_DIR/boot"
MOUNT_ROOT="$TEMP_DIR/root"

if [ -z "$IMG_PATH" ]; then
  echo "❌ Utilisation : $0 image.img"
  exit 1
fi

mkdir -p "$MOUNT_BOOT" "$MOUNT_ROOT"

OFFSET_BOOT=$(fdisk -l "$IMG_PATH" | grep FAT | awk '{print $2}')
OFFSET_ROOT=$(fdisk -l "$IMG_PATH" | grep Linux | awk '{print $2}')
SECTOR_SIZE=$(fdisk -l "$IMG_PATH" | grep "Sector size" | awk '{print $4}')

let "BYTE_OFFSET_BOOT=$OFFSET_BOOT * $SECTOR_SIZE"
let "BYTE_OFFSET_ROOT=$OFFSET_ROOT * $SECTOR_SIZE"

sudo mount -o loop,offset=$BYTE_OFFSET_BOOT "$IMG_PATH" "$MOUNT_BOOT"
sudo mount -o loop,offset=$BYTE_OFFSET_ROOT "$IMG_PATH" "$MOUNT_ROOT"

echo "✅ Image montée :"
echo "  - BOOT -> $MOUNT_BOOT"
echo "  - ROOT -> $MOUNT_ROOT"
