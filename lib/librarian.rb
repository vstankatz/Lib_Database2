# class Librarian
#   attr_reader :id, :name
#
#
#   def initialize(attributes)
#     @id = attributes.fetch(:id)
#     @name = attributes.fetch(:name)
#   end
#
#
#   def self.all
#     returned_librarians = DB.exec("SELECT * FROM librarians;")
#     librarians = []
#     returned_librarians.each() do |librarian|
#       name = librarian.fetch("name")
#       id = librarian.fetch("id").to_i
#       librarians.push(Librarian.new({:name => name, :id => id}))
#     end
#     librarians
#   end
#
#   def save
#     result = DB.exec("INSERT INTO librarians (name) VALUES ('#{@name}') RETURNING id;")
#     @id = result.first().fetch("id").to_i
#   end
#
#   def ==(librarian_to_compare)
#     self.name().downcase().eql?(librarian_to_compare.name.downcase())
#   end
#
#   def self.clear
#     DB.exec("DELETE FROM librarians *;")
#   end
#
#   def self.find(id)
#     librarian = DB.exec("SELECT * FROM librarians WHERE id = #{id};").first
#     name = librarian.fetch("name")
#     id = librarian.fetch("id").to_i
#     Librarian.new({:name => name, :id => id})
#   end
#
#   def find_by_author(author_id)
#     books_by_author = []
#     returned_books = DB.exec("SELECT * FROM creators WHERE author_id = #{author_id};")
#     returned_books.each() do |book|
#       name = librarian.fetch("name")
#       id = librarian.fetch("id").to_i
#       books_by_author.push(Book.new({:name => name, :id => id}))
#     end
#     return books_by_author
#   end
#
#   # def songs
#   #   Song.find_by_librarian(self.id)
#   # end
#
#   def update(name)
#     @name = name
#     DB.exec("UPDATE librarians SET name = '#{@name}' WHERE id = #{@id};")
#   end
#
#   def delete
#     DB.exec("DELETE FROM librarians WHERE id = #{@id};")
#   end
# end
