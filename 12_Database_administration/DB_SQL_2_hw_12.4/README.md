# Домашнее задание к занятию «SQL. Часть 2» - Липовецкий Александр  
  
## Задание 1  

Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию:  

* фамилия и имя сотрудника из этого магазина;  
* город нахождения магазина;  
* количество пользователей, закреплённых в этом магазине.  

### Ответ на задание 1  

```SQL
SELECT
CONCAT(s.last_name, ' ', s.first_name) AS staff_name,
c.city,
COUNT(cu.customer_id) AS customer_count
FROM store st
LEFT JOIN staff s ON st.store_id = s.store_id
LEFT JOIN address a ON st.address_id = a.address_id
LEFT JOIN city c ON a.city_id = c.city_id
LEFT JOIN customer cu ON st.store_id = cu.store_id
GROUP BY st.store_id, s.first_name, s.last_name, c.city
HAVING COUNT(cu.customer_id) > 300
;  
```

## Задание 2  

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.  

### Ответ на задание 2  

```SQL
SELECT COUNT(*)
FROM film
WHERE length > (SELECT AVG(length) FROM film)
; 
```

## Задание 3  

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.  

### Ответ на задание 3  

```SQL
SELECT DATE_FORMAT(p.payment_date, '%M') AS month  
,SUM(p.amount) AS sum_payments  
,COUNT(r.rental_id) AS count_rental  
FROM payment p  
LEFT JOIN rental r ON p.rental_id = r.rental_id  
GROUP BY month  
ORDER BY sum_payments DESC  
LIMIT 1  
;  
```