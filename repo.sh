#!/bin/bash
cd /cirrus/rom
    
sync () {
    #rm -rf .repo/local_manifests
    #repo init --depth=1 --no-repo-verify -u https://github.com/NusantaraProject-ROM/android_manifest.git -b 12 -g default,-mips,-darwin,-notdefault
    #git clone https://github.com/ariffjenong/local_manifest.git --depth 1 -b nad-12 .repo/local_manifests
    repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24
}

compile () {
    sync
    echo "done."
}

cherry_pick () {
  cd frameworks/base
  git remote add fork https://github.com/ariffjenong/android_frameworks_base-1.git
  git fetch fork twelve-one && git cherry-pick 8880cb54eed9277a9e3581aa3ad55ba718f7e012 && git cherry-pick 6c0124275d947c784b2f021d8d64b9918a31b369
}

patch () {
  cd device/sony/maple_dsds
  wget https://raw.githubusercontent.com/Flamefire/android_device_sony_lilac/lineage-19.0/patches/applyPatches.sh
  wget https://raw.githubusercontent.com/Flamefire/android_device_sony_lilac/lineage-19.0/patches/workaround_egl_lib_symbols.patch
  git add . && git commit -m 'apply path'
}

ls -lh
compile

# Lets see machine specifications and environments
df -h
free -h
nproc
cat /etc/os*
