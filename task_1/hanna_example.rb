# frozen_string_literal: true

puts 'Connect gems in hanna_example.rb'
require 'curb'
require 'nokogiri'
require 'open-uri'
require 'csv'

EXTENTION_CSV = '.csv'

# enter link with nessesary category of products
def getting_url
  puts 'Insert link for selected category:'
  url = gets
  url.strip
end

# get the filename
def create_filename
  puts 'Enter the file name:'
  filename = gets
  filename += EXTENTION_CSV
  puts "Your file is #{filename}."
  filename.to_s
end

# create file
def create_file(filename)
  first_line = []
  first_line.push 'Name', 'Price', 'Picture'
  CSV.open(filename, 'w', write_headers: false, headers: first_line.first) do |csv|
    csv << first_line
  end
  puts "File #{filename} was created."
end

# find products links
def find_products_links(url)
  page = Nokogiri::HTML(URI.open(url))
  page.xpath('//div[@class="product-desc display_sd"]//a//@href')
end

# get only numbers in prices
def prices_only(prices)
  price = prices.map do |elem|
    elem.to_s.delete ' €'
  end
  price.to_a
end

# get only numbers in sizes
def form_name_size(name, sizes)
  sizes.map do |elem|
    "#{name.to_s.strip} (#{elem})"
  end
end

# fornating one_to_one and add to file
def format_one_product_one_name_one_price(filename, normal_name, prices, img)
  product = []
  product.push normal_name, prices, img
  product.each do |elem|
    elem.each_index do |index_item| # go by name
      if elem.size == 1
        # filename, name, price, pictures
        add_to_file(filename, product[0][0], product[1][0], product[2][0])
      else
        # filename, name, price, pictures
        add_to_file(filename, product[0][index_item], product[1][index_item], product[2])
      end
    end
    break
  end
end

# get names, prices, pictures
def parse_page(filename, links)
  links.each do |link|
    page = Nokogiri::HTML(URI.open(link))
    name = page.xpath('//div[@class="nombre_fabricante_bloque col-md-12 desktop"]/*').at_xpath('//h1').text
    sizes = page.xpath('//span [@class="radio_label"]//text()')
    normal_name = form_name_size(name, sizes)
    prices = page.xpath('//span [@class="price_comb"]//text()')
    prices = prices_only(prices)
    img = page.xpath('//span [@id ="view_full_size"]//img/ @src').text

    unless normal_name == [] || prices == [] || img == []
      format_one_product_one_name_one_price(filename, normal_name, prices,
                                            img)
    end

    puts "Page #{link} was parsing."
  end
end

def add_to_file(filename, normal_name, prices, img)
  product = []
  product.push name: normal_name, price: prices, img: img
  CSV.open(filename, 'a', write_headers: false, headers: product.first.keys) do |csv|
    product.each do |elem|
      csv << elem.values
    end
  end
end

def main
  puts 'Begin working'
  filename = create_filename
  create_file(filename)
  url = getting_url
  links = find_products_links(url)
  parse_page(filename, links)
  puts 'Finish working'
end

main
