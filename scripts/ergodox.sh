#!/usr/bin/env sh

cat ~/settings/ergodox/MDErgo1-Default.json | pbcopy
open "http://input.club/configurator-ergodox"

while true; do
  echo "[q]uit [m]ove download [d]iff [r]ight flash [l]eft flash [f]lash both"
  read -n1 -r key
  case $key in
    m)
      rm -rf ~/settings/ergodox/{kll,log}
      mkdir -p /tmp/ergoautomator
      cd /tmp/ergoautomator
      mv ~/Downloads/MDErgo*.zip .
      unzip *.zip
      rm *.zip
      mv -f * ~/settings/ergodox
      cd ~/settings/ergodox
      rm -rf /tmp/ergoautomator
      echo "moved!"
      ;;
    r)
      echo "go into flash mode on the RIGHT and press any key to continue"
      read -n1 -r
      dfu-util -D right_kiibohd.dfu.bin
      ;;
    l)
      echo "go into flash mode on the LEFT and press any key to continue"
      read -n1 -r
      dfu-util -D left_kiibohd.dfu.bin
      ;;
    f)
      echo "go into flash mode on the LEFT and press any key to continue"
      read -n1 -r
      dfu-util -D left_kiibohd.dfu.bin
      echo "go into flash mode on the RIGHT and press any key to continue"
      read -n1 -r
      dfu-util -D right_kiibohd.dfu.bin
      ;;

    d)
      pwd
      git difftool ~/settings/ergodox/*.json
      git status
      ;;
    q)
      break
      ;;
  esac
done;
