class Borrowing
    attr_accessor :book, :borrower, :return_date
  
    def initialize(book, borrower, return_date)
      @book = book
      @borrower = borrower
      @return_date = return_date
    end
  end
