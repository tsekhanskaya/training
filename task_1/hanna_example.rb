# frozen_string_literal: true

puts 'Connect gems in hanna_example.rb'
require 'curb'
require 'nokogiri'
require 'open-uri'
require 'csv'

EXTENTION_CSV = '.csv'

temp = []
tmp = []

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
    # csv << temp
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
  prices_only.to_s.delete ' '
end

# get only numbers in sizes
def form_name_size(name, sizes)
  sizes.map do |elem|
    "#{name} (#{elem})"
  end
end

# get names, prices, pictures
def find_data(links, tmp)
  links.each do |link|
    new_arr = []
    page = Nokogiri::HTML(URI.open(link))
    name = page.xpath('//div[@class="nombre_fabricante_bloque col-md-12 desktop"]/*').at_xpath('//h1').text
    sizes = page.xpath('//span [@class="radio_label"]//text()')
    normal_name = form_name_size(name, sizes)
    prices = page.xpath('//span [@class="price_comb"]//text()')
    prices = prices_only(prices).to_s
    img = page.xpath('//span [@id ="view_full_size"]//img/ @src').text
    new_arr += [normal_name, prices, img]
    tmp.push new_arr
    # rubocop recommends to delete 11/10 string in thismethod but I need in comments in task
    puts "Page #{link} was parsing."
  end
  tmp
end

def form(tmp)
  result = []
  tmp.each do |elem|
    elem.each_with_index do |el, inx|
      if el.size == 1
        result << el
      else
        result << el[0][inx] # name
        result << el[1][inx] # price
        result << el[2] # img
      end
    end
  end
end

puts 'Begin working'
filename = file_name
create_file(filename, temp = [])
url = getting_url
links = find_products_links(url)
tmp = find_data(links, tmp)
print tmp
form(tmp)
temp << tmp
CSV.open(filename, 'a', write_headers: false) do |csv|
  csv << temp
end
