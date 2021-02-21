# frozen_string_literal: true

module Parser
  # loads the file from given path, validates
  # and read the content from file
  class File
    SUPPORTED_FORMATS = ['.log'].freeze
    attr_reader :errors

    def initialize(path)
      @path = path
      @errors = []
      @content = []
    end

    def content
      return @content unless @content.empty?

      @content = ::File.read(@path).split(/\n/)
    end

    def valid?
      validate!
      @errors.empty?
    end

    private

    def validate!
      validate_file_presence
      validate_file_format
    end

    def validate_file_presence
      return if ::File.exist?(@path)

      @errors << 'Given file path does not exists.'
    end

    def validate_file_format
      return if SUPPORTED_FORMATS.include?(::File.extname(@path))

      errors << "File format not allowed. Only '.log' extension files allowed."
    end
  end
end
