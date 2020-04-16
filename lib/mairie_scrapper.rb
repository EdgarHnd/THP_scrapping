require 'nokogiri'
require 'open-uri'

def scrapping_mairie_name
    name_array = Array.new
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))  
    list_names = page.xpath("//table//a[@class = 'lientxt']")
    list_names.each do |name|
        name_array << name.text.capitalize
    end
    return name_array
end

def scrapping_mairie_link
    link_array = Array.new
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))  
    list_names = page.xpath("//table//a[@class = 'lientxt']")
    list_names.each do |name|
        temp_name = name.values[1]
        link_array << temp_name[1...-5]
    end
    return link_array
end

def scrapping_mairie_email
    email_array = Array.new
    scrapping_mairie_link.each do |link|
        page = Nokogiri::HTML(open("http://annuaire-des-mairies.com#{link}.html"))
        puts "scrapping : #{page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text}"  
        email_array << page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    end
    return email_array
end

def final_mairie_array(name,email)
    final_array = Array.new
    name.each do |k|
        result = Hash.new
        result[k] = email[name.find_index(k)]
        final_array << result
    end
    return final_array
end

puts final_mairie_array(scrapping_mairie_name,scrapping_mairie_email)
