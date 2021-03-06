# frozen_string_literal: true

puts 'Connect gems in hanna_example.rb'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'time'

EXTENTION_CSV = '.csv'
FIRST_LINE = %w[Name Price Picture].freeze

# enter link with nessesary category of products
def request_url
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
  CSV.open(filename, 'w', write_headers: false, headers: FIRST_LINE.first).add_row(FIRST_LINE)
  puts "File #{filename} was created."
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

# get links 11 pages
def request_links_of_all_pages(url)
  pages = []
  page = Nokogiri::HTML(URI.open(url))
  last_page = page.xpath('//*[@id="pagination_bottom"]/ul/li[6]/a/span').text
  count = last_page.to_i
  count.times { |number_pages| pages.push(number_pages + 1) }
  pages.map { |elem| "#{url}?p=#{elem}" } # is links_pages (11)
end

# find products links
def find_products_links_on_one_page(url)
  page = Nokogiri::HTML(URI.open(url))
  links_products_on_one_page = []
  page.xpath('//div[@class="product-desc display_sd"]//a//@href').each do |elem|
    links_products_on_one_page << elem.text
  end
  links_products_on_one_page
end

# find all product links
def find_products_links(links_pages)
  all_product_links = []
  links_pages.each do |link|
    all_product_links += find_products_links_on_one_page(link)
  end
  all_product_links
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

# divide product into table template and add to file
def add_product(filename, normal_name, prices, img)
  product = []
  product.push normal_name, prices, img
  product.each do |elem|
    elem.each_index do |index_item| # go by name
      if elem.size == 1
        # filename, name, price, picture
        add_to_file(filename, product[0][0], product[1][0], product[2])
      else
        # filename, name, price, picture
        add_to_file(filename, product[0][index_item], product[1][index_item], product[2])
      end
    end
    break
  end
end

# get names, prices, pictures
def parse_one_page(filename, links_products_on_one_page)
  links_products_on_one_page.each do |link|
    puts "The page #{link} starts to parse."
    page = Nokogiri::HTML(URI.open(link))

    name = page.xpath('//div[@class="nombre_fabricante_bloque col-md-12 desktop"]/*').at_xpath('//h1')
    name = name.text unless name.nil?

    sizes = page.xpath('//span [@class="radio_label"]//text()')

    normal_name = form_name_size(name, sizes)

    prices = page.xpath('//span [@class="price_comb"]//text()')
    prices = prices_only(prices)

    img = page.xpath('//span [@id ="view_full_size"]//img/ @src').text

    add_product(filename, normal_name, prices, img) unless normal_name == [] || prices == [] || img == []
    puts "The page #{link} has been parsed."
  end
end

def main
  start = Time.now
  puts "Beginning of work at #{start}"
  filename = create_filename
  create_file(filename)
  url = request_url
  links_pages = request_links_of_all_pages(url) # array with 11 links
  all_links_products = find_products_links(links_pages)
  parse_one_page(filename, all_links_products)
  finish = Time.now
  puts "Finish of work at #{finish}"
  puts "Parsing was #{finish - start} seconds."
end

main
