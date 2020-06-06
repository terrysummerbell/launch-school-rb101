# ask the user for the loan amount
# ask the user for the interest rate
# ask the user for the loan duration
# return the monthly payments using the formula

# Initialize YAML
require 'yaml'

# Create variable and set it equal to the YAML file
MESSAGES = YAML.load_file('mortgage_messages.yml')

def prompt(message)
  puts "=> #{message}"
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

loop do # main loop
  prompt(MESSAGES['welcome'])
  prompt(MESSAGES['amount'])
  
  # get the amount from the user
  amount = ''
  loop do
    amount = gets.chomp

    # check the inputted value is a number
    if number?(amount)
      break
    else
      prompt(MESSAGES['error_number'])
    end
  end

  prompt(MESSAGES['interest_amount'])
  prompt(MESSAGES['interest_example'])

  interest_rate = ''
  loop do
    interest_rate = gets.chomp

    if number?(interest_rate)
      break
    else
      prompt(MESSAGES['error_number'])
    end
  end

  prompt(MESSAGES['loan_duration'])

  duration = ''
  loop do
    duration = gets.chomp

    if number?(duration)
      break
    else
      prompt(MESSAGES['error_number'])
    end
  end

  # complex mortgage calculation
  annual_interest_rate = interest_rate.to_f() / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = duration.to_i() * 12

  monthly_payment = amount.to_f() * 
                    (monthly_interest_rate / 
                    (1 - (1 + monthly_interest_rate)**(-months)))


  prompt 'Thank you for your details'
  sleep(1)
  prompt 'Calculating monthly payment...'
  sleep(2)

  # complex way of telling the complex mortgage formula
  prompt "Your mortgage monthly repayment is: $#{format('%.2f', monthly_payment)}"

  prompt(MESSAGES['calculate_again'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['thank_you'])
