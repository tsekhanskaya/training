# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'yaml'
require 'csv'

require_relative 'lib/file'
require_relative 'lib/parse'

file = File.new

file.create_filename
file.create_file

def main
  argument = YAML.load_file('lib/arguments.yaml')
  File.create_file(argument['filename'])
end

main
