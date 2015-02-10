require "trello"
require "dotenv"

class TrelloWorkout
  def initialize(board_name)
    @lists = Trello::Board.all.select do |board|
      board.name.eql? board_name
    end.first.lists
  end

  def setup(series)
    todo.cards.each do |card|
      card.move_to_list(done) unless card.name.eql? "Weighing"
    end
    done.cards.each do |card|
      card.move_to_list(todo) if card.name.starts_with?(series)
    end
  end

  def todo
    list("TODO")
  end

  def done
    list("Done")
  end

  private

  def list(name)
    @lists.select { |list| list.name.eql? name }.first
  end
end

# `open "https://trello.com/1/authorize?key=#{ENV["TRELLO_API_KEY"]}&name=TrelloWorkout&response_type=token&scope=read,write,account&expiration=never"`
Dotenv.load
Trello.configure do |config|
  config.developer_public_key = ENV["TRELLO_API_KEY"]
  config.member_token = ENV["TRELLO_API_TOKEN"]
end
next_series = ARGV[0] || "A"
TrelloWorkout.new("Workout").setup next_series.upcase
