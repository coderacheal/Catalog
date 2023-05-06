require_relative '../classes/music'
require_relative '../classes/app'

describe MusicAlbum do
  before(:context) do
    @music_album_one = MusicAlbum.new(true, '2028-7-10')
    @music_album_two = MusicAlbum.new(false, '2000-11-11')
    @music_album_three = MusicAlbum.new(true, '2010-12-13')
    @app = App.new
  end
  context 'Testing methods in MusicAlbum' do
    it 'Should be an instance of MusicAlbum' do
      expect(@music_album_one).to be_an_instance_of MusicAlbum
      expect(@music_album_two).to be_an_instance_of MusicAlbum
      expect(@music_album_three).to be_an_instance_of MusicAlbum
    end

    it 'can_be_archived return false' do
      expect(@music_album_one.can_be_archived?).to eq false
      expect(@music_album_two.can_be_archived?).to eq false
    end

    it 'can_be_archived return true' do
      expect(@music_album_three.can_be_archived?).to eq true
    end

    it 'Should set archived to true' do
      expect(@music_album_three.move_to_archive).to eq true
      expect(@music_album_three.archived).to eq true
    end

  end
end
