require 'colorize'

class Mastermind
  def initialize
    @peg_colors = { r: :light_red, b: :light_blue, y: :yellow, g: :green, w: :white, p: :magenta }
    reset
    # set_game_mode
  end

  def reset
    @secret = random_input
    @answer = []
    @turns = 0
  end

  def start
    prompt_user until guessed_correctly?
    puts "You have guessed the secret in #{@turns} turns!"
    print 'Answer: '
    print_secret
  end

  private

  def computer_guess
    # TODO: implement algorithm to guess user answer
  end

  def user_guessing?
    # TODO: select computer_guess mode
    true
  end

  def guessed_correctly?
    return false if @answer.empty?

    @turns += 1
    return true if @answer == @secret

    validation_array = []
    @answer.each_with_index do |ans, idx|
      validation_array << if ans == @secret[idx]
                            ans.to_s.colorize(:green)
                          elsif @secret.include? ans
                            ans.to_s.colorize(:yellow)
                          else
                            ans.to_s.colorize(:light_red)
                          end
    end
    puts validation_array.join
    false
  end

  def print_options
    print 'Options: '
    @peg_colors.keys.each { |color| print color.to_s.colorize(@peg_colors[color]) }
    puts ''
  end

  def print_secret
    @secret.map { |i| print i.to_s.colorize(@peg_colors[i]) }
    puts ''
  end

  def prompt_user
    print_options
    answer = []
    until valid_input? answer
      print '>>>'
      answer = gets.chomp.split('').map(&:to_sym)
    end
    @answer = answer
  end

  def set_secret
    input = []
    until valid_input? input
      print_options
      print "Please, set the answer (eg. 'rbgy'):"
      input = gets.chomp.split('').map(&:to_sym)
    end
    @answer = input
  end

  def set_game_mode
    if user_guessing?
      start
    else
      set_secret
      computer_guess until guessed_correctly?
    end
  end

  def random_input
    input = []
    while input.length < 4
      sample = @peg_colors.keys.sample
      input << sample unless input.include? sample
    end
    input
  end

  def valid_input?(arr)
    arr.uniq.length == 4 && arr.all? { |i| @peg_colors.keys.include? i }
  end
end