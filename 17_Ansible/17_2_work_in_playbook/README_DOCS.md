# Install Clickhouse and Vector Ansible Playbook  
## Плейбук для установки Clickhouse, Vector на операционных системах типа Linux, использующих пакетный менеджер на базе .deb  
  
### Системные требования  
Плейбук разработан для локальной установки Clickhouse и Vector на дистрибутивах Linux с пакетным менеджером .deb (Ubuntu, Mint), архитектура amd64.   
  
### Запуск командой - 
```bash
ansible-playbook -i inventory/prod.yml site.yml --diff --ask-become-pass --ask-vault-pass  
```  
    
# Состав playbook:  
## Playbook   
- [playbook](./playbook/site.yml)  
## Переменные   
- [clickhouse](./playbook/group_vars/clickhouse/)  
- [vector](./playbook/group_vars/vector/)  
## Хосты  
- [hosts](./playbook/inventory/prod.yml)  
## Фалы конфигурации   
- [j2](./playbook/templates/vector.toml.j2)  
  
Данный playbook состоит из двух основных плеев: 1. установка Clickhouse и 2. установка и настройка Vector.  
  
## Плей 1: Install Clickhouse  
  
### Описание  
Устанавливает и настраивает Clickhouse на хостах из группы `clickhouse`.  
  
### Привилегии  
Используется `become: true` для выполнения задач с повышенными привилегиями.  
При необходимости ввода пароля использовать --ask-become-pass при запуске.  
  
### Handlers  
- **Start clickhouse service**  
  Перезапускает сервис `clickhouse-server` при необходимости.  
  
### Задачи  
  
1. **Add Clickhouse GPG key**  
   Добавляет публичный GPG ключ репозитория Clickhouse для проверки пакетов.  
  
2. **Add Clickhouse APT repository**   
   Добавляет официальный репозиторий Clickhouse в систему.  
  
3. **Update APT cache**  
   Обновляет кэш пакетов apt для актуализации списка доступных пакетов.  
  
4. **Install Clickhouse packages via apt**  
   Устанавливает пакеты Clickhouse, перечисленные в переменной `clickhouse_packages`.  
   Переменные заданы в файле ./group_vars/clickhouse/vars.yml  
   После успешной установки вызывает handler для перезапуска сервиса.  
  
5. **Ensure clickhouse service is started and enabled**  
   Гарантирует, что сервис `clickhouse-server` запущен и настроен на автозапуск при загрузке системы.  
  
6. **Create database logs**  
   Выполняет команду создания базы данных `logs` в Clickhouse.  
   Задача считается успешной, если команда возвращает код 0 (создание прошло) или 82 (база уже существует) — эти коды не считаются ошибкой.  
  
  
## Плей 2: Install and configure Vector  
  
### Описание  
Устанавливает Vector (агент для сбора и обработки логов) на хостах из группы `vector` и настраивает его.  
  
### Привилегии  
Используется `become: true` для выполнения от имени администратора.  
  
### Handlers  
- **Restart vector service**   
  Перезапускает сервис `vector` при изменении конфигурации.  
  
### Задачи  
  
1. **Download Vector DEB package**   
   Скачивает DEB-пакет Vector с защищённого URL, используя имя пользователя `U_M1GME` и пароль из переменной `vector_url_password`.  
   Переменная `vector_url_password` зашифрована в файле ./group_vars/vector/secret.yml, при запуске необходимо использовать --ask-vault-pass  
   Пакет сохраняется в `/tmp/vector-{{ vector_version }}.deb`.  
   В данном случае использован защищенный URL, так как отсуствовал доступ к официальному хранилищу. При использовании официального хранилища, необходимо в данной задаче поправить путь.  
   
2. **Install Vector DEB package**  
   Устанавливает скачанный DEB-пакет Vector через `apt`.  
   Результат установки сохраняется в переменной `vector_install`.  
  
3. **Run apt-get install -f if broken dependencies detected**  
   При ошибке установки (`vector_install is failed`) выполняет полное обновление системы и удаляет неиспользуемые пакеты для исправления возможных сломанных зависимостей.  
  
4. **Ensure Vector config directory exists**  
   Создаёт каталог конфигурации Vector (путь из переменной `vector_config_dir`) с правами доступа `0755`.  
  
5. **Deploy Vector configuration from template**  
   Разворачивает файл конфигурации Vector на основе шаблона `templates/vector.toml.j2` в каталог конфигурации.  
   После изменения файла вызывает handler для перезапуска сервиса.  
  
6. **Ensure Vector service is running and enabled**  
   Обеспечивает, что сервис Vector запущен и включён в автозапуск.  
  
## Примечания  
- Конфигурационные файлы для Vector развертываются из шаблонов с использованием Jinja2.  
  