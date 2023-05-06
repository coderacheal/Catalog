module MusicAlbumHelper
  def exist_genre?(genres, name)
    genres.any? { |genre| genre.name == name }
  end

  def update_items(genres, name, new_music_album)
    genres.each do |genre_item|
      if genre_item.name == name
        genre_item.add_item(new_music_album)
        break
      end
    end
  end

  # Handle user input
  def ask_on_spotify
    print 'Is it available on Spotify? (y/n) '
    on_spotify_input = gets.chomp.downcase
    %w[y yes].include?(on_spotify_input)
  end

  def ask_publish_date
    print 'What is the date of publication? (YYYY-MM-DD-) '
    gets.chomp
  end

  def ask_archived
    print 'Is it archived? (y/n) '
    archived_input = gets.chomp.downcase
    %w[y yes].include?(archived_input)
  end

  def ask_genre
    print 'What is the genre of the music album? '
    gets.chomp.capitalize
  end

  def add_genre_to_music_album(genres, music_album, genre_name)
    if exist_genre?(genres, genre_name)
      update_items(genres, genre_name, music_album)
    else
      new_genre = Genre.new(genre_name)
      music_album.add_genre(new_genre)
      genres << new_genre
    end
    write_file(genres, './data/genres.json')
  end
end
