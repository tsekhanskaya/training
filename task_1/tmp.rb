# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

url = 'https://www.petsonic.com/farmacia-para-gatos/?categorias=hepaticos'

page = Nokogiri::HTML(URI.open(url))
links = page.xpath('//div[@class="product-desc display_sd"]//a//@href')
links.each do |link|
  page = Nokogiri::HTML(URI.open(link))
  name = page.xpath('//div[@class="nombre_fabricante_bloque col-md-12 desktop"]/*').at_xpath('//h1').text
  sizes = page.xpath('//span [@class="radio_label"]//text()')
  sizes_only = sizes.map do |elem|
    siz = elem.to_s.delete 'a-zA-z'
    puts siz
    data << "#{name} #{siz}"
  end

  prices = page.xpath('//span [@class="price_comb"]//text()')
  prices_only = prices.map do |elem|
    puts elem.to_s.delete '€'
  end
  # images =
  # CSV.open(filename, 'w', write_headers: false, headers: hash_data.first) do |csv|

  #     csv << line.values
  #  end
end
# link = page.xpath('//ul[@class = "product_list grid row af-product-list"]
#    //div[@class="product-container"]//div[@class="pro_first_box"]')
# //a[@class="product_img_link pro_img_hover_scale product-list-category-img"]')
# //*[@id="product_list"]/li[1]/div[1]/div[2]/div[1]/a
