#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO


# Esta claserepresenta a los potenciadores de escudo que pueden tener las
# estaciones espaciales

require_relative 'ShieldToUI.rb'

module Deepspace
	class ShieldBooster

		# Constructor

		def initialize (name, boost, uses)
			# Atributos de instancia privados
			@name = name
			@boost = boost
			@uses = uses
		end

		# Método de copia (método de clase)

		def self.newCopy (s)
			new(s.name, s.boost, s.uses)
		end

		public

		# Consultores públicos
		
		# Consultor del atributo name, para así poder usar newCopy
		def name
			return @name
		end

		# Consultor del atributo boost
		def boost
			return @boost
		end

		#Consultor del atributo uses
		def uses
			return @uses
		end

		# Método de uso del escudo

		def useIt
			if (@uses > 0)
				@uses-= 1
				return @boost
			else
				return 1.0
			end
		end
		
		def to_s
			return "Name: #{@name}, Boost: #{@boost}, Uses: #{@uses}"
		end
		
		def getUIversion
			return ShieldToUI.new(self)
		end

	end
	
	# Comprobación de código
=begin
	s = ShieldBooster.new("Prueba", 2.0, 10)
	s_copy = ShieldBooster.newCopy(s)
	puts s.inspect
	puts s_copy.inspect
	puts s.name
	puts s.boost
	puts s.uses
	puts s.useIt
	puts s.uses
	puts s.to_s
=end
end
