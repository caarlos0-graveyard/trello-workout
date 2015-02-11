# trello-workout
I use Trello to manage my Gym workout and I tired to move cards. Deal with it.

So, I have a Board called "Workout", with to lists: TODO and Done.

I have my workout divided in four "series" (A, B, C, D). Every day I move
the current series to the TODO List. As I do the exercises, I annotate
the weight I lifted and move them to Done.

I was tired to move this stuff by hand, so I created this script.

I also intend to collect the lifted weight data and do some charts and
stuff.

### Environment variables

- `TRELLO_API_KEY` (required): you can get it [here](https://trello.com/app-key);
- `TRELLO_API_TOKEN` (required): you can create one [here](https://trello.com/1/authorize?key=!!!TRELLO_API_KEY!!!&name=TrelloWorkout&response_type=token&scope=read,write,account&expiration=never) (replace `!!!TRELLO_API_KEY!!!`);
- `BOARD_NAME`: default to "Workout";
- `WEIGHING_NAME`: default to "Weighing";
- `TODO_LIST_NAME`: default to "TODO";
- `DONE_LIST_NAME`: default to "Done".

You can put all environment variables in a `.env` file.

### Args

- `series` (a, b, c, d, whatever): the `starts_with` of the series you want to
do next. For example, "b" will move all `B*` cards to `TODO` and all others to
`Done` (except `Weighing`).


### Executing

ruby bin/trello-workout.rb c
