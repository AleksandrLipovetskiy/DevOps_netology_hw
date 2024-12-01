# Домашнее задание к занятию "Disaster recovery и Keepalived" - Липовецкий Александр

**Задание 1**

Выпонил настройку как указано в задании.
![Настройка Router1](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/Router1.png)

![Настройка Router2](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/Router2.png)

Поправил описание на схеме.

![Схема после правки](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/setUp1group.png)

[Файл схемы в формате pkt](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/hsrp_advanced_hw.pkt)

**Задание 2**

Выполнил насройки серверов nginx и сервиса keepalived.

[Файл настроек keepalived](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/keepalived.conf)

Подготовил скрипт bash

[Файл script.sh](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/script.sh)

Протестировал работу.
Изменил расширение файла index.html на index.htmllll в root директории сервера на "мастере". Зафиксировал изменние статуса "мастера", а также отображение ip-адреса на странице сервера.
Вернул расширение файла index.html на "мастере" обратно, зафиксировал возвращение "мастера" в бой и отображение ip-адреса на странице сервера.

![Изменение расширения файла index.html](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/ChangHtml_1.png)

![Результат в браузере после изменения](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/ChangHtml_1_br.png)

![Изменение расширения файла index.html на правильное](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/ChangHtml_2_back.png)

![Результат в брацзере после возврата названия файла к правильному](https://github.com/AleksandrLipovetskiy/DP-Keepalived/blob/main/ChangHtml_2_back_br.png)

