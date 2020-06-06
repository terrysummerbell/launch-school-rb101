# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

# answer = Kernel.gets()
# Kernel.puts(answer)

# initializes yaml
require 'yaml'
# creates variable 'MESSAGES' and sets it equal to loading in the yaml file
MESSAGES = YAML.load_file('calculator_messages.yml')

# this just shows us in the terminal the values of 'MESSAGES', which shows they're treated as hashes
# it isn't integral to the program
puts MESSAGES.inspect

# defines method 'prompt', which takes an argument of 'message'
# and in the block prints the message, preceded by '=>' to the screen
# this method formats our prompt messages throughout our program
def prompt(message)
  Kernel.puts("=> #{message}")
end

# this method checks that the inputted number is an integer
def integer?(input)
  input.to_i.to_s == input
end

# this method checks that the inputted number is a float
def float?(input)
  input.to_f.to_s == input
end

# this method checks whether the inputted number is either an integer or a float, as defined in the above two methods
def number?(input)
  integer?(input) || float?(input)
end

# this is a case statement, set equal to a variable 'word',
# which returns the appropriate text depending on the operation (1, 2, 3, 4) input by the user
# we return the value of 'word' at the end of the block
def operation_to_message(op)
  word =  case op
          when '1'
            'Adding'
          when '2'
            'Subtracting'
          when '3'
            'Multiplying'
          when '4'
            'Dividing'
          end
  word
end

# returns a message prompt to the screen, which is grabbing the key 'welcome' from the yaml file 
# and returning the associated message, via the 'messages' method passed into it
prompt(MESSAGES['welcome'])

# variable 'name' is initialised outside the loop so it's both accessible inside the loop, and outside it, by the 'prompt' that follows the loop
# the loop is set to receive and check the user input for name - the  user is prompted to provide their name, which is captured by the 'name' variable inside the loop
# the if statement checks if, after the user has hit return, the name variable is empty. If the user hits return without providing a name, the 'valid_name' message is
# dsiplayed and the program loops around to the start of the loop, where the user is expected to type their name
# once the name is entered and returned, i.e. 'name' is not empty, the program breaks out the loop and moves onto the Hi #{name} prompt
name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt "Hi #{name}"

# the main loop starts by initialising the variable 'number1' outside the smaller loop that asks for the first number
# the smaller loop asks for the first number and saves the user input to the variable 'number1'
# the if statement checks if the value of number1 is valid, as determined in the method 'number?' above
# the same loop mechanism is done for the second number, 'number2'
loop do # main loop
  number1 = ''
  loop do
    prompt(MESSAGES['first_number'])
    number1 = Kernel.gets.chomp

    if number?(number1)
      break
    else
      prompt(MESSAGES['error_number'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['second_number'])
    number2 = Kernel.gets.chomp

    if number?(number2)
      break
    else
      prompt(MESSAGES['error_number'])
    end
  end

  # this is a way of formating a string across multiple lines - called a 'heredoc'
  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) Add
    2) Subtract
    3) Multiple
    4) Divide
  MSG

  # this line returns the above heredoc content to the console
  prompt operator_prompt

  # similar to the above number1 and number2 loops, the user's input for their selected operator is saved to the variable 'operator'
  # the if statement is different - it looks to see if the value of operator is included in an array of 4 digits (1, 2, 3, 4)
  # that's the comparison - if the user input for operator is the same as an element in this array, then break. Else, return MESSAGE asking for input 
  operator = ''
  loop do
    operator = Kernel.gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['choose_operator'])
    end
  end

  # this presents the prompt from the case above, in the 'operation_to_message' method 
  prompt "#{operation_to_message(operator)} the two numbers..."

  result =  case operator
            when '1'
              number1.to_i + number2.to_i
            when '2'
              number1.to_i - number2.to_i
            when '3'
              number1.to_i * number2.to_i
            when '4'
              number1.to_f / number2.to_f
            end

  prompt "The result is #{result}"

  # this section loops right back to the start of the main loop again if the user inputs 'y'
  prompt(MESSAGES['calculate_again'])
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['thank_you'])
