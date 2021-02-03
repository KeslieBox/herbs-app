
class Cli
    def welcome
        puts "**************************************"
        puts "                                      "
        puts "🌿🧙‍♀️ ‍HELLO & WELCOME TO HERBWARTS 🧙‍🌿"
        puts "                                      "
        puts "**************************************"
        self.herb_selection
    end

    def herb_selection
        Scraper.scrape_url
        puts "HERE IS A LIST OF ALL THE HERBS WE HAVE:\n\n"
        Herb.all.each.with_index do |info, index| 
            print "#{info.name.upcase.blue} "  
        end
        self.prompt_for_input
    end

    def prompt_for_input
        puts "\n\nTO SEE AN HERB PROFILE, TYPE THE NAME OF AN HERB FROM THE LIST AND PRESS \"ENTER\"" 
        input = gets.strip
        user_input(input)
    end

    def return_plant_info(object)
        Scraper.scrape_herb_page(object)
        puts "\n#{"Plant Name:".upcase.blue} #{object.name}"
        puts "\n#{"Plant Family:".upcase.blue} #{object.plant_family}"
        puts "\n#{"Key Constituents:".upcase.blue} #{object.constituents}"
        puts "\n#{"Key Actions:".upcase.blue} #{object.actions}\n"
    end  

    def user_input(input)

        # try to make this into while loop??
        object = Herb.find_by_name(input)
        if Herb.find_by_name(input) 
            return_plant_info(object) 
            self.main_menu
        else 
            puts "\nTHAT SELECTION WAS INVALID. \nPLEASE ENTER THE NAME OF AN HERB, ENTER 1 TO SEE THE MAIN MENU OR ENTER 2 TO EXIT THE PROGRAM.\n"
        end
        new_input = gets.strip
        if new_input == "1"
            self.main_menu
        elsif new_input == "2"
            self.exit_program
        else 
            self.user_input(new_input)
        end 
    end

    def main_menu
        puts "\nYAY, YOU'VE LEARNED SO MUCH ALREADY! WHAT WOULD YOU LIKE TO DO NEXT?"
        puts "\n1. To see our LIST OF HERBS, please enter 1"
        puts "2. To search for another HERB PROFILE, please press 2"
        puts "3. To EXIT the program, please press 3\n\n"
        input = gets.strip
        if input == "1"
            self.herb_selection
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
        abort("THANKS FOR COMING TO HERBWARTS, COME BACK AND VISIT SOON!")
    end
end
    

    