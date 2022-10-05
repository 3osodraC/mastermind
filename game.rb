require 'colorize'

# Mastermind game class.
class Game
  def initialize
    @code = Array.new(4)
    @board = { guess: [], pins: [] }
    @colors = %w[red blue green yellow cyan purple]
  end

  def define_pins
    # 0 == no pin | 1 == white pin | 2 == red pin
    @board[:guess].each_with_index do |item, i|
      @code.each_with_index do |itm, j|
        if item == itm && i != j
          @board[:pins].push(1)
        elsif item == itm && i == j
          @board[:pins].push(2)
        end
      end
    end
    p @board[:guess]
    p @board[:pins]
  end

  def make_code
    @code.map! { @colors[rand(6)] }
  end

  def play
    tutorial
    make_code
    prompt
    define_pins
  end

  # Prompts & stores guess.
  def prompt
    p @code
    prompt = []
    until valid_prompt?(prompt)
      puts "\nMake your guess by typing #{'four colors separated by spaces'.underline}."
      puts "Possible colors: #{
      'red'.colorize(:red)}, #{'blue'.colorize(:blue)}, #{'green'.colorize(:green)}, #{
      'yellow'.colorize(:light_yellow)}, #{'cyan'.colorize(:cyan)}, & #{'purple'.colorize(:magenta)}"
      print 'Guess: '.bold
      prompt = gets.chomp.downcase.split
    end
    @board[:guess] = prompt
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

    puts "\nAlright, Let's play!\n".bold
  end

  def valid_prompt?(prompt)
    return true if (prompt - @colors).empty? && prompt.size == 4
  end

  # PSEUDO:

  # define_pins: scans guess and returns pins.

  # update_board: add the colors to the board, maybe with a method with conditionals for each one of the 6 colors,
  # then it calls #feedback and adds the pins to the board.

  # valid_prompt?: checks if guess matches colors array.

  # play: executes all methods needed to play the game.
end

game = Game.new
game.play
