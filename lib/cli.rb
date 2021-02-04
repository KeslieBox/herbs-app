
class Cli
    def welcome
        puts "\n\n                       *********************************************************************************************************************"
        puts "\n"
        puts "                                                           🌿🧙‍♀️ ‍#{"HELLO & WELCOME TO HERBWARTS!!!".green} 🧙‍🌿"
        puts "\n"                                                                            
        puts "                       **********************************************************************************************************************"
        self.herb_library
    end

    def herb_library
        Scraper.scrape_url
        puts "\n                                                          🌿 HERE IS A LIST OF #{"ALL THE HERBS".green} WE HAVE 🌿\n\n"

        herbs_array = Herb.all.each_with_index.map {|object, index| "#{index+1}. #{object.name.upcase.green}"}

        rows = []
        i = 0
        while i <= 236
            rows << herbs_array[i..i + 5]
            i+=6
        end
        table = Terminal::Table.new :rows => rows, :style => {:width => 170}
        puts table

        self.prompt_for_input
    end

    def prompt_for_input
        puts "\n\nTO SEE AN HERB PROFILE, TYPE THE NAME OF AN HERB FROM THE LIST AND PRESS \"ENTER\"" 
        input = gets.strip
        user_input(input.downcase)
    end 

    def user_input(input)
        while Herb.find_by_name(input) == nil && input != "1" && input != "2"
            puts "\nTHAT SELECTION WAS INVALID. \nPLEASE ENTER THE NAME OF AN HERB, ENTER 1 TO SEE THE MAIN MENU OR ENTER 2 TO EXIT THE PROGRAM.\n"
            input = gets.strip
        end
        if input == "1"
            self.main_menu
        elsif input == "2"
            self.exit_program
        elsif Herb.find_by_name(input)
            object = Herb.find_by_name(input)
            return_plant_info(object) 
            self.main_menu
        end 
    end

    def return_plant_info(object)
        Scraper.scrape_herb_page(object)
        puts "\n#{"Plant Name:".upcase.green} #{object.name.capitalize}"
        puts "\n#{"Plant Family:".upcase.green} #{object.plant_family}"
        puts "\n#{"Key Constituents:".upcase.green} #{object.constituents}"
        puts "\n#{"Key Actions:".upcase.green} #{object.actions}\n"
        puts "\n#{"Description:".upcase.green} #{object.description}\n"
    end 

    def main_menu
        puts "\n\nYAY, YOU'VE LEARNED SO MUCH ALREADY! WHAT WOULD YOU LIKE TO DO NEXT?"
        puts "\n1. To see our LIST OF HERBS, please enter 1".green
        puts "2. To search for another HERB PROFILE, please press 2".green
        puts "3. To EXIT the program, please press 3\n\n".green
        input = gets.strip
        if input == "1"
            self.herb_library
        elsif input == "2"
            self.prompt_for_input
        elsif input == "3"
            self.exit_program
        else 
            puts "INVALID SELECTION"
            self.main_menu
        end
    end
    
    def exit_program
        abort("THANKS FOR COMING TO HERBWARTS, COME BACK AGAIN SOON!")
    end
end
    

    