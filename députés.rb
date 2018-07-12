require 'nokogiri'
require 'open-uri'
def get_url
  doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  url = doc.xpath("//ul[@class = 'col3']//a/@href")
end

def get_email(url_député)
  doc = Nokogiri::HTML(open(url_député))
  email = doc.xpath("/html/body/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[1]/a/@href")
  email = email.to_s.delete_prefix!("mailto:")
end

def get_first_and_last_name
  doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  url = doc.xpath("//ul[@class = 'col3']//a")
  super_array = []
  url.each { |nom|
    hash = {}
    #get attribute of <a>
    #prend le href de la liste des attributes
    url_député_attributes = nom.attributes
    url_député = url_député_attributes["href"]
    url_député = "http://www2.assemblee-nationale.fr" + url_député.to_s
    #prend le txt à l'intérieur du <a>
    nom = nom.text
    # clean nom
    nom.delete_prefix!("M. ")
    nom.delete_prefix!("Mme ")
    # division du nom
    array = nom.split
    # hash personel
    hash.store("last_name", array[0])
    #drop(1) càd on enlève le prénom, 
    #puis on join ce qu'il reste càd ça marche avec les noms composés
    hash.store("first_name", array.drop(1).join(" "))
    hash.store("email", get_email(url_député))
    # hash personal dans le super_array
    puts hash
    super_array << hash
  }
  super_array
end

get_first_and_last_name


