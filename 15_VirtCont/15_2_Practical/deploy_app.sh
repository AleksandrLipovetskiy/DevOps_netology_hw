#!/bin/bash

REPO="https://github.com/AleksandrLipovetskiy/shvirtd-example-python.git"
TARGET_DIR="/opt/app"


if [ ! -d "$TARGET_DIR" ]; then
    echo "Создаем директорию $TARGET_DIR..."
    mkdir -p "$TARGET_DIR"
    if [ $? -ne 0 ]; then
        echo "Ошибка при создании директории!" >&2
        exit 1
    fi
else
    echo "Директория $TARGET_DIR уже существует. Продолжаем работу..."
fi

rm -rf $TARGET_DIR

echo "Клонируем репозиторий в $TARGET_DIR..."
git clone $REPO $TARGET_DIR
cd $TARGET_DIR

echo "Запускаем Docker-проект..."
docker compose up -d --build