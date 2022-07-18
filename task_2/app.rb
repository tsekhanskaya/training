# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'yaml'
require 'csv'
require 'time'

require_relative 'lib/file'
require_relative 'lib/parsing'

def main
  start = Time.now
  argument = YAML.load_file('lib/arguments.yaml')
  File.create_file(argument['filename'])
  Parsing.main_parse(argument['filename'], argument['link'])
  finish = Time.now
  puts "Parsing was #{finish - start} seconds."
end

main
