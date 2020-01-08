require 'rspec'
require 'patron'
require 'book'
require 'pry'
require('spec_helper')

describe '#Patron' do

  describe('#==') do
    it("is the same patron if it has the same attributes as another patron") do
      patron = Patron.new({:name => "Naima", :id => nil, :album_id => 1})
      patron2 = Patron.new({:name => "Naima", :id => nil, :album_id => 1})
      expect(patron).to(eq(patron2))
    end
  end
  describe('.all') do
    it("returns an empty array when there are no patrons") do
      expect(Patron.all).to(eq([]))
    end
  end
  describe('.all') do
    it("returns a list of all patrons") do
      patron = Patron.new({:name => "Giant Steps", :id => nil, :album_id => 1})
      patron.save()
      patron2 = Patron.new({:name => "Naima", :id => nil, :album_id => 1})
      patron2.save()
      expect(Patron.all).to(eq([patron, patron2]))
    end
  end

  describe('.clear') do
    it("clears all patrons") do
      patron = Patron.new({:name => "Giant Step", :id => nil, :album_id => 1})
      patron.save()
      patron2 = Patron.new({:name => "Naima", :id => nil, :album_id => 2})
      patron2.save()
      Patron.clear()
      expect(Patron.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a patron") do
      patron = Patron.new({:name => "Naima", :id => nil, :album_id => 1})
      patron.save()
      expect(Patron.all).to(eq([patron]))
    end
  end

  describe('.find') do
    it("finds a patron by id") do
      patron = Patron.new({:name => "Giant Step", :id => nil, :album_id => 1})
      patron.save()
      patron2 = Patron.new({:name => "Naima", :id => nil, :album_id => 2})
      patron2.save()
      expect(Patron.find(patron.id)).to(eq(patron))
    end
  end

  describe('.find_by_album') do
    it("finds patrons for an album") do
      album = Album.new({:name => "Red", :id => nil})
      album.save
      album2 = Album.new({:name => "Blue", :id => nil})
      album2.save
      patron = Patron.new({:name => "Naima", :id => nil, :album_id => album.id})
      patron.save()
      patron2 = Patron.new({:name => "California", :id => nil, :album_id => album2.id})
      patron2.save()
      expect(Patron.find_by_album(album2.id)).to(eq([patron2]))
    end
  end

  describe('#patrons') do
    it("returns an album's patrons") do
      album = Album.new({:name => "Blue", :id => nil})
      album.save
      patron = Patron.new({:name => "Naima", :id => nil, :album_id => album.id})
      patron.save()
      patron2 = Patron.new({:name => "California", :id => nil, :album_id => album.id})
      patron2.save()
      expect(album.patrons).to(eq([patron, patron2]))
    end
  end

  describe('#album') do
    it("finds the album a patron belongs to") do
      album = Album.new({:name => "Blue", :id => nil})
      album.save
      patron = Patron.new({:name => "Naima", :id => nil, :album_id => album.id})
      patron.save()
      expect(patron.album()).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an patron by id") do
      album = Album.new({:name => "Blue", :id => nil})
      album.save
      patron = Patron.new({:name => "Naima", :id => nil, :album_id => album.id})
      patron.save()
      patron.update("Mr. P.C.", album.id)
      expect(patron.name).to(eq("Mr. P.C."))
    end
  end

  describe('#delete') do
    it("deletes an patron by id") do
      album = Album.new({:name => "Blue", :id => nil})
      album.save
      patron = Patron.new({:name => "Giant Step", :id => nil, :album_id => album.id})
      patron.save()
      patron2 = Patron.new({:name => "Naima", :id => nil, :album_id => album.id})
      patron2.save()
      patron.delete()
      expect(Patron.all).to(eq([patron2]))
    end
  end

end
