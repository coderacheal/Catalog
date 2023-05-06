require_relative './item'
class Game < Item
  attr_reader :publish_date
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer, publish_date, last_played_at = Time.new.strftime('%Y-%m-%d'))
    super publish_date
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @publish_date = publish_date
  end

  def can_be_archived?
    super && (@last_played_at.to_i < Date.today.year - 2)
  end
end
