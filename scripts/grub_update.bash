#!/bin/bash
set -euxo pipefail

if [ -x /usr/bin/update-grub ]; then
	/usr/bin/update-grub
elif [ -x /usr/sbin/update-grub ]; then
	/usr/sbin/update-grub
else
	TRY[0]='/usr/bin/grub2-mkconfig'
	TRY[1]='/usr/bin/grub-mkconfig'
	TRY[2]='/usr/sbin/grub2-mkconfig'
	TRY[3]='/usr/sbin/grub-mkconfig'
	C=0
	while [ ! -x ${TRY[C]} ]; do
		C=$(( C + 1 ))
	done
	${TRY[C]} -o /boot/grub2/grub.cfg
fi
