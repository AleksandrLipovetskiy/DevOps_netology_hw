# Домашнее задание к занятию «Кеширование Redis/memcached» - Липовецкий Александр

## Задание 1. Кеширование
Приведите примеры проблем, которые может решить кеширование.

### ОТВЕТ на задание 1.

Кэширование — это способ оптимизации работы приложения, при котором данные временно кладутся в промежуточный буфер с быстрым доступом. Выбор буфера для кэша зависит от решаемой задачи и может быть как памятью сервера, так и файлом, базой данных или любой другой сущностью, куда можно положить данные. Обычно данные в кэше — это данные, к которым наиболее часто осуществляется запрос.

● Повышение производительности, которое достигается за счет складывания в кэш данных, к которым чаще всего происходит обращение;  
● Увеличение скорости ответа;  
● Экономия ресурсов базы данных, например, применяя кэширование тяжелых запросов;  
● Сглаживание бустов трафика. Например, во время черной пятницы онлайн-магазины используют кэш, чтобы переживать резкое увеличение трафика.  

1. Снижение времени отклика:

   • Проблема: ПользовательскийПользовательский интерфейс приложения медленно реагирует на запросы из-за долгого времени обработки запросов к базе данных.

   • Решение: Кеширование часто запрашиваемых данных (например, результаты поисковых запросов) позволяет значительно сократить время отклика.

2. Снижение нагрузки на базу данных:

   • Проблема: Высокая нагрузка на базу данных из-за большого числа однотипных запросов.

   • Решение: Кеширование результатов запросов позволяет уменьшить количество обращений к базе данных, снижая ее нагрузку и увеличивая производительность.

3. Улучшение производительности при чтении:

   • Проблема: Приложение требует частого доступа к статическим данным (например, конфигурации, справочные данные).

   • Решение: Кеширование этих данных в памяти позволяет быстро их извлекать без необходимости повторных обращений к медленным дисковым хранилищам.

4. Оптимизация работы с API:

   • Проблема: Частые вызовы внешних API могут приводить к превышению лимитов на количество запросов и увеличению времени ответа.

   • Решение: Кеширование ответов от API позволяет повторно использовать данные, минимизируя количество вызовов к внешнему сервису.

5. Снижение затрат на сетевые ресурсы:

   • Проблема: Частые запросы к удаленным серверам создают значительную нагрузку на сеть и увеличивают задержки.

   • Решение: Кеширование данных локально позволяет уменьшить количество сетевых запросов и снизить задержки.

6. Увеличение масштабируемости приложения:

   • Проблема: При росте числа пользователей приложение начинает испытывать трудности с обработкой запросов.

   • Решение: Использование кеша для хранения часто запрашиваемых данных помогает распределить нагрузку и улучшить масштабируемость системы.

7. Улучшение пользовательского опыта:

   • Проблема: Долгое время загрузки страниц или данных приводит к плохому опыту пользователей.

   • Решение: Кеширование статических ресурсов (например, изображения, CSS и JavaScript) позволяет значительно сократить время загрузки страниц.

8. Обработка больших объемов данных:

   • Проблема: Обработка больших объемов данных в реальном времени может быть медленной.

   • Решение: Кеширование промежуточных результатов обработки позволяет ускорить выполнение сложных вычислений.

## Задание 2. Memcached
Установите и запустите memcached.

Приведите скриншот systemctl status memcached, где будет видно, что memcached запущен.

### ОТВЕТ на задание 2.

Скриншот статуса сервиса mamcached.  
![Скриншот статуса mamcached](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/11-02/stat_memcached.png)

## Задание 3. Удаление по TTL в Memcached
Запишите в memcached несколько ключей с любыми именами и значениями, для которых выставлен TTL 5.

Приведите скриншот, на котором видно, что спустя 5 секунд ключи удалились из базы.

### ОТВЕТ на задание 3.

Скриншот добавления ключей в memcached с ttl = 5 сек.  
![Скриншот добавления ключей с ttl](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/11-02/add_key_memcached.png)

## Задание 4. Запись данных в Redis
Запишите в Redis несколько ключей с любыми именами и значениями.

Через redis-cli достаньте все записанные ключи и значения из базы, приведите скриншот этой операции.

### ОТВЕТ на задание 4.

Скриншот добавления ключей в redis.  
![Скриншот добавления ключей в redis](https://github.com/AleksandrLipovetskiy/sdb-hw-11/blob/main/11-02/add_key_redis.png)