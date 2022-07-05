# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

url = 'https://www.petsonic.com/farmacia-para-gatos/'
html = open(url)

doc = Nokogiri::HTML(html)