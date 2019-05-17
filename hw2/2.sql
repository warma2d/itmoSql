/*Выбрать те товары, которых нет в конкретной корзине*/
SELECT g2.idGood, g2.`name`
FROM good g2
WHERE g2.idGood NOT IN
(
	SELECT g.idGood 
	FROM good g
	INNER JOIN cart_good cg ON cg.idGood = g.idGood
	WHERE cg.idCart = 2
)

/*По 3 конкретным корзинам найти среднее значение чека*/
SELECT AVG(res)
FROM 
(
	SELECT cg.idCart, SUM(cg.amount*g.price) AS res
	FROM cart_good cg
	INNER JOIN good g ON cg.idGood = g.idGood
	WHERE cg.idCart = 1 OR cg.idCart = 2 OR cg.idCart = 3
	GROUP BY cg.idCart
) t1


/*Максимальный и минимальный чек*/
SELECT MIN(res) AS minCheck, MAX(res) AS maxCheck
FROM 
(
	SELECT cg.idCart, SUM(cg.amount*g.price) AS res
	FROM cart_good cg
	INNER JOIN good g ON cg.idGood = g.idGood	
	GROUP BY cg.idCart
) t1