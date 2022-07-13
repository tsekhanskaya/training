# frozen_string_literal: true

puts 'Connect gems in hanna_example.rb'
require 'curb'
require 'nokogiri'
require 'open-uri'
require 'csv'

EXTENTION_CSV = '.csv'

# temp = []
# tmp = []

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
  temp = []
  temp.push 'Name', 'Price', 'Picture'
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

# get names, prices, pictures
def parse_page(filename, links)
  links.each do |link|
    # new_arr = []
    page = Nokogiri::HTML(URI.open(link))
    name = page.xpath('//div[@class="nombre_fabricante_bloque col-md-12 desktop"]/*').at_xpath('//h1').text
    sizes = page.xpath('//span [@class="radio_label"]//text()')
    normal_name = form_name_size(name, sizes)
    prices = page.xpath('//span [@class="price_comb"]//text()')
    prices = prices_only(prices)
    img = page.xpath('//span [@id ="view_full_size"]//img/ @src').text
    add_to_file(filename, normal_name, prices, img) unless normal_name == [] || prices == [] || img == []
    # unless normal_name == [] || prices == [] || img == []
    #   add_to_file(filename, normal_name, prices, img)
    #   new_arr += [normal_name, prices, img.split] # normal_name,prices, img is elements of array
    #   products.push new_arr
    # end
    # rubocop recommends to delete 12/10 strings in this method but I need add comments in task
    puts "Page #{link} was parsing."
  end
  # products
end

def add_to_file(filename, normal_name, prices, img)
  product = []
  p "#{normal_name.class}, #{prices.class}, #{img.class}"
  product.push "#{normal_name}, #{prices}, #{img}"
  CSV.open(filename, 'a', write_headers: false) do |csv|
    csv << product
    # product.each do |elem|
    #   csv << elem
    # end
  end
end

# def split_data_to_form(products)
#   result = []
#   temp = []
#   # get my data about products
#   products.each do |product|
#     # get information about all names, prices, pictures
#     product.each do |elem|
#       # information about names or prices or pictures
#       elem.each_index do |index_item|
#         if elem.size == 1
#           temp.push product[0], product[1], product[2] # add name, price, picture
#         else
#           temp.push product[0][index_item], product[1][index_item], product[2] # add name, price, picture
#         end
#         result << temp
#       end
#       break
#     end
#   end
#   result
# end

def main
  puts 'Begin working'
  filename = create_filename
  create_file(filename)
  url = getting_url
  links = find_products_links(url)
  parse_page(filename, links)
  # tmp = parse_page(links, tmp = [])
  # data = split_data_to_form(tmp)
  # data.each { |product| add_to_file(filename, product) }
  # temp << tmp
  puts 'Finish working'
end

main
