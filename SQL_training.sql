В этом документе представлены SQL-запросы к тренировочным базам данных.

В запросах используются: 
- фильтрация по условию, агрегация при помощи group by, 
- join-запросы, а также запросы при помощи union, except, intersect, 
- подзапросы (exists, in, select from select, cte), 
- оконные функции.
 
Для выполнения заданий № 1 - 31 (несложные группировки) используются таблицы схемы "Books".  

Для выполнения заданий № 31 - 50 (сложные группировки, подзапросы) используются таблицы схемы "Shipping".
Структура таблицы shipping представлена в этом репозитории (Изображение - entity_relation_shipping.jpg). 




ДЛЯ ВЫПОЛНЕНИЯ СЛЕДУЮЩИХ ЗАДАНИЙ ИСПОЛЬЗУЮТСЯ ТАБЛИЦЫ СХЕМЫ "Books"  

ЗАДАНИЕ 1.
Выведите все книги Charlaine Harris с рейтингом выше 3 или количеством оценок больше 1000.

SELECT * 
FROM books 
WHERE author = 'Charlaine Harris' 
      and (book_average_rating > 3 or book_ratings_count > 1000);



ЗАДАНИЕ 2.
Для каких книг не указан язык в базе данных?

SELECT * 
FROM books 
WHERE language_code is NULL;



ЗАДАНИЕ 3. 
Выведите столбцы book_name и publishing_year для всех книг, у которых рейтинг больше 4.5.

SELECT 
	book_name, 
	publishing_year
FROM 
	books
WHERE book_average_rating > 4.5;



ЗАДАНИЕ 4. 
Выведите столбцы book_name, publishing_year и author для всех книг, 
у которых рейтинг больше 4.5 и количество оценок меньше 100000.

SELECT 
	book_name, 
	publishing_year, 
	author
FROM 
	books
WHERE book_average_rating > 4.5 and book_ratings_count < 100000;



ЗАДАНИЕ 5.
Выведите все столбцы для книг, у которых значения года публикации не лежат 
в промежутке от 1950 до 1965 г. или у которых пустой год публикации.

SELECT *
FROM books
WHERE publishing_year not between 1950 and 1965 or publishing_year is null;



ЗАДАНИЕ 6. 
Выведите все столбцы для книг, у которых 
(language_code = 'eng' или language_code = 'en-US' и больше 10000 оценок), 
либо у которых (жанр 'fiction' или год публикации 1957). Скобки указывают порядок действий.

SELECT *
FROM books
WHERE ((language_code = 'eng' or language_code = 'en-US') and book_ratings_count > 10000) 
	or (genre = 'fiction' or publishing_year = 1957);
	   
	   
	   
ЗАДАНИЕ 7.
Выведите столбцы author и book_id для всех строк, у которых: 
либо ((author_rating -Intermediate или Novice) и рейтинг книги >= 4), 
либо (рейтинг книги > 4.5 и год публикации меньше 1955), 
либо количество оценок книги больше 3000000.

SELECT 
	author, 
	book_id
FROM 
	books
WHERE ((author_rating = 'Intermediate' or author_rating = 'Novice') and book_average_rating >= 4) 
       or (book_average_rating > 4.5 and publishing_year < 1955) or (book_ratings_count > 3000000);
	   
	   
	   
ЗАДАНИЕ 8.
Выведите список авторов и ID их книг, отсортированный по второй колонке в запросе.

SELECT 
	author, 
	book_id
FROM 
	books
ORDER BY 2;



ЗАДАНИЕ 9.
Выведите все столбцы таблицы books, где publishing_year = 1960, 
и отсортируйте их в порядке убывания по названию книги.

SELECT *
FROM books
WHERE publishing_year = 1960
ORDER BY book_name DESC; 



ЗАДАНИЕ 10.
Выведите столбцы author, book_name для всех строк, где средний рейтинг книги больше 4 и language_code = 'eng', 
отсортированные по рейтингу книги и по количеству оценок книги.

SELECT 
	author, 
	book_name 
FROM 
	books
WHERE 
	book_average_rating > 4 and language_code = 'eng'
ORDER BY  
	book_average_rating, book_ratings_count;



ЗАДАНИЕ 11.
Выведите название и рейтинг топ-3 книг из набора данных (топ по рейтингу).

SELECT 
	book_name, 
	book_average_rating 
FROM 
	books 
ORDER BY 
	book_average_rating DESC 
LIMIT 3;



ЗАДАНИЕ 12.
Выведите название и рейтинг книг с 4-го по 8-е место. 

SELECT 
	book_name, 
	book_average_rating 
FROM 
	books 
ORDER BY 
	book_average_rating DESC 
OFFSET 3 LIMIT 5;



ЗАДАНИЕ 13.
Найдите в базе данных название и год издания топ-20 самых старых по году издания книг. 
Какой запрос вы использовали? Если года совпадают, сортировка идёт по имени книги.

SELECT 
	book_name, 
	publishing_year 
FROM 
	books 
ORDER BY 
	publishing_year, book_name
LIMIT 20;



ЗАДАНИЕ 14.
Среди книг с author_rating = 'Intermediate' найдите названия тех, которые занимают в рейтинге книг 
с 20 по 47 место и отсортируйте книги по убыванию рейтинга. Укажите запрос ниже.

SELECT book_name
FROM books
WHERE author_rating = 'Intermediate'
ORDER BY book_average_rating DESC 
OFFSET 19 LIMIT 28;



ЗАДАНИЕ 15.
Выведите список авторов и их книг, вышедших в интервале с 1950 по 2000 гг. 
При этом список не должен включать топ 10 книг по количеству оценок.

SELECT 
	author, 
	book_name
FROM 
	books
WHERE  
	publishing_year between 1950 and 2000
ORDER BY  
	book_ratings_count DESC
OFFSET 10;



ЗАДАНИЕ 16.
Определите средний рейтинг (as average_rating) и минимальное количество оценок книги 
(min_ratings) для книг Стивена Кинга (Stephen King), изданных позднее 1990 года. 

SELECT 
	avg(book_average_rating) as average_rating, 
	min(book_ratings_count) as min_ratings
FROM 
	books
WHERE   author = 'Stephen King' and publishing_year > 1990;



ЗАДАНИЕ 17.
Подсчитайте количество непустых строк в столбце book_name (не изменяйте название столбца) 
среди всех книг с рейтингом < 4 и количеством оценок > 100000.

SELECT 
	count(book_name) as book_name
FROM 
	books
WHERE   book_average_rating < 4 and book_ratings_count > 100000;



ЗАДАНИЕ 18.
Выведите минимальное значение столбца book_name для книг, у которых: 
(language_code = 'eng' или language_code = 'en-US' и больше 10000 оценок), 
либо у которых (жанр 'fiction' или год публикации 1957). Скобки указывают порядок действий.

SELECT 
	min(book_name)
FROM 
	books
WHERE ((language_code = 'eng' or language_code = 'en-US') and book_ratings_count > 10000) 
	or (genre = 'fiction' or publishing_year = 1957);



ЗАДАНИЕ 19.
Посчитайте количество авторов в базе данных.

SELECT 
	count(distinct author) authors_count
FROM 
	books;



ЗАДАНИЕ 20.
Сколько уникальных наименований книг содержится в базе?

SELECT 
		count(distinct book_name)
FROM 
		books;



ЗАДАНИЕ 21.
Выведите средние оценки и количество книг, вышедших с 2005 до 2010 года, 
в разбивке по жанру и году публикации книги, и отсортируйте по убыванию по средней оценки книги в группе.

SELECT 
	genre, 
	publishing_year, 
	avg(book_average_rating) books_rating, 
	count(book_id) books_count
FROM 
	books
WHERE publishing_year between 2005 and 2010
GROUP BY genre, publishing_year
ORDER BY books_rating DESC;



ЗАДАНИЕ 22.
Напишите запрос, который выводит топ-5 авторов по количеству написанных книг 
в период с 1985 (включительно) до 2015 года (включительно).

SELECT 
	author, 
	count(book_name) as books_count
FROM 
	books
WHERE publishing_year between 1985 and 2015
GROUP BY author
ORDER BY books_count DESC, author
LIMIT 5;



ЗАДАНИЕ 23.
Напишите запрос, который выводит топ 10 авторов, пишущих на английском языке, 
в максимальном количестве разных жанров. Вывод должен содержать столбцы: 
author, genres_count и быть отсортирован по genres_count по убыванию и по author по возрастанию.

SELECT 
	author, 
	count(distinct genre) as genres_count
FROM 
	books
WHERE language_code = 'eng'
GROUP BY author
ORDER BY genres_count DESC, author
LIMIT 10;



ЗАДАНИЕ 24.
Напишите запрос, который выводит все уникальные жанры книг в базе данных на экран. 
(Итоговый столбец называется genre и не отсортирован, используйте DISTINCT, а не группировку.)

SELECT distinct genre
FROM books;



ЗАДАНИЕ 25.
Выведите список самых плодовитых авторов, которые написали больше 10 книг.

SELECT author 
FROM books 
GROUP BY author 
HAVING count(book_id) > 10;



ЗАДАНИЕ 26.
Напишите запрос, который выводит издательства, опубликовавшие больше 100 книг. 
Необходимые столбцы: publisher, сортировка в алфавитном порядке.

SELECT publisher 
FROM books
GROUP BY publisher
HAVING count(book_id) > 100
ORDER BY publisher; 



ЗАДАНИЕ 27.
Напишите запрос, который выводит список авторов, публиковавших книги с 1940 до 1980 годов 
в жанре fiction, средний рейтинг книг которых больше, чем 3.9.
Необходимые столбцы для выдачи: author, average_rating. Сортировка по author по возрастанию.

SELECT 
	author, 
	avg(book_average_rating) as average_rating
FROM 
	books
WHERE publishing_year between 1940 and 1980 and genre = 'fiction'
GROUP BY author
HAVING avg(book_average_rating) > 3.9
ORDER BY author;



ЗАДАНИЕ 28.
Напишите запрос, который выводит года публикации книг, 
жанр книг и их количество для каждой комбинации года публикации и жанра из таблицы, 
если средний рейтинг книг в этой группе меньше 4.2, а количество опубликованных книг больше 5. 
Необходимые столбцы: publishing_year, genre, books_count с сортировкой по всем столбцам 
(в таком же порядке, как они перечислены в запросе) в порядке возрастания.

SELECT 
		publishing_year, 
		genre, 
		count(book_id) as books_count
FROM 
		books
GROUP BY publishing_year, genre
HAVING avg(book_average_rating) < 4.2 and count(book_id) > 5
ORDER BY publishing_year, genre, books_count;



ЗАДАНИЕ 29.
Определите среднее количество оценок, поставленных книгам авторов 
Stephen King или Amy Tan для книг, опубликованных с 1950 года до 1995 года.

SELECT avg(book_ratings_count)
FROM books
WHERE publishing_year between 1950 and 1995 
      and (author = 'Stephen King' or author = 'Amy Tan');
 


ЗАДАНИЕ 30.
Напишите запрос, который получает средний рейтинг книг автора по различным жанрам. 
Выведите топ таких авторов с 3-го до 8-го места включительно. 
Должны получиться столбцы author, genre, average_rating, 
отсортированные по убыванию по среднему рейтингу и по возрастанию по автору и жанру.

SELECT 
	author, 
	genre, 
	avg(book_average_rating) as average_rating
FROM 
	books
GROUP BY 
	author, genre
ORDER BY 
	average_rating DESC, author, genre 
OFFSET 2 LIMIT 6;



ЗАДАНИЕ 31.
Напишите запрос, который для каждого автора книг, опубликованных после 1930 года, 
подсчитывает количество издательств, в которых публиковались книги, 
сумму количества всех оценок таких книг, их средний рейтинг, минимальный и максимальный год публикации.
Выведите только таких авторов, которые публиковались хотя бы в двух издательствах 
и опубликовали хотя бы одну книгу после 1950 года.

SELECT 
		author, 
		count(distinct publisher), 
		sum(book_ratings_count), 
		avg(book_average_rating), 
		min(publishing_year), 
		max(publishing_year)
FROM 
		books
WHERE publishing_year > 1930
GROUP BY author
HAVING count(distinct publisher) >= 2 and max(publishing_year) > 1950;




        *******    *******    *******    *******    



ДАЛЕЕ ДЛЯ ВЫПОЛНЕНИЯ ЗАДАНИЙ ИСПОЛЬЗУЮТСЯ ТАБЛИЦЫ СХЕМЫ "Shipping"
      Файл со структурой схемы представлен в репозитории 
         (Изображение - entity_relation_shipping.jpg)



ЗАДАНИЕ 32.
Напишите запрос, который выводит количество городов с населением более 1000000.

SELECT count(city_name)
FROM shipping.city
WHERE population > 1000000;



ЗАДАНИЕ 33.
Напишите запрос, который выводит среднюю выручку по каждой категории клиентов.

SELECT 
	cust_type, 
	avg(annual_revenue)
FROM shipping.customer
GROUP BY cust_type;



ЗАДАНИЕ 34.
Теперь модифицируйте предыдущий запрос, оставив название только тех типов клиентов, 
у которых среднегодовой доход больше 25 млн.

SELECT 
	cust_type, 
	avg(annual_revenue)
FROM shipping.customer
GROUP BY cust_type
HAVING avg(annual_revenue) > 25000000;



ЗАДАНИЕ 35.
Напишите запрос, который позволит вывести фамилию водителя, не указавшего телефон.

SELECT last_name
FROM shipping.driver
WHERE phone is NULL;



ЗАДАНИЕ 36.
Напишите запрос, который выведет количество уникальных производителей грузовиков.

SELECT count(distinct make)
FROM shipping.truck;



ЗАДАНИЕ 37.
Напишите запрос, который выведет идентификатор и вес третьей по весу доставки 
(сортировка по убыванию).

SELECT 
	ship_id, 
	weight
FROM shipment
ORDER BY weight DESC
LIMIT 1 OFFSET 2;



ЗАДАНИЕ 38.
Напишите запрос, с помощью которого можно увидеть список всех таблиц, относящихся к датасету.

SELECT 
	t.table_schema,
	t.table_name
FROM 
	information_schema.tables t
WHERE 
	t.table_schema = 'shipping';
	


ЗАДАНИЕ 39.
Напишите запрос, который посчитает, сколько таблиц в схеме public.

SELECT count(t.table_name)
FROM information_schema.tables t
WHERE t.table_schema = 'public';



ЗАДАНИЕ 40.
Напишите запрос, с помощью которого можно увидеть список всех полей 
и их типов в таблице city в схеме shipping.

