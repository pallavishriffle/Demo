require_relative 'borrower'
require_relative 'function'

class BorrowerInfo
  include Function

  def initialize(borrowers)
    @borrowers = borrowers
  end
  def borrower_info
    loop do
      puts "1. Add Borrower"
      puts "2. Delete Borrower"
      puts "3. Update Borrower"
      puts "4. Display All Borrowers"
      puts "5. Exit"
      puts "--------------------------------------"

      choice = validation('Please enter your choice (1-5): ', /^[1-5]$/, 'Invalid choice. Please enter a number between 1 and 5.', 3)
      return if choice.nil?

      case choice.to_i
      when 1
        add_borrower
      when 2
        delete_borrower
      when 3
        update_borrower
      when 4
        display_all_borrowers
      when 5
        puts "Exiting..."
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end
#====================================*************************=====================================================#
  def add_borrower
    name = validation('Enter borrower name: ', /^[a-zA-Z\s\-'"]+$/,'Borrower name cannot be empty. Please enter a valid name.', 3)
    return if name.nil?
    
    contact_information = validation('Enter email address: ', /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, 'Invalid email address. Please enter a valid email.', 3)
    return if contact_information.nil?
  
    borrower = Borrower.new(name, contact_information)
    @borrowers << borrower
    puts 'Borrower added successfully!'
  end  
#====================================*************************=====================================================#
  def display_borrower
    @borrowers.each do |borrower|
      puts '--------------------------------------'
      puts "Borrower Name: #{borrower.name}"
      puts "Contact: #{borrower.contact_information}"
      puts '--------------------------------------'
    end
  end

  def display_all_borrowers
    if @borrowers.empty?
      puts "No borrowers available!"
    else
      puts "List of borrowers:"
      display_borrower
    end
  end
#====================================*************************=====================================================#
  def delete_borrower
    name = validation("Enter borrower name: ", /\A\S(.*\S)?\z/,"Borrower name cannot be empty.", 3)
    return if name.nil?

    borrower = @borrowers.find { |b| b.name == name }

    if borrower.nil?
      puts "Borrower not found with the given name."
    else
      @borrowers.delete(borrower)
      puts "Borrower deleted successfully!"
      display_borrower
    end
  end
#====================================*************************=====================================================#
  def update_borrower
    name = validation("Enter borrower name: ", /\A\S(.*\S)?\z/,"Name cannot be empty. Please enter a valid name.", 3)
    return if name.nil?
    borrower = @borrowers.find { |b| b.name == name }
    if borrower.nil?
      puts "Borrower not found with the given name."
    else
      puts "Update Borrower Information:"
      puts "--------------------------------------"
      puts "Current Borrower Name: #{borrower.name}"
      puts "Current Contact: #{borrower.contact_information}"
      puts "--------------------------------------"

      new_name = validation("Enter Borrower name: ", /\A\S(.*\S)?\z/,"New Borrower cannot be empty.", 3)
      return if new_name.nil?
      new_contact = validation('Enter email address: ', /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, 'Invalid email address.', 3)
      return if new_contact.nil?

      if !new_name.nil? && !new_contact.nil? 
        borrower.name = new_name
        borrower.contact_information = new_contact
        puts "Borrower information updated successfully!"
        display_borrower
      else
        puts "Failed to update borrower information."
      end
    end
  end
end
