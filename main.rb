require('./src/Book')
require('./src/User')
require('./src/Library')
require('./utils/input')


library = Library.new
customer_info = {}
is_customer = false

loop do
  puts "================================================"
  puts "welcome to the library!"
  puts "to continue with the process, I need to sign you up as one of our customers"
  print "Do you mind if I do it? (y/n): "

  user_response = input()
  if user_response.eql?("y") && !is_customer
    puts "I am sorry for the inconvinience, here is the catalog of our books"
    puts "so you can later decide to be our customer"
    library.show_catalog
    break
  elsif user_response.eql?("n") && !is_customer
    print "Whats your name? "
    name = input()
    print "Whats your email? "
    email = input()
    customer_info = User.new(name, email)
    is_customer = true
  end


  puts "How can we help you today? (choose the option number you prefere):"
  puts "1. lend a book"
  puts "2. return a book"
  puts "3. add new book to library"
  print "(select): "
  option = input()
  puts

  if option.eql? "1"
    library.show_catalog
    print "What book do you want to choose?: "
    book = input()
    library.lend_book(book, customer_info)
    puts
  elsif option.eql? "2"
    print "What book do you want to return?: "
    book = input()
    library.return_to_shelf(book, customer_info)
    puts
  elsif option.eql? "3"
    puts "What book do you want to add to our library?: "
    print "title: "
    title = input()
    print "author: "
    author = input()
    book = Book.new(title, author)
    library.add_book(book)
    puts
  else
    puts "no valid option was selected, bye"
    puts
    exit
  end
end