SELECT 
	c.table_schema,
	c.table_name,
	c.column_name,
	c.data_type,
	c.ordinal_position
FROM 
	information_schema.columns c
WHERE 
	c.table_schema = 'shipping'
	and c.table_name = 'city';
	


ЗАДАНИЕ 41.
Напишите запрос, который выведет самый частый тип в таблицах схемы public. 
Количество выводить не нужно.

SELECT
	c.data_type
FROM
	information_schema.columns as c
WHERE
	c.table_schema = 'public'
GROUP BY c.data_type
ORDER BY count(c.data_type) DESC 
LIMIT 1;



ЗАДАНИЕ 42.
Напишите запрос, который выведет количество таблиц в схеме shipping, 
в которых есть столбцы типа numeric.

SELECT
	count(c.table_name)
FROM
	information_schema.columns as c
WHERE
	c.table_schema = 'shipping'
	and c.data_type = 'numeric';



ЗАДАНИЕ 43.
Напишите запрос, с помощью которого можно увидеть все ключи таблицы shipment.

SELECT 
	c.table_schema,
	c.table_name,
	c.constraint_name,
	c.constraint_type
FROM 
	information_schema.table_constraints c
WHERE 
	c.table_schema = 'shipping'
	and c.table_name = 'shipment'
	and c.constraint_type in ('PRIMARY KEY', 'FOREIGN KEY');



ЗАДАНИЕ 44.
Напишите запрос, который выведет количество таблиц с первичными ключами в схеме public.

SELECT 
	count(c.table_name)
FROM 
	information_schema.table_constraints c
WHERE 
	c.table_schema = 'public'
	and c.constraint_type = 'PRIMARY KEY';



ЗАДАНИЕ 45.
Напишите запрос в Metabase, который считает среднее население города в таблице shipping.city. 
Сохраните или скопируйте его результат. После этого в поле ответа напишите запрос, 
который выводит количество городов с населением выше среднего 
(подставив результат предыдущего запроса в условие) и оставьте любой комментарий, 
объясняющий, откуда было взято это число. Используйте разные способы комментирования.

/*
SELECT avg(c.population)
FROM  shipping.city as c
*/ 


SELECT 
	count(c.city_name)
FROM  
	shipping.city as c
WHERE c.population > 165718.76 -- среднее население по городам было найдено с помощью функции avg



ЗАДАНИЕ 46.
Выведите все уникальные пары идентификаторов города доставки и города клиента, 
имеющиеся в таблице с доставками.

SELECT   
	s.city_id, 
	cus.city_id
FROM
	shipping.shipment s
	   join shipping.customer cus 
	      on s.cust_id = cus.cust_id
 
GROUP BY s.city_id, cus.city_id;



ЗАДАНИЕ 47.
Выведите название второго города по числу доставок и количество доставок в нем.

SELECT 
	c.city_name, 
	count(s.ship_id) 
FROM 
	shipping.shipment s 
	   join shipping.city c on s.city_id = c.city_id
GROUP BY c.city_name
ORDER BY count(s.ship_id) DESC
OFFSET 1 LIMIT 1;



ЗАДАНИЕ 48.
Выведите список всех грузовиков, выпущенных не раньше грузовика с идентификатором 8, 
исключая этот грузовик.

SELECT 
	t1.*
FROM 
	shipping.truck t 
	   join shipping.truck t1 
	      on t.model_year <= t1.model_year and t.truck_id != t1.truck_id
WHERE t.truck_id = 8;



ЗАДАНИЕ 49.
Выведите среднее население, среднюю площадь и плотность населения городов, 
чья площадь больше города Paramount. Плотность населения в этом задании рассчитывается 
как сумма населения, деленная на сумму площади.

SELECT 
	avg(s.population) as average_population, 
	avg(s.area) as average_area, 
	sum(s.population) / sum(s.area) as density_of_population
FROM shipping.city c 
	join shipping.city s on c.area < s.area
WHERE c.city_name = 'Paramount';



ЗАДАНИЕ 50.
Выведите количество доставок по дате, году выпуска грузовика и названию города доставки.

SELECT 
	s.ship_date,
	t.model_year,
	c.city_name,
	count(*) shipments
FROM 
	shipping.shipment s
	   join shipping.truck t on s.truck_id = t.truck_id
	      join shipping.city c on s.city_id = c.city_id
GROUP BY 	
	s.ship_date,
	t.model_year,
	c.city_name;
	


ЗАДАНИЕ 51.
Выведите имена и фамилии водителей, которые совершали доставки, а также из какого города они родом. 
Отдельным столбцом выведите последнюю дату таких доставок. 
Отсортируйте по фамилии водителя в алфавитном порядке.

SELECT 
	d.first_name, 
	d.last_name, 
	c.city_name, 
	max(s.ship_date)

FROM  shipping.driver d 
         join shipping.shipment s on d.driver_id = s.driver_id 
	    join shipping.city c on d.city_id = c.city_id 
GROUP BY 
	d.first_name, 
	d.last_name, 
	c.city_name
ORDER BY 
	d.last_name;   -- asc 



ЗАДАНИЕ 52.
Посчитайте количество доставок и среднюю массу груза в разрезе клиентов и города доставки. 
Выведите таблицу с полями: имя клиента, город доставки, кол-во доставок и средняя масса груза. 
Отсортируйте по имени клиента в алфавитном порядке, затем по средней массе груза по убыванию.

SELECT 
	c.cust_name, 
	cit.city_name, 
	count(s.ship_id) as shipments_count, 
	avg(s.weight) as average_weight

FROM  shipping.shipment s 
	 join shipping.customer c on s.cust_id = c.cust_id
	    join shipping.city cit on s.city_id = cit.city_id
GROUP BY 
	c.cust_name,    -- 1, 2
	cit.city_name
ORDER BY 
	c.cust_name,  -- asc
	avg(s.weight) DESC;



ЗАДАНИЕ 53.
Напишите запрос, который выводит все названия штатов и кол-во клиентов в них, используя LEFT JOIN. 
Упорядочите список штатов по кол-ву клиентов по убыванию, а затем по штату в алфавитном порядке.

SELECT
	s.state, 
	count(distinct c.cust_name) as cust_count

FROM shipping.city s 
	left join shipping.customer c on s.city_id = c.city_id
GROUP BY s.state
ORDER BY cust_count DESC, s.state;



ЗАДАНИЕ 54.
Найдите клиентов, которые никогда не совершали заказ.

SELECT 
	c.cust_id
FROM 
	shipping.customer c 
	   left join shipping.shipment s on c.cust_id = s.cust_id
WHERE s.ship_id is NULL; 



ЗАДАНИЕ 55.
Напишите запрос, который выдает сводную статистику по городам: количество клиентов, заказов и водителей. 
Оставьте города, в которых хотя бы один из этих показателей ненулевой, и отсортируйте по первому столбцу. 
Используйте left join для таблицы с городами.

SELECT 
	c.city_name, 
	count(distinct cus.cust_id) as count_customers, 
	count(distinct sh.ship_id) as count_shipments, 
	count(distinct d.driver_id) as count_drivers

FROM shipping.city c 
	left join shipping.customer cus on c.city_id = cus.city_id
	   left join shipping.shipment sh on c.city_id = sh.city_id
	      left join shipping.driver d on c.city_id = d.city_id
GROUP BY c.city_name
HAVING count(distinct cus.cust_id) > 0 
	or count(distinct sh.ship_id) > 0 
	or count(distinct d.driver_id) > 0
