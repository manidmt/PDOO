#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Esta clase representa la divisón en daño específico

require_relative 'Damage'
require_relative 'SpecificDamageToUI'

module Deepspace
	class SpecificDamage < Damage
		
		public_class_method :new

		@@VALOR_INICIAL = -1
		
		def initialize(wl, s)
			super(s)
			@weapons = wl	
		end

		private

		# Devuelve el índice de la posición de la primera arma de la colección de armas  
		# (primer parámetro) cuyo tipo coincida con el tipo indicado por el segundo  
		# parámetro. Devuelve -1 si no hay ninguna  arma en la colección del tipo  
		# indicado por el segundo parámetro.
		def arrayContainsType(w, t)
			returnvalue = w.find_index{|x| x.type == t}
			if returnvalue.nil?
				return @@VALOR_INICIAL
			else
				return returnvalue
			end
		end
		
		public
		
		def copy
			return SpecificDamage.new(@weapons, @nShields)
		end
		
		def weapons
			return @weapons
		end
		
		def adjust(w, s)
			arrayWT = []
			w.each {|x| arrayWT.push(x.type)}
			ret_array = @weapons & arrayWT
			return SpecificDamage.new(ret_array, adjustNShields(s))
		end
		
		def hasNoEffect
			return super && (@weapons.nil? || @weapons.length == 0)
		end
		
		def discardWeapon(w)
			@weapons.delete_if{|x| x == w.type}
		end
		
		def to_s
			return "[Specific Damage] -> Weapons: #{@weapons}, Shields: #{@nShields}"
		end
		
		def getUIversion
		    SpecificDamageToUI.new(self)
	    end
	end
end
