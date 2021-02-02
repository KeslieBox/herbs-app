
class Cli
    def welcome
        puts "Welcome to Herbwarts!"
        self.prompt_for_input
    end

    def prompt_for_input
        puts "Please enter the name of the herb you wish to research!"
        input = gets.strip
        Scraper.scrape_url
    end
end  