ORDER BY 1;



ЗАДАНИЕ 56.
К каждой записи водителя присоедините все записи с клиентами.

SELECT 
	*
FROM 
	shipping.driver 
	   CROSS JOIN shipping.customer;
	
	
ДРУГОЙ ВАРИАНТ РЕШЕНИЯ: 
		
SELECT 
	*
FROM 
	shipping.driver 
	   join shipping.customer on true;



ЗАДАНИЕ 57.
Напишите запрос, который выводит все возможные уникальные пары даты доставки 
и имени водителя, упорядоченные по дате и имени по возрастанию.

SELECT 
	distinct s.ship_date, 
	d.first_name
FROM 
	shipping.shipment s 
	   cross join shipping.driver d
ORDER BY 
	s.ship_date, 
	d.first_name;



ЗАДАНИЕ 58.
Напишите запрос, который создает уникальный алфавитный справочник всех городов, штатов, 
имен водителей и производителей грузовиков. Результатом запроса должны быть два столбца 
(название объекта и тип объекта — city, state, driver, truck). 
Отсортируйте список по названию объекта, а затем по типу.

SELECT 
	c.city_name as object_name,
	'city' as object_type
FROM
	shipping.city c
union 
SELECT 
	cc.state,
	'state' 
FROM
	shipping.city cc
union 
SELECT 
	d.first_name,
	'driver' 
FROM
	shipping.driver d
union 
SELECT 
	t.make,
	'truck' 
FROM
	shipping.truck t
ORDER BY 1, 2; 



ЗАДАНИЕ 59.
Выведите список всех id городов и их названий в одном столбце.

SELECT 
	c.city_id::text    -- Переводим id в текст
FROM 
	shipping.city c
union all
SELECT 
	cc.city_name
FROM 
	shipping.city cc;



ЗАДАНИЕ 60.
Напишите запрос, который объединит в себе все почтовые индексы водителей и их телефоны в единый столбец-справочник. 
Также добавьте столбец с именем водителя и столбец с типом контакта ('phone' или 'zip' в зависимости от типа). 
Упорядочите список по столбцу с контактными данными по возрастанию, а затем по имени водителя.

SELECT 
	d.zip_code::text as driver_zip_and_phone,
	d.first_name as driver_name,
	'zip' as object_type
FROM 
	shipping.driver d

union 	
SELECT 
	dr.phone,
	dr.first_name as driver_name,
	'phone' as object_type
FROM 
	shipping.driver dr
ORDER BY 1, 2;



ЗАДАНИЕ 61.
Выведите общее население по всем городам и его детализацию до конкретного города. 

SELECT  
	c.city_name,
	c.population
FROM 
	shipping.city c

union all
SELECT 
	'total' total_name,
	sum(c.population) total_population
FROM 
	shipping.city c
ORDER BY 2 DESC;



ЗАДАНИЕ 62.
Напишите запрос, который выводит общее число доставок ('total_shippings'), а также количество доставок в каждый день. 
Необходимые столбцы: date_period, cnt_shipping. Упорядочите по убыванию столбца date_period.

SELECT 
	s.ship_date::text as date_period,    -- Перевод в текстовый тип данных
	count(s.ship_id) as cnt_shipping
FROM 
	shipping.shipment s 
GROUP BY 1

union all
SELECT
	'total_shippings' as total,
	count(s.ship_id) as total_ships
FROM 
	shipping.shipment s
ORDER BY 1 DESC;



ЗАДАНИЕ 63.
С помощью UNION отобразите, у кого из водителей заполнен столбец с номером телефона.

SELECT
        d.first_name,
        d.last_name,
        'телефон заполнен' phone_info
FROM
        shipping.driver d
WHERE 
	d.phone IS NOT NULL

UNION
SELECT
        d.first_name,
        d.last_name,
        'телефон не заполнен' phone_info
FROM
        shipping.driver d
WHERE 
		d.phone IS NULL;



ЗАДАНИЕ 64.
Напишите запрос, который выводит два столбца: city_name и shippings_fake. 
В первом столбце название города, а второй формируется так:
- eсли в городе было более 10 доставок, вывести количество доставок в этот город как есть;
- иначе вывести количество доставок, увеличенное на 5.
Отсортируйте по убыванию получившегося «нечестного» количества доставок, а затем по имени в алфавитном порядке.
В выводе не должно быть городов, в которые нет доставок.

SELECT 
	c.city_name as city_name,
	count(s.ship_id) as shippings_fake
  
FROM 
	shipping.city c 
	   join shipping.shipment s on c.city_id = s.city_id
GROUP BY c.city_name
HAVING count(s.ship_id) > 10

union
SELECT 
	c.city_name as city_name,
	count(s.ship_id) + 5 as shippings_fake
FROM 
	shipping.city c 
	   join shipping.shipment s on c.city_id = s.city_id
GROUP BY c.city_name
HAVING count(s.ship_id) <= 10
ORDER BY 2 DESC, 1;



ЗАДАНИЕ 65.
Выведите первые три буквы алфавита и их порядковые номера. (Формирование справочника)

SELECT 
	'a'letter, '1' ordinal_position
union 
SELECT 
	'b', '2' 
union 
SELECT 
	'c', '3' 



ЗАДАНИЕ 66.
Выведите количество клиентов и количество водителей в каждом из почтовых индексов (zip code). 
Отсортировать по сумме водителей и клиентов

SELECT 
	coalesce(c.zip, d.zip_code) zip,
	count(distinct c.cust_id) customers,
	count(distinct d.driver_id) drivers
FROM 
	shipping.customer c
	   full outer join shipping.driver d on c.zip = d.zip_code
GROUP BY 1
HAVING count(distinct c.cust_id) + count(distinct d.driver_id) > 0
ORDER BY  count(distinct c.cust_id) + count(distinct d.driver_id) DESC;



ЗАДАНИЕ 67.
Выведите список столбцов, которые есть в таблице shipping.shipment, 
но нет в других таблицах схемы shipping. Отсортируйте столбцы по возрастанию.

SELECT 
	column_name
FROM 
	information_schema.columns
WHERE table_schema = 'shipping' and table_name = 'shipment'

except
SELECT 
	column_name
FROM 
	information_schema.columns
WHERE table_schema = 'shipping' and table_name != 'shipment'
ORDER BY column_name asc;



ЗАДАНИЕ 68.
Выведите список id городов, в которых есть и клиенты, и доставки, и водители.

SELECT s.city_id
FROM shipping.city s

intersect
SELECT c.city_id
FROM shipping.customer c

intersect
SELECT sh.city_id
FROM shipping.shipment sh

intersect
SELECT d.city_id
FROM shipping.driver d;



ЗАДАНИЕ 69.
Напишите запрос, который в алфавитном порядке выводит названия штатов, где были совершены доставки. 
Используйте оператор JOIN! 

SELECT 
	distinct c.state
FROM  
	shipping.city c 
	   inner join shipping.shipment s on c.city_id = s.city_id
ORDER BY 1; 



ЗАДАНИЕ 70.
Напишите запрос, который в алфавитном порядке выводит названия штатов, где были совершены доставки. 
Используйте exists! 

SELECT 
	distinct state
FROM 
	shipping.city c
WHERE 
	exists 
		(
		SELECT 
			*
		FROM 
			shipping.shipment s 
		WHERE 
			s.city_id = c.city_id
		  )
ORDER BY 1;



