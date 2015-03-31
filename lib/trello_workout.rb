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
    puts "\nMoving all cards to Done..."
    @todo.cards.each do |card|
      unless card.name.eql? @weighing_card_name
        puts " ---> Moving '#{card.name}' to '#{@done.name}'..."
        card.move_to_list(@done)
      end
    end
    puts "\nMoving all cards from series #{series} to TODO..."
    @done.cards.each do |card|
      if card.name.starts_with?(series)
        puts " ---> Moving '#{card.name}' to '#{@todo.name}'..."
        card.move_to_list(@todo)
      end
    end
  end

  private

  def list(name)
    @lists.select { |list| list.name.eql? name }.first
  end
end
