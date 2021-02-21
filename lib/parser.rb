# frozen_string_literal: true

# loads the file from given path and validates
class Parser
  SUPPORTED_FILE_FORMATS = ['.log'].freeze

  class FileNotFound < ArgumentError; end

  class InvalidFileFormat < ArgumentError; end

  def initialize(path)
    @path = path
    validate!
  end

  private

  def validate!
    validate_file_presence
    validate_file_format
  end

  def validate_file_presence
    raise FileNotFound, 'Given file path does not exists.' unless File.exist?(@path)
  end

  def validate_file_format
    return if SUPPORTED_FILE_FORMATS.include?(File.extname(@path))

    raise InvalidFileFormat, "File format not allowed. Only '.log' extension files allowed."
  end
end
