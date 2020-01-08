class Book
  attr_reader :id, :name


  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end


  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      name = book.fetch("name")
      id = book.fetch("id").to_i
      books.push(Book.new({:name => name, :id => id}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(book_to_compare)
    self.name().downcase().eql?(book_to_compare.name.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM books *;")
  end

  def self.find(id)
    book = DB.exec("SELECT * FROM books WHERE id = #{id};").first
    name = book.fetch("name")
    id = book.fetch("id").to_i
    Book.new({:name => name, :id => id})
  end

  def find_by_artist(artist_id)
    books = []
    returned_books = DB.exec("SELECT * FROM books_artists WHERE artist_id = #{artist_id};")
    returned_books.each() do |book|
      name = book.fetch("name")
      id = book.fetch("id").to_i
      books.push(Book.new({:name => name, :id => id}))
    end
    return books
  end

  def songs
    Song.find_by_book(self.id)
  end

  def update(name)
    @name = name
    DB.exec("UPDATE books SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end
end
