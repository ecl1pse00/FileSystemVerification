#!/bin/bash

# Создание точки монтирования
MOUNT_POINT="/mnt/testfs"

mkdir -p "$MOUNT_POINT"


# Монтирование целевой файловой системы
TARGET_FS=$1
mount "$TARGET_FS" "$MOUNT_POINT"
if [ $? -ne 0 ]; then
    echo "Failed to mount $TARGET_FS to $MOUNT_POINT"
    exit 1
fi

# Переключение в точку монтирования
cd "$MOUNT_POINT" || exit 1

touch errfile.txt
touch test_results.log

/home/aignashev/tests/manage.sh
/home/aignashev/tests/mods.sh
/home/aignashev/tests/fio.sh
/home/aignashev/tests/refs.sh

/home/aignashev/tests/analyze.sh

cat test_report.txt
cat errfile.txt

rm errfile.txt
rm test_results.log

# Возврат в исходную директорию и размонтирование файловой системы
cd -
umount "$MOUNT_POINT"
if [ $? -ne 0 ]; then
    echo "Failed to unmount $MOUNT_POINT"
    exit 1
fi


