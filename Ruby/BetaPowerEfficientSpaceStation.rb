#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Esta clase representa el concepto de estación espacial 
# eficiente beta así como sus atributos y funcionalidades

require_relative 'Dice'
require_relative 'PowerEfficientSpaceStation'
require_relative 'BetaPowerEfficientSpaceStationToUI'

module Deepspace
	class BetaPowerEfficientSpaceStation < PowerEfficientSpaceStation
		
		private
		
		@@EXTRAEFFICIENCY = 1.2
		
		public
		
		def initialize(spacestation)
			super(spacestation)
			@dice = Dice.new
		end
			
		def fire
			if @dice.extraEfficiency
				return super*@@EXTRAEFFICIENCY
			else
				return super
			end	
		end	
		
		def getUIVersion
			return BetaPowerEfficientSpaceStationToUI.new(this)
		end
		
	end
end
