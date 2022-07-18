# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require_relative 'file'
require_relative 'product'

# class for parse information by web-site
class Parsing
  # get links 11 pages
  def self.request_links_of_all_pages(url)
    pages = []
    page = Nokogiri::HTML(URI.open(url))
    last_page = page.xpath('//*[@id="pagination_bottom"]/ul/li[6]/a/span').text
    count = last_page.to_i
    count.times { |number_pages| pages.push(number_pages + 1) }
    pages.map { |elem| "#{url}?p=#{elem}" } # is links_pages (11)
  end

  # find products links
  def self.find_products_links_on_one_page(url)
    page = Nokogiri::HTML(URI.open(url))
    links_products_on_one_page = []
    page.xpath('//div[@class="product-desc display_sd"]//a//@href').each do |elem|
      links_products_on_one_page << elem.text
    end
    links_products_on_one_page
  end

  # find all product links
  def self.find_products_links(links_pages)
    all_product_links = []
    links_pages.each do |link|
      all_product_links += find_products_links_on_one_page(link)
    end
    all_product_links
  end

  # get only numbers in prices
  def self.prices_only(prices)
    price = prices.map do |elem|
      elem.to_s.delete ' €'
    end
    price.to_a
  end

  # get only numbers in sizes
  def self.form_name_size(name, sizes)
    sizes.map do |elem|
      "#{name.to_s.strip} (#{elem})"
    end
  end

  # get names, prices, pictures
  def self.parse_one_page(filename, links_products_on_one_page)
    thread = []
    links_products_on_one_page.each do |link|
      thread << Thread.new do
        puts "The page #{link} starts to parse."
        page = Nokogiri::HTML(URI.open(link))

        name = page.xpath('//div[@class="nombre_fabricante_bloque col-md-12 desktop"]/*').at_xpath('//h1')
        name = name.text unless name.nil?

        sizes = page.xpath('//span [@class="radio_label"]//text()')

        normal_name = form_name_size(name, sizes)

        prices = page.xpath('//span [@class="price_comb"]//text()')
        prices = prices_only(prices)

        img = page.xpath('//span [@id ="view_full_size"]//img/ @src').text
        product = Product.new (normal_name, prices, img)
        unless product.normal_name == [] || product.prices == [] || product.img == []
          Product.add_product(filename, product.normal_name, product.prices,
            product.img)
        end
        puts "The page #{link} has been parsed."
      end
      thread.each(&:join)
    end
  end

  # main method to parse
  def self.main_parse(filename, url)
    links_pages = request_links_of_all_pages(url) # array with 11 links
    all_links_products = find_products_links(links_pages)
    parse_one_page(filename, all_links_products)
  end
end
