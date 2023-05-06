require_relative './games'
require_relative './author'
require 'json'

class GameActions
  attr_accessor :games, :authors

  def initialize
    @games = load_games
    @authors = load_authors
  end

  def save_games
    data = []
    @games.each do |game|
      data.push({ id: game.id,
                  multiplayer: game.multiplayer,
                  last_played_at: game.last_played_at,
                  publish_date: game.publish_date })
    end
    File.write('./data/games.json', JSON.generate(data)).to_s
  end

  def save_authors
    data = []
    @authors.each do |author|
      data.push({ id: author.id,
                  first_name: author.first_name,
                  last_name: author.last_name })
    end
    File.write('./data/authors.json', JSON.generate(data)).to_s
  end

  def load_games
    data = []
    file = './data/games.json'

    if File.exist?(file)
      JSON.parse(File.read(file)).each do |game|
        data.push(Game.new(game['multiplayer'], game['last_played_at'], game['publish_date']))
      end
    else
      File.write(file, JSON.generate(data))
    end
    data
  end

  def load_authors
    data = []
    file = './data/authors.json'

    if File.exist?(file)
      JSON.parse(File.read(file)).each do |author|
        data.push(Author.new(author['first_name'], author['last_name']))
      end
    else
      File.write(file, JSON.generate(data))
    end
    data
  end

  def add_game
    puts 'What\'s the publish date of the game? (yyyy-mm-dd): '
    publish_date = gets.chomp

    puts 'Is the game multiplayer or not? [Y/N]: '
    multiplayer = gets.chomp.downcase

    puts 'Please provide the last date you played it? (yyyy-mm-dd):'
    last_played_at = gets.chomp

    game = Game.new(multiplayer, last_played_at, publish_date)
    @games.push(game)

    puts 'Author first name: '
    first_name = gets.chomp
    puts 'Author last name: '
    last_name = gets.chomp
    author = Author.new(first_name, last_name)

    author.add_item(game)
    @authors.push(game.author)
    puts "\n Game Added."
  end

  def list_games
    if @games.empty?
      puts 'No games available yet!'
    else
      @games.each do |game|
        puts "
          Game id: #{game.id}
          Publish date : #{game.publish_date}
          Multiplayer: #{game.multiplayer == 'y' ? 'Yes' : 'No'}
          Last played date : #{game.last_played_at}
          "
      end
    end
  end

  def list_authors
    if @authors.empty?
      puts 'no authors available!'
    else
      @authors.each do |author|
        puts "
          Author's id: #{author.id}
          Author's name: #{author.first_name}
          Author's lastname: #{author.last_name}
        "
      end
    end
  end
end
