{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings.allowDiscards = true;
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
      nvme0 = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zhome";
              };
            };
          };
        };
      };
      nvme1 = {
        device = "/dev/nvme1n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zhome";
              };
            };
          };
        };
      };
    };
    zpool = {
      zhome = {
        type = "zpool";
        mode = "mirror";
        options = {
          ashift = "12";
          autotrim = "on";
        };
        rootFsOptions = {
          relatime = "on";
          compression = "lz4";
          "com.sun:auto-snapshot" = "false";
        };
        mountpoint = "/home";

        datasets = {
          bas = {
            type = "zfs_fs";
            options = {
              mountpoint = "/home/bas";
              encryption = "aes-256-gcm";
              keyformat = "passphrase";
            };
            postCreateHook = ''
              zfs set keylocation="prompt" "zhome/$name";
            '';
          };
        };
      };
    };
  };
}
