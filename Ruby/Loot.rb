#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO


# Esta clase representa el botín que se obtiene al vencer a una nave enemiga. Puede incluir 
# cantidades que representen un número de paquetes de suministros, armas, potenciadores de
# de escudo, hangares y/o medallas.

require_relative 'LootToUI.rb'

module Deepspace
	class Loot

		# Constructor

		def initialize (supplies, weapons, shields, hangars, medals, efficient = false, spacecity = false)
			# Atributos de instancia (son privados)
			@nSupplies = supplies
			@nWeapons = weapons
			@nShields = shields
			@nHangars = hangars
			@nMedals = medals
			@getEfficient = efficient
			@spaceCity = spacecity
		end

		public

		# Consultores

		def nSupplies
			return @nSupplies
		end

		def nWeapons
			return @nWeapons
		end

		def nShields
			return @nShields
		end

		def nHangars
			return @nHangars
		end

		def nMedals
			return @nMedals
		end
		
		def getEfficient
			return @getEfficient
		end
		
		def spaceCity
			return @spaceCity
		end	
			
		def to_s
			return getUIversion.to_s
		end
		
		def getUIversion
			return LootToUI.new(self)
		end

	end
	
	#Comprobación de código:
=begin
	l = Loot.new(2, 3, 4, 5, 6)
	puts l.inspect
	puts l.nSupplies
	puts l.nWeapons
	puts l.nShields
	puts l.nHangars
	puts l.nMedals
	puts l.to_s
=end
end
