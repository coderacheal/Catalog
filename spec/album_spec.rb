require_relative '../modules/album'
require_relative '../modules/item'
require_relative '../modules/genre'
require_relative '../modules/label'
# require_relative 'spec_helper'

describe MusicAlbum do
  let(:label) do
    Label.new(nil, 'Mavins', 'Red')
  end
  let(:genre) do
    Genre.new(nil, 'Fantasy')
  end
  describe '#initialize' do
    it 'should set the id, publish_date, archived, and on_spotify attributes' do
      album = MusicAlbum.new(1, genre, 'J.R.R', 'The Hobbit', label,
                             '2010-10-12', false)
      expect(album.id).to eq(1)
    end
  end

  describe '#can_be_archived?' do
    it 'should return true if the item can be archived and is on Spotify' do
      album = MusicAlbum.new(2, genre, 'J.R.R', 'The Hobbit', label,
                             '2010-10-12', true)
      expect(album.can_be_archived?).to be_truthy
    end

    it 'should return false if the item cannot be archived' do
      album = MusicAlbum.new(3, genre, 'J.R.R', 'The Hobbit', label,
                             '2010-10-12', false)
      expect(album.can_be_archived?).to be_falsey
    end

    it 'should return false if the item is not on Spotify' do
      album = MusicAlbum.new(4, genre, 'J.R.R', 'The Hobbit', label,
                             '2010-10-12', false)
      expect(album.can_be_archived?).to be_falsey
    end
  end
end
