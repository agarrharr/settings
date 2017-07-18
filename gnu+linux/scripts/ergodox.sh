#!/bin/bash

ergodox_dir="${HOME}/Development/github/aharris88/settings/ergodox"
cat "${ergodox_dir}/MDErgo1-Default.json" | xsel --clipboard --input
xdg-open "http://input.club/configurator-ergodox"

while true; do
  echo "[q]uit [m]ove download [d]iff [r]ight flash [l]eft flash [f]lash both"
  read -n 1 -r key
  echo $key
  case $key in
    m)
      echo "m"
      rm -rf "${ergodox_dir}/{kll,log}"
      mkdir -p /tmp/ergoautomator
      cd /tmp/ergoautomator
      mv ~/Downloads/MDErgo*.zip .
      unzip *.zip
      rm *.zip
      mv -f * $ergodox_dir
      cd $ergodox_dir
      rm -rf /tmp/ergoautomator
      echo "moved!"
      ;;
    r)
      echo "r"
      echo "go into flash mode on the RIGHT and press any key to continue"
      read -n 1 -r
      sudo dfu-util -D "${ergodox_dir}/right_kiibohd.dfu.bin"
      ;;
    l)
      echo "l"
      echo "go into flash mode on the LEFT and press any key to continue"
      read -n 1 -r
      sudo dfu-util -D "${ergodox_dir}/left_kiibohd.dfu.bin"
      ;;
    f)
      echo "f"
      echo "go into flash mode on the LEFT and press any key to continue"
      read -n 1 -r
      sudo dfu-util -D "${ergodox_dir}/left_kiibohd.dfu.bin"
      echo "go into flash mode on the RIGHT and press any key to continue"
      read -n 1 -r
      sudo dfu-util -D "${ergodox_dir}/right_kiibohd.dfu.bin"
      ;;

    d)
      pwd
      git difftool "${ergodox_dir}/*.json"
      git status
      ;;
    q)
      break
      ;;
  esac
done;
