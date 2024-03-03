#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO


# Este enumerado representa a los tipos de armas del juego y no será simplemente una
# lista de valores, sino que tendrá ciertea funcionalidad adicional. En este caso, cada 
# valor posible del tipo enumerado tendrá un valor numérico concreto igual a la potencia
# de disparo de cada tipo de arma.

module Deepspace
	module WeaponType

		class Type

			# Constructor
			def initialize(p)
				# Atributos de instancia privados
				@power = p
				@name = "LASER"
				if @power == 3.0
					@name = "MISSILE"
				elsif @power == 4.0
					@name = "PLASMA"
				end
			end

			# Consultor power
			def power
				return @power
			end

			# Consultor name
			def name
				return @name
			end

			def to_s
				return @name
			end

		end

		LASER = Type.new(2.0)
		MISSILE = Type.new(3.0)
		PLASMA = Type.new(4.0)

	end
	
	# Comprobación de código:
=begin
	puts WeaponType::LASER.power
	puts WeaponType::MISSILE.power
	puts WeaponType::PLASMA.power
=end
end 
