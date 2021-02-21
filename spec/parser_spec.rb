# frozen_string_literal: true

describe Parser do
  it 'throws an error when file not found on given path' do
    unknown_file_path = '/unknown_path/non-existent'
    expect do
      described_class.new(unknown_file_path)
    end.to raise_error("file not found: #{unknown_file_path}")
  end
end
