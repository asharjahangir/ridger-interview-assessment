#!/bin/bash
# start-vm.sh — Start the RidgerNAS/XigmaNAS VM
# Usage: ./start-vm.sh [options]
#   -c, --cdrom ISO    Boot from CD-ROM ISO
#   -m, --monitor      Enable QEMU monitor on socket
#   -s, --serial       Enable serial console
#   -h, --help         Show this help

DISK="xigmanas-disk.qcow2"
MEM="2048"
SMP="2"
VNC_DISPLAY=":0"
MONITOR_SOCKET="/tmp/qemu-monitor.sock"
SSH_PORT="2222"
HTTP_PORT="8888"

# Default: boot from disk (no CD-ROM)
CDROM=""
MONITOR=""
SERIAL=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -c|--cdrom)
      CDROM="-cdrom $2 -boot d"
      shift 2 ;;
    -m|--monitor)
      MONITOR="-monitor unix:$MONITOR_SOCKET,server,nowait"
      shift ;;
    -s|--serial)
      SERIAL="-serial file:/tmp/xigmanas-console.log"
      shift ;;
    -h|--help)
      echo "Usage: $0 [-c|--cdrom ISO] [-m|--monitor] [-s|--serial]"
      exit 0 ;;
    *)
      echo "Unknown option: $1"
      exit 1 ;;
  esac
done

echo "Starting RidgerNAS VM..."
echo "  Web GUI: http://localhost:$HTTP_PORT"
echo "  SSH:     ssh -p $SSH_PORT root@localhost"
echo "  VNC:     localhost${VNC_DISPLAY}"

qemu-system-x86_64 \
  -machine q35 \
  -m $MEM \
  -smp $SMP \
  -drive file=$DISK,format=qcow2 \
  $CDROM \
  -boot c \
  -vga std \
  -vnc $VNC_DISPLAY \
  $MONITOR \
  $SERIAL \
  -device e1000,netdev=net0 \
  -netdev user,id=net0,hostfwd=tcp::${SSH_PORT}-:22,hostfwd=tcp::${HTTP_PORT}-:80

echo "VM stopped."