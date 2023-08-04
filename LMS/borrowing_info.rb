require 'date'
require_relative 'function'
require_relative 'borrowing' 

class BorrowingInfo
  include Function

  def initialize(books, borrowers, borrowings)
    @books = books
    @borrowers = borrowers
    @borrowings = borrowings
  end

  def manage_borrowing
    book = find_book_by_title
    return if book.nil?

    borrower = find_borrower_by_name
    return if borrower.nil?

    return_date = validation('Enter return date (YYYY-MM-DD): ', /^(19|20)\d\d-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/, 'Invalid date format. Please enter a valid date (YYYY-MM-DD).', 3)

    if return_date.nil?
      puts "Please enter a valid return date."
      return
    end

    if Date.parse(return_date) > Date.today
      puts "Check-out for upcoming dates..."
    else
      borrowing = Borrowing.new(book, borrower, return_date)
      @borrowings << borrowing
      puts 'Book checked out successfully!'
    end
  end

  def find_book_by_title
    title = validation('Enter book title: ', /\A\S(.*\S)?\z/,'Please enter a valid title.', 3)
    return nil if title.nil?
    book = @books.find { |b| b.title == title }

    if book.nil?
      puts 'Book not found with the given title.'
      return nil
    end
    book
  end

  def find_borrower_by_name
    name = validation('Enter borrower name: ', /\A\S(.*\S)?\z/,'Please enter a valid name.', 3)
    return nil if name.nil?
    borrower = @borrowers.find { |b| b.name == name }

    if borrower.nil?
      puts 'Borrower not found with the given name.'
      return nil
    end
    borrower
  end
end
