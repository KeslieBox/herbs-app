
class Scraper
  
    

    def self.scrape_url
        url = "https://www.herbrally.com/monographs" 
        index_page = Nokogiri::HTML(open(url))

        websites = []
    
        index_page.css("div.image-caption a").each do |x|
            website = x.attribute("href").text
            websites << [website]
        end
        websites
    end
end