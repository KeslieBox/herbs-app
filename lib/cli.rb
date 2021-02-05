
class Cli
    def welcome
        puts "\n\nHELLO! WHAT IS YOUR NAME, STUDIOUS NEW FRIEND?".green
        input = gets.strip
        puts "\n      *********************************************************************************************************"
        puts ""
        puts "                                    🌿🧙‍♀️ ‍#{"HELLO, #{input.upcase}, WELCOME TO HERBWARTS!!!".green} 🧙‍🌿"
        puts ""                                                                            
        puts "      *********************************************************************************************************"
        puts ""
        puts "                           Thanks so much for visiting our virtual herbal encyclopedia!".green
        puts "                 This application will allow you to see a list of all the herbs in our repertoire,".green
        puts "                           as well as enter the name of an herb you wish to research.".green
        puts "                  It will then return all of the information we have available for your selection".green
        puts "                                        Why don't you give it a try below!".green
        puts ""
        puts "       *********************************************************************************************************"
        self.herb_library
    end

    def herb_library
        Scraper.scrape_url
        puts "\n                        🌿 HERE IS A LIST OF #{"ALL THE HERBS".green} WE HAVE IN OUR LIBRARY 🌿\n\n"

        herbs_array = Herb.sort_by_name.map {|name| name.upcase.green}
        rows = []
        i = 0
        while i <= 15
            rows << herbs_array[i..i + 5]
            i+=6
        end
        table = Terminal::Table.new :rows => rows, :style => {:width => 120}
        puts table

        self.prompt_for_input
    end

    def prompt_for_input
        puts "\nOOOOOOOOHHHH AAAAAAAHHH, THAT'S VERY EXCITING ISN'T IT? DON'T YOU WANT TO SEE MORE?!".green
        puts "\nTO SEE AN HERB PROFILE, TYPE THE NAME OF AN HERB FROM THE LIST AND PRESS \"ENTER\" OR TYPE 2 TO EXIT THE PROGRAM".green 
        puts "**NOTE: YOU DON'T HAVE TO TYPE IN THE WHOLE NAME ;)".green
        input = gets.strip
        user_input(input.downcase)
    end 

    def user_input(input)
        while Herb.find_by_name(input) == nil && input != "1" && input != "2"
            puts "\nOOPS! THAT SELECTION WAS INVALID. \nPLEASE ENTER THE NAME OF AN HERB, ENTER 1 TO SEE THE MAIN MENU OR ENTER 2 TO EXIT THE PROGRAM.\n"
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
        puts "\n🌿 #{"PLANT NAME:"} #{object.name.upcase.green}"
        puts "\n🌿 #{"PLANT FAMILY:"} #{object.plant_family.upcase.green}"
        puts "\n🌿 #{"LATIN NAME:"} #{object.latin_name.upcase.green}"
        if object.constituents && object.constituents.length > 0
            puts "\n🌿 #{"KEY CONSTITUENTS:"} #{object.constituents.upcase.green}"
        else
            puts "\n🌿 #{"KEY CONSTITUENTS:"} #{"NONE LISTED".green}"
        end
        if object.actions && object.actions.length > 0
            puts "\n🌿 #{"ACTIONS:"} #{object.actions.upcase.green}"
        else
            puts "\n🌿 #{"ACTIONS:"} #{"NONE LISTED".green}"
        end
    end 

    def main_menu
        puts "\nYAY, YOU'VE LEARNED SO MUCH ALREADY! WHAT WOULD YOU LIKE TO DO NEXT?"
        puts "\n1. #{"For the LIST OF HERBS, enter 1".green}"
        puts "2. #{"To research another HERB PROFILE, enter 2".green}"
        puts "3. #{"To EXIT the program, enter 3".green}\n\n"
        input = gets.strip
        if input == "1"
            self.herb_library
        elsif input == "2"
            self.prompt_for_input
        elsif input == "3"
            self.exit_program
        else 
            puts "OOPS THAT WAS INVALID SELECTION"
            self.main_menu
        end
    end
    
    def exit_program
        abort("\nTHANKS FOR COMING TO HERBWARTS, COME BACK AGAIN SOON!\n\n".green)
    end
end
    

    