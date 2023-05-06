require_relative './item'

class Genre
  attr_reader :id, :items
  attr_accessor :name

  @@all = [] # rubocop:disable Style/ClassVars

  def initialize(name)
    @id = Random.rand(1..2000)
    @name = name
    @items = []
    @@all << self
  end

  def add_item(item)
    if item.genre&.name
      'The genre of the Item has already been set.'
    else
      @items << item
      item.add_genre(self) unless item.genre == (self)
    end
  end

  def self.all
    @@all
  end

  def self.find(id)
    all.find { |genre| genre.id == id }
  end

  def to_json(*_args)
    JSON.generate({
                    id: @id,
                    name: @name,
                    items: @items
                  })
  end

  def self.from_json(string)
    data = JSON.parse(string)
    obj = new(data['name'])
    obj.instance_variable_set(:@id, data['id'])
    obj
  end
end
