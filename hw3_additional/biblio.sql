/*Для указанного филиала, 
определенной книги определить 
доступное количество*/
delimiter $$
CREATE PROCEDURE getQuantity(IN bookId INT, IN storageId INT, OUT availQuantity INT)
BEGIN
	SELECT avail_quantity INTO availQuantity
	FROM book_has_storage bhs
	INNER JOIN book b  ON b.id=bhs.book_id
	INNER JOIN storage s ON s.id=bhs.storage_id
	WHERE bhs.book_id = bookId AND bhs.storage_id = storageId;
END$$
delimiter ;


/*Для указанной книги посчитать 
кол-во факультетов, на которых она 
используется в данном  филиале, 
вывести названия этих факультетов

количествово_факультетов    название_факультета*/

delimiter $$
CREATE PROCEDURE getCount(IN bookId INT, IN storageId INT, OUT str TEXT)
BEGIN
	SELECT COUNT(*) AS count_faculty, f.name INTO str
	FROM faculty_has_book fhb
	INNER JOIN faculty f ON f.id=fhb.faculty_id
	INNER JOIN book b ON b.id=fhb.book_id
	INNER JOIN book_has_storage bhs ON bhs.book_id = b.id
	WHERE fhb.book_id = bookId
	AND bhs.storage_id = storageId
	GROUP BY f.name;
END$$
delimiter ;



/*Добавлять книги*/
delimiter $$
CREATE PROCEDURE addBook(IN title varchar(200), IN publish_year YEAR, IN number_pages INT, IN number_figures INT, IN price DECIMAL, IN publisher_id INT)
BEGIN
	INSERT INTO `book` (`title`, `publish_year`, `number_pages`, `number_figures`, `price`, `publisher_id`)
	VALUES (title, publish_year, number_pages, number_figures, price, publisher_id);
END$$
delimiter ;

/*изменять информацию о книгах в библиотеке*/
delimiter $$
CREATE PROCEDURE editBook(IN columnName varchar(200), IN val varchar(200), IN bookId INT)
BEGIN
	SET @var=CONCAT('UPDATE `book` SET ', columnName, '=\'',val,'\' WHERE id = ',bookId);    
    PREPARE zxc FROM @var;
	EXECUTE zxc;
END$$
delimiter ;

 CALL editBook('title', 'Виктория', 3);

/*Добавить филиал*/
delimiter $$
CREATE PROCEDURE addStorage(IN name varchar(200))
BEGIN
	INSERT INTO `storage` (`name`) VALUES (name);
END$$
delimiter ;


/*изменять информацию о филиалах*/
delimiter $$
CREATE PROCEDURE editStorage(IN name VARCHAR(200), IN id INT)
BEGIN
	SET @var=CONCAT('UPDATE `storage` SET name = \'', name,'\' WHERE id = ', id);    
    PREPARE zxc FROM @var;
	EXECUTE zxc;
END$$
delimiter ;













