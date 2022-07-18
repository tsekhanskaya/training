# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'yaml'
require 'csv'

require_relative 'lib/file'
require_relative 'lib/parse'

def main
  argument = YAML.load_file('lib/arguments.yaml')
  File.create_file(argument['filename'])
  Parsing.main_parse(argument['filename'], argument['link'])
end

main
