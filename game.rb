require 'colorize'

# Mastermind game class.
class Game
  def initialize
    @code = Array.new(4)
    @row = { guess: [], pins: [] }
    @colors = %w[red blue green yellow cyan purple]
  end

  # nested loop checks for white pins by checking if the current element in both loops
  # are equal, but the index is different, and red pins by checking if both the element
  # and index are equal in both loops.

  # dup[index] = nil inside if/elsif was a little workaround to a bug: if the
  # code was, for example, "red blue cyan green" and the guess "red red cyan green"
  # the pins would return as [2, 1, 2, 2], it's not supposed to do that.
  def define_pins
    guess_dup = @row[:guess].dup
    code_dup = @code.dup

    # 1 == white pin | 2 == red pin
    guess_dup.each_with_index do |item, i|
      code_dup.each_with_index do |itm, j|
        if item == itm && i != j
          @row[:pins].push(1)
          code_dup[j] = nil
          guess_dup[i] = nil
        elsif item == itm && i == j
          @row[:pins].push(2)
          code_dup[j] = nil
          guess_dup[i] = nil
        end
      end
    end
    @row[:pins] = @row[:pins].shuffle
  end

  # chooses 4 random colors.
  def make_code
    code = @colors.shuffle
    code.pop(2)
    @code = code
  end

  def play
    tutorial
    make_code
    # p @code # debug
    12.times do |_item|
      prompt
      define_pins

      # \r moves cursor to line start, \e[A moves cursor up, \e[J
      # deletes everything after the cursor, \e[B moves cursor down.
      print "\r#{"\e[A\e[A\e[J\e[B" * 3}"

      print_guess
      print_pins
      if win?(@row[:pins])
        puts 'Congratulations! You did it! :D'.bold.colorize(:green)
        break
      end

      @row = { guess: [], pins: [] }
    end
    puts 'Code maker wins :('.bold.colorize(:red) unless win?(@row[:pins])
  end

  # prompts & stores guess.
  def prompt
    prompt = []
    until valid_prompt?(prompt)
      puts "Make your guess by typing #{'four colors separated by spaces'.underline}."
      puts "Possible colors: #{
      'red'.colorize(:red)}, #{'blue'.colorize(:blue)}, #{'green'.colorize(:green)}, #{
      'yellow'.colorize(:light_yellow)}, #{'cyan'.colorize(:cyan)}, & #{'purple'.colorize(:magenta)}"
      print 'Guess: '.bold
      prompt = gets.chomp.downcase.split
    end
    @row[:guess] = prompt
  end

  def print_guess
    print '|'
    @row[:guess].each do |color|
      case color
      when 'red'
        print ' ⏺ '.colorize(:red)
      when 'blue'
        print ' ⏺ '.colorize(:blue)
      when 'green'
        print ' ⏺ '.colorize(:green)
      when 'yellow'
        print ' ⏺ '.colorize(:light_yellow)
      when 'cyan'
        print ' ⏺ '.colorize(:cyan)
      when 'purple'
        print ' ⏺ '.colorize(:magenta)
      end
    end
  end

  def print_pins
    print '|'
    @row[:pins].each do |pin|
      case pin
      when 1
        print ' ⬢ '
      when 2
        print ' ⬢ '.colorize(:red)
      end
    end

    if @row[:pins].size < 4
      (4 - @row[:pins].size).times do
        print ' ⬡ '
      end
    end
    print "|\n\n"
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

  def win?(pins)
    return true if pins == [2, 2, 2, 2]
  end
end

game = Game.new
game.play
