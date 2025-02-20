# ZFS Setup

## Partition Disks

- Find disk id
    - `fdisk -l`
- Create partitions
    - `fdisk /dev/disk/by-id/X`
        - Create 1 partition

## Setup Mirror

To setup a mirror but start of with one drive and add the second one later.

### Single drive

- Encrypt partition
    - `cryptsetup luksFormat /dev/disk/by-id/X-part1` 
    - `cryptsetup luksOpen /dev/disk/by-id/X-part1 CRYPTNAME`
- Create zpool
    - `zpool create -R /mnt -o ashift=12 POOLNAME /dev/mapper/CRYPTNAME`
    - `zpool status`
- Create dataset 
    - `zfs create POOLNAME/DATASETNAME`
- For SSD's: enable autotrim
    - `zpool set autotrim=on POOLNAME`

### Add mirror

- Attach drive to existing pool and drive
    - `zpool attach POOLNAME /dev/disk/by-id/CURRENTDRIVE /dev/disk/by-id/NEWHDD`
