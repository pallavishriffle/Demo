require_relative 'book'
require_relative 'borrower'
require_relative 'book_info'
require_relative 'borrower_info'
require_relative 'search_info'
require_relative 'borrowing_info'
require_relative 'overdue'
require_relative 'report'

class Library
  def initialize
    @books = []
    @borrowers = []
    @borrowings = []
  end

  def run

    book_info = BookInfo.new(@books)
    borrower_info = BorrowerInfo.new(@borrowers)
    search_info = SearchInfo.new(@books)
    borrowing_info = BorrowingInfo.new(@books, @borrowers, @borrowings)
    overdue = Overdue.new(@borrowings)
    report = Report.new(@books, @borrowers, @borrowings)
    

    loop do
      puts "Library Management System".center(50, " ")
      puts "1. Book Management"
      puts "2. Borrower Management"
      puts "3. Search Book"
      puts "4. Manage Borrowing"
      puts "5. Overdue Books"
      puts "6. Reports"
      puts "7. Exit"
      puts "--------------------------------------"
      print "Please enter your choice: "
      choice = gets.chomp.to_i

      case choice
      when 1
        book_info.book_info
      when 2
        borrower_info.borrower_info
      when 3
        search_info.search_info
      when 4
        borrowing_info.manage_borrowing
      when 5
        overdue.check_overdue_books
      when 6
        report.generate_reports
      when 7
        puts "Exiting..."
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
    puts "--------------------------------------"
  end
end

library = Library.new
library.run
