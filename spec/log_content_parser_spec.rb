# frozen_string_literal: true

describe Parser::LogContentParser do
  it 'returns the parsed content for page with count and ip address information' do
    expect_parsed_log_to_eq(
      content: ['/help_page/1 126.318.035.038', '/contact 184.123.665.067', '/help_page/1 929.398.951.889'],
      expected_parsed_log: { '/help_page/1' => { '126.318.035.038' => { count: 1 },
                                                 '929.398.951.889' => { count: 1 } },
                             '/contact' => { '184.123.665.067' => { count: 1 } } }
    )
  end

  it 'increases the count of page for same IP address' do
    expect_parsed_log_to_eq(
      content: ['/help_page/1 126.318.035.038', '/help_page/1 126.318.035.038'],
      expected_parsed_log: { '/help_page/1' => { '126.318.035.038' => { count: 2 } } }
    )
  end

  it 'does not increase the count of page for different IP addresses' do
    expect_parsed_log_to_eq(
      content: ['/help_page/1 126.318.035.038', '/help_page/1 929.398.951.889'],
      expected_parsed_log: { '/help_page/1' => { '126.318.035.038' => { count: 1 },
                                                 '929.398.951.889' => { count: 1 } } }
    )
  end

  it 'skips the any blank line in the content' do
    expect_parsed_log_to_eq(
      content: ['/help_page/1 126.318.035.038', ' '],
      expected_parsed_log: { '/help_page/1' => { '126.318.035.038' => { count: 1 } } }
    )
  end

  private

  def expect_parsed_log_to_eq(content:, expected_parsed_log:)
    parsed_logs = described_class.new(content).parse
    expect(parsed_logs).to eq(expected_parsed_log)
  end
end
