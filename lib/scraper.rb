
class Scraper
  
    def self.scrape_url

        url = "https://solidarityapothecary.org/category/plant-allies/" 
        index_page = Nokogiri::HTML(open(url))

        index_page.css("div.post-header h2 a").each do |website_element| 

            Herb.new(website_element.children.text.gsub(" Plant Profile", "").downcase, website_element.attribute("href").text)
        end 
    end

    def self.scrape_herb_page(object)   
        herb_page = Nokogiri::HTML(open(object.website)) 
        herb_page.css("div.post-entry p").each do |info|
            if info.text.include?("Plant family:") 
                object.plant_family = info.text.gsub("Plant family: ", "")
            elsif info.text.include?("Plant family") 
                object.plant_family = info.text.gsub("Plant family ", "")
            end
            if info.text.include?("Latin name:")
                object.latin_name = info.text.gsub("Latin name: ", "")
            elsif info.text.include?("Latin name")
                object.latin_name = info.text.gsub("Latin name ", "")
            end
            if info.text.include?("Chemical constituents:") 
                object.constituents = info.text.gsub("Chemical constituents: ", "")
            elsif info.text.include?("Chemical constituents") 
                object.constituents = info.text.gsub("Chemical constituents ", "")    
            end 
            if info.text.include?("Herbal actions:")
                object.actions = info.text.gsub("Herbal actions: ", "")
            elsif info.text.include?("Herbal actions")
                object.actions = info.text.gsub("Herbal actions ", "")
            end
        end
    end  
end

