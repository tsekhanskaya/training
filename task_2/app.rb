# frozen_string_literal: true

require_relative 'lib/file'
require_relative 'lib/parse'

file = File.new

file.create_filename
file.create_file
