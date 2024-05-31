#!/bin/bash

# Тест работы с файловыми дескрипторами

# Создание и открытие файла через файловый дескриптор
exec 3> testfile.txt

# Проверка успешного открытия файлового дескриптора
if [ $? -eq 0 ]; then
    echo "OPEN FILE DESCRIPTOR: PASS" >> test_results.log
else
    echo "OPEN FILE DESCRIPTOR: FAIL" >> test_results.log
fi

# Запись данных через файловый дескриптор
echo "Test data" >&3

# Закрытие файлового дескриптора
exec 3>&-

# Проверка успешного закрытия файлового дескриптора
if [ $? -eq 0 ]; then
    echo "CLOSE FILE DESCRIPTOR: PASS" >> test_results.log
else
    echo "CLOSE FILE DESCRIPTOR: FAIL" >> test_results.log
fi

# Проверка содержания файла
if grep -q "Test data" testfile.txt; then
    echo "WRITE FILE DESCRIPTOR: PASS" >> test_results.log
else
    echo "WRITE FILE DESCRIPTOR: FAIL" >> test_results.log
fi

# Очистка
rm testfile.txt


# Перенаправление стандартного вывода в файл
echo "This is standard output" > stdout.txt

# Проверка содержания файла стандартного вывода
if grep -q "This is standard output" stdout.txt; then
    echo "REDIRECT STDOUT: PASS" >> test_results.log
else
    echo "REDIRECT STDOUT: FAIL" >> test_results.log
fi

# Перенаправление стандартного ошибки в файл
echo "This is standard error" 2> stderr.txt

# Проверка содержания файла стандартного ошибки
if grep -q "This is standard error" stderr.txt; then
    echo "REDIRECT STDERR: PASS" >> test_results.log
else
    echo "REDIRECT STDERR: FAIL" >> test_results.log
fi

# Очистка
rm stdout.txt stderr.txt

# Перенаправление стандартного вывода и стандартного ошибки в один файл
{
    echo "This is standard output"
    echo "This is standard error" >&2
} > combined_output.txt 2>&1

# Проверка содержания файла
if grep -q "This is standard output" combined_output.txt && grep -q "This is standard error" combined_output.txt; then
    echo "COMBINE STDOUT AND STDERR: PASS" >> test_results.log
else
    echo "COMBINE STDOUT AND STDERR: FAIL" >> test_results.log
fi

# Очистка
rm combined_output.txt
