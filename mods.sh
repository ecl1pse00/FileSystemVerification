#!/bin/bash

# Тест прав доступа к файлу

# Создание файла для теста
touch testfile.txt

# Установка прав доступа
chmod 0755 testfile.txt

# Проверка прав доступа
actual_permissions=$(stat -c "%a" testfile.txt)
expected_permissions="755"
if [ "$actual_permissions" == "$expected_permissions" ]; then

    echo "SET FILE PERMISSIONS: PASS" >> test_results.log
else
    echo "SET FILE PERMISSIONS: FAIL" >> test_results.log
fi

# Исходный владелец и группа
original_owner=$(stat -c "%U" testfile.txt)
original_group=$(stat -c "%G" testfile.txt)

# Изменение владельца и группы
sudo chown nobody:nogroup testfile.txt

# Проверка владельца и группы
new_owner=$(stat -c "%U" testfile.txt)
new_group=$(stat -c "%G" testfile.txt)

if [ "$new_owner" == "nobody" ] && [ "$new_group" == "nogroup" ]; then
    echo "CHOWN FILE: PASS" >> test_results.log
else
    echo "CHOWN FILE: FAIL" >> test_results.log
fi 

# Восстановление исходного владельца и группы
sudo chown "$original_owner":"$original_group" testfile.txt

# Очистка
rm testfile.txt

# Тест прав доступа к каталогу

# Создание каталога для теста
mkdir testdir

# Установка прав доступа
chmod 0755 testdir

# Проверка прав доступа
actual_permissions=$(stat -c "%a" testdir)
expected_permissions="755"
if [ "$actual_permissions" == "$expected_permissions" ]; then

    echo "SET DIRECTORY PERMISSIONS: PASS" >> test_results.log
else 
    echo "SET DIRECTORY PERMISSIONS: FAIL" >> test_results.log
fi

# Исходный владелец и группа
original_owner=$(stat -c "%U" testdir)
original_group=$(stat -c "%G" testdir)

# Изменение владельца и группы
sudo chown nobody:nogroup testdir

# Проверка владельца и группы
new_owner=$(stat -c "%U" testdir)
new_group=$(stat -c "%G" testdir)

if [ "$new_owner" == "nobody" ] && [ "$new_group" == "nogroup" ]; then
    echo "CHOWN DIRECTORY: PASS"  >> test_results.log
else
    echo "CHOWN DIRECTORY: FAIL"  >> test_results.log
fi

# Восстановление исходного владельца и группы
sudo chown "$original_owner":"$original_group" testdir

# Очистка
rmdir testdir

