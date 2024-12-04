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
SELECT COUNT(*)
FROM film
WHERE length > (SELECT AVG(length) FROM film)
; 
```
