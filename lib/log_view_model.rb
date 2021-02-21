# frozen_string_literal: true

module Parser
  # View model to render the reponse information for client based on request
  # such as unique page view response or number of page visits response
  class LogViewModel
    def initialize(parsed_content)
      @parsed_content = parsed_content
    end

    def sorted_page_data(unique_page_views:)
      page_count_content = @parsed_content.map do |page, ip_address|
        count = unique_page_views ? ip_address.values.size : ip_address.values.sum { |ip| ip[:count] }
        { page: page, count: count }
      end

      page_count_content.sort_by { |content| content[:count] }.reverse!
    end

    def render_response(unique_page_views: false)
      sorted_data = sorted_page_data(unique_page_views: unique_page_views)
      sorted_data.each do |page_data|
        if unique_page_views
          puts "#{page_data[:page]} #{page_data[:count]} unique views"
        else
          puts "#{page_data[:page]} #{page_data[:count]} visits"
        end
      end
    end
  end
end
