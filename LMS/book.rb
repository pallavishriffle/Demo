class Book
    attr_accessor :title, :author, :publication_year, :availability
  
    def initialize(title, author, publication_year)
      @title = title
      @author = author
      @publication_year = publication_year
      @availability = true
    end
  end
  