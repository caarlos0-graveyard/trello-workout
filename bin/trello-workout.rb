require "dotenv"
require_relative "../lib/trello_workout"

Dotenv.load

unless ENV["TRELLO_API_KEY"]
  abort "
    Please create an API key at https://trello.com/app-key and add export it
    to TRELLO_API_KEY (or put it in .env)."
end

unless ENV["TRELLO_API_TOKEN"]
  abort "
    Please create an API token at
    https://trello.com/1/authorize?key=#{ENV["TRELLO_API_KEY"]}&name=TrelloWorkout&response_type=token&scope=read,write,account&expiration=never
    and add export it to TRELLO_API_TOKEN (or put it in .env)."
end

Trello.configure do |config|
  config.developer_public_key = ENV["TRELLO_API_KEY"]
  config.member_token = ENV["TRELLO_API_TOKEN"]
end

board_name = ENV["BOARD_NAME"] || "Workout"
weighing_card_name = ENV["WEIGHING_NAME"] || "Weighing"
todo_list_name = ENV["TODO_LIST_NAME"] || "TODO"
done_list_name = ENV["DONE_LIST_NAME"] || "Done"
next_series = ARGV[0] || "A"

TrelloWorkout.new(
  board_name,
  weighing_card_name,
  todo_list_name,
  done_list_name
).setup next_series.upcase
