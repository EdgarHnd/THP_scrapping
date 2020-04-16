require 'nokogiri'
require 'open-uri'
require 'json'

def scrapping_deputie_name
    name_array = Array.new
    page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
    list_names = page.xpath("//table//a")
    list_names.each do |name|
        name_array << name.text
    end
    return name_array
end

def scrapping_deputie_link
    link_array = Array.new
    page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
    list_names = page.xpath("//table//a")
    list_names.each do |name|
        temp_name = name.values[0]
        link_array << temp_name
    end
    return link_array
end

def scrapping_deputie_email
    email_array = Array.new
    scrapping_deputie_link.each do |link|
        page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr#{link}"))
        puts "scrapping : #{page.xpath("//*[@id='haut-contenu-page']/article/div[3]/div/dl/dd[4]/ul/li[2]/a").text}"  
        email_array << page.xpath("//*[@id='haut-contenu-page']/article/div[3]/div/dl/dd[4]/ul/li[2]/a").text
    end
    return email_array
end

def final_deputie_array(name,email)
    final_array = Array.new
    name.each do |k|
        result = Hash.new
        result["first_name"] = k.split(" ")[1]
        result["last_name"] = k.split(" ")[2]
        result["email"] = email[name.find_index(k)]
        final_array << result
    end
    return final_array
end

#Method use to make the JSON file
#File.write('deputie_names.json',scrapping_deputie_name.to_json)
#File.write('deputie_email.json',scrapping_deputie_email.to_json)
#File.write('deputie_final.json',JSON.pretty_generate(result_final))

#using the data from my JSON files to save time
names = File.read('deputie_names.json')
emails = File.read('deputie_email.json')

result_final = final_deputie_array(JSON.parse(names),JSON.parse(emails))

puts JSON.pretty_generate(result_final)