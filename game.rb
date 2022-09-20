require 'colorize'

# Mastermind game class.
class Game
  def initialize
    # oh, hi!
  end

  def tutorial
    puts 'Hello, and welcome to Mastermind!'.bold

    puts "\nThis is a #{'code breaking game'.underline} where one player \nis the code #{
    'MAKER'.bold.colorize(:blue)} & the other is the code #{'BREAKER'.bold.colorize(:red)}."

    puts "\nToday, the computer will be playing as the code #{'MAKER'.bold.colorize(:blue)
    }. It will \n#{'choose a sequence of 4 colors'.underline} in whichever order it pleases,\nwhich can be #{
    'red'.colorize(:red)}, #{'blue'.colorize(:blue)}, #{'green'.colorize(:green)}, #{
    'yellow'.colorize(:light_yellow)}, #{'cyan'.colorize(:cyan)}, or #{'purple'.colorize(:magenta)}."

    puts "\nYou, the code #{'BREAKER'.bold.colorize(:red)}, will try to #{"guess the code maker's code"
    .underline}."
  end
end

game = Game.new
game.tutorial

# String.colors                       # return array of all possible colors names
# puts String.modes                        # return array of all possible modes
# String.color_samples                # displays color samples in all combinations
