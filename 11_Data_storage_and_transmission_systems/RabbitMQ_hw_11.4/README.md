# Домашнее задание к занятию «Очереди RabbitMQ» - Липовецкий Александр

## Задание 1. Установка RabbitMQ
Используя Vagrant или VirtualBox, создайте виртуальную машину и установите RabbitMQ. Добавьте management plug-in и зайдите в веб-интерфейс.  

Итогом выполнения домашнего задания будет приложенный скриншот веб-интерфейса RabbitMQ.  

### ОТВЕТ на задание 1.

Веб-интерфейс RabbitMQ
![Веб-интерфейс RabbitMQ](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/RabbitMQ_hw_11.4/2024-11-26_00-16-18.png)

## Задание 2. Отправка и получение сообщений
Используя приложенные скрипты, проведите тестовую отправку и получение сообщения. Для отправки сообщений необходимо запустить скрипт producer.py.

Для работы скриптов вам необходимо установить Python версии 3 и библиотеку Pika. Также в скриптах нужно указать IP-адрес машины, на которой запущен RabbitMQ, заменив localhost на нужный IP.

```shell script
$ pip install pika
```

Зайдите в веб-интерфейс, найдите очередь под названием hello и сделайте скриншот. После чего запустите второй скрипт consumer.py и сделайте скриншот результата выполнения скрипта

В качестве решения домашнего задания приложите оба скриншота, сделанных на этапе выполнения.

Для закрепления материала можете попробовать модифицировать скрипты, чтобы поменять название очереди и отправляемое сообщение.


### ОТВЕТ на задание 2.

Скриншот очереди "Hello".  
![Скриншот очереди Hello](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/RabbitMQ_hw_11.4/2024-11-26_00-39-34.png)  

Скриншот результата выполнения скрипта consumer.py.  
![Скриншот результата выполнения скрипта consumer.py](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/RabbitMQ_hw_11.4/2024-11-26_00-43-26.png)  

## Задание 3. Подготовка HA кластера  

Используя Vagrant или VirtualBox, создайте вторую виртуальную машину и установите RabbitMQ.  
Добавьте в файл hosts название и IP-адрес каждой машины, чтобы машины могли видеть друг друга по имени.  

Пример содержимого hosts файла:
```shell script
$ cat /etc/hosts
192.168.0.10 rmq01
192.168.0.11 rmq02
```
После этого ваши машины могут пинговаться по имени.

Затем объедините две машины в кластер и создайте политику ha-all на все очереди.

*В качестве решения домашнего задания приложите скриншоты из веб-интерфейса с информацией о доступных нодах в кластере и включённой политикой.*

Также приложите вывод команды с двух нод:

```shell script
$ rabbitmqctl cluster_status
```

Для закрепления материала снова запустите скрипт producer.py и приложите скриншот выполнения команды на каждой из нод:

```shell script
$ rabbitmqadmin get queue='hello'
```

После чего попробуйте отключить одну из нод, желательно ту, к которой подключались из скрипта, затем поправьте параметры подключения в скрипте consumer.py на вторую ноду и запустите его.

*Приложите скриншот результата работы второго скрипта.*

### ОТВЕТ на задание 3.

Выполнял все в контейнерах Docker.

Скриншот с информацией о доступных нодах.  
![Скриншот с информацией о доступных нодах](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/RabbitMQ_hw_11.4/2024-11-30_21-33-12.png)

Скриншот применения политики ha-all.  
![Скриншот применения политики ha-all](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/RabbitMQ_hw_11.4/2024-11-30_22-54-16.png)

Файл с выводом команды rabbitmqctl cluster_status на ноде 1.  
[Файл с выводом команды rabbitmqctl cluster_status1](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/RabbitMQ_hw_11.4/stdout_rabbitctl_1.txt)

Файл с выводом команды rabbitmqctl cluster_status на ноде 2.  
[Файл с выводом команды rabbitmqctl cluster_status2](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/RabbitMQ_hw_11.4/stdout_rabbitctl_2.txt)

Скриншот с результатом работы скриптов produser.py и consumer.py
![Скриншот с результатом работы скриптов produser.py и consumer.py](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/RabbitMQ_hw_11.4/2024-11-30_21-51-00.png)

Скриншот вывода команды rabbitmqadmin get queue='hello'
![Скриншот вывода команды rabbitmqadmin get queue='hello'](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/RabbitMQ_hw_11.4/2024-11-30_21-51-47.png)

