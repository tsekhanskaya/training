# frozen_string_literal: true

puts 'Connect gems in hanna_example.rb'
require 'curb'
require 'nokogiri'
require 'open-uri'
require 'csv'

EXTENTION_CSV = '.csv'

temp = []

# enter link with nessesary category of products
def getting_url
  puts 'Insert link for selected category:'
  url = gets
  url.strip
end

# get the filename
def file_name
  puts 'Enter the file name:'
  filename = gets
  filename += EXTENTION_CSV
  puts "Your file is #{filename}."
  filename.to_s
end

# create file
def create_file(filename, temp)
  temp << 'Name, Price, Picture'
  CSV.open(filename, 'w', write_headers: false, headers: temp.first) do |csv|
    csv << temp
  end
  puts "File #{filename} was created."
end

# get category links
def find_products_links(url)
  page = Nokogiri::HTML(URI.open(url))
  page.xpath('//div[@class="product-desc display_sd"]//a//@href')
end

# get only numbers in prices
def prices_only(prices)
  prices_only = prices.map do |elem|
    elem.to_s.delete '€'
  end
  prices_only.to_s.strip
end

# get only numbers in sizes
def form_name_size(name, sizes)
  sizes.map do |elem|
    siz = elem.to_s.delete 'a-zA-z'
    "#{name} #{siz}"
  end
end

# get names, prices, pictures
def find_data(links, temp)
  links.each do |link|
    page = Nokogiri::HTML(URI.open(link))
    name = page.xpath('//div[@class="nombre_fabricante_bloque col-md-12 desktop"]/*').at_xpath('//h1').text
    sizes = page.xpath('//span [@class="radio_label"]//text()')
    normal_name = form_name_size(name, sizes)
    prices = page.xpath('//span [@class="price_comb"]//text()')
    prices = prices_only(prices)
    puts prices
    img = page.xpath('//span [@id ="view_full_size"]//img/ @src').text
    temp += [normal_name, prices, img]
    # rubocop recommends to delete 11/10 string in thismethod but I need in comments in task
    puts "Page #{link} was parsing."
  end
  temp
end

puts 'Begin working'
filename = file_name
create_file(filename, temp = [])
url = getting_url
links = find_products_links(url)
temp = find_data(links, temp)
CSV.open(filename, 'a', write_headers: false, headers: temp.first) do |csv|
  csv << temp
end
