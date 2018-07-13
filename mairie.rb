require 'nokogiri'
require 'open-uri'

def get_email(url)
  doc = Nokogiri::HTML(open(url.to_s))
  email = doc.xpath("//main/section[2]//tbody/tr[4]/td[2]")
  email.text
end

def get_url
  doc = Nokogiri::HTML(open("département.html"))
  url = doc.xpath("//a[@class ='lientxt']/@href")
end

def boucle
  hash = {}
  woof = get_url
  woof.each { |url|
    puts url
    puts get_email(url)
    hash.store(url, get_email(url))
  }
  hash
end

puts boucle
