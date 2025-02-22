{...}: {
  boot.initrd.luks.devices = {
    "cryptzbig1".device = "/dev/disk/by-uuid/bfca26e6-bfa1-4f07-b694-80c135c447ed";
    "cryptzbig2".device = "/dev/disk/by-uuid/f079793a-a450-4f98-815f-750d76d91669";
  };
  boot.zfs.extraPools = ["zbig"];
}
