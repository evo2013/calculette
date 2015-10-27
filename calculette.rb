require 'pry'
require 'yaml'

LANGUAGE = 'fr'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='fr')
  MESSAGES[lang][message]
end

def prompt(message)
  puts
  Kernel.puts("#{message}")
end

def number?(input)
  integer?(input)  || float?(input)
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def operation_to_message(op)
  word =  case op
            when '1'
              "L'ajout"
            when '2'
              'Soustraction'
            when '3'
              "Multipliant"
            when '4'
              'Divisant'
          end

  word
end

prompt(messages('welcome', 'fr'))

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(messages('valid_name', 'fr'))
  else
    break
  end
end

prompt("Bonjour #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt(messages('first_num', 'fr'))
    number1 = Kernel.gets().chomp()

    if number?(number1)
      break
    else
      prompt(messages('hmm', 'fr'))
    end
  end

  number2 = ''
  loop do
    prompt(messages('second_num', 'fr'))
    number2 = Kernel.gets().chomp()

    if number?(number2)
      break
    else
      prompt(messages('hmm', 'fr'))
    end
  end

  operator_prompt = <<-MSG
    Quelle opération souhaitez-vous effectuer ?
    1) ajouter
    2) soustraire
    3) multiplier
    4) divisent
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('choose', 'fr'))
    end
  end

  prompt("#{operation_to_message(operator)} les deux chiffres...")

  result =  case operator
            when '1'
              number1.to_f() + number2.to_f()
            when '2'
              number1.to_f() - number2.to_f()
            when '3'
              number1.to_f() * number2.to_f()
            when '4'
              number1.to_f() / number2.to_f()
            end

  prompt("Le résultat est #{result}. ")

  prompt(messages('replay', 'fr'))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(messages('bye', 'fr'))
