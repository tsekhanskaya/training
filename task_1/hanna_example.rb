# frozen_string_literal: true

puts 'Connect gems in hanna_example.rb'
require 'curb'
require 'nokogiri'
require 'open-uri'
require 'csv'

EXTENTION_CSV = '.csv'

def getting_url
  puts 'Insert link for selected category:'
  url = get
  url.strip
end

def file_name
  puts 'Enter the file name:'
  filename = get
  filename += EXTENTION_CSV
  puts "Your file is #{filename} was created."
  filename
end

def create_file(filename)
  hash_data = []
  hash_data << 'Name, Price, Picture'
  CSV.open(filename, 'w', write_headers: false, headers: hash_data.first) do |csv|
    hash_data.each do |line|
      csv << line.values
    end
  end
  puts 'hj'
  puts 'hj'
  puts 'hj'
  puts 'hj'
  puts "File #{filename} was created."
end

def add_file; end

def parsing_link(url)
  puts 'Connect to site'
  page = Nokogiri::HTML(URI.open(url))
  puts 'Search for nodes by xpath'
  page.xpath('//*[@id="product_list"]').each do |link|
    hash << link.content
  end
end

puts 'Begin working'
file_name
create_file
url = getting_url
parsing_link(url)
