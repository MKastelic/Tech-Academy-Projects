/*  Database/table creation code and INSERT statements for FINAL PROJECT - LIBRARY MANAGEMENT SYSTEM  */

CREATE DATABASE db_library

USE db_library
CREATE TABLE tbl_library_branch (
	branchID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	branchName VARCHAR(50) NOT NULL,
	address VARCHAR(75) NOT NULL
	);

CREATE TABLE tbl_publisher (
	publisherName VARCHAR(50) NOT NULL PRIMARY KEY,
	address VARCHAR(75) NOT NULL,
	phone CHAR(15)
	);

CREATE TABLE tbl_books (
	bookID INT NOT NULL PRIMARY KEY IDENTITY (100, 1),
	title VARCHAR(100) NOT NULL,
	publisherName VARCHAR(50) NOT NULL CONSTRAINT fk_publisher_publisherName FOREIGN KEY REFERENCES tbl_publisher(publisherName) ON UPDATE CASCADE ON DELETE CASCADE
	);

CREATE TABLE tbl_book_authors (
	bookID INT NOT NULL CONSTRAINT fk_books_bookID FOREIGN KEY REFERENCES tbl_books(bookID) ON UPDATE CASCADE ON DELETE CASCADE,
	authorName VARCHAR(40) NOT NULL
	);

CREATE TABLE tbl_book_copies (
	bookID INT NOT NULL CONSTRAINT fk_books_bookID2 FOREIGN KEY REFERENCES tbl_books(bookID) ON UPDATE CASCADE ON DELETE CASCADE,
	branchID INT NOT NULL CONSTRAINT fk_library_branch_branchID FOREIGN KEY REFERENCES tbl_library_branch(branchID) ON UPDATE CASCADE ON DELETE CASCADE,
	numberOfCopies INT NOT NULL
	);

CREATE TABLE tbl_borrower (
	cardNo INT NOT NULL PRIMARY KEY,
	name VARCHAR(40) NOT NULL,
	address VARCHAR(75),
	phone CHAR(15)
	);

CREATE TABLE tbl_book_loans (
	bookID INT NOT NULL CONSTRAINT fk_books_bookID3 FOREIGN KEY REFERENCES tbl_books(bookID) ON UPDATE CASCADE ON DELETE CASCADE,
	branchID INT NOT NULL CONSTRAINT fk_library_branch_branchID2 FOREIGN KEY REFERENCES tbl_library_branch(branchID) ON UPDATE CASCADE ON DELETE CASCADE,
	cardNo INT NOT NULL CONSTRAINT fk_orrower_cardNo FOREIGN KEY REFERENCES tbl_borrower(cardNo) ON UPDATE CASCADE ON DELETE CASCADE,
	dateOut CHAR(20) NOT NULL,
	dateDue CHAR(20) NOT NULL
	);

INSERT INTO tbl_library_branch
	(branchName, address)
	VALUES
	('Hillsboro Brookwood', '2850 NE Brookwood Pkwy, Hillsboro, OR  97124-5327'),
	('Hillsboro Shute Park', '775 SE 10th Ave., Hillsboro, OR  97123-4784'),
	('Sharpstown', '123 Main Street, Hillsboro, OR 97123'),
	('Central', '845 South Central Blvd., Hillsboro, OR 97124'),
	('North Plains', '31334 NW Commercial St., North Plains, OR 97133-6215'),
	('Aloha', '17455 SW Farmington Rd., Ste. 26A, Aloha, OR 97078')
	;

INSERT INTO tbl_publisher
	(publisherName, address, phone)
	VALUES
	('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020', '212-698-7000'),
	('Penguin Books USA', '375 Hudson Street, New York, NY  10014', ''),
	('The Perseus Book Group', '2300 Chestnut Street, Suite 200, Philadelphia, PA  19103', '800-810-4145'),
	('Princeton University Press', '41 William Street, Princeton, NJ 08540', ''),
	('ECW Press', '2120 Queen Street East, Suite 200, Toronto, Ontario, Canada M4E 1E2', ''),
	('Andrews McMeel Publishing, LLC', '1130 Walnut Street, Kansas City, MO  64106', ''),
	('Henry Holt & Co', '175 Fifth Avenue, New York, NY  10010', '646-307-5095'),
	('O''Reilly', '1005 Gravenstein Highway North, Sebastopol, CA  95472', '707-827-7000'),
	('Bantam Books', '666 Fifth Avenue, New York, NY  10103', ''),
	('Manning Publications Co', '20 Baldwin Road, PO Box 761, Shelter Island, NY 11964', ''),
	('Oxford University Press', '198 Madison Avenue, New York, NY  10016', '')
	;

