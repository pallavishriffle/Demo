require_relative 'function'

class BookInfo
  include Function

  def initialize(books)
    @books = books
  end


  def book_info
    loop do
      puts "1. Add Book"
      puts "2. Delete Book"
      puts "3. Update Book"
      puts "4. Display All Books"
      puts "5. Exit"
      puts "--------------------------------------"

      choice = validation('Please enter your choice (1-5): ', /^[1-5]$/, 'Invalid choice. Please enter a number between 1 and 5.', 3)
      return if choice.nil?

      case choice.to_i
      when 1
        add_book
      when 2
        delete_book
      when 3
        update_book 
      when 4
        display_all_books
      when 5
        puts "Exiting..."
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end

#====================================*************************=====================================================#
 
def book_with_same_title_and_author_exists?(title, author)
    @books.any? { |b| b.title.downcase == title.downcase && b.author.downcase == author.downcase }
  end

  def add_book
    title = nil
    author = nil
    year = nil

    loop do
      title = validation('Enter book title: ', /^[a-zA-Z\s\-'"]+$/, 'Title cannot be empty. Please enter a valid title.', 3)
      return if title.nil?
      author = validation('Enter book author: ', /^[a-zA-Z\s\-'"]+$/, 'Author cannot be empty. Please enter a valid author name.', 3)
      return if author.nil?
      unless book_with_same_title_and_author_exists?(title, author)
        break
      end
      puts "A book with the same title and author already exists."
    end

    year = validation('Enter publication year: ', /^\d{4}$/, 'Invalid year. Please enter a valid publication year.', 3)
    return if year.nil?

    book = Book.new(title, author, year.to_i)
    @books << book
    puts 'Book added successfully!'
    display_book
  end
  #====================================*************************=====================================================#
  def display_book
    @books.each do |book|
      puts '--------------------------------------'
      puts "Title: #{book.title}"
      puts "Author: #{book.author}"
      puts "Year: #{book.publication_year}"
      puts '--------------------------------------'
    end
  end
  def display_all_books
    if @books.empty?
      puts "No books available!"
    else
      puts "List of books:"
      display_book
    end
  end
#====================================*************************=====================================================#
def delete_book
    title = validation("Enter book title: ", /\A\S(.*\S)?\z/,"Book title cannot be empty.", 3)
    return if title.nil?

    book = @books.find { |b| b.title == title }

    if book.nil?
      puts "Book not found with the given title."
    else
      @books.delete(book)
      puts "Book deleted successfully!"
      display_book
    end
  end
#====================================*************************=====================================================#  
def update_book
    title = validation("Enter book title: ", /\A\S(.*\S)?\z/,"Book title cannot be empty. Please enter a valid title.", 3)
    return if title.nil?
    book = @books.find { |b| b.title == title }
    if book.nil?
      puts "Book not found with the given title."
    else
      puts "Update Book Information:"
      puts "--------------------------------------"
      puts "Current Title: #{book.title}"
      puts "Current Author: #{book.author}"
      puts "Current Publication Year: #{book.publication_year}"
      puts "--------------------------------------"

      new_title = validation("Enter new title: ", /\A\S(.*\S)?\z/,"New title cannot be empty.", 3)
      return if new_title.nil?
      new_author = validation("Enter new author: ", /\A\S(.*\S)?\z/,"New author cannot be empty.", 3)
      return if new_author.nil?
      new_year = validation("Enter new publication year: ", /^\d+$/,"Invalid year.", 3)
      return if new_year.nil?

      if !new_title.nil? && !new_author.nil? && !new_year.nil?
        book.title = new_title
        book.author = new_author
        book.publication_year = new_year.to_i
        puts "Book information updated successfully!"
        display_book
      else
        puts "Failed to update book information."
      end
    end
  end
end
