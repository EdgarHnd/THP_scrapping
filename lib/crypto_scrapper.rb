require 'nokogiri'
require 'open-uri'

#page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))  

#puts page.css('title').text

#Scrapping name
def scrapping_name
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))  
    name_array = Array.new
    (0..200).each do |x|
        name_array << page.xpath("//table/tbody/tr[#{x}]/td[3]").text
        puts "scrapping : " + name_array[x]
    end    
    return name_array
end

#Scrapping price
def scrapping_price
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))  
    price_array = Array.new
    (0..200).each do |x|
        price_array << page.xpath("//table/tbody/tr[#{x}]/td[5]").text
        puts "scrapping : " + price_array[x]
    end
    return price_array
end

#Cleaning price
def clean_price(arr)
    arr.each do |i|
        i.delete!('$').to_f
    end
end


#Create final array
def final_array(names,prices)
    crypto_array = Array.new
    names.each do |k|
        if k != ""
            result = Hash.new
            result[k] = prices[names.find_index(k)]
            crypto_array << result
        end
    end
    return crypto_array
end

crypto_name_array = scrapping_name
crypto_price_array = scrapping_price
clean_price(crypto_price_array)
puts final_array(crypto_name_array,crypto_price_array)