INSERT INTO tbl_books
	(title, publisherName)
	VALUES
	('How to tell if your Cat is plotting to kill you', 'Andrews McMeel Publishing, LLC'),
	('Traveling Music', 'ECW Press'),
	('Ghost Rider:  Travels on the Healing Road', 'ECW Press'),
	('The Masked Rider:  Cycling in West Africa', 'ECW Press'),
	('ATOM:  Journey Across The Subatomic Cosmos', 'Penguin Books USA'),
	('The Periodic Table', 'Penguin Books USA'),
	('QED:  The Strange Theory of Light and Matter', 'Princeton University Press'),
	('The Strangest Man:  The Hidden Life of Paul Dirac, Mystic of the Atom', 'The Perseus Book Group'),
	('The Lost Tribe', 'Henry Holt & Co'),
	('Carrie', 'Simon & Schuster'),
	('Pet Sematary', 'Simon & Schuster'),
	('Teach Yourself C++', 'Henry Holt & Co'),
	('Python Cookbook', 'O''Reilly'),
	('Deep Learning with Python', 'Manning Publications Co'),
	('The Hitchhiker''s guide to Python:  best practices for development', 'O''Reilly'),
	('Elegant sciPy:  the art of scientific Python', 'O''Reilly'),
	('Flask web development:  developing web applications with Python', 'O''Reilly'),
	('Building maintainable software:  ten guidelines for future-proof code', 'O''Reilly'),
	('Fluent Python', 'O''Reilly'),
	('Introducing Python', 'O''Reilly'),
	('High performance Python', 'O''Reilly'),
	('Python in a nutshell', 'O''Reilly'),
	('Neutrino', 'Oxford University Press'),
	('In Search of Schrodinger''s Cat', 'Bantam Books')
	;

INSERT INTO tbl_book_authors
	(bookID, authorName)
	VALUES
	(107, 'Graham Farmelo'),
	(106, 'Richard P. Feynman'),
	(122, 'Frank Close'),
	(105, 'Primo Levi'),
	(104, 'Isaac Asimov'),
	(111, 'Al Stevens'),
	(101, 'Neil Peart'),
	(102, 'Neil Peart'),
	(103, 'Neil Peart'),
	(100, 'Matthew Inman'),
	(123, 'John Gribbin'),
	(109, 'Stephen King'),
	(110, 'Stephen King'),
	(108, 'Edward Marriott'),
	(112, 'David M. Beazley'),
	(113, 'Francois Chollet'),
	(114, 'Kenneth Reitz'),
	(115, 'Juan Nunex-Iglesias'),
	(116, 'Miguel Grinberg'),
	(117, 'Joost Visser'),
	(118, 'Luciano Ramalho'),
	(119, 'Bill Lubanovic'),
	(120, 'Micha Gorelick'),
	(121, 'Alex Martlli')
	;

INSERT INTO tbl_book_copies
	(bookID, branchID, numberOfCopies)
	VALUES
	(100, 1, 2),
	(108, 3, 1),
	(109, 4, 1),
	(110, 4, 2),
	(105, 1, 3),
	(109, 1, 2),
	(113, 1, 2),
	(118, 1, 2),
	(119, 1, 3),
	(120, 1, 2),
	(121, 1, 2),
	(122, 1, 2),
	(123, 1, 2),
	(100, 2, 2),
	(101, 2, 2),
	(103, 2, 2),
	(104, 2, 3),
	(106, 2, 2),
	(107, 2, 2),
	(108, 2, 2),
	(110, 2, 2),
	(111, 2, 2),
	(114, 2, 2),
	(123, 2, 2),
	(123, 3, 2),
	(122, 3, 2),
	(121, 3, 2),
	(120, 3, 2),
	(115, 3, 2),
	(114, 3, 2),
	(113, 3, 2),
	(112, 3, 2),
	(111, 3, 2),
	(110, 3, 2),
	(101, 4, 2),
	(102, 4, 2),
	(103, 4, 2),
	(112, 4, 2),
	(117, 4, 2),
	(119, 4, 2),
	(122, 4, 2),
	(123, 4, 2),
	(100, 4, 2),
	(102, 5, 2),
	(106, 5, 2),
	(107, 5, 2),
	(109, 5, 2),
	(111, 5, 2),
	(114, 5, 2),
	(116, 5, 2),
	(118, 5, 2),
	(120, 5, 2),
	(122, 5, 2),
	(100, 6, 3),
	(101, 6, 3),
	(103, 6, 2),
	(108, 6, 2),
	(107, 6, 2),
	(111, 6, 2),
	(112, 6, 2),
	(113, 6, 2),
	(114, 6, 2),
	(117, 6, 2),
	(119, 6, 2)
	;

