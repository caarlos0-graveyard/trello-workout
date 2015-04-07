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
    @todo.cards
      .select { |card| !card.name.eql?(@weighing_card_name) }
      .each do |card|
      puts " ---> Moving '#{card.name}' to '#{@done.name}'..."
      card.move_to_list(@done)
    end
    puts "\nMoving all cards from series #{series} to TODO..."
    @done.cards
      .select { |card| card.name.starts_with?(series) }
      .sort { |a, b| a.name <=> b.name }
      .each do |card|
        puts " ---> Moving '#{card.name}' to '#{@todo.name}'..."
        card.move_to_list(@todo)
    end
  end

  private

  def list(name)
    @lists.select { |list| list.name.eql? name }.first
  end
end
