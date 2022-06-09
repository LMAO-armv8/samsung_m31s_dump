#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71106560:62df1f386fb70319ac78f41191abeb166baad47f; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):61865984:67bc168fac5444862e7a6f51e73114a80b40279f \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71106560:62df1f386fb70319ac78f41191abeb166baad47f && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

