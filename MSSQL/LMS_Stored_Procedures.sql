/*  Final query statements for creation of stored procedures followed by example of procedure execution
    to fullfill the query for each question.
*/

USE db_library
GO
CREATE PROCEDURE dbo.usp_GetBranchBookCopies @BookTitle nvarchar(50) = NULL, @LibraryBranch nvarchar(50) = NULL
AS
SELECT a1.branchName AS 'Library Branch', a2.title AS 'Book Title', a3.numberOfCopies AS 'Number of Copies'
FROM tbl_library_branch a1
	INNER JOIN tbl_book_copies a3 ON a3.branchID = a1.branchID
	INNER JOIN tbl_books a2 ON a2.bookID = a3.bookID
WHERE a2.title = ISNULL(@BookTitle, a2.title) AND a1.branchName = ISNULL(@LibraryBranch, a1.branchName)
GO

/*  To retrieve: 1. How many copies of the book titled "The Lost Tribe" are owned by the library branch
    whose name is "Sharpstown,"  execute usp_GetBranchBookCopies specifying "Sharpstown" as the library
	branch and supply the book title.
*/

EXEC [dbo].[usp_GetBranchBookCopies] @BookTitle = 'The Lost Tribe', @LibraryBranch = 'Sharpstown'

/*  To find:  2. The number of copies of the book titled "The Lost Tribe" that are owned by each library
    branch, execute usp_GetBranchBookCopies as above, but without specifying a library branch."
*/

EXEC [dbo].[usp_GetBranchBookCopies] @BookTitle = 'The Lost Tribe'



USE db_library
GO
CREATE PROCEDURE dbo.usp_LoanFreePatrons
AS
SELECT tbl_borrower.name AS 'Patron Names Without Loans'
FROM tbl_borrower
WHERE NOT EXISTS
(SELECT *
	FROM tbl_book_loans 
	WHERE tbl_borrower.cardNo = tbl_book_loans.cardNo);
GO

/*  To retrieve:  3. The names of all borrowers who do not have any books checked out use usp_LoanFreePatrons.
*/

EXEC [dbo].[usp_LoanFreePatrons]



USE db_library
GO
CREATE PROCEDURE dbo.usp_GetBooksDue @LibraryBranch nvarchar(50) = NULL, @TodaysDate nvarchar(20) = NULL
AS
SELECT a1.branchName AS 'Library Branch', a2.dateDue AS 'Due Date', a4.title AS 'Book Title', a3.name AS 'Borrower''s Name', a3.address AS 'Borrower''s Address'
FROM tbl_library_branch a1
	INNER JOIN tbl_book_loans a2 ON a2.branchID = a1.branchID
	INNER JOIN tbl_borrower a3 ON a3.cardNo = a2.cardNo
	INNER JOIN tbl_books a4 ON a4.bookID = a2.bookID
WHERE a2.dateDue = ISNULL(@TodaysDate, a2.dateDue) AND a1.branchName = ISNULL(@LibraryBranch, a1.branchName)
GO

/*  To retrieve:  4. The book title and borrower's name and address for every book loaned out from the "Sharpstown"
    library branch which is due on a given date, execute usp_GetBooksDue and supply the library branch and
	today's date (mm/dd/yyyy) as below:
*/

EXEC [dbo].[usp_GetBooksDue] @LibraryBranch = 'Sharpstown', @TodaysDate = '12/28/2018'



USE db_library
GO
CREATE PROCEDURE dbo.usp_GetTotalBookLoans
AS
SELECT a1.branchName AS 'Library Branch', COUNT(a2.branchID) AS 'Total Books Loaned Out'
FROM tbl_book_loans a2
	INNER JOIN tbl_library_branch a1 ON a1.branchID = a2.branchID
WHERE a1.branchID = a2.branchID
GROUP BY a1.branchName
GO

/*  To retrieve:  5. The branch name and the total number of books loaned out from each library branch,
    execute usp_GetTotalBookLoans.
*/

EXEC [dbo].[usp_GetTotalBookLoans]



USE db_library
GO
CREATE PROCEDURE dbo.usp_GetBigBorrowers
AS
SELECT a1.name AS 'Borrower Name', a1.address AS 'Borrower Address', COUNT(a2.cardNo) AS 'Number of Books Checked Out'
FROM tbl_book_loans a2
	INNER JOIN tbl_borrower a1 ON a1.cardNo = a2.cardNo
WHERE a1.cardNo = a2.cardNo
GROUP BY a1.name, a1.address
HAVING COUNT(a2.cardNo) > 5;
GO

/*  To retrieve:  6. The names, addresses, and number of books checked out for all borrowers who have more than
    five books checked out, execute usp_GetBigBorrowers.
*/

EXEC [dbo].[usp_GetBigBorrowers]



USE db_library
GO
CREATE PROCEDURE dbo.usp_GetBooksByAuthor @Author nvarchar(40) = NULL, @LibraryBranch nvarchar(50) = NULL
AS
SELECT a1.branchName AS 'Library Branch', a2.authorName AS 'Author', a3.title AS 'Book Title', a4.numberOfCopies AS 'Number of Copies at Branch'
FROM tbl_library_branch a1
	INNER JOIN tbl_book_copies a4 ON a4.branchID = a1.branchID
	INNER JOIN tbl_books a3 ON a3.bookID = a4.bookID
	INNER JOIN tbl_book_authors a2 ON a2.bookID = a3.bookID
WHERE a2.authorName = ISNULL(@Author, a2.authorName) AND a1.branchName = ISNULL(@LibraryBranch, a1.branchName)
GO

/*  To retrieve:  7. The title and number of copies for each book authored (or co-authored) by "Stephen King,"
    owned by the "Central" library branch, execute usp_GetBooksByAuthor and specify the library branch and 
	author as below:
*/

EXEC [dbo].[usp_GetBooksByAuthor] @LibraryBranch = 'Central', @Author = 'Stephen King'