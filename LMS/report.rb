class Report
    def initialize(books, borrowers, borrowings)
      @books = books
      @borrowers = borrowers
      @borrowings = borrowings
    end
  
    def generate_reports
      loop do
        puts "1. Available Books Report"
        puts "2. Borrowed Books Report"
        puts "3. Borrowers' Borrowing History Report"
        puts "4. Exit"
        puts "--------------------------------------"
        print "Please enter your choice: "
        choice = gets.chomp.to_i
  
        case choice
        when 1
          available_books_report
        when 2
          book_report
        when 3
          book_report
        when 4
          puts "Exit..."
          break
        else
          puts "Invalid choice. Please try again."
        end
      end
    end
  

  
    def available_books_report
      puts '--------------------------------------'
      available_books = @books.select { |book| book.availability }
      if available_books.empty?
        puts "No available books."
      else
        available_books.each do |book|
          puts "Title: #{book.title}","Author: #{book.author}","Publication Year: #{book.publication_year}"
          puts '--------------------------------------'
        end
      end
    end
  
    def book_report
      puts '--------------------------------------'
      @borrowers.each do |borrower|
        puts "Borrower: #{borrower.name}"
        borrowing_history = @borrowings.select { |borrowing| borrowing.borrower == borrower }
        if borrowing_history.empty?
          puts "No borrowing history for this borrower."
        else
          borrowing_history.each do |borrowing|
            book = borrowing.book
            puts "Title: #{book.title}", "Author: #{book.author}","Return Date: #{borrowing.return_date || 'Not returned yet'}"
            puts '--------------------------------------'
          end
        end
      end
    end
  end