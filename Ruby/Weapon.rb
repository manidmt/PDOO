#encoding: UTF-8
#require_relative 'WeaponType.rb' # solo para el código de prueba

# Autores: Manuel Díaz-Meco y Ana Graciani Donaire
# 2º DGIIM		PDOO

# Esta clase representa a las armas de las que puede disponer una estación
# espacial para potenciar su energía al disparar.

require_relative 'WeaponToUI.rb'

module Deepspace

	class Weapon

		# Constructor con parámetros

		def initialize (name_, type_, uses_)
			# atributos privados de instancia
			@name = name_
			@type = type_
			@uses = uses_
		end

		# Método de copia (método de clase)

		def self.newCopy (w)
			new(w.name, w.type, w.uses)
		end

		public

		# Consultores

		# Consultor del atributo name
		def name
			return @name
		end

		# Consultor del atributo type
		def type
			return @type
		end

		# Consultor del atributo uses
		def uses
			return @uses
		end

		# Método que devuelve la potencia de disparo del arma según type
		def power
			return @type.power
		end

		# Método de uso del arma

		def useIt
			if (@uses > 0)
				@uses-= 1
				return power
			else
				return 1.0
			end
		end
		
		def to_s
			return "name: #{@name}, type: #{@type.name}, uses: #{@uses}"
		end
		
		def getUIversion
			return WeaponToUI.new(self)
		end
		
	end
end

# Código de prueba

=begin

	require_relative 'WeaponType.rb'

	arma1 = Deepspace::Weapon.new("manolo", Deepspace::WeaponType::LASER, 2)
	puts arma1.inspect
	puts arma1.name
	puts arma1.type
	puts arma1.uses
	puts arma1.power
	arma2 = Deepspace::Weapon.newCopy(arma1)
	puts arma2.inspect
	puts arma1.useIt
	puts arma1.useIt
	puts arma1.useIt
	arma3 = Deepspace::Weapon.new("kike", Deepspace::WeaponType::PLASMA, 0)
	puts arma3.useIt
	puts arma1.to_s
	puts arma1.getUIversion
=end
