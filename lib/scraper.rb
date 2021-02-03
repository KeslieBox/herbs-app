
class Scraper
  
    def self.scrape_url
        url = "https://www.cloverleaffarmherbs.com/" 
        index_page = Nokogiri::HTML(open(url))
        herbs = []
        index_page.css("ul li strong a").each do |website_element| 
            Herb.new(website_element.text.downcase, website_element.attribute("href").text)
        end 
    end

    
    def self.scrape_herb_page(object)   

        herb_page = Nokogiri::HTML(open(object.website)) 
        
        herb_page.css("div.entry-content").each do |info|
            if info.text.include?("Family") 
                object.plant_family = herb_page.css("div.entry-content ul li")[0].children.collect {|family| family.text}.join("")
            end
            if info.text.include?("Actions") 
                object.actions = herb_page.css("div.entry-content ul")[2].children.collect {|action| action.text}.join(", ")
            end
            if info.text.include?("Components")
                object.constituents = herb_page.css("div.entry-content ul")[3].children.collect {|constituent| constituent.text}.join(", ")
            end     
            # elsif figure out how to access latin_name = herb_page.css("div.entry-content ul li")[1].children.text 
        end 

    end
end

