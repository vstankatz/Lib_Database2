require 'rspec'
require 'patron'
require('spec_helper')

describe '#Patron' do

  describe('#save') do
    it("Saves patron") do
      patron = Patron.new({:id => nil, :name => "Billy Jimmy`s Banjo", :phone => 1234569876, :address => "456 street, Moscow Ireland"})
      patron.save()
      patron2 = Patron.new({:id => nil, :name => "Billy Jimmy`s Lute", :phone => 1234569875, :address => "457 street, Moscow Ireland"})
      patron2.save()
      expect(Patron.all).to(eq([patron, patron2]))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no patrons") do
      expect(Patron.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same patron if it has the same attributes as another patron") do
      patron = Patron.new({:id => nil, :name => "Billy Jimmy`s Banjo", :phone => 1234569876, :address => "456 street, Moscow Ireland"})
      patron2 = Patron.new({:id => nil, :name => "Billy Jimmy`s Banjo", :phone => 1234569876, :address => "456 street, Moscow Ireland"})
      expect(patron).to(eq(patron2))
    end
  end

  describe('.clear') do
    it('clears all patrons') do
      patron = Patron.new({:id => nil, :name => "Billy Jimmy`s Banjo", :phone => 1234569876, :address => "456 street, Moscow Ireland"})
      patron.save()
      patron2 = Patron.new({:id => nil, :name => "Billy Jimmy`s Lute", :phone => 1234569875, :address => "457 street, Moscow Ireland"})
      patron2.save()
      Patron.clear()
      expect(Patron.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an patron by id") do
      patron = Patron.new({:id => nil, :name => "Billy Jimmy`s Banjo", :phone => 1234569876, :address => "456 street, Moscow Ireland"})
      patron.save()
      patron2 = Patron.new({:id => nil, :name => "Billy Jimmy`s Lute", :phone => 1234569875, :address => "457 street, Moscow Ireland"})
      patron2.save()
      expect(Patron.find(patron.id)).to(eq(patron))
    end
  end

  describe('#update') do
    it("updates an patron by id") do
      patron = Patron.new({:id => nil, :name => "Billy Jimmy`s Banjo", :phone => 1234569876, :address => "456 street, Moscow Ireland"})
      patron.save()
      patron.update("Blue")
      expect(patron.name).to(eq("Blue"))
    end
  end

  describe('#delete') do
    it('deletes an patron by id') do
      patron = Patron.new({:id => nil, :name => "Billy Jimmy`s Banjo", :phone => 1234569876, :address => "456 street, Moscow Ireland"})
      patron.save()
      patron2 = Patron.new({:id => nil, :name => "Billy Jimmy`s Lute", :phone => 1234569875, :address => "457 street, Moscow Ireland"})
      patron2.save()
      patron.delete()
      expect(Patron.all).to(eq([patron2]))
    end
  end

  describe('.search') do
    it('searches for the given patron name') do
      Patron.clear()
      patron = Patron.new({:id => nil, :name => "Billy Jimmy`s Banjo", :phone => 1234569876, :address => "456 street, Moscow Ireland"})
      patron.save()
      patron2 = Patron.new({:id => nil, :name => "Billy Jimmy`s Lute", :phone => 1234569875, :address => "457 street, Moscow Ireland"})
      patron2.save()
      patron3 = Patron.new({:id => nil, :name => "Billy Jimmy`s Pickup Truck", :phone => 1234569875, :address => "457 street, Moscow Texas"})
      patron3.save()
      expect(Patron.search("Billy Jimmy`s Banjo")).to(eq(patron))
    end
  end

end
