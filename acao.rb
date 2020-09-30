# frozen_string_literal: true

# Acao da bolsa
class Acao
  attr_accessor :code, :values

  def initialize(code, values)
    @code = code
    @values = values
  end

  def add_value(date, value)
    @values << { 'date' => date, 'value' => value }
  end

  def edit_value(date, value, index)
    @values[index] = { 'date' => date, 'value' => value }
  end

  def to_hash
    {
      'code' => @code,
      'values' => @values
    }
  end

  def print_acao
    puts "Ação: #{@code}\nValores:\n"
    @values.map do |value|
      puts " * #{value['date']}: #{value['value']}\n"
    end
    puts "\n"
  end
end
