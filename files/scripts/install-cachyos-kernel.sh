#!/bin/bash
set -e

FEDORA_VERSION=$(rpm --eval '%{fedora}')
dnf5 -y copr enable bieszczaders/kernel-cachyos fedora-${FEDORA_VERSION}-x86_64
dnf5 -y copr enable bieszczaders/kernel-cachyos-addons fedora-${FEDORA_VERSION}-x86_64
dnf5 install -y kernel-cachyos kernel-cachyos-modules

if command -v grub2-mkconfig &> /dev/null; then
  grub2-mkconfig -o /etc/grub2.cfg
  if [ -d /boot/efi ]; then
    grub2-mkconfig -o /etc/grub2-efi.cfg
  fi
fi
