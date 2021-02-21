# frozen_string_literal: true

describe Parser do
  describe '.call' do
    it 'prints the errors for invalid path' do
      log_file = File.join(RSPEC_ROOT, 'fixtures', 'non-existent.log')
      expect($stdout).to receive(:puts).with('Given file path does not exists.')
      Parser.call(log_file)
    end

    it 'prints the errors for invalid log file' do
      log_file = File.join(RSPEC_ROOT, 'fixtures', 'incorrect_format.json')
      expect($stdout).to receive(:puts).with("File format not allowed. Only '.log' extension files allowed.")
      Parser.call(log_file)
    end

    it 'prints the page visits and unique page information for valid log file' do
      log_file = File.join(RSPEC_ROOT, 'fixtures', 'test.log')
      expect($stdout).to receive(:puts).with(%r{^/[a-zA-Z_]+/?[a-zA-Z_0-9]* \d+ visits}).exactly(2).times
      expect($stdout).to receive(:puts).with(%r{^/[a-zA-Z_]+/?[a-zA-Z_0-9]* \d+ unique views}).exactly(2).times
      Parser.call(log_file)
    end
  end
end
