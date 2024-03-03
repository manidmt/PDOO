#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Esta clase representa el concepto de estación espacial 
# eficiente así como sus atributos y funcionalidades

require_relative 'SpaceStation'
#require_relative 'Transformation'
require_relative 'PowerEfficientSpaceStationToUI'

module Deepspace
	class PowerEfficientSpaceStation < SpaceStation
	
		private
	
		@@EFFICIENCYFACTOR = 1.10

		public
		
		def initialize(spacestation)
			copy(spacestation)
		end
		
		def fire
			return super*@@EFFICIENCYFACTOR
		end
		
		def protection
			return super*@@EFFICIENCYFACTOR
		end
		
		def setLoot(loot)
			trans = super

            if trans == Transformation::SPACECITY 
               	return Transformation::NOTRANSFORM
            else
            	return trans
            end
		end
		
		def getUIversion
		      	return PowerEfficientSpaceStationToUI.new(self)
		end
	end
end
