# frozen_string_literal: true

describe Parser do
  it 'throws an error when file not found on given path' do
    unknown_file_path = '/unknown_path/non-existent'
    expect do
      described_class.new(unknown_file_path)
    end.to raise_error("file not found: #{unknown_file_path}")
  end

  it 'throws an error when the file format is not supported' do
    incorrect_format_file = File.join(RSPEC_ROOT, 'fixtures/incorrect_format.json')
    expect { described_class.new(incorrect_format_file) }
      .to raise_error("File format not allowed. Only '.log' extension files allowed")
  end

  it 'does not throw error for valid format file' do
    valid_format_file = File.join(RSPEC_ROOT, 'fixtures/valid_format.log')
    expect { described_class.new(valid_format_file) }.not_to raise_error
  end
end
