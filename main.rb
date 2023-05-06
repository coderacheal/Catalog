require_relative './classes/app'

def main
  start = App.new
  loop do
    start.start
  end
end

main
