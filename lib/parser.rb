# frozen_string_literal: true

# parse the file and return the result view for client
module Parser
  def self.call(path)
    file = Parser::File.new(path)
    return puts file.errors.join("\n\n") unless file.valid?

    parsed_content = Parser::LogContentParser.new(file.content).parse

    parsed_content.each do |page, ip_addresses|
      puts "#{page} #{ip_addresses.values.sum { |ip| ip[:count] }} visits"
      puts "#{page} #{ip_addresses.values.size} unique views"
    end
  end
end
