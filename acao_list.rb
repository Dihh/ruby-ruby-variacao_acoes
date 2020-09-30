# frozen_string_literal: true

require 'json'

require_relative './file_manager'
require_relative './acao'

# lista de acoes cadastradas
class AcaoList
  def initialize
    @file_manager = FileManager.new
    @acao_list = load
  end

  def listar_todas_acoes
    @acao_list.each do |acao|
      acao.print_acao
    end
  end

  def listar_acao
    code = ask_acao_code
    acao = find_acao(code)
    acao.print_acao
  end

  def criar_acao
    code = ask_acao_code
    acao = Acao.new(code, [])
    @acao_list << acao
    save
  end

  def adicionar_valor_em_acao
    code = ask_acao_code
    acao = find_acao(code)
    date = ask_date
    value = ask_value
    acao.add_value(date, value)
    save
  end

  def edita_codigo_de_uma_acao
    code = ask_acao_code
    acao = find_acao(code)
    new_code = ask_acao_code(new: true)
    acao.code = new_code
    save
  end

  def edita_valor_de_uma_acao
    code = ask_acao_code
    acao = find_acao(code)
    date = ask_date
    index = acao.values.index { |el| el['date'] == date }
    raise 'Data não encontrada' unless index

    new_date = ask_date(new: true)
    new_value = ask_value(new: true)
    acao.edit_value(new_date, new_value, index)
    save
  end

  def deletar_acao
    code = ask_acao_code
    index = @acao_list.index { |el| el.code == code }
    raise 'Ação não encontrada' unless index

    @acao_list.delete_at(index)
    save
  end

  def remover_valor_de_uma_acao
    code = ask_acao_code
    acao = find_acao(code)
    date = ask_date
    index = acao.values.index { |el| el['date'] == date }
    raise 'Data não encontrada' unless index

    acao.values.delete_at(index)
    save
  end

  def ask_value(new: false)
    print "Digite o#{new ? ' novo' : ''} valor: (00,00): "
    value = gets.strip
    raise 'Formato de valor inválido' if value.split(',').length != 2

    value
  end

  def ask_date(new: false)
    print "Digite a#{new ? ' nova' : ''} data: (dd/mm/aaaa): "
    date = gets.strip
    raise 'Formato de data inválido' if date.split('/').length < 3

    date
  end

  def find_acao(code)
    acao = @acao_list.find { |element| element.code == code }
    raise "\nAção não encontrada" unless acao

    acao
  end

  def ask_acao_code(new: false)
    print "\nDigite o#{new ? ' novo' : ''} código da ação (0 - cancelar): "
    code = gets.strip
    raise '' if code == '0'

    code
  end

  def load
    data = @file_manager.read_file
    data.map do |element|
      Acao.new(element['code'], element['values'])
    end
  end

  def save
    hash_acao_list = @acao_list.map(&:to_hash)
    @file_manager.write_file(hash_acao_list)
  end
end
