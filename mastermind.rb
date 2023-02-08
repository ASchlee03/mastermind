# Constants
COLORS = ['R', 'G', 'B', 'Y', 'O', 'P']
LENGTH = 4
TURNS = 12

# Generates a random code
def generate_code
  code = []
  LENGTH.times { code << COLORS.sample }
  code
end

# Checks the guess against the code and returns feedback
def check_guess(guess, code)
  exact = 0
  near = 0
  code = code.dup
  guess.each_with_index do |g, i|
    if code[i] == g
      exact += 1
      code[i] = nil
    end
  end
  guess.each do |g|
    if code.include?(g)
      near += 1
      code[code.index(g)] = nil
    end
  end
  [exact, near]
end

# Asks the user for their guess
def get_guess
  puts "Enter your guess (R, G, B, Y, O, P): "
  gets.chomp.split('')
end

# Asks the user for the code
def get_code
  puts "Enter the code (R, G, B, Y, O, P): "
  gets.chomp.split('')
end

# Play as the code creator
def play_as_creator
  code = generate_code
  puts "The code has been generated. Now it's the computer's turn to guess."
  TURNS.times do |turn|
    guess = generate_code
    puts "Computer's guess: #{guess.join}"
    exact, near = check_guess(guess, code)
    puts "Result: #{exact} exact, #{near} near"
    break if exact == LENGTH
  end
  puts "The computer couldn't guess the code. The code was: #{code.join}"
end

# Play as the guesser
def play_as_guesser
  code = get_code
  TURNS.times do |turn|
    guess = get_guess
    if guess.length != LENGTH
      puts "Invalid guess. Try again."
      next
    end
    exact, near = check_guess(guess, code)
    puts "Result: #{exact} exact, #{near} near"
    break if exact == LENGTH
  end
  puts "You couldn't guess the code. The code was: #{code.join}"
end

# Asks the user to be the code creator or guesser
def play_game
  puts "Do you want to be the code creator or the guesser? (c/g)"
  role = gets.chomp.downcase
  if role == 'c'
    play_as_creator
  elsif role == 'g'
    play_as_guesser
  else
    puts "Invalid choice. Try again."
    play_game
  end
end

# Start the game
play_game
