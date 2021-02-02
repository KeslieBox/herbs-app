
class Cli
    def welcome
        puts "Welcome to Herbwarts!"
        self.prompt_for_input
    end

    def prompt_for_input
        Scraper.scrape_url
        puts "Please enter the name of the herb you wish to research!"
        input = gets.strip
   
        Herb.find_by_name(input)
      
    end
end  

