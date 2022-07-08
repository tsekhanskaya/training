# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

url = 'https://www.petsonic.com/farmacia-para-gatos/?categorias=cognitivos-neurologicos-para-gatos'

page = Nokogiri::HTML(URI.open(url))
puts page
