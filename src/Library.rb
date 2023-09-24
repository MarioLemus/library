class Library
  def initialize()
    @books_registry = [{title: "sakura card captor", author: "clamp", available:true}, {title: "ONE PIECE", author: "eiichiro oda", available:true}]
    @lend_registry = []
  end

  def show_catalog
    puts "AVAILBLE BOOKS"
    @books_registry.each {|book| puts book if book[:available]}
    puts
  end

  def lend_book(book_title, user)
    is_book_in_registry = check_book_existence(book_title, @books_registry)
    is_lended = check_book_existence(book_title, @lend_registry)
    is_customer = check_user_in_lend_registry(user, @lend_registry)

    if is_book_in_registry && !is_lended && !is_customer
      change_book_availability(book_title, false)
      @lend_registry << {title:book_title, customer_info:user}
      puts "The book you requested is here, please return it on time!"
    else
      puts "I am sorry there is a limit on the amount of books a person can take daily!"
      exit
    end
  end

  def return_to_shelf(book, user)
    is_customer = check_user_in_lend_registry(user, @lend_registry)
    is_book_in_registry = check_book_existence(book, @books_registry)
    is_lended = check_book_existence(book, @lend_registry)

    if is_customer && is_book_in_registry && is_lended
      @lend_registry = @lend_registry.select {|registry| registry[:title] != book}
    end
  end

  def add_book(book)
    is_book_in_registry = check_book_existence(book, @books_registry)

    if !is_book_in_registry
      @books_registry << {title:book.title, author:book.author, available:true}
      puts "Book added succesfuly, thanks!"
    else
      puts "This book is already in our registry, We can't take it. Sorry :("
    end
  end

  private
  def check_book_existence(user_book, books_registry)
    return !!books_registry.find do |book|
      book[:title].eql? user_book
    end
  end

  # one book per day each person
  def check_user_in_lend_registry(user, lend_registry)
    return lend_registry.find do |registry|
      registry[:customer_info].name == user.name
    end
  end

  def change_book_availability(book_title, is_available=true)
    @books_registry.find do |book_registry|
      if book_registry[:title].eql? book_title
        book_registry[:available] = is_available
      end
    end
  end
end
