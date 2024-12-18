# Домашнее задание Александра Липовецкого по занятию "Система мониторинга Zabbix"

# Часть 2

![Задание 1](./1.png)

![Задание 2-3_1](./2-3_1.png)

![Задание 2-3_2](./2-3_2.png)

![Задание 2-3_3](./2-3_3.png)

![Задание 4](./4.png)


# Часть 1

## vm-zabbix

ROOT

    wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb
    dpkg -i zabbix-release_7.0-2+ubuntu24.04_all.deb
    apt update
    apt install zabbix-server-pgsql zabbix-frontend-php php8.3-pgsql zabbix-apache-conf zabbix-sql-scripts
    exit
    systemctl restart zabbix-server apache2
    systemctl enable zabbix-server apache2
    systemctl status  zabbix-server

VM-SAM

    sudo apt update
    sudo apt upgrade
    sudo apt install postgresql
    sudo -s
    sudo -u postgres createuser --pwprompt zabbix
    sudo -u postgres createdb -O zabbix zabbix
    zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
    sudo nano /etc/zabbix/zabbix_server.conf
    sudo -s
    
ROOT

    apt install zabbix-agent
    systemctl restart zabbix-agent
    systemctl enable zabbix-agent
    systemctl status zabbix-agent
    
## vm-ansible

VM-SAM

    sudo apt upgrade
    sudo -s
    cd /etc/zabbix/zabbix_agentd.d/
    ll
    cd ..
    ll
    sudo nano zabbix_agentd.c
    sudo nano zabbix_agentd.conf
    sudo -s
    
ROOT 

    wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb  
    dpkg -i zabbix-release_7.0-2+ubuntu24.04_all.deb  
    apt update  
    apt install zabbix-agent  
    systemctl restart zabbix-agent  
    systemctl enable zabbix-agent  
    systemctl status zabbix-agent  
    exit  
    systemctl restart zabbix-agent  
    systemctl status zabbix-agent  
    tail -f /var/log/zabbix/zabbix_agentd.log  


Далее идут скриншоты. 

![Авторизация в админке](./avtor_admin.png)

![Configuration > Hosts](./Configuration_Hosts.png)

![Лог zabbix agent](./Log_zabbix_agent.png)

![Monitoring > Latest data](./Monitoring_Latest_data.png)






  
