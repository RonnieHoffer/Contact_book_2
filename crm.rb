# require_relative "contact"
require "./contact"

class CRM

  def initialize(user_name)
    @user_name = user_name
  end

 
  def main_menu
    puts "Welcome, #{@user_name}."
    while true # causes the loop to repeat indefinitely
      puts "\n"     
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end


  def print_main_menu
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Search by attribute"
    puts "[6] Exit"
  end


  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then exit
    end
  end


  def add_new_contact
    print "Enter First Name: "
    first_name = gets.chomp

    print "Enter Last Name: "
    last_name = gets.chomp

    print "Enter Email Address: "
    email = gets.chomp

    print "Enter a Note: "
    note = gets.chomp

    Contact.create(
      first_name:  first_name, 
      last_name:   last_name, 
      email:       email, 
      note:        note
      )
  end


  def modify_existing_contact
    puts "Please enter the contact ID of the contact you would like to modify:"
    id = gets.to_i
    puts "You chosen the following contact: "
    # p unmodified_contact = Contact.find(id)
    puts "Which attribute would you like to update?"
    puts "[1] First name"
    puts "[2] Last name"
    puts "[3] Email address"
    puts "[4] Notes"
    attribute = gets.to_i 
    # print "Please enter the new value: "
    # new_value = gets.chomp
    # modified_contact = unmodified_contact.update(attribute, new_value)
    # puts "Your contact now has the information: "
    # p modified_contact
  end


  def delete_contact
    puts "Please enter the contact ID of the contact you would like to delete:"
    puts "(To delete all contacts, enter 0)"
    id = gets.to_i
    if id == 0
      Contact.delete_all
    else
      puts "You chosen the following contact: "
      p contact_for_deleting = Contact.find(id)
      contact_for_deleting.delete
    end
    puts "Your contact list is now: "
    p Contact.all
  end


  def display_all_contacts
    p Contact.all    
  end


  def search_by_attribute
    puts "By which attribute would you like to search for a contact?"
    puts "[1] First name"
    puts "[2] Last name"
    puts "[3] Email address"
    puts "[4] Notes"
    puts "[5] Contact ID"
    attribute = gets.to_i
    print "Please enter the value of the attribute: "
    value = gets.chomp
    puts "Here is the contact you searched for: "
    if attribute == 5
      p Contact.find(value.to_i)
    else    
      p Contact.find_by(attribute, value)
    end
  end


end

at_exit do
  ActiveRecord::Base.connection.close
end