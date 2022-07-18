# frozen_string_literal: true

require_relative 'file'

# class for product (consist of name, price and picture)
class Product
  attr_accessor :normal_name, :prices, :img

  def initialize(normal_name, prices, img)
    @normal_name = normal_name
    @prices = prices
    @img = img
  end

  # divide product into table template and add to file
  def self.add_product(filename, normal_name, prices, img)
    product = []
    product.push normal_name, prices, img
    product.each do |elem|
      elem.each_index do |index_item| # go by name
        if elem.size == 1
          # filename, name, price, picture
          File.add_to_file(filename, product[0][0], product[1][0], product[2])
        else
          # filename, name, price, picture
          File.add_to_file(filename, product[0][index_item], product[1][index_item], product[2])
        end
      end
      break
    end
  end
end