ЗАДАНИЕ 71.
Напишите запрос, который выводит все схемы и названия таблиц в базе, в которых нет первичных ключей. 
Отсортируйте оба столбца в алфавитном порядке (по возрастанию).

SELECT 
	t.table_schema, 
	t.table_name
FROM information_schema.tables t
WHERE
	not exists   (
			SELECT *
			FROM information_schema.table_constraints c
			WHERE c.constraint_type = 'PRIMARY KEY' 
				and t.table_schema = c.table_schema 
				and t.table_name = c.table_name
			  )
ORDER BY 1, 2;



ЗАДАНИЕ 72.
Выведите все города, с указанием о наличии или отсутствии в нем заказов. 
Используйте exists. В выводе должно быть два столбца: city_name, has_shipments.

SELECT 
	city_name,
	exists 
		(
		SELECT *
		FROM  shipping.shipment s 
		WHERE s.city_id = c.city_id
		  ) has_shipments
FROM shipping.city c
ORDER BY 1;



ЗАДАНИЕ 73.
Напишите запрос, который выводит названия всех городов и булевы поля, показывающие наличие клиентов, 
наличие водителей и доставок в этом городе. Добавьте сортировку по названию городов.

SELECT 
	c.city_name,
	  exists
		(
		SELECT *
		FROM shipping.customer cus 
   		WHERE c.city_id = cus.city_id
   		 ) has_customers,
	  exists
		(
   		SELECT *
   		FROM shipping.driver d 
   		WHERE c.city_id = d.city_id
   		  ) has_drivers,
	  exists
		(
		SELECT *
		FROM shipping.shipment s 
		WHERE c.city_id = s.city_id
		  ) has_shipments
FROM shipping.city c 
ORDER BY 1;   



ЗАДАНИЕ 74.
Выведите все штаты, в которых есть водители с указанным номером телефона. 
Используйте подзапрос с IN.

SELECT 
	distinct state
FROM 
	shipping.city c
WHERE 
	c.city_id in
		   	(
			SELECT 
				d.city_id
			FROM 
				shipping.driver d
			WHERE d.phone is not NULL
			  ) 
ORDER BY 1;



ЗАДАНИЕ 75.
Напишите запрос, который выводит все поля из таблицы доставок по водителям, 
совершившим более 90 доставок. Отсортируйте запрос по первому и второму столбцу.

SELECT *
FROM 
	shipping.shipment s
WHERE 
	s.driver_id in 
			(
			SELECT s.driver_id
			FROM shipping.shipment s 
			GROUP BY s.driver_id
			HAVING count(s.ship_id) > 90
   			  )
ORDER BY 1, 2;



ЗАДАНИЕ 76.
Выведите среднее по средним массам груза доставки на каждого водителя. Используйте SELECT FROM SELECT.

SELECT 
	avg(a.avg_weight) avg_avg_weight
FROM 
	(
	SELECT 
		s.driver_id,
		avg(s.weight) avg_weight
	FROM 
		shipping.shipment s
	GROUP BY 1
	) a




ЗАДАНИЕ 77.
Выведите идентификатор доставки, ее дату, массу груза, среднюю массу доставленных в этот день грузов 
и признак того, что масса груза больше средней в этот день на сто кг. Используйте SELECT FROM SELECT.

SELECT 
	s.ship_id,
	s.ship_date,
	s.weight,
	a.avg_weight avg_weight_this_day,
	s.weight > a.avg_weight + 100 is_heavyweighted
FROM 
	(
	SELECT 
		s.ship_date,
		avg(s.weight) avg_weight
	FROM 
		shipping.shipment s
	GROUP BY 1
	) a 
	join  shipping.shipment s 
		on a.ship_date = s.ship_date



ЗАДАНИЕ 78.
Напишите запрос, который найдет водителя, совершившего наибольшее количество доставок одному клиенту. 
В выводе должна быть одна строка, которая содержит имя водителя (first_name), 
имя клиента и количество доставок водителя этому клиенту. Используйте конструкцию SELECT FROM SELECT.

1) ПЕРВЫЙ ВАРИАНТ РЕШЕНИЯ:

SELECT
   d.first_name, 
   c.cust_name,
   a.ship_count
   
FROM  (
	SELECT  s.driver_id, 
		s.cust_id, 
		count(s.ship_id) as ship_count
	FROM shipping.shipment s
	GROUP BY driver_id, s.cust_id
	ORDER BY 3 DESC
	  ) as a
  join
	shipping.driver d on d.driver_id = a.driver_id
  join 
	shipping.customer c on c.cust_id = a.cust_id
LIMIT 1;



2) ВТОРОЙ ВАРИАНТ РЕШЕНИЯ (более эффективный)
Напишите запрос, который найдет водителя, совершившего наибольшее количество доставок одному клиенту. 
В выводе должна быть одна строка, которая содержит имя водителя (first_name), имя клиента 
и количество доставок водителя этому клиенту. Используйте конструкцию SELECT FROM SELECT.

SELECT 
    a.first_name, 
    a.cust_name, 
    a.ships_count
FROM  (
	SELECT 
		d.first_name, 
		cus.cust_name,  
		count(s.ship_id) ships_count
	FROM  shipping.shipment s   
	   join shipping.driver d on s.driver_id = d.driver_id
		join shipping.customer cus on s.cust_id = cus.cust_id  
	GROUP BY 1,2
	ORDER BY 3 DESC
	   ) a
LIMIT 1;



ЗАДАНИЕ 79.
Используя конструкцию SELECT FROM SELECT, преобразуйте предыдущий запрос таким образом, чтобы он вывел:
- имя водителя (first_name);
- имя клиента;
- количество доставок этому клиенту;
- общее количество доставок водителя.

1) ПЕРВЫЙ ВАРИАНТ РЕШЕНИЯ:

SELECT
	d.first_name, 
	c.cust_name,
	a.ship_count,
	s.total_num
FROM  	    (
		SELECT  s.driver_id, 
			s.cust_id, 
			count(s.ship_id) as ship_count
		FROM shipping.shipment s
		GROUP BY driver_id, s.cust_id
		ORDER BY 3 DESC
    	   	     ) as a
  join
	shipping.driver d on d.driver_id = a.driver_id
  join 
	shipping.customer c on c.cust_id = a.cust_id
  join 	    ( 
		SELECT  s.driver_id, 
			count(s.ship_id) as total_num
		FROM  shipping.shipment s
		GROUP BY  s.driver_id  
	   	    ) as s 
	    on a.driver_id = s.driver_id
LIMIT 1;



2) ВТОРОЙ ВАРИАНТ РЕШЕНИЯ (более эффективный)
Используя конструкцию SELECT FROM SELECT, преобразуйте предыдущий запрос таким образом, чтобы он вывел:
- имя водителя (first_name);
- имя клиента;
- количество доставок этому клиенту;
- общее количество доставок водителя.

SELECT 
	a.first_name,
	a.cust_name,
	a.ships_count,
	count(sh1.ship_id)
FROM 
	    (
		SELECT 
			d.first_name,
			cus.cust_name,
			sh.driver_id,
			count(sh.ship_id) ships_count
		FROM  shipping.shipment sh
			join shipping.driver d on sh.driver_id = d.driver_id  
			   join shipping.customer cus on sh.cust_id = cus.cust_id
		GROUP BY 1, 2, 3 
		ORDER BY 3 DESC
		     )a  
   join shipping.shipment sh1 on a.driver_id = sh1.driver_id
