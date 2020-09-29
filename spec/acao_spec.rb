require_relative '../acao'

RSpec.describe Acao, '#score' do
  context 'asdf' do
    it 'teste' do
      acao = Acao.new('001', [])
      expect(acao.code).to eq '001'
    end
  end
end
