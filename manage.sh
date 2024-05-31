#!/bin/bash


# Тест на создание каталога
mkdir testdir
if [ -d testdir ]; then
    echo "CREATE DIRECTORY: PASS" >> test_results.log
else
    echo "CREATE DIRECTORY: FAIL" >> test_results.log
fi

# Тест на удаление каталога
rmdir testdir
if [ ! -d testdir ]; then
    echo "DELETE DIRECTORY: PASS" >> test_results.log
else
    echo "DELETE DIRECTORY: FAIL" >> test_results.log
fi
    
    
# Создание файла
touch testfile.txt

if [[ -f testfile.txt ]]; then
	echo "CREATE FILE: PASS" >> test_results.log
else
	echo "CREATE FILE: FAIL" >> test_results.log
fi

# Тест на переименование файла
mv testfile.txt renamedfile.txt

if [ -f renamedfile.txt ]; then
    echo "RENAME FILE: PASS" >> test_results.log
else 
    echo "RENAME FILE: FAIL" >> test_results.log
fi

# Удаление файла
rm renamedfile.txt
if [[ ! -f renamedfile.txt ]]; then
	echo "DELETE FILE: PASS" >> test_results.log
else
	echo "DELETE FILE: FAIL" >> test_results.log
fi


