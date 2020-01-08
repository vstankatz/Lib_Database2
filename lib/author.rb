class Author
  attr_reader :id, :name

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end


  def self.all
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch("name")
      id = author.fetch("id").to_i
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(author_to_compare)
    self.name().downcase().eql?(author_to_compare.name.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM authors *;")
  end

  def self.find(id)
    author = DB.exec("SELECT * FROM authors WHERE id = #{id};").first
    name = author.fetch("name")
    id = author.fetch("id").to_i
    Author.new({:name => name, :id => id})
  end

  def albums
    Album.find_by_author(self.id)
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")
    end
    album_name = attributes.fetch(:album_name)
    if album_name != nil
      album = DB.exec("SELECT * FROM albums WHERE lower(name)='#{album_name.downcase}';").first
      if album != nil
        DB.exec("INSERT INTO albums_authors (album_id, author_id) VALUES (#{album['id'].to_i}, #{@id});")
      end
    end
  end

  def albums
    albums = []
    results = DB.exec("SELECT album_id FROM albums_authors WHERE author_id = #{@id};")
    results.each() do |result|
      album_id = result.fetch("album_id").to_i()
      album = DB.exec("SELECT * FROM albums WHERE id = #{album_id};")
      name = album.first().fetch("name")
      albums.push(Album.new({:name => name, :id => album_id}))
    end
    albums
  end

  def delete
    DB.exec("DELETE FROM albums_authors WHERE author_id = #{@id};")
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end
end
