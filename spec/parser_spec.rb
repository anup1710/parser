# frozen_string_literal: true

describe Parser do
  it 'throws an error when file not found on given path' do
    expect do
      described_class.new('/unknown_path/non-existent')
    end.to raise_error(Parser::FileNotFound, 'Given file path does not exists.')
  end

  it 'throws an error when the file format is not supported' do
    incorrect_format_file = File.join(RSPEC_ROOT, 'fixtures/incorrect_format.json')
    expect { described_class.new(incorrect_format_file) }
      .to raise_error(Parser::InvalidFileFormat, "File format not allowed. Only '.log' extension files allowed.")
  end

  it 'does not throw error for valid format file' do
    valid_format_file = File.join(RSPEC_ROOT, 'fixtures/valid_format.log')
    expect { described_class.new(valid_format_file) }.not_to raise_error
  end
end