GROUP BY 1, 2, 3
ORDER BY 3 DESC
LIMIT 1;



ЗАДАНИЕ 80.
Преобразовав запрос из предыдущего задания, напишите такой запрос, который найдет водителя, 
совершившего наибольшее число доставок одному клиенту. По этому водителю выведите следующие поля:
- имя водителя;
- имя самого частого для него клиента;
- дату последней доставки этому клиенту;
- общее число доставок этого водителя;
- количество различных грузовиков, на которых он совершал доставку грузов.

1) ПЕРВЫЙ ВАРИАНТ РЕШЕНИЯ:

SELECT
	d.first_name,
	cus.cust_name,
	max(s.ship_date),
	c.ship_count,
	c.truck_count
FROM
	   (
		SELECT
			s.driver_id,
			count(s.ship_id) ship_count,
			count(distinct s.truck_id) truck_count
		FROM  shipping.shipment as s
		GROUP BY  s.driver_id
		      ) c
   join shipping.shipment as s  on  c.driver_id = s.driver_id
   join shipping.driver as d  on  c.driver_id = d.driver_id
   join shipping.customer as cus  on  s.cust_id = cus.cust_id

GROUP BY
	d.first_name,
	cus.cust_name,
	c.ship_count,
	c.truck_count
ORDER BY  count(s.ship_id) DESC
LIMIT  1;



2) ВТОРОЙ ВАРИАНТ РЕШЕНИЯ: 

SELECT
	d.first_name, 
	c.cust_name,
	a.latest_date,
	t.ship_count,
	t.truck_count
FROM 
	    (
		SELECT  s.driver_id, 
			s.cust_id, 
			count(s.ship_id), 
			max(s.ship_date) as latest_date 
		FROM  shipping.shipment s
		GROUP BY  driver_id, s.cust_id
		ORDER BY  3 DESC
		LIMIT  1
			) as a

  join
	shipping.driver d on a.driver_id = d.driver_id 
  join 
	shipping.customer c on a.cust_id = c.cust_id 
  join 
	    (
		SELECT  sh.driver_id, 
			count(sh.ship_id) ship_count, 
			count(distinct sh.truck_id) truck_count
		FROM  shipping.shipment sh 
		GROUP BY 1
			) as t
       	   on t.driver_id = a.driver_id
LIMIT 1;


ТРЕТИЙ ВАРИАНТ РЕШЕНИЯ (более эффективный)
Преобразовав запрос из предыдущего задания, напишите такой запрос, который найдет водителя, 
совершившего наибольшее число доставок одному клиенту. По этому водителю выведите следующие поля:
- имя водителя;
- имя самого частого для него клиента;
- дату последней доставки этому клиенту;
- общее число доставок этого водителя;
- количество различных грузовиков (грузовиков с различными truck_id), на которых он совершал доставку грузов

SELECT 
	a.first_name,
	a.cust_name,
	a.max_ship_date,
	count(sh1.ship_id) total_ship_count,
	count(distinct t.truck_id) truck_count
FROM 
	    (
		SELECT 
			d.first_name,
			cus.cust_name,
			sh.driver_id,
			max(sh.ship_date) max_ship_date,
			count(sh.ship_id) ships_count
		FROM shipping.shipment sh
			join shipping.driver d on sh.driver_id = d.driver_id  
			   join shipping.customer cus on sh.cust_id = cus.cust_id
		GROUP BY  1, 2, 3 
		ORDER BY  5 DESC
		LIMIT  1
		     )a  
   join shipping.shipment sh1 on a.driver_id = sh1.driver_id
   join shipping.truck t on t.truck_id = sh1.truck_id
GROUP BY 1, 2, 3;
   


ЗАДАНИЕ 81.
Напишите запрос, который найдет водителей, совершивших наибольшее число доставок 
и наименьшее число доставок. Выведите их имена (сначала больший, потом меньший) 
и разницу между их числом доставок (наибольший — наименьший). В выводе должна быть одна строка.

1) ВАРИАНТ РЕШЕНИЯ С ПОДЗАПРОСАМИ SELECT FROM SELECT (Наиболее эффективный и читабельный):

SELECT 
	a.first_name, 
	b.first_name, 
	a.ship_count - b.ship_count  ship_count_diff
FROM  
	    (
		SELECT  
			d.first_name,
			count(sh.ship_id) ship_count
		FROM  shipping.driver d  
		   join  shipping.shipment sh  on  d.driver_id = sh.driver_id  
		GROUP BY 1  
		ORDER BY 2 DESC
		    ) a,

	    (
		SELECT  
			d.first_name,
			count(sh.ship_id) ship_count
		FROM  shipping.driver d  
		   join  shipping.shipment sh  on  d.driver_id = sh.driver_id  
		GROUP BY 1  
		ORDER BY 2  -- сортировка acs, т.е. по возрастанию, настроена по умолчанию
		    ) b
LIMIT 1;



2) ВАРИАНТ РЕШЕНИЯ С ТИПОМ СОЕДИНЕНИЯ CROSS JOIN.
Напишите запрос, который найдет водителей, совершивших наибольшее число доставок 
и наименьшее число доставок. Выведите их имена (сначала больший, потом меньший) 
и разницу между их числом доставок (наибольший — наименьший). В выводе должна быть одна строка.

SELECT
	max_driver.first_name,
	min_driver.first_name,
	max_driver.ship_count - min_driver.ship_count  as diff
FROM
	    (
		SELECT
			d.first_name,
			count(s.ship_id) ship_count
		FROM  shipping.shipment as s
		   join shipping.driver as d  on  s.driver_id = d.driver_id
		GROUP BY  1
		ORDER BY 2 DESC
		LIMIT  1
		    ) max_driver
    
  CROSS JOIN 
	    (
		SELECT
			d.first_name,
			count(s.ship_id) ship_count
		FROM  shipping.shipment as s
		   join shipping.driver as d  on  s.driver_id = d.driver_id
		GROUP BY  1
		ORDER BY  2 
		LIMIT  1
		    ) min_driver



3) ВАРИАНТ РЕШЕНИЯ С ПОЗДАПРОСАМИ: Common Table Expressions (CTE), SELECT FROM SELECT.
Напишите запрос, который найдет водителей, совершивших наибольшее число доставок 
и наименьшее число доставок. Выведите их имена (сначала больший, потом меньший) 
и разницу между их числом доставок (наибольший — наименьший). В выводе должна быть одна строка.

WITH max_driver as (
                    SELECT
                          a.first_name,
                          a.ship_count
                    FROM 
                        (
                            SELECT 
                                s.driver_id,
                                d.first_name,
                                count(s.ship_id)  as ship_count
                            FROM 
                                shipping.shipment s
                                   join shipping.driver d  on  s.driver_id = d.driver_id
                            GROUP BY 1, 2
                            ORDER BY 3 DESC
                            LIMIT 1 
                        ) as a
                    ), 
     min_driver as (
                    SELECT
                         b.first_name,
                         b.ship_count
                    FROM 
                        (
                            SELECT 
                                s.driver_id,
                                d.first_name,
                                count(s.ship_id) as ship_count
                            FROM 
                                shipping.shipment s
                                   join shipping.driver d  on  s.driver_id = d.driver_id
                            GROUP BY 1, 2
                            ORDER BY 3
                            LIMIT 1 
                        ) as b
                     )
  
  SELECT 
        max_driver.first_name, 
	min_driver.first_name,  
	max_driver.ship_count - min_driver.ship_count  as diff
  FROM 
        max_driver, min_driver; 
 



   ******  ЗАДАНИЕ 82.  ******
