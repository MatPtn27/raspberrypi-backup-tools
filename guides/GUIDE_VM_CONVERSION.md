# GUIDE_VM_CONVERSION.md

## Préparer l’image pour machine virtuelle

1. Placer ton fichier `.img`, `.img.gz`, `.7z`, etc. dans un dossier
2. Lancer le script :
   ```bash
   ./convert_rpi_to_vm.sh raspberry_backup.7z vdi
   ```
   Formats supportés : `vdi`, `vmdk`, `qcow2`

## Importer dans un hyperviseur

- **VirtualBox** : créer une nouvelle VM (Other Linux 64-bit), ajouter le `.vdi`
- **VMware** : ajouter le `.vmdk`
- **QEMU/Proxmox** : utiliser le `.qcow2`

## Remarques

- Certaines images nécessitent un `kernel-qemu` pour démarrer
- L’accélération matérielle ARM dépend de la config (voir `qemu-system-aarch64`)
