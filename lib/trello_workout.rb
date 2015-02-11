require "trello"

class TrelloWorkout
  def initialize(board_name, weighing_card_name, todo_list_name, done_list_name)
    @lists = Trello::Board.all.select do |board|
      board.name.eql? board_name
    end.first.lists
    @todo = list(todo_list_name)
    @done = list(done_list_name)
    @weighing_card_name = weighing_card_name
  end

  def setup(series)
    puts "Moving all cards to Done..."
    @todo.cards.each do |card|
      card.move_to_list(@done) unless card.name.eql? @weighing_card_name
    end
    puts "Moving all cards from series #{series} to TODO..."
    @done.cards.each do |card|
      card.move_to_list(@todo) if card.name.starts_with?(series)
    end
  end

  private

  def list(name)
    @lists.select { |list| list.name.eql? name }.first
  end
end
