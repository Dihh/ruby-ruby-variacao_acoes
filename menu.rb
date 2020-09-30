# frozen_string_literal: true

require_relative './acao_list'

# system control
class Menu
  def initialize
    @acao_list = AcaoList.new
    @options = set_options
  end

  def set_options
    options = {}
    acao_list_methods = (@acao_list.methods - Object.methods)
    acao_list_methods.each_with_index.map do |acao_method, index|
      case acao_method.to_s
      when 'load'
        next
      when 'save'
        next
      when 'ask_value'
        next
      when 'ask_date'
        next
      when 'find_acao'
        next
      when 'ask_acao_code'
        next
      else
        options[(index + 1).to_s] = { 'method' => @acao_list.method(acao_method), 'text' => acao_method }
      end
    end
    options
  end

  def print_options
    menu_options = @options.map do |key, value|
      "#{key} - #{value['text'].to_s.split('_').join(' ')}"
    end
    menu_options << '0 - sair'
  end

  def execute_option(option)
    @options[option]['method'].call if @options[option]
  rescue StandardError => e
    puts e.message == 'invalid date' ? 'Data inválida' : e.message
  end
end
