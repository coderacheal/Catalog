class Item
  attr_reader :id, :author, :label, :genre, :source, :publish_date, :archived

  def initialize(id, publish_date, archived: false)
    @id = id
    @publish_date = publish_date
    @archived = archived
  end

  def can_be_archived?
    @publish_date > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
