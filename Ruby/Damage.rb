#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Los objetos de esta clase representan el daño producido a una estación espacial por una nave
# enemiga cuando se pierde un combate.
		
require_relative 'DamageToUI'


module Deepspace

	class Damage
	
		# Método de inicialización
		def initialize (s)
			# Atributos de instancia (son privados)
			@nShields = s
		end
		
		protected

		def adjustNShields(s)
			return [@nShields, s.size].min
		end

		public
		
		# Decrementa en una unidad el número de potenciadores de escudo que deben ser
		# eliminados. Ese contador no puede ser inferior a cero en ningún caso.
		def discardShieldBooster
			@nShields = [@nShields-1, 0].max
		end
		
		# Devuelve true si el daño representado no tiene ningún efecto.
		# Esto quiere decir que no implica la pérdida de ningún tipo de accesorio
		# (armas o potenciadores de escudo).
		def hasNoEffect
			return @nShields == 0
		end
		
		# Consultores
		
		def nShields
			return @nShields
		end
		
		def to_s
			return getUIversion.to_s
		end

		private_class_method :new

	end
end
