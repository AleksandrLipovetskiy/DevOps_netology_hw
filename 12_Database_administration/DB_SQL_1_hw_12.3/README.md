# Домашнее задание к занятию «Работа с данными (DDL/DML)» - Липовецкий Александр  
  
## Задание 1  

Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.  

### Ответ на задание 1  

```SQL
SELECT DISTINCT district FROM address  
WHERE district like 'K%a' and district not like '% %'  
;  
```

## Задание 2  
Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года включительно и стоимость которых превышает 10.00.  

### Ответ на задание 2  

```SQL
SELECT * FROM payment  
WHERE and amount > 10  
and DATE_FORMAT(payment_date, '%Y%m%d') BETWEEN 20050615 and 20050618  
order by 6  
;  
```

## Задание 3  
Получите последние пять аренд фильмов.  

### Ответ на задание 3  

```SQL
SELECT * FROM rental  
order by rental_date desc  
LIMIT 5  
;  
```

## Задание 4  
Одним запросом получите активных покупателей, имена которых Kelly или Willie.  

Сформируйте вывод в результат таким образом:  

все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр, замените буквы 'll' в именах на 'pp'.

### Ответ на задание 4  

```SQL
SELECT  
REPLACE(LOWER(first_name), 'll', 'pp') AS first_name,  
LOWER(last_name) AS last_name  
FROM customer  
WHERE active = 1  
AND (first_name = 'Kelly' OR first_name = 'Willie')  
;  
```