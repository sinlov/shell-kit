#!/bin/bash

os_release="unix"
os_bit=""
check_sys() {
  case "$(uname)" in
  Darwin*)
    os_release="Darwin"
    ;;
  *)
    if [[ -f /etc/redhat-release ]]; then
      os_release="centos"
    elif cat /etc/issue | grep -q -E -i "debian"; then
      os_release="debian"
    elif cat /etc/issue | grep -q -E -i "ubuntu"; then
      os_release="ubuntu"
    elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
      os_release="centos"
    elif cat /proc/version | grep -q -E -i "debian"; then
      os_release="debian"
    elif cat /proc/version | grep -q -E -i "ubuntu"; then
      os_release="ubuntu"
    elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
      os_release="centos"
    fi
    ;;
  esac
  os_bit=$(uname -m)
}
check_sys

# Check if it includes deleting the root directory
cannot_delete_dir=false
contains_root_dir=false
for ((i = 2; i <= $#; i++)); do
  rp=$(realpath ${!i})
  if [[ "${os_release}" -ne "Darwin" ]]; then
    rp=$(realpath -s ${!i})
  fi

  if (
    [ "$rp" = "/bin" ] ||
    [ "$rp" = "/boot" ] ||
    [ "$rp" = "/data" ] ||
    [ "$rp" = "/dev" ] ||
    [ "$rp" = "/etc" ] ||
    [ "$rp" = "/home" ] ||
    [ "$rp" = "/lib" ] ||
    [ "$rp" = "/lib32" ] ||
    [ "$rp" = "/lib64" ] ||
    [ "$rp" = "/libx32" ] ||
    [ "$rp" = "/mnt" ] ||
    [ "$rp" = "/media" ] ||
    [ "$rp" = "/opt" ] ||
    [ "$rp" = "/proc" ] ||
    [ "$rp" = "/root" ] ||
    [ "$rp" = "/run" ] ||
    [ "$rp" = "/sbin" ] ||
    [ "$rp" = "/snap" ] ||
    [ "$rp" = "/srv" ] ||
    [ "$rp" = "/sys" ] ||
    [ "$rp" = "/tmp" ] ||
    [ "$rp" = "/usr" ] ||
    [ "$rp" = "/usr/bin" ] ||
    [ "$rp" = "/usr/lib" ] ||
    [ "$rp" = "/usr/lib32" ] ||
    [ "$rp" = "/usr/libx32" ] ||
    [ "$rp" = "/usr/sbin" ] ||
    [ "$rp" = "/usr/local" ] ||
    [ "$rp" = "/var" ]
  ); then
    cannot_delete_dir=true
  elif [[ $rp =~ ^/[^/]*$ ]]; then
    contains_root_dir=true
  fi
done

# Check if command-line arguments are "rm -rf /" or "rm -rf /*"
if [ "$#" -ge 2 ] && [ "$0" = "/usr/local/bin/saferm" ] && [ "$1" = "-rf" ]; then
    if [ "$2" = "/" ] || [ "$cannot_delete_dir"  = "true" ]; then
      # Cannot delete specified directories
      echo "Deletion of these directories is not allowed."
    elif [ "$contains_root_dir"  = "true" ]; then
      # Prompt the user for confirmation
      echo "Danger: Are you sure you want to delete the folders in this root directory? (yes/no): "
      read confirmation
      # Check the user's input
      if [ "$confirmation" == "yes" ]; then
        # If the user enters "yes," execute the system's rm command
        /bin/rm "$@"
        echo "Deletion successful."
      else
        # If the user enters anything else or "no," cancel the deletion operation
        echo "Deletion canceled."
      fi
    else
      /bin/rm "$@"
    fi
fi