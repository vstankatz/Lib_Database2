class Patron
  attr_accessor :id, :name, :phone, :address


  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @address = attributes.fetch(:address)
  end


  def self.all
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i
      phone = patron.fetch("phone").to_i
      address = patron.fetch("address")
      patrons.push(Patron.new({:id => id, :name => name, :phone => phone, :address => address}))
    end
    patrons
  end

  def save
    result = DB.exec("INSERT INTO patrons (name, address, phone) VALUES ('#{@name}', '#{@address}', #{@phone.to_i}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(patron_to_compare)
    self.name().downcase().eql?(patron_to_compare.name.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM patrons *;")
  end

  def self.search(name)
    patron = DB.exec("SELECT * FROM patrons WHERE name = '#{name}';").first
    name = patron.fetch("name")
    id = patron.fetch("id").to_i
    phone = patron.fetch("phone").to_i
    address = patron.fetch("address")
    Patron.new({:id => id, :name => name, :phone => phone, :address => address})
  end

  def self.find(id)
    patron = DB.exec("SELECT * FROM patrons WHERE id = #{id};").first
    name = patron.fetch("name")
    id = patron.fetch("id").to_i
    phone = patron.fetch("phone").to_i
    address = patron.fetch("address")
    Patron.new({:id => id, :name => name, :phone => phone, :address => address})
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
