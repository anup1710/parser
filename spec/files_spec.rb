# frozen_string_literal: true

describe Parser::File do
  it 'validates the file and add error when file not found for given path' do
    file = described_class.new('/unknown_path/non-existent')
    expect(file.valid?).to be_falsey
    expect(file.errors).to include('Given file path does not exists.')
  end

  it 'validates the file and add error when format not supported' do
    incorrect_format_file = File.join(RSPEC_ROOT, 'fixtures/incorrect_format.json')
    file = described_class.new(incorrect_format_file)
    expect(file.valid?).to be_falsey
    expect(file.errors).to include("File format not allowed. Only '.log' extension files allowed.")
  end

  it 'validates and does not add error for valid format file' do
    valid_format_file = File.join(RSPEC_ROOT, 'fixtures/valid_format.log')
    file = described_class.new(valid_format_file)
    expect(file.errors).to be_empty
  end

  it 'reads the content of valid file' do
    file = described_class.new(File.join(RSPEC_ROOT, 'fixtures/valid_format.log'))
    expected_content = ['/help_page/1 126.318.035.038', '/contact 184.123.665.067']
    expect(file.content).to eq(expected_content)
  end
end
