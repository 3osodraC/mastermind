require 'colorize'

# Mastermind game class.
class Game
  def initialize
    @board = { colors: [nil, nil, nil, nil], keys: [nil, nil, nil, nil] }
    @possible_colors = %w[red blue green yellow cyan purple]
  end

  # prompt: prompts 4 colors separated by spaces, verify by splitting the string and checking if all the colors exist,
  # also, store all guesses.
  def prompt
    prompt = []
    until valid_prompt?(prompt)
      puts "\nMake your guess by typing #{'four colors separated by spaces'.underline}."
      puts "Possible colors: #{
      'red'.colorize(:red)}, #{'blue'.colorize(:blue)}, #{'green'.colorize(:green)}, #{
      'yellow'.colorize(:light_yellow)}, #{'cyan'.colorize(:cyan)}, & #{'purple'.colorize(:magenta)}"
      print 'Guess: '.bold
      prompt = gets.chomp.split
    end
    @board[:colors] = prompt
  end

  def tutorial
    puts 'Hello, and welcome to Mastermind!'.bold

    puts "\nThis is a #{'code breaking game'.underline} where one player \nis the code #{
    'MAKER'.bold.colorize(:light_blue)} & the other is the code #{'BREAKER'.bold.colorize(:light_green)}."

    puts "\nToday, the computer will be playing as the code #{'MAKER'.bold.colorize(:light_blue)
    }. It will \n#{'choose a sequence of 4 colors'.underline} in whatever order it pleases,\nwhich can be #{
    'red'.colorize(:red)}, #{'blue'.colorize(:blue)}, #{'green'.colorize(:green)}, #{
    'yellow'.colorize(:light_yellow)}, #{'cyan'.colorize(:cyan)}, & #{'purple'.colorize(:magenta)}."

    puts "\nYou, the code #{'BREAKER'.bold.colorize(:light_green)}, will try to #{"guess the code maker's code"
    .underline}.\nAfter each guess, #{'the code maker will give feedback'.underline} to the code\nbreaker using #{
    'PINS'.bold}."

    puts "\n#{'RED PINS'.colorize(:red).bold}   (#{'⬢'.colorize(:red)}) denote an accurate guess.\n#{
    'WHITE PINS'.bold} (⬢) denote a right color, but in the wrong position.\n#{
    'NO PINS'.bold.colorize(:black).on_white}    (⬡) denote an inaccurate guess."

    puts "\n#{'NOTE'.underline}: The position of the pins are #{
    'not related'.underline} to the position\nof the colors, you will not know #{
    'which'.italic} one is right or wrong."
  end

  def valid_prompt?(prompt)
    return true if (prompt - @possible_colors).empty? && prompt.size == 4
  end

  # PSEUDO:

  # feedback: scans guess and returns pins.

  # update_board: add the colors to the board, maybe with a method with conditionals for each one of the 6 colors,
  # then it calls #feedback and adds the pins to the board.

  # valid_prompt?: checks if guess matches colors array.

  # play: executes all methods needed to play the game.
end

game = Game.new
game.tutorial
game.prompt
