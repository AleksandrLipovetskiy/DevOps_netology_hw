# Домашнее задание к занятию 3 «Резервное копирование» - Липовецкий Александр  

Задание 1  
Скриншот выполнения команды rsync, которая позволяет создавать зеркальную копию домашней директории пользователя в директорию /tmp/backup и исключает из синхронизации все директории, начинающиеся с точки (скрытые)  
![Скриншот1](./2024-11-20_22-22-59.png)  

Скриншот выполнения rsync с подсчетом хэш-суммы для всех файлов, даже если их время модификации и размер идентичны в источнике и приемнике.  
![Скриншот2](./2024-11-20_22-28-24.png)  

Задание 2  
Файл настроек crone:
[Sam](./sam)  

Результат выполнения задачи на регулярное резервное копирование домашней директории пользователя с помощью rsync и cron.  
![Скриншот3](./2024-11-20_23-40-35.png)  
