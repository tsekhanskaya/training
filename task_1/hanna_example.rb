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
    elem.to_s.delete ' €'
  end
  prices_only.to_a
end

# get only numbers in sizes
def form_name_size(name, sizes)
  sizes.map do |elem|
    "#{name.to_s.strip} (#{elem})"
  end
end

# get names, prices, pictures
def parse_page(links, tmp = [])
  links.each do |link|
    new_arr = []
    page = Nokogiri::HTML(URI.open(link))
    name = page.xpath('//div[@class="nombre_fabricante_bloque col-md-12 desktop"]/*').at_xpath('//h1').text
    sizes = page.xpath('//span [@class="radio_label"]//text()')
    normal_name = form_name_size(name, sizes)
    prices = page.xpath('//span [@class="price_comb"]//text()')
    prices = prices_only(prices)
    img = page.xpath('//span [@id ="view_full_size"]//img/ @src').text
    unless normal_name == [] || prices == [] || img == []
      new_arr += [normal_name, prices, img.split] # normal_name,prices, img is elements of array
      tmp.push new_arr
    end
    # rubocop recommends to delete 12/10 strings in this method but I need add comments in task
    puts "Page #{link} was parsing."
  end
  print tmp
  tmp
end

def add_one_string(product); end

def form(products)
  # result = []
  # get my data about products
  products.each do |product|
    # get information about all names, prices, pictures
    product.each_with_index do |elem, index_elem|
      # information about names or prices or pictures
      elem.each_with_index do |_item, _index_item|
        if elem.size == 1
          result << "#{elem[0]}, #{elem[1]}, #{elem[2]}"
          break
        else
          result << "#{elem[0][index_elem]}, #{elem[1][index_elem]}, #{elem[2]}" # add name, price, picture
        end
      end
    end
  end
  result
end

def main
  puts 'Begin working'
  filename = file_name
  create_file(filename, temp = [])
  url = getting_url
  links = find_products_links(url)
  tmp = parse_page(links, tmp = [])
  form(tmp)
  temp << tmp
  CSV.open(filename, 'a', write_headers: false) do |csv|
    temp.each do |elem|
      csv << elem
    end
  end
end

main
