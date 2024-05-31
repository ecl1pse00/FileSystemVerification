#!/bin/bash

# Тест создания и удаления символических ссылок

# Создание файла для теста
touch testfile.txt

# Создание символической ссылки
ln -s testfile.txt symlink.txt

# Проверка символической ссылки
if [ -L symlink.txt ]; then
    echo "CREATE SYMBOLIC LINK: PASS" >> test_results.log
else
    echo "CREATE SYMBOLIC LINK: FAIL" >> test_results.log
fi

# Удаление символической ссылки
rm symlink.txt

# Проверка удаления символической ссылки
if [ ! -L symlink.txt ]; then
    echo "DELETE SYMBOLIC LINK: PASS" >> test_results.log
else
    echo "DELETE SYMBOLIC LINK: FAIL" >> test_results.log
fi

# Тест создания и удаления жестких ссылок

# Создание жесткой ссылки
ln testfile.txt hardlink.txt

# Проверка жесткой ссылки
if [ -f hardlink.txt ]; then
    echo "CREATE HARD LINK: PASS" >> test_results.log
else
    echo "CREATE HARD LINK: FAIL" >> test_results.log
fi

# Удаление жесткой ссылки
rm hardlink.txt

# Проверка удаления жесткой ссылки
if [ ! -f hardlink.txt ]; then
    echo "DELETE HARD LINK: PASS" >> test_results.log
else
    echo "DELETE HARD LINK: FAIL" >> test_results.log
fi

# Очистка
rm testfile.txt
