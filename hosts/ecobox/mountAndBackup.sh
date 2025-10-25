block_path=/dev/disk/by-uuid/fb8546a6-b71e-47a8-87bb-21ee7394fb9b
service_name=restic-backups-local.service

udisksctl mount -b "$block_path"
systemctl start "$service_name"
journalctl -b -u "$service_name"
udisksctl unmount -b "$block_path"
udisksctl power-off -b "$block_path"

