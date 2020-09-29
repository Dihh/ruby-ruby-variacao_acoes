temp = 2
require_relative '../main'

RSpec.describe 'main' do
  it 'teste' do
    # mockMain = spy('main')
    # expect(mockMain).to have_received
    double('main' => 13)
    main
    expect(true).to eq true
  end
end
