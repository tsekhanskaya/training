# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'httparty'

url = 'https://www.petsonic.com/farmacia-para-gatos/'
uri = URI.parse(url)

response = Net::HTTP.get_response(uri)
html = response.body

puts html
