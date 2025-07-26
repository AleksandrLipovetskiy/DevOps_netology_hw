# Домашнее задание к занятию «Использование Ansible" - Липовецкий Александр  
  
Ссылка на тег 08-ansible-03-yandex в моем репозитории.  
[teg - 08-ansible-03-yandex](https://github.com/AleksandrLipovetskiy/DevOps_netology_hw/releases/tag/08-ansible-03-yandex)  
  
# Документация по проекту - Install Clickhouse and Vector Ansible Playbook  
  
## Плейбук для установки Clickhouse, Vector, Lighthouse, Nginx на операционных системах типа Linux, использующих пакетный менеджер на базе .deb  
  
- ClickHouse — высокопроизводительная аналитическая СУБД.  
- Lighthouse — веб-интерфейс для ClickHouse.  
- Nginx — веб-сервер для отдачи Lighthouse.  
- Vector — инструмент для сбора и передачи логов.  
  
### Системные требования  
Плейбук разработан для удаленной установки Clickhouse и Vector, а также Lighthouse на базе сервера Vector на дистрибутивах Linux с пакетным менеджером .deb (Ubuntu, Mint), архитектура amd64.  
  
### Запуск командой -  
```bash
ansible-playbook -i inventory/prod.yml site.yml --diff --ask-become-pass --ask-vault-pass  
```  
### Компоненты разворачиваются на отдельных хостах согласно инвентарному файлу.  
  
#### Структура проекта  
.  
├── ansible.cfg  
├── group_vars/  
│ ├── clickhouse/  
│ │ └── vars.yml  
│ ├── lighthouse/  
│ │ └── vars.yml  
│ └── vector/  
│   ├── secret.yml  
│   └── vars.yml  
├── inventory/  
│ └── prod.yml  
├── site.yml  
└── templates/  
├── nginx.conf.j2  
├── lighthouse.conf.j2  
└── vector.toml.j2  
  
# Состав playbook:  
## Playbook   
- [playbook](./playbook/site.yml)  
## Переменные   
- [clickhouse](./playbook/group_vars/clickhouse/)  
- [vector](./playbook/group_vars/vector/)  
- [lighthouse](./playbook/group_vars/lighthouse/)  
## Хосты  
- [hosts](./playbook/inventory/prod.yml)  
## Фалы конфигурации   
- [vector](./playbook/templates/vector.toml.j2)  
- [lighthous](./playbook/templates/lighthouse.conf.j2)  
- [nginx](./playbook/templates/nginx.conf.j2)  
  
### Хосты разделены по группам:  
clickhouse: main, replica  
lighthouse: mon- c префиксом в зависимости от колличества виртуальных машин  
vector: web- c префиксом в зависимости от колличества виртуальных машин  
  
# Данный playbook состоит из 4 основных плеев: 1. установка и настройка сервера Nginx 2. установка на Nginx и настройка Lighthouse 3. установка и настройка Clickhouse и 4. установка и настройка Vector.  
  
## Плей 1: Install and Configure Nginx on Ubuntu  
  
### Описание   
Обновляет пакетный кеш, устанавливает и настраивает Nginx на хостах из группы `lighthouse`.  
  
### Привилегии   
Используется `become: true` для выполнения задач с повышенными привилегиями.  
  
### Handlers  
- **Start Nginx**  
  Перезапускает сервис Nginx при изменении конфигурации.  
  
- **Reload Nginx**  
  Перезагружает сервис Nginx при обновлении конфигурации.  
  
Обе задачи игнорируют ошибки, если playbook запущен в режиме проверки (`--check`).  
  
### Задачи  
  
1. **Update APT package cache**  
   Обновляет кеш пакетов apt (без изменения состояния).  
  
2. **Install Nginx**  
   Устанавливает пакет `nginx`, если он не установлен.  
  
3. **Copy Nginx configuration file**  
   Копирует кастомный конфигурационный шаблон `nginx.conf.j2` в `/etc/nginx/nginx.conf`.   
   После копирования уведомляет handler `Start Nginx` для перезапуска сервиса.  
   
## Плей 2: Install and Configure Lighthouse on Ubuntu   
  
### Описание  
Устанавливает и настраивает Lighthouse сервис на хостах из группы `lighthouse`, включая настройку сайта в Nginx.  
  
### Привилегии  
Используется `become: true` для выполнения задач с повышенными привилегиями.  
  
### Handlers  
- **Restart Nginx**  
  Перезапускает сервис Nginx при изменении конфигурации Lighthouse.  
  Игнорирует ошибки в режиме `--check`.  
  
### Предварительные задачи (pre_tasks)  
1. **Install Dependencies for Lighthouse**  
   Устанавливает пакет `git`, если он не установлен, с обновлением кеша `apt`.  
   Не считается изменением.  
   
### Основные задачи  
  
1. **Create Lighthouse Directory**  
   Создаёт директорию `/var/www/lighthouse` с правами `0755` и владельцем `www-data`.  
  
2. **Add /var/www/lighthouse to Git Safe Directory**  
   Добавляет директорию в глобальные безопасные директории git для предотвращения предупреждений безопасности.  
   Выполняется от имени root, изменяет глобальный `.gitconfig`.  
  
3. **Reset Local Changes in Lighthouse Repository**  
   Откатывает локальные изменения в каталоге Lighthouse (игнорирует ошибки).  
  
4. **Clone Lighthouse Repository from Git**  
   Клонирует или обновляет репозиторий Lighthouse из переменной `lighthouse_vcs` в папку `/var/www/lighthouse` (по умолчанию).  
  
5. **Copy Lighthouse Nginx Configuration**  
   Копирует шаблон конфигурации `lighthouse.conf.j2` в каталог `sites-available` Nginx.  
   При изменении запускает handler `nginx config changed`.  
  
6. **Enable Lighthouse Site in Nginx**   
   Создаёт символическую ссылку для активации сайта Lighthouse в `sites-enabled`.  
   При изменении уведомляет handler для перезапуска Nginx.  
   Игнорирует ошибки при запуске в режиме `--check`.  
  
## Плей 4: Install and Configure Vector  
  
### Описание  
Устанавливает и настраивает Vector — агент для сбора и передачи логов — на хостах из группы `vector`.  
  
### Привилегии   
Используется `become: true` для выполнения задач с повышенными привилегиями.  
  
### Handlers  
- **Restart vector service**  
  Перезапускает сервис Vector при изменении конфигурации.  
  Игнорирует ошибки в режиме `--check`.  
  
### Задачи  
  
1. **Download Vector DEB package**  
   Загружает DEB-пакет Vector с приватного URL с указанием учётных данных.  
   В плейбуке имеется альтернативная, закомментированная версия загрузки с публичного канала.  
  
2. **Install Vector DEB package**  
   Устанавливает загруженный DEB-пакет.  
   Регистрирует результат установки.  
  
3. **Run apt-get install -f if broken dependencies detected**  
   Выполняет обновление системы и исправление зависимостей, если установка прошла с ошибками (условно).  
  
4. **Ensure Vector config directory exists**   
   Создаёт директорию конфигурации для Vector с правами `0755`.  
  
5. **Deploy Vector configuration from template**   
   Разворачивает конфигурационный файл `vector.toml` из шаблона и уведомляет handler для перезапуска сервиса.  
  
6. **Ensure Vector service is running and enabled**   
   Гарантирует, что сервис Vector запущен и настроен на автозапуск при старте системы.  
  
  
## Примечания  
- Конфигурационные файлы для Vector, Nginx, Lighthouse развертываются из шаблонов с использованием Jinja2.  
  