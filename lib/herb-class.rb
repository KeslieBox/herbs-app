class Herb
    attr_accessor :name, :website, :plant_family, :actions, :constituents

    @@all = []

    def initialize(name, website)
        @name = name
        @website = website
        @@all << self
    end

    def self.all
        @@all 
    end

    def self.find_by_name(input)
        self.all.detect do |herb|
            input == herb.name
        end
    end
end