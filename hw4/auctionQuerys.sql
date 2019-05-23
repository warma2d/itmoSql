/*
База данных фирмы, проводящей аукционы.
Фирма занимается продажей с аукциона антикварных изделий и произведений искусства.
Владельцы вещей, выставляемых на проводимых фирмой аукционах, юридически являются продавцами.
Лица, приобретающие эти вещи, именуются покупателями. 
Получив от продавцов партию предметов, фирма решает, 
на котором из аукционов выгоднее представить конкретный предмет.
Перед проведением очередного аукциона каждой 
из выставляемых на нем вещей присваивается отдельный номер лота, играющий ту же роль,
что и введенный ранее шифр товара. Две вещи, 
продаваемые на различных аукционах, могут иметь одинаковые номера лотов. 
В книгах фирмы делается запись о каждом аукционе. Там отмечаются дата, место и время
его проведения, а также специфика (например, выставляются картины, написанные маслом и не
ранее 1900г.). Заносятся также сведения о каждом продаваемом предмете: аукцион, на который он заявлен, номер лота, продавец, отправная цена
и краткое словесное описание.
Продавцу разрешается выставлять любое количество вещей, а покупатель имеет право приобретать любое количество вещей. 
Одно и то же лицо или фирма может выступать и как продавец, и как покупатель.
После аукциона служащие фирмы, проводящей аукционы, записывают фактическую цену, уплаченную за проданный предмет, и фиксируют
данные покупателя.
Создать пакет, состоящий из процедур и функций (или простые запросы), позволяющий осуществить следующие операции:
*/


/*1. для указанного интервала дат вывести список аукционов с указанием наименования, даты и места проведения;*/
SELECT a.specifics, a.datetime, p.name
FROM auction a
INNER JOIN place p ON p.id=a.place_id
WHERE a.datetime >= '2019-03-25' AND a.datetime <= '2019-05-15'


/*2. добавить на указанный пользователем аукцион на продажу предмет искусства с указанием начальной цены; */
INSERT INTO `item` (`description`) VALUES('Гантель 10кг');

INSERT INTO `lot` (`seller_id`, `start_price`, `item_id`, auction_id, lot_id)
VALUES(2, '2000', 9, 2, 4);

/*3. вывести список аукционов, с указанием суммарного дохода от продажи, отсортированных по доходу;*/
SELECT a.id, a.specifics, 
(
	SELECT SUM(start_price) 
    FROM lot 
    WHERE auction_id = a.id
) AS income
FROM auction a
GROUP BY a.id
ORDER BY income

/*4. для указанного интервала дат, вывести список предметов, которые были проданы на аукционах в этот период времени;*/
SELECT i.description
FROM item i
INNER JOIN lot l ON l.item_id=i.id
INNER JOIN auction a ON a.id=l.auction_id
WHERE a.datetime >= '2019-03-25' AND a.datetime <= '2019-05-15'



/*5. предоставить возможность добавления факта продажи на указанном аукционе заданного предмета;*/
UPDATE `lot` SET final_price = 70000, customer_id = 1
WHERE auction_id = 2 AND lot_id = 1

/*6. для указанного интервала дат 
вывести список продавцов с указанием общей суммы, 
полученной от продажи предметов в этот промежуток времени;*/
SELECT DISTINCT m.id, 
(
	SELECT SUM(l2.start_price) 
    FROM lot l2
    INNER JOIN auction a2 ON l2.auction_id = a2.id 
    WHERE seller_id = m.id
    AND a2.id = l.auction_id
) AS sum
FROM man m
INNER JOIN lot l ON l.seller_id = m.id
INNER JOIN auction a ON a.id = l.auction_id
WHERE DATE(a.datetime) = '2019-05-23';

/* 7. вывести список покупателей, которые сделали приобретения в указанный интервал дат; */
SELECT m.id
FROM man m
INNER JOIN lot l ON l.customer_id = m.id
INNER JOIN auction a ON a.id = l.auction_id
WHERE DATE(a.datetime) = '2019-05-10'
AND m.id > 0


/*8. предоставить возможность добавления записи о проводимом аукционе (место, время);*/
INSERT INTO auction (`datetime`, `specifics`, place_id) VALUES('2019-06-25 13:00', 'Июньский аукцион', 2);

/*9. для указанного места, вывести список аукционов;*/
SELECT a.id, a.specifics
FROM auction a
INNER JOIN place p ON p.id=a.place_id
WHERE a.place_id=2;

/*10. для указанного интервала дат вывести список продавцов, 
которые принимали участие в аукционах, 
проводимых в этот период времени;*/
SELECT DISTINCT m.id
FROM man m
INNER JOIN lot l ON l.seller_id = m.id
INNER JOIN auction a ON a.id = l.auction_id
WHERE DATE(a.datetime) = '2019-05-10'
AND m.id > 0

/*11. предоставить возможность добавления и изменения информации о продавцах и покупателях;*/
UPDATE `man`
SET firstname = 'НовоеИмя'
WHERE id=4;

/*12. вывести список покупателей 
с указанием количества приобретенных предметов в указанный период времени.*/
SELECT DISTINCT m.id, 
(
	SELECT COUNT(*)
	FROM lot l2
	WHERE l2.auction_id = l.auction_id
	AND l2.customer_id = l.customer_id
) as items
FROM man m
INNER JOIN lot l ON l.customer_id = m.id
INNER JOIN auction a ON a.id = l.auction_id
WHERE DATE(a.datetime) = '2019-05-10'
AND m.id > 0