INSERT INTO tbl_borrower
	(cardNo, name, address, phone)
	VALUES
	(222222, 'Mark Kastelic', '2 Hanson Drive, Granite City, IL', ''),
	(211221, 'Geddy Lee', '2112 Mercury Drive, Toronto, Canada', ''),
	(211212, 'Alex Lifeson', '2112 Lakeside Park Ave, Toronto, Canada', ''),
	(000002, 'Stephen Hawking', '110 Stellar Street, Cambridge, England', ''),
	(111777, 'Gerry Wiley', '1 Civic Center Drive, Hillsboro, OR', ''),
	(100001, 'Vera Katz', '1511 SW Park Ave Apt 901, Portland, OR', ''),
	(666666, 'Donald J. Trump', '1600 Pennsylvania Ave. NW, Washington DC  20500', ''),
	(808600, 'Andy Grove', '8086 Fairchild Lane, San Jose, CA', ''),
	(101010, 'Erik Gross', '310 SW 4th Ave Suite 230, Portland, OR', '')
	;

INSERT INTO tbl_book_loans
	(bookID, branchID, cardNo, dateOut, dateDue)
	VALUES
	(100, 1, 666666, '12/07/2018', '12/28/2018'),
	(100, 1, 666666, '12/10/2018', '12/31/2018'),
	(100, 2, 666666, '12/07/2018', '12/28/2018'),
	(100, 4, 666666, '12/07/2018', '12/28/2018'),
	(100, 6, 666666, '12/09/2018', '12/30/2018'),
	(100, 6, 666666, '12/07/2018', '12/28/2018'),
	(108, 2, 666666, '12/07/2018', '12/28/2018'),
	(108, 3, 666666, '12/07/2018', '12/28/2018'),
	(108, 6, 666666, '12/07/2018', '12/28/2018'),
	(109, 5, 666666, '12/07/2018', '12/28/2018'),
	(110, 2, 666666, '12/07/2018', '12/28/2018'),
	(113, 3, 666666, '12/07/2018', '12/28/2018'),
	(114, 3, 666666, '12/07/2018', '12/28/2018'),
	(115, 3, 666666, '12/07/2018', '12/28/2018'),
	(120, 3, 666666, '12/07/2018', '12/28/2018'),
	(121, 3, 666666, '12/07/2018', '12/28/2018'),
	(122, 3, 666666, '12/07/2018', '12/28/2018'),
	(123, 3, 666666, '12/07/2018', '12/28/2018'),
	(106, 2, 000002, '12/25/2018', '01/14/2019'),
	(107, 5, 000002, '12/25/2018', '01/14/2019'),
	(122, 1, 000002, '12/25/2018', '01/14/2019'),
	(104, 2, 000002, '12/25/2018', '01/14/2019'),
	(105, 1, 000002, '12/25/2018', '01/14/2019'),
	(111, 2, 000002, '12/25/2018', '01/14/2019'),
	(123, 2, 000002, '12/25/2018', '01/14/2019'),
	(118, 1, 101010, '12/31/2018', '01/21/2019'),
	(111, 5, 101010, '12/31/2018', '01/21/2019'),
	(112, 3, 101010, '12/31/2018', '01/21/2019'),
	(113, 1, 101010, '12/31/2018', '01/21/2019'),
	(114, 3, 101010, '12/31/2018', '01/21/2019'),
	(115, 3, 101010, '12/31/2018', '01/21/2019'),
	(116, 5, 101010, '12/31/2018', '01/21/2019'),
	(117, 4, 101010, '12/31/2018', '01/21/2019'),
	(119, 6, 101010, '12/31/2018', '01/21/2019'),
	(120, 5, 101010, '12/31/2018', '01/21/2019'),
	(121, 3, 101010, '12/31/2018', '01/21/2019'),
	(109, 1, 100001, '12/09/2018', '12/30/2018'),
	(110, 3, 100001, '12/09/2018', '12/30/2018'),
	(100, 6, 100001, '12/09/2018', '12/30/2018'),
	(108, 6, 100001, '12/09/2018', '12/30/2018'),
	(103, 2, 100001, '12/09/2018', '12/30/2018'),
	(101, 4, 211221, '12/12/2018', '01/02/2019'),
	(102, 4, 211221, '12/12/2018', '01/02/2019'),
	(103, 4, 211221, '12/12/2018', '01/02/2019'),
	(111, 2, 222222, '12/14/2018', '01/04/2019'),
	(122, 4, 222222, '12/14/2018', '01/04/2019'),
	(101, 4, 222222, '12/12/2018', '01/02/2019'),
	(102, 4, 222222, '12/12/2018', '01/02/2019'),
	(103, 4, 222222, '12/12/2018', '01/02/2019'),
	(110, 3, 808600, '12/16/2018', '01/06/2019'),
	(111, 6, 808600, '12/19/2018', '01/09/2019')
	;
