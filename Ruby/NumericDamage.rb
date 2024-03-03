#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Esta clase representa la divisón en daño numérico 

require_relative 'Damage'
require_relative 'NumericDamageToUI'

module Deepspace
	class NumericDamage < Damage
		
		public_class_method :new
		
		def initialize(w, s)
			super(s)
			@nWeapons = w
		end
		
		def copy
			return NumericDamage.new(@nWeapons, @nShields)
		end
		
		def nWeapons
			return @nWeapons
		end
		
		def adjust(w, s)
			return NumericDamage.new([@nWeapons, w.length].min, adjustNShields(s))
		end
		
		def hasNoEffect
			return super && (@nWeapons == 0)
		end
		
		def discardWeapon(w)
			@nWeapons = [@nWeapons-1, 0].max
		end
		
		def to_s
			return "[Numeric Damage] -> Weapons: #{@nWeapons}, Shields: #{@nShields}"
		end
		
		def getUIversion
			return NumericDamageToUI.new(self)
		end
	end
end
