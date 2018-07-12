require 'nokogiri'
require 'open-uri'
doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

coin = doc.xpath("//table/tbody/tr/td[@class = 'no-wrap currency-name']/@data-sort")
value = doc.xpath("//a[@class = 'price']")
value_array = []
name_array = []
coin.each { |nom|
  name_array << nom
}
value.each { |value|
  value_array << value.text
}
super_hash = {}
i = 0

name_array.size.times do
  super_hash.store((name_array[i]).to_s, value_array[i])
  i += 1
end
puts super_hash
