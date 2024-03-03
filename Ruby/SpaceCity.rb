#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Esta clase representa el concepto de ciudad espacial así como
# sus atributos y funcionalidades

require_relative 'SpaceStation'
require_relative 'SpaceCityToUI'

module Deepspace
	class SpaceCity < SpaceStation
		
		def initialize(base, rest)
			copy(base)
			@base = base
			@collaborators = rest
		end
		
		def collaborators
			return @collaborators
		end
		
		def fire
			power = super
			@collaborators.each do |s|
				power+= s.fire
			end
			return power
		end
		
		def protection
			shield = super
			@collaborators.each do |s|
				shield+= s.protection
			end
			return shield
		end
		
		def setLoot(loot)
			super
			return Transformation::NOTRANSFORM
		end
		
		def getUIVersion
			return SpaceCityToUI.new(self)
		end
		
		def to_s
			return getUIVersion.to_s
		end
			
	end
end
