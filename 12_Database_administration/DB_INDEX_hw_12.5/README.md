# Домашнее задание к занятию «Индексы» - Липовецкий Александр  
  
## Задание 1  

Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.  

### Ответ на задание 1  

```SQL
SELECT ROUND(SUM(index_length)/SUM(data_length)*100, 2) AS "index/table"  
FROM information_schema.tables  
WHERE table_schema = 'sakila'  
;  
```

## Задание 2  

Выполните explain analyze следующего запроса:  

```SQL
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
;
```
* перечислите узкие места;  
* оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.  


### Ответ на задание 2  

```SQL
EXPLAIN ANALYZE
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```
  
```SQL
-> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=20290..20290 rows=391 loops=1)
    -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=20290..20290 rows=391 loops=1)
        -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=8632..19644 rows=642000 loops=1)
            -> Sort: c.customer_id, f.title  (actual time=8632..8922 rows=642000 loops=1)
                -> Stream results  (cost=23.2e+6 rows=16.7e+6) (actual time=18.4..6240 rows=642000 loops=1)
                    -> Nested loop inner join  (cost=23.2e+6 rows=16.7e+6) (actual time=18.4..5055 rows=642000 loops=1)
                        -> Nested loop inner join  (cost=21.5e+6 rows=16.7e+6) (actual time=15.7..4291 rows=642000 loops=1)
                            -> Nested loop inner join  (cost=19.8e+6 rows=16.7e+6) (actual time=13.7..3427 rows=642000 loops=1)
                                -> Inner hash join (no condition)  (cost=1.65e+6 rows=16.5e+6) (actual time=10.2..213 rows=634000 loops=1)
                                    -> Filter: (cast(p.payment_date as date) = '2005-07-30')  (cost=1.94 rows=16500) (actual time=4.16..78.1 rows=634 loops=1)
                                        -> Table scan on p  (cost=1.94 rows=16500) (actual time=4.14..72 rows=16044 loops=1)
                                    -> Hash
                                        -> Covering index scan on f using idx_title  (cost=112 rows=1000) (actual time=5.03..5.92 rows=1000 loops=1)
                                -> Covering index lookup on r using rental_date (rental_date=p.payment_date)  (cost=1 rows=1.01) (actual time=0.00329..0.00453 rows=1.01 loops=634000)
                            -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.001 rows=1) (actual time=722e-6..778e-6 rows=1 loops=642000)
                        -> Single-row covering index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.001 rows=1) (actual time=585e-6..654e-6 rows=1 loops=642000)  
```
  
### Общая структура  

#### 1. Table scan on <temporary>:  
* Временная таблица используется для хранения промежуточных результатов. В данном случае, она содержит 391 строки, что указывает на то, что запрос создает временную таблицу для хранения уникальных значений.  
#### 2. Temporary table with deduplication:  
* Эта операция выполняет удаление дубликатов в временной таблице. Она завершилась без дополнительных затрат (cost=0..0), но фактическое время выполнения составило 20290 мс.  
#### 3. Window aggregate with buffering:  
* Операция агрегации с использованием оконной функции SUM. Здесь видно, что эта операция занимает значительное время (8632..19644 мс) и обрабатывает 642000 строк.  
#### 4. Sort:  
* Сортировка по c.customer_id и f.title. Это также занимает время (8632..8922 мс) и может быть узким местом, если данные не отсортированы заранее.  
#### 5. Stream results:  
* Стриминг результатов указывает на то, что данные передаются поэтапно, что может быть полезно для экономии памяти.  
#### 6. Nested loop inner join:  
* Использование вложенных циклов для соединения таблиц — это нормально, но производительность может пострадать при большом количестве записей.  

### Подробный анализ операций  

#### 1. Inner hash join (no condition):  
* Эффективное соединение, но требуется фильтрация по дате платежа. Здесь видно, что фильтрация по payment_date возвращает 16044 строки, что может быть значительным объемом данных для обработки.  
#### 2. Filter: (cast(p.payment_date as date) = '2005-07-30'):  
* Фильтрация по дате выполняется на 634 строках, что указывает на то, что в таблице payment много записей, которые не соответствуют условию.  
#### 3. Table scan on p:  
* Полное сканирование таблицы payment, которое возвращает 16044 строки. Это может быть медленным процессом, особенно если таблица большая.  
#### 4. Covering index scan on f using idx_title:  
* Использование индекса на таблице film. Это эффективная операция, которая позволяет быстро получить нужные данные.  
#### 5. Single-row index lookup on c using PRIMARY:  
* Индексированный поиск по первичному ключу customer_id, который является быстрым и эффективным.  
#### 6. Single-row covering index lookup on i using PRIMARY:  
* Аналогично предыдущему пункту, это также быстрое выполнение.  

### Рекомендации по оптимизации  

#### 1. Индексы:  
* Необходимо добавить индекс на столбце payment_date в таблице payment. Это значительно ускорит фильтрацию по дате.  
  
```SQL
CREATE INDEX idx_payment_date ON payment(payment_date);   
```

#### 2. Изменение структуры запроса:  
* Использовать более простых агрегатных функций без оконных функций.  
* Заменить неявные JOIN-ы на явные, чтобы улучшить читаемость и производительность.  
  
```SQL
SELECT CONCAT(c.last_name, ' ', c.first_name) AS full_name,  
SUM(p.amount) AS total_amount  
FROM payment p  
LEFT JOIN rental r ON p.payment_date = r.rental_date  
LEFT JOIN customer c ON r.customer_id = c.customer_id  
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id  
LEFT JOIN film f ON i.film_id = f.film_id  
WHERE DATE(p.payment_date) = '2005-07-30'  
GROUP BY full_name;  
```