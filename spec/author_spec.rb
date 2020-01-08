require 'rspec'
require 'author'
require('spec_helper')

describe '#Author' do

  describe('#save') do
    it("Saves author") do
      author = Author.new({:id => nil, :name => "Kind of Blue"})
      author.save()
      author2 = Author.new({:id => nil, :name => "Kind of Green"})
      author2.save()
      expect(Author.all).to(eq([author, author2]))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no authors") do
      expect(Author.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same author if it has the same attributes as another author") do
      author = Author.new({:id => 1, :name => "Kind of Blue"})
      author2 = Author.new({:id => 2, :name => "Kind of Blue"})
      expect(author).to(eq(author2))
    end
  end
  #
  describe('.clear') do
    it('clears all authors') do
      author = Author.new({:name => "Giant Steps", :id => nil})
      author.save()
      author2 = Author.new({:name => "Blue", :id => nil})
      author2.save()
      Author.clear()
      expect(Author.all).to(eq([]))
    end
  end
  #
  describe('.find') do
    it("finds an author by id") do
      author = Author.new({:name => "Giant Steps", :id => nil})
      author.save()
      author2 = Author.new({:name => "Blue", :id => nil})
      author2.save()
      expect(Author.find(author.id)).to(eq(author))
    end
  end


  describe('#delete') do
    it('deletes an author by id') do
      author = Author.new({:name => "Giant Steps", :id => nil})
      author.save()
      author2 = Author.new({:name => "Blue", :id => nil})
      author2.save()
      author.delete()
      expect(Author.all).to(eq([author2]))
    end
  end

  describe('#update') do
    it("adds an album to an author") do
      author = Author.new({:name => "John Coltrane", :id => nil})
      author.save()
      album = Album.new({:name => "A Love Supreme", :id => nil})
      album.save()
      author.update({:album_name => "A Love Supreme"})
      expect(author.albums).to(eq([album]))
    end
  end

  describe('#update') do
    it("Able to change an authors name") do
      author = Author.new({:name => "John Coltrane", :id => nil})
      author.save()
      author.update({:name => "Joan Rivers", :album_name => "Something Silly"})
      expect(author.name).to(eq("Joan Rivers"))
    end
  end

end
