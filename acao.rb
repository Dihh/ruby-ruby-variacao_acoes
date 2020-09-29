# frozen_string_literal: true

# Acao da bolsa
class Acao
  attr_reader :code, :values

  def initialize(code, values)
    @code = code
    @values = values
  end

  def add_value(date, value)
    @values << { date => date, value => value }
  end

  def to_hash
    {
      'code' => @code,
      'values' => @values
    }
  end
end
