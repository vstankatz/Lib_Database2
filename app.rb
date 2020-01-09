require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/author')
require('./lib/patron')
require('pry')
require('pg')

DB = PG.connect({:dbname => "library"})

also_reload('lib/**/*.rb')

get('/') do
  @books = Book.all
  erb(:books)
end

get('/books') do
  @books = Book.all
  erb(:books)
end

get('/books/new') do
  erb(:new_book)
end

get('/books/:id') do
  @book = Book.find(params[:id].to_i())
  erb(:book)
end

post('/books') do
  name = params[:book_name]
  id = params[:book_id]
  genre = params[:book_genre]
  isbn = params[:isbn]
  new_book = Book.new({:name => name, :id => nil, :genre => genre, :isbn => isbn})
  @books = Book.all
  # @books.each do |book|
  # if new_book == book
  # new_search = book.add_search
  # book = Book.new(name, nil, new_search)
  new_book.save()
  erb(:books)
end


get('/books/:id/edit') do
  @book = Book.find(params[:id].to_i())
  erb(:edit_book)
end

patch('/books/:id') do
  if !params[:name] && !params[:genre] && !params[:author] && !params[:isbn]
    @book = Book.find(params[:id].to_i())
    @book.sold()
    @books = Book.all
    erb(:books)
  else
    @book = Book.find(params[:id].to_i())
    @book.update({:name => params[:name], :genre => params[:genre], :isbn => params[:isbn]})
    # @book = Book.add_search
    @books = Book.all
    erb(:book)
  end

end

patch('/books/:id/edit') do
  @book = Book.find(params[:id].to_i)
  author = Author.new({:name => params[:author_name], :bio => params[:author_bio], :id => nil})
  author.save
  @book.addAuthor(author.id)
  erb(:book)
end



delete('/books/:id') do
  @book = Book.find(params[:id].to_i())
  @book.delete()
  @books = Book.all
  erb(:books)
end

get('/books/search/') do
  @book = Book.search(params[:searched])
  erb(:search)
end

get('/authors/:author_id') do
  @author = Author.find(params[:author_id].to_i())
  erb(:author)
end

get('/authors') do
  @authors = Author.all
  erb(:authors)
end


post('/authors') do
  @book = Book.find(params[:id].to_i())
  author = Author.new(params[:author_name], @book.id, nil)
  author.save()
  erb(:book)
end


patch('authors/:author_id') do
  @book = Book.find(params[:id].to_i())
  author = Author.find(params[:author_id].to_i())
  author.update(params[:name], @book.id)
  erb(:book)
end

delete('/books/:id/authors/:author_id') do
  author = Author.find(params[:author_id].to_i())
  author.delete
  @book = Book.find(params[:id].to_i())
  erb(:book)
end