Выведите среднее значение по средним массам груза доставки на каждого водителя. 
Используйте CTE (Common Table Expressions).

WITH a as   (
		SELECT 
			s.driver_id,
			avg(s.weight) avg_weight
		FROM  shipping.shipment s
		GROUP BY 1
		    ) 
SELECT  avg(a.avg_weight) avg_avg_weight
FROM  a; 	



ЗАДАНИЕ 83.
Выведите идентификатор доставки, ее дату, массу груза, среднюю массу доставленных в этот день грузов 
и признак того, что масса груза больше средней в этот день на 100 кг. 
Используйте CTE (Common Table Expressions).

WITH a as    ( 
		SELECT 
			s.ship_date, 
			avg(s.weight) avg_weight 
		FROM shipping.shipment s 
		GROUP BY 1 
		    )
SELECT 
	s.ship_id,
	s.ship_date,
	s.weight,
	a.avg_weight  avg_weight_this_day,
	s.weight > a.avg_weight + 100  is_heavyweighted
FROM 
	a 
	 join  shipping.shipment s  on  a.ship_date = s.ship_date;



ЗАДАНИЕ 84.
Выведите первый день, в котором число тяжеловесных заказов больше двух, 
и последний день, но в разных строках и с указанием типа дня.

WITH a as   (
		SELECT 
			s.ship_date,
			avg(s.weight)  avg_weight
		FROM 
			shipping.shipment s
		GROUP BY 1
		    ),
    d as   (
		SELECT 
			s.ship_date,
			s.weight > a.avg_weight + 100   is_heavyweighted, 
			count(*) qty
		FROM 
			a 
			  join  shipping.shipment s  on  a.ship_date = s.ship_date
		GROUP BY 1,2
		    )
SELECT 
	'first_heavy_date'  date_type,
	min(d.ship_date)  date
FROM  d
WHERE   d.is_heavyweighted 
	and  d.qty > 2
union 
SELECT 
	'last_heavy_date'  date_type,
	max(d.ship_date)  date
FROM   d
WHERE   d.is_heavyweighted 
	and  d.qty > 2;



ЗАДАНИЕ 85.
Представим, что в компании было два директора: Paolo Lorenzo и его сын Nicco Lorenzo. 
Первый руководил компанией с начала и до 2017-02-01 невключительно. 
Второй — с 2017-02-01 включительно и до конца периода. 
Напишите запрос, который даст следующий отчет: имя и фамилия директора в одном поле, 
далее поля со сводной статистикой по доставкам (кол-во доставок, кол-во совершивших доставки водителей, 
кол-во клиентов, которым была оказана услуга доставки, и общая масса перевезенных грузов). 
Отсортируйте по имени директора.

1) РЕШЕНИЕ ПРИ ПОМОЩИ CTE (Common Table Expressions) И UNION

WITH statistics_1 as (
			SELECT 
				count(distinct sh.ship_id)  ship_id_count,
				count(distinct sh.driver_id)  driver_id_count,
				count(distinct sh.cust_id)  cust_id_count,
				sum(sh.weight) weight_sum
			FROM  shipping.shipment sh 
			WHERE  sh.ship_date < '2017-02-01'
                          ),
    statistics_2 as (
			SELECT 
				count(distinct sh.ship_id)  ship_id_count,
 				count(distinct sh.driver_id)  driver_id_count,
				count(distinct sh.cust_id)  cust_id_count,
				sum(sh.weight)  weight_sum
			FROM  shipping.shipment sh 
			WHERE  sh.ship_date >= '2017-02-01'  
			   )
SELECT  
	'Paolo Lorenzo' director_name,
	statistics_1.ship_id_count,
	statistics_1.driver_id_count,
	statistics_1.cust_id_count,
	statistics_1.weight_sum
FROM  statistics_1
UNION
SELECT  
	'Nicco Lorenzo',
	statistics_2.ship_id_count,
	statistics_2.driver_id_count,
	statistics_2.cust_id_count,
	statistics_2.weight_sum
FROM  statistics_2; 



2) ВТОРОЙ ВАРИАНТ РЕШЕНИЯ ПРИ ПОМОЩИ CTE (Common Table Expressions)

WITH stat as (
		SELECT 
			'Paolo Lorenzo'  as director_name,
			s.ship_date  as heading
		FROM shipping.shipment s 
                WHERE s.ship_date < 'February 01, 2017'
                GROUP BY 2
                
		union 
                SELECT 
			'Nicco Lorenzo'  as director_name,
			ss.ship_date  as heading
                FROM shipping.shipment ss 
                WHERE ss.ship_date >= 'February 01, 2017'
                GROUP BY 2
            	   )  
SELECT  
	stat.director_name,
	count(distinct sh.ship_id) shipments,
	count(distinct d.driver_id) drivers,
	count(distinct c.cust_id) customers,
	sum(sh.weight) weights
FROM stat 
   join shipping.shipment sh  on  stat.heading = sh.ship_date
	join shipping.driver d  on  sh.driver_id = d.driver_id
	   join shipping.customer c  on  sh.cust_id = c.cust_id
GROUP BY 1;




******  ОКОННЫЕ ФУНКЦИИ  ******


ЗАДАНИЕ 86.
Посчитать, каков вклад каждой доставки в общую массу доставок в город, 
то есть отношение массы конкретной доставки к массе всех доставок в городе.
1) Решить при помощи CTE

WITH city_weight as (
			SELECT 
				c.city_id,
				sum(s.weight) city_weight
			FROM shipping.shipment s
			   join shipping.city c  on  s.city_id = c.city_id
			GROUP BY  1
		      )
SELECT 
	s.ship_id,
	s.weight / w.city_weight  ratio
FROM shipping.shipment s
   join city_weight w  on  s.city_id = w.city_id
ORDER BY 2 DESC;



2) Решить при помощи оконных функций

SELECT 
	s.ship_id,
	s.weight / sum(s.weight) over(partition by s.city_id) ratio
FROM shipping.shipment  s
ORDER BY 2 DESC;



ЗАДАНИЕ 87.
Проранжируйте уникальными числами имена клиентов в порядке обратном алфавитному, 
а затем отсортируйте запрос по столбцу с номером по возрастанию. Столбцы в выдаче:
cust_id — id клиента, cust_name — имя клиента, num — порядковый номер.

SELECT 
	cust_id,
	cust_name,
	row_number() over(order by cust_name DESC) as num    
FROM shipping.customer
ORDER BY 3;



ЗАДАНИЕ 88.
Предположим, вы хотите устроить акцию и вернуть бонусами деньги за доставку 3-х самых тяжелых 
грузов для каждого клиента. Напишите запрос, который отранжирует все заказы для каждого клиента 
по массе груза по убыванию, и выберите три самых тяжелых из них. Сортировка по cust_id, а затем 
по столбцу с номером по возрастанию. Столбцы в выдаче: cust_id, ship_id, weight, weight_number. 

WITH action as (
		SELECT 
		   s.cust_id,
		   s.ship_id,
		   s.weight,
		   row_number() over (partition by s.cust_id order by s.weight desc)  weight_number
		FROM shipping.shipment s
		OREDR BY  s.cust_id, 
			  weight_number
		  )
