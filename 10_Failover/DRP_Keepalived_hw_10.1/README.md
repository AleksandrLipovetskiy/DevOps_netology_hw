# Домашнее задание к занятию "Disaster recovery и Keepalived" - Липовецкий Александр

**Задание 1**

Выпонил настройку как указано в задании.
![Настройка Router1](https://github.com/AleksandrLipovetskiy/DevOps_netology_hw/blob/main/10_Failover/DRP_Keepalived_hw_10.1/Router1.png)

![Настройка Router2](https://github.com/AleksandrLipovetskiy/DevOps_netology_hw/blob/main/10_Failover/DRP_Keepalived_hw_10.1/Router2.png)

Поправил описание на схеме.

![Схема после правки](10_Failover\DRP_Keepalived_hw_10.1\setUp1group.png)

[Файл схемы в формате pkt](10_Failover\DRP_Keepalived_hw_10.1\hsrp_advanced_hw.pkt)

**Задание 2**

Выполнил насройки серверов nginx и сервиса keepalived.

[Файл настроек keepalived](10_Failover\DRP_Keepalived_hw_10.1\keepalived.conf)

Подготовил скрипт bash

[Файл script.sh](10_Failover\DRP_Keepalived_hw_10.1\script.sh)

Протестировал работу.
Изменил расширение файла index.html на index.htmllll в root директории сервера на "мастере". Зафиксировал изменние статуса "мастера", а также отображение ip-адреса на странице сервера.
Вернул расширение файла index.html на "мастере" обратно, зафиксировал возвращение "мастера" в бой и отображение ip-адреса на странице сервера.

![Изменение расширения файла index.html](10_Failover\DRP_Keepalived_hw_10.1\ChangHtml_1.png)

![Результат в браузере после изменения](10_Failover\DRP_Keepalived_hw_10.1\ChangHtml_1_br.png)

![Изменение расширения файла index.html на правильное](10_Failover\DRP_Keepalived_hw_10.1\ChangHtml_2_back.png)

![Результат в брацзере после возврата названия файла к правильному](10_Failover\DRP_Keepalived_hw_10.1\ChangHtml_2_back_br.png)

