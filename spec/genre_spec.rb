require_relative '../modules/genre'
require_relative '../modules/album'
require_relative '../modules/label'
require_relative 'spec_helper'
# require_relative 'spec_helper'

describe Genre do
  let(:label) do
    Label.new(nil, 'Mavins', 'Red')
  end
  let(:genre) do
    Genre.new(nil, 'Fantasy')
  end
  describe '#initialize' do
    it 'should set the id and name attributes' do
      genre = Genre.new(1, 'Action')
      expect(genre.id).to eq(1)
      expect(genre.name).to eq('Action')
    end

    it 'should set a random id if one is not provided' do
      genre = Genre.new(nil, 'Comedy')
      expect(genre.id).to be_an(Integer)
      expect(genre.name).to eq('Comedy')
    end

    it 'should set an empty items array' do
      genre = Genre.new(2, 'Horror')
      expect(genre.items).to be_an(Array)
      expect(genre.items).to be_empty
    end
  end

  describe '#add_items' do
    before(:each) do
      @music_album = MusicAlbum.new(1, genre, 'J.R.R', 'The Hobbit', label,
                                    '2010-10-12', false)
    end

    let(:genre) do
      Genre.new(3, 'Sci-Fi')
    end

    it 'should add the item to the genre items array' do
      genre.add_items(@music_album)
      expect(genre.items).to include(@music_album)
    end

    it 'should set the item genre to the genre instance' do
      genre.add_items(@music_album)
      expect(@music_album.genre).to eq(genre)
    end
  end
end
