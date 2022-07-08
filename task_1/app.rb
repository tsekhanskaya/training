# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

url = 'https://www.petsonic.com/farmacia-para-gatos/?categorias=hepaticos'

page = Nokogiri::HTML(URI.open(url))
links = page.xpath('//div[@class="product-desc display_sd"]//a//@href')
links.each do |link|
  data = []
  page = Nokogiri::HTML(URI.open(link))
  name = page.xpath('//div[@class="nombre_fabricante_bloque col-md-12 desktop"]/*').at_xpath('//h1').text

  sizes = page.xpath('//span [@class="radio_label"]//text()')
  sizes_only = sizes.map do |elem|
    siz = elem.to_s.delete 'a-zA-z'
    data << "#{name} #{siz}"
  end

  data = data.flatten
  prices = page.xpath('//span [@class="price_comb"]//text()')
  prices_only = prices.map do |elem|
    data << "#{elem.to_s.delete '€'}"
  end

  print data
end
