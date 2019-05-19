CREATE TABLE `backupBook` (
`idbook` int(11) NOT NULL AUTO_INCREMENT,
`title` varchar(45) NOT NULL,
`price` decimal(10,0) NOT NULL,
`author` varchar(45) NOT NULL,
PRIMARY KEY (`idbook`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8


INSERT INTO backupBook (`idbook`, `title`, `price`, `author`)
SELECT `idbook`, `title`, `price`, `author` 
FROM `book`;



/*Error Code: 1175. 
You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
*/
SET SQL_SAFE_UPDATES = 0;

DELETE
FROM backupBook
WHERE idbook IN 
(
	SELECT bookId FROM book_stat WHERE bookCount > 5
);