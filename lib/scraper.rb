
class Scraper
  
    def self.scrape_url

        url = "https://solidarityapothecary.org/category/plant-allies/" 
        index_page = Nokogiri::HTML(open(url))

        index_page.css("div.post-header h2 a").each do |website_element| 

            Herb.new(website_element.children.text.gsub(" Plant Profile", "").downcase, website_element.attribute("href").text)

        # url = "https://www.cloverleaffarmherbs.com/" 
        # index_page = Nokogiri::HTML(open(url))
        # index_page.css("ul li strong a").each do |website_element| 
        #     Herb.new(website_element.text.downcase, website_element.attribute("href").text)
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

        # herb_page.css("div.post-entry").each do |title|
            # binding.pry
        # title = herb_page.css("div.post-entry p").text
        #     if  title.include?("Chemical constituents")
        #         object.constituents = herb_page.css("div.post-entry ul li").text
        #     else
        #         object.constituents = "None listed" 
        #     end
        #     if  title.include?("Herbal actions")
        #         object.actions = herb_page.css("div.post-entry ul li").text
        #     else
        #         object.actions = "None listed"
        #     end
        # end

        # if herb_page.css("div.post-entry h3").text.include?("Energetics")
        #     object.energetics = herb_page.css("div.post-entry ul").text
        # else
        #     "None listed"
        # end
        
        # herb_page.css("div.entry-content").each do |info|
        #     # binding.pry
        #     if info.text.include?("Family") 
        #         object.plant_family = herb_page.css("div.entry-content ul li")[0].children.collect {|family| family.text}.join("")        
        #     end
        #     if info.text.include?("Actions") && div_entry[2] != nil
        #         object.actions = div_entry[2].children.collect {|action| action.text}.join(", ")
        #     end
        #     if info.text.include?("Components") && div_entry[3] != nil
        #         object.constituents = div_entry[3].children.collect {|constituent| constituent.text}.join(", ")
        #     end   
        #     if  info.text.include?("<Medicinal") && div_entry[4] != nil
        #         object.description = div_entry[4].children.collect {|med_parts| med_parts.text}.join(", ")
        #     end
        # end 
    end  
end

