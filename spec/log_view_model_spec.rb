# frozen_string_literal: true

describe Parser::LogViewModel do
  let(:parsed_content) do
    { '/help_page/1' => { '126.318.035.038' => { count: 5 },
                          '929.398.951.877' => { count: 9 },
                          '929.398.951.889' => { count: 1 } },
      '/home' => { '184.123.665.067' => { count: 5 },
                   '316.433.849.805' => { count: 1 } },
      '/contact' => { '184.123.665.067' => { count: 7 } } }
  end

  describe '#sorted_page_data' do
    it 'returns the descending page count data for unique page views' do
      log_view_model = described_class.new(parsed_content)
      result = log_view_model.sorted_page_data(unique_page_views: true)

      expect(result).to eq([{ page: '/help_page/1', count: 3 },
                            { page: '/home', count: 2 },
                            { page: '/contact', count: 1 }])
    end

    it 'returns the descending page count data for non unique page views' do
      log_view_model = described_class.new(parsed_content)
      result = log_view_model.sorted_page_data(unique_page_views: false)

      expect(result).to eq([{ page: '/help_page/1', count: 15 },
                            { page: '/contact', count: 7 },
                            { page: '/home', count: 6 }])
    end
  end

  describe '#render_response' do
    it 'renders the unique page views response' do
      log_view_model = described_class.new(parsed_content)
      expect($stdout).to receive(:puts).with('/help_page/1 3 unique views').ordered
      expect($stdout).to receive(:puts).with('/home 2 unique views').ordered
      expect($stdout).to receive(:puts).with('/contact 1 unique views').ordered
      log_view_model.render_response(unique_page_views: true)
    end

    it 'renders the non-unique page views response' do
      log_view_model = described_class.new(parsed_content)
      expect($stdout).to receive(:puts).with('/help_page/1 15 visits').ordered
      expect($stdout).to receive(:puts).with('/contact 7 visits').ordered
      expect($stdout).to receive(:puts).with('/home 6 visits').ordered
      log_view_model.render_response(unique_page_views: false)
    end
  end
end
