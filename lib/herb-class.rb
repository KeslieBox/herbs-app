class Herb
    attr_accessor :name, :website, :plant_family, :actions, :constituents, :med_parts, :energetics, :latin_name

    @@all = []

    def initialize(name, website)
        @name = name
        @website = website
        @@all << self
    end
    
    def self.all
        @@all
    end

    def self.sort_by_name
        self.all.collect {|herb| herb.name}.sort
    end 

    def self.find_by_name(input)
        self.all.detect {|herb| herb.name.include?(input)}
    end
end