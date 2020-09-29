# frozen_string_literal: true

require 'json'

# file manager
class FileManager
  FILE_NAME = 'data.json'

  def read_file
    File.write(FILE_NAME, '[]', mode: 'w') unless File.file?(FILE_NAME)
    data = File.read(FILE_NAME)
    JSON.parse(data)
  end

  def write_file(acao_list)
    File.write(FILE_NAME, JSON.generate(acao_list), mode: 'w')
  end
end
