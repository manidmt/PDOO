#encoding: UTF-8

require_relative 'SpaceStation'
require_relative 'CardDealer'
require_relative 'SpaceCity'

class Examen
	def self.run
		cardDealer = Deepspace::CardDealer.instance
		s1 = Deepspace::SpaceStation.new("s1", cardDealer.nextSuppliesPackage)
		s2 = Deepspace::SpaceStation.new("s2", cardDealer.nextSuppliesPackage)
		s3 = Deepspace::SpaceStation.new("s3", cardDealer.nextSuppliesPackage)
		
		spaceStations = Array.new
		
		spaceStations << s1
		spaceStations << s2
		spaceStations << s3
		
		s2 = Deepspace::SpaceCity.new(s2, [s1, s3])
		spaceStations[1] = s2

		spaceStations.each do |s|
			puts s.to_s
			puts s.fire
			puts " "
		end 
	end
end

Examen.run
