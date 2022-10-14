require 'colorize'

# Mastermind game class.
class Game
  def initialize
    @code = Array.new(4)
    @board = []
    @row = { guess: [], pins: [] }
    @colors = %w[red blue green yellow cyan purple]
  end

  # this nested loop checks for white pins by checking if the current element in both
  # loops are equal, but the index is different, and red pins by checking if both the
  # element and index are equal in both loops.

  # variable[index] = nil inside if/elsif was a little workaround to a bug: if the
  # code was, for example, "red blue cyan green" and the guess "red red cyan green"
  # the pins would return as [2, 1, 2, 2], it's not supposed to do that.
  def define_pins
    guess_dummy = @row[:guess]
    code_dummy = @code

    # 1 == white pin | 2 == red pin
    guess_dummy.each_with_index do |item, i|
      code_dummy.each_with_index do |itm, j|
        if item == itm && i != j
          @row[:pins].push(1)
          code_dummy[j] = nil
          guess_dummy[i] = nil
        elsif item == itm && i == j
          @row[:pins].push(2)
          code_dummy[j] = nil
          guess_dummy[i] = nil
        end
      end
    end
    @row[:pins] = @row[:pins].shuffle
    p @row[:pins]
  end

  def make_code
    code = @colors.shuffle
    code.pop(2)
    @code = code
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
    @row[:guess] = prompt
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

  # update_board: add the colors to the board, maybe with a method with conditionals for each one of the 6 colors,
  # then it calls #feedback and adds the pins to the board.
end

game = Game.new
game.play
