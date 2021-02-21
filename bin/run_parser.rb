#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/parser'

file_path = ARGV[0]

if file_path
  Parser.call(file_path)
else
  puts 'Please provide file to parse.'
end
