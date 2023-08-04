class Overdue
    def initialize(borrowings)
      @borrowings = borrowings
    end
  
    def check_overdue_books
      today = Date.today
      overdue_borrowings = @borrowings.select { |borrowing| Date.parse(borrowing.return_date) <= today }
  
      if overdue_borrowings.empty?
        puts 'No overdue books.'
      else
        puts 'Overdue Books:'
  
        overdue_borrowings.each do |borrowing|
          return_date = Date.parse(borrowing.return_date)
  
          next if return_date > today
  
          book = borrowing.book
          borrower = borrowing.borrower
  
          puts '------------------------------------------'
          puts "Title: #{book.title}", "Borrower: #{borrower.name}","Return Date: #{borrowing.return_date} (Already Checked Out)"
          puts '------------------------------------------'
        end
      end
    end
  end
  