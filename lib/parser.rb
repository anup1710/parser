# frozen_string_literal: true

# loads the file from given path
class Parser
  def initialize(path)
    raise "file not found: #{path}" unless File.exist?(path)
  end
end
