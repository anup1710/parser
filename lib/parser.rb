# frozen_string_literal: true

require_relative 'file'
require_relative 'log_content_parser'
require_relative 'log_view_model'

# parse the file and return the result view for client
module Parser
  def self.call(path)
    file = Parser::File.new(path)
    return puts file.errors.join("\n\n") unless file.valid?

    parsed_content = Parser::LogContentParser.new(file.content).parse

    log_view_model = Parser::LogViewModel.new(parsed_content)
    log_view_model.render_response

    log_view_model.render_response(unique_page_views: true)
  end
end
