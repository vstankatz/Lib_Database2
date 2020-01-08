class Patron
  attr_reader :id, :name


  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end


  def self.all
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  def save
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(patron_to_compare)
    self.name().downcase().eql?(patron_to_compare.name.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM patrons *;")
  end

  def self.find(id)
    patron = DB.exec("SELECT * FROM patrons WHERE id = #{id};").first
    name = patron.fetch("name")
    id = patron.fetch("id").to_i
    Patron.new({:name => name, :id => id})
  end

  def find_by_author(author_id)
    patrons = []
    returned_patrons = DB.exec("SELECT * FROM patrons_authors WHERE author_id = #{author_id};")
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    return patrons
  end

  # def songs
  #   Song.find_by_patron(self.id)
  # end

  def update(name)
    @name = name
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{@id};")
  end
end
