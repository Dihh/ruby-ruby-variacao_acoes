require 'bundler/setup'

require_relative './menu'

def main
  menu = Menu.new
  loop do
    puts menu.print_options
    print "\nDigite uma opção: "
    option = gets.strip
    system 'clear'
    menu.execute_option option if option != '0'
    puts "\n\n"
    break if option == '0'
  end
  # rescue StandardError => e
  # puts e.message
end

main
