require_relative '../classes/games'
require_relative '../classes/item'

describe Game do
  before :each do
    @game = Game.new true, '2021-05-05', '2023-04-01'
  end

  describe 'Create a new game object' do
    it 'Takes 3 arguments and return the game object' do
      expect(@game).to be_an_instance_of(Game)
    end
  end

  describe 'Multiplayer input testing' do
    it 'returns the correct value for Multiplayer' do
      expect(@game.multiplayer).to eq(true)
    end
  end

  describe 'Last played date check' do
    it 'returns the correct value for last played date' do
      expect(@game.last_played_at).to eq '2023-04-01'
    end
  end


  describe 'Published date date check' do
    it 'returns the correct value for publish date' do
      expect(@game.publish_date).to eq '2021-05-05'
    end
  end

  describe 'Test for can_be_archived? method' do
    it 'Checks if the game can be archived or not ' do
      expect(@game.can_be_archived?).to eq(false)
    end
  end
end
