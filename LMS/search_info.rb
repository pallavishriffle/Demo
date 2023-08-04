class SearchInfo
  include Function

  def initialize(books)
    @books = books
  end


  def search_info
    loop do
      puts "1. Search Book by Title"
      puts "2. Search Book by Author"
      puts "3. Exit"
      puts "--------------------------------------"

      choice = validation('Please enter your choice (1-3): ', /^[1-3]$/, 'Invalid choice. Please enter a number between 1 and 3.', 3)
      return if choice.nil?

      case choice.to_i
      when 1
        search_book_by_title
      when 2
        search_book_by_author
      when 3
        puts "Exiting..."
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end

  def search_book_by_title
    title = validation('Enter book title: ', /^[a-zA-Z\s\-'"]+$/, 'Please enter a valid title.', 3)
    return if title.nil?

    matching_books = @books.select { |book| book.title.downcase.include?(title.downcase) }
    display_search_results(matching_books, title, 'title')
  end

  def search_book_by_author
    author = validation('Enter book author: ', /^[a-zA-Z\s\-'"]+$/, ' Please enter a valid author name.', 3)
    return if author.nil?

    matching_books = @books.select { |book| book.author.downcase.include?(author.downcase) }
    display_search_results(matching_books, author, 'author')
  end

  def display_search_results(books, search_term, search_type)
    if books.empty?
      puts "No books found with #{search_type} containing '#{search_term}'."
    else
      puts "Search results for #{search_type}: '#{search_term}'"
      display_book(books)
    end
  end

  def display_book(books)
    books.each do |book|
      puts '--------------------------------------'
      puts "Title: #{book.title}"
      puts "Author: #{book.author}"
      puts "Year: #{book.publication_year}"
      puts '--------------------------------------'
    end
  end
end
