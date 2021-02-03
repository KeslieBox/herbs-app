
class Scraper
  
    def self.scrape_url
        url = "https://www.cloverleaffarmherbs.com/" 
        index_page = Nokogiri::HTML(open(url))
        herbs = []
        index_page.css("ul li strong a").each do |website_element| 
            Herb.new(website_element.text.downcase, website_element.attribute("href").text)
        end 
    end

    
    
end

