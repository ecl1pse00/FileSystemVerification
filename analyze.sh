#!/bin/bash

# Функция для чтения лог-файла и анализа результатов
log_file="test_results.log"
total_tests=0
passed_tests=0
failed_tests=0

while IFS= read -r line; do
	total_tests=$((total_tests + 1))
	if [[ "$line" == *"PASS"* ]]; then
   	 passed_tests=$((passed_tests + 1))
	else
		echo "$line" >> errfile.txt
    	failed_tests=$((failed_tests + 1))
	fi
done < "$log_file"

pass_rate=$(echo "scale=2; $passed_tests / $total_tests * 100" | bc)

echo "Test Report:" > test_report.txt
echo "Total Tests: $total_tests" >> test_report.txt
echo "Passed Tests: $passed_tests" >> test_report.txt
echo "Failed Tests: $failed_tests" >> test_report.txt
echo "Pass Rate: $pass_rate%" >> test_report.txt

