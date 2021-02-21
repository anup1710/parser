# frozen_string_literal: true

module Parser
  # Parse the content to read the page and IP address related information
  # e.g count of page visits per IP address
  class LogContentParser
    def initialize(content)
      @content = content
    end

    def parse
      @content.each_with_object({}) do |line, logs|
        next if line.strip.empty?

        page_count_per_ip_address(line, logs)
      end
    end

    private

    def page_count_per_ip_address(line, logs)
      page, ip_address = line.split

      if logs[page] && logs[page][ip_address]
        logs[page][ip_address][:count] += 1
      else
        logs[page] = {} if logs[page].nil?
        logs[page][ip_address] = { count: 1 }
      end
    end
  end
end
