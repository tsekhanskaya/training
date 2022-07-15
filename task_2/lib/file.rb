# frozen_string_literal: true

require 'csv'

EXTENTION = '.csv'
FIRST_LINE = %w[Name Price Picture].freeze

# class works with file.csv
class File
  attr_reader :name, :price, :img

  def initialize(filename:, name:, price:, img:)
    @filename = filename
    @name = name
    @price = price
    @img = img
  end

  def self.create_filename
    puts 'Enter the file name:'
    filename = gets.strip.chomp.concat(EXTENSION).to_s
    puts "Your file is #{filename}."
  end

  def self.create_file(filename)
    CSV.open(filename, 'w', write_headers: false, headers: FIRST_LINE.first).add_row(FIRST_LINE)
    puts "File #{filename} was created."
  end

  def self.add_to_file(filename, name, price, img)
    product = []
    product.push name: name, price: price, img: img
    CSV.open(filename, 'a', write_headers: false, headers: product.first.keys) do |csv|
      product.each do |elem|
        csv << elem.values
      end
    end
  end
end