SELECT
	action.cust_id,
	action.ship_id,
	action.weight,
	action.weight_number
FROM  action
WHERE action.weight_number between 1 and 3;



ЗАДАНИЕ 89.
Выведите первый и последний по алфавиту город.

WITH rownums as (
		SELCT 
			c.city_name,
			row_number() over (order by c.city_name) ascending,
			row_number() over (order by c.city_name desc) descending
		FROM shipping.city c
		OREDR BY c.city_name
		  )
SELECT
	r.city_name
FROM
	rownums r 
WHERE
	r.ascending = 1 OR r.descending = 1;



ЗАДАНИЕ 90.
Попрактикуемся в использовании общего окна для нескольких функций. 
Выведите результат ранжирования клиентов по годовой выручке 
по убыванию функциями: row_number, rank, dense_rank, используя общее окно. 
Столбцы в выдаче: cust_name, row_number, rank, dense_rank, annual_revenue. 
Сортировка по annual_revenue по убыванию.

SELECT
	c.cust_name,
	row_number() over my_window,
	rank() over my_window,
	dense_rank() over my_window,
	c.annual_revenue
FROM shipping.customer c
WINDOW my_window AS (order by annual_revenue desc)




ЗАДАНИЕ 91.
Сравните кол-во доставок в первый и последний месяц. 
Посчитайте два dense_rank (по убыванию и возрастанию) и количество доставок.

SELECT
	t.mn,
	t.qty
FROM  (
	SELECT distinct 
		date_trunc('month', s.ship_date) mn,
		count(s.ship_id) over (partition by date_trunc('month', s.ship_date)) qty,
		dense_rank() over (order by date_trunc('month', s.ship_date)) ascend,
		dense_rank() over (order by date_trunc('month', s.ship_date) desc) descend
	FROM shipping.shipment s
	ORDER BY 1
	  ) t 
WHERE  t.ascend = 1  OR  t.descend = 1;



ЗАДАНИЕ 92.
Представим, что мы хотим оценить и сравнить самых «богатых» и самых «бедных» клиентов по выручке. 
Напишите запрос, который выведет трех лидеров и трех аутсайдеров по выручке, их количество доставок 
и средний вес доставки. Столбцы в выдаче: cust_name — имя клиента, annual_revenue — годовая выручка
ship_qty — количество доставок на клиента, avg_weight — средний вес доставки
Сортировка по annual_revenue по убыванию.

SELECT
	distinct a.cust_name, 
	a.annual_revenue,
	a.ship_qty,
	a.avg_weight

FROM  ( 
	SELECT
		c.cust_name, 
		c.annual_revenue,
		count(s.ship_id) over(partition by c.cust_id) as ship_qty,
		avg(s.weight) over(partition by c.cust_id) as avg_weight,
		dense_rank() over(order by c.annual_revenue) as ascending,
		dense_rank() over(order by c.annual_revenue desc) as descending
	FROM shipping.customer c 
	   join shipping.shipment s on c.cust_id = s.cust_id
	ORDER BY 2 
	   ) a  
WHERE a.ascending between 1 and 3  
	OR  a.descending between 1 and 3 
OREDR BY a.annual_revenue DESC;



ЗАДАНИЕ 93.
Выведите кумулятивное число доставок по месяцам.

SELECT
	distinct 
	  date_trunc('month',ship_date) mn,
	  count(*) over (order by date_trunc('month',ship_date) ) shipments_cumulative
FROM shipping.shipment
ORDER BY  1;



ЗАДАНИЕ 94.
Давайте оценим конверсию из добавления в корзину в покупку. 
Напишите запрос, который выведет коверсию из события addtocart в transaction по дням, 
а также выведите общее число заказов. Столбцы в выдаче: dt — дата события, 
conv — конверсия из корзины в покупку, orders_cnt — количество заказов
Сортировка по дате по возрастанию. Столбец с датой необходимо привести к типу date.

SELECT
	date_trunc('day', el.event_datetime)::date dt,
	count(distinct case when el.event_name = 'transaction' then el.client_id end) * 1.0  / 
		nullif(count(distinct case when el.event_name = 'addtocart' then el.client_id end), 0) conv,
	count(distinct el.order_id) orders_cnt
FROM webevents.event_log el   
GROUP BY 1
ORDER BY 1; 



ЗАДАНИЕ 95.
Давайте посмотрим в динамике на соотношение событий каждого типа — обычное и накопленное. 
Напишите запрос, который выведет количество открытий товаров, добавлений в корзину, 
оформлений заказов в разбивке по месяцам, а также кумулятивно эти метрики. 
Столбцы в выдаче: dt — дата первого дня месяца события, 
views, carts, orders — 3 столбца, которые содержат количество событий view, addtocart, transaction соответственно в этот месяц
столбцы views_cumulative, carts_cumulative, orders_cumulative, в которых будут те же значения, но с накоплением
Сортировка по месяцу по убыванию. Столбец с датой необходимо привести к типу date.

SELECT
	date_trunc('month', el.event_datetime)::date as dt,
	count(case when el.event_name = 'view' then el.event_name end) 
		over (partition by date_trunc('month', el.event_datetime))  as  views,
	count(case when el.event_name = 'addtocart' then el.event_name end)
		over (partition by date_trunc('month', el.event_datetime))  as  carts,
	count(case when el.event_name = 'transaction' then el.event_name end) 
		over (partition by date_trunc('month', el.event_datetime))  as  orders,
	count(case when el.event_name = 'view' then el.event_name end) 
		over (order by date_trunc('month', el.event_datetime))  as  views_cumulative,
	count(case when el.event_name = 'addtocart' then el.event_name end) 
		over (order by date_trunc('month', el.event_datetime))  as  carts_cumulative,
	count(case when el.event_name = 'transaction' then el.event_name end) 
		over (order by date_trunc('month', el.event_datetime))  as  orders_cumulative
FROM webevents.event_log el 
ORDER BY dt DESC;



ЗАДАНИЕ 96.
Вычислим конверсию из события view в событие addtocart.

SELECT	
	date_trunc('month',el.event_datetime) mn,
	count(distinct case when el.event_name = 'addtocart' then el.client_id end) * 1.0 /
	   count(distinct case when el.event_name = 'view' then el.client_id end)  conv
FROM webevents.event_log el
GROUP BY 1;



ЗАДАНИЕ 97.
Найдем среднее время между заказами клиента в сервисе доставок.
(РЕШЕНИЕ С ФУНКЦИЕЙ lead - находит следующее значение в столбце)
/* Функции lead/lag нужны для получения следующих и предыдущих значений выражения в таблице */

WITH gaps as (
		SELECT            
			s.cust_id,
			lead(s.ship_date) over (partition by s.cust_id order by s.ship_date) - s.ship_date diff
		FROM shipping.shipment s
		    )   
SELECT
	c.cust_name,
	avg(g.diff)
FROM gaps g 
   left join shipping.customer c on g.cust_id = c.cust_id
GROUP BY 1;



(РЕШЕНИЕ С ФУНКЦИЕЙ lag - находит предыдущ.значение)

WITH gaps as (
		SELECT
			s.cust_id,
			s.ship_date - lag (s.ship_date) over (partition by s.cust_id order by s.ship_date) diff
		FROM shipping.shipment s
		    )
SELECT
	c.cust_name,
	avg(g.diff)
FROM gaps g 
   left join shipping.customer c on g.cust_id = c.cust_id
GROUP BY 1;


