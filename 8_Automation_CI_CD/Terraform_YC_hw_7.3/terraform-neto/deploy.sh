#!/bin/bash

# Запускаем terraform
terraform apply -auto-approve

# Получаем IP адрес из output terraform

external_ipv4_address=$(terraform output external_ipv4_address)

# Добавляем IP адрес в файл hosts ansible
echo -e "[myhosts]\n${external_ipv4_address}\n\n[myhosts:vars]\nansible_host_key_checking=False" > /etc/ansible/inventory.ini

# проверка
max_attempts=3  # Максимальное количество попыток
attempts=0      # Счетчик попыток

while [ $attempts -lt $max_attempts ]; do
    # Выполняем команду ansible
    ansible_output=$(ansible all -m ping)
    status=$?

    # Проверяем статус выполнения команды
    if [ $status -eq 0 ]; then
        echo "OK"  # Команда выполнена успешно
        break      # Завершение цикла, но продолжение выполнения скрипта
    else
        echo "Не удалось выполнить команду, попытка $((attempts + 1)) из $max_attempts..."
        attempts=$((attempts + 1))  # Увеличиваем счетчик попыток
        sleep 60   # Ждем 60 секунд перед повтором
    fi
done

# Этот код выполнится после завершения цикла
if [ $attempts -eq $max_attempts ]; then
    echo "Все попытки завершились неудачей."
fi

ansible-playbook ~/ansible-netology/nginx_site.yml 

echo "Скрипт завершён."


