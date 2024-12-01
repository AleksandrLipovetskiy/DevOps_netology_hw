#!/bin/bash

# Переменные
PORT=80  # Порт, который нужно проверить
NGINX_ROOT="/var/www/html"  # Путь к root-директории Nginx

# Проверка доступности порта
if nc -z localhost $PORT; then
    echo "Порт $PORT доступен."
else
    echo "Порт $PORT недоступен."
    exit 1
fi

# Проверка существования файла index.html
if [ -f "$NGINX_ROOT/index.html" ]; then
    echo "Файл index.html существует в $NGINX_ROOT."
else
    echo "Файл index.html не найден в $NGINX_ROOT."
    exit 1
fi

echo "Проверка завершена успешно."
exit 0  # Возвращаем 0 при успешной проверке
