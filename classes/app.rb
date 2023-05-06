require_relative './music'
require_relative './genre'
require_relative './io'
require_relative './music_utils'
require_relative './book'
require_relative './label'
require_relative './book_info'
require_relative './game_actions'

class App
  include MusicAlbumHelper
  include IOHelper
  attr_accessor :music_albums, :genres
  attr_reader :books

  def initialize
    @music_albums = read_file('./data/music_album.json', 'MusicAlbum')
    @genres = read_file('./data/genres.json', 'Genre')
    @game_actions = GameActions.new
    @books = []
    @labels = []
  end

  def title(title)
    puts "_____#{title.upcase}_____"
    puts ''
  end

  def options_list
    puts "\nPlease Select an option :
    1. List all books
    2. List all music albums
    3. List of games
    4. List all genres (e.g 'Comedy', 'Thriller')
    5. List all labels (e.g. 'Gift', 'New')
    6. List all authors (e.g. 'Stephen King')
    7. Add a book
    8. Add a music album
    9. Add a game
    10. Exit the app"
    choice = gets.chomp
    selection(choice.to_i)
  end

  def selection(choice)
    methods = [
      method(:list_all_books), method(:list_music_albums), method(:gamelist), method(:list_all_genres), method(:list_all_labels),
      method(:list_authors), method(:add_book), method(:add_music_albums), method(:create_game), method(:quit_app)
    ]

    (1..10).include?(choice) && methods[choice - 1].call
  end

  def list_all_labels
    @labels.clear
    book_data = BookData.new
    book_data.load_label(@labels)
    puts "\nLabel list(#{@labels.length}):"
    puts '---------------'
    return puts 'No labels added yet!' if @labels.empty?

    @labels.each.with_index(1) do |label, index|
      puts "#{index}. Title: #{label.title}, Color: #{label.color}"
    end
  end

  def add_book
    book_data = BookData.new
    puts 'Create book'
    puts '-----------------'
    puts 'Add the publisher name'
    publisher = gets.chomp
    puts 'Add the state of the cover "bad or good"'
    cover_state = gets.chomp.downcase
    puts 'The date of publishing: '
    publish_date = gets.chomp
    book = Book.new(publish_date, publisher, cover_state)
    label = add_label
    book.add_label(label)
    @books << book
    book_data.store_book(book)
    @books.clear
    @labels << label
    book_data.store_label(label)
    @labels.clear
    puts 'Book added successfully'
  end

  def list_all_books
    @books.clear
    book_data = BookData.new
    book_data.load_book(@books, @labels)
    puts '========Current Books==========='
    puts "\nBook list(#{@books.length}):"
    puts '--------------'
    return puts 'No books added yet!' if @books.empty?

    @books.each.with_index(1) do |book, index|
      publisher = "Publisher: #{book.publisher}, " unless book.publisher.nil?
      publish_date = "Publish date: #{book.publish_date}, " unless book.publish_date.nil?
      cover_state = "Cover state: #{book.cover_state}" unless book.cover_state.nil?
      puts "#{index}. #{publisher}#{publish_date}#{cover_state}"
    end
  end

  def add_label
    puts 'BOOK LABEL INFO'
    puts '-------------------------'
    puts 'What is the title of the book '
    title = gets.chomp
    puts 'What color is your book'
    color = gets.chomp
    Label.new(title, color)
  end

  def list_music_albums
    @music_albums = read_file('./data/music_album.json', 'MusicAlbum')
    title('My Music List')
    if @music_albums.empty?
      puts 'No Album Yet'
      nil
    else
      @music_albums.each_with_index do |music_album, index|
        puts "#{index}- Music id: #{music_album.id} - is published on #{music_album.publish_date}"
      end
    end
  end

  def list_all_genres
    @genres = read_file('./data/genres.json', 'Genre')
    title('list of genre')
    @genres.each_with_index { |genre, index| puts "#{index} - #{genre.name}" }
  end

  def add_music_albums
    title('add a music album')
    on_spotify = ask_on_spotify
    publish_date = ask_publish_date
    archived = ask_archived
    genre = ask_genre
    new_music_album = MusicAlbum.new(on_spotify, publish_date, archived: archived)
    add_genre_to_music_album(@genres, new_music_album, genre) unless genre.empty?
    @music_albums << new_music_album
    write_file(@music_albums, './data/music_album.json')
    puts 'A music album is created successfully'
  end

  def create_game
    @game_actions.add_game
  end

  def gamelist
    @game_actions.list_games
  end

  def list_authors
    @game_actions.list_authors
  end

  def quit_app
    @game_actions.save_games
    @game_actions.save_authors
    puts 'SEE YOU SOON WHEN YOU HAVE MORE THINGS TO ARCHIVE!!!'
    exit
  end

  def start
    options_list
  end
end
