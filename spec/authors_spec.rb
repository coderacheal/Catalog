require_relative '../classes/author'
require_relative '../classes/item'

describe Author do
  before :each do
    @author1 = Author.new 'Racheal', 'Appiah'
    @author2 = Author.new 'Crispin', 'Bigizi'
    @new_item = Item.new '1775-09-07'
  end

  describe 'initialization of a new author' do
    it 'takes three parameters and returns 2 author objects' do
      expect(@author1).to be_an_instance_of Author
      expect(@author2).to be_an_instance_of Author
    end

    it 'returns the correct value for first name of @author1' do
      expect(@author1.first_name).to eql 'Racheal'
    end

    it 'returns the correct value for last name of @author2' do
      expect(@author2.last_name).to eql 'Bigizi'
    end
  end

  describe 'add_item method test' do
    it 'should add new author item' do
      @author1.add_item(@new_item)
      expect(@author1.items).to eql([@new_item])
    end
  end
end
