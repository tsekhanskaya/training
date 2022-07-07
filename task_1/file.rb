# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
# fetch and parse HTML document
puts 'Fetch and parse HTML document.'
doc = Nokogiri::HTML(URI.open('https://www.petsonic.com/farmacia-para-gatos/'))
puts 'Fetch and parse HTML document successfully.'
# csv = CSV.new(string_or_io, **options)

# write
# CSV.open('csv.csv', 'wb') do |csv|
# Search for nodes by xpath
puts 'Search for nodes by xpath'
doc
  .xpath('/html/body/div[1]/div/div[5]/div/div/div[2]/div[2]/ul')
  .each do |link|
  # csv << link.content
  puts link.content
end
# end
