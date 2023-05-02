require_relative './modules/app'

def main
  app = App.new
  app.program_title
  option = ''

  exit_program = lambda {
    puts 'BYE!!! SEE YOU WHEN YOU HAVE NEW THINGS TO ARCHIVE!'
    exit
  }

  while option != '0'
    app.all_options
    option = gets.chomp
    app.execute_option unless option == '0'
  end
  exit_program.call
end

main
