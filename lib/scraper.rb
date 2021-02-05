
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
        # div_entry =  herb_page.css("div.entry-content ul li")
        herb_page.css("div.post-entry p").each do |info|
            # binding.pry

            if info.text.include?("Plant family") 
                # object.plant_family = herb_page.css("div.post-entry p")[2].text.gsub("Plant family: ", "")  
                object.plant_family = info.text.gsub("Plant family: ", "").gsub(":", "")
            end
            if info.text.include?("Latin name")
                object.latin_name = info.text.gsub("Latin name", "").gsub(":", "")
            end
            if info.text.include?("Chemical constituents") && herb_page.css("div.post-entry ul li")[0].text
                object.constituents = info.text.gsub("Chemical constituents: ", "").gsub(":", "")
            # need to test for when constituents has an extra level ie chickweed
            # else
            #   object.constituents = herb_page.css("div.post-entry ul li")[0].text
            elsif info.text.include?("Chemical constituents") 
                object.constituents = info.text.gsub("Chemical constituents: ", "").gsub(":", "")
            end 
            if  info.text.include?("Herbal actions")
                object.actions = info.text.gsub("Herbal actions: ", "").gsub(":", "")
            end
            # if info.text.include?("Energetics")
            #     object.energetics = herb_page.css("div.post-entry ul").text
            # end

        end 
        
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

