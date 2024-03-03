#encoding: UTF-8

# Autores: Manuel Díaz-Meco y Ana Graciani Donaire
# 2º DGIIM		PDOO

# Esta clase representa a un paquete de suministros para una estación espacial.
# Puede contener armamento, combustible y/o energía para los escudos.

module Deepspace

	class SuppliesPackage

		# Constructor

		def initialize (ammo, fuel, shield)
			# Atributos de instancia (son privados)
			@ammoPower = ammo
			@fuelUnits = fuel
			@shieldPower = shield
		end

		# Método de copia (método de clase)

		def self.newCopy(s)
			new(s.ammoPower, s.fuelUnits, s.shieldPower)
		end

		public

		# Consultores públicos

		# Consultor del atributo ammoPower
		def ammoPower
			return @ammoPower
		end

		# Consultor del atributo fuelUnits
		def fuelUnits
			return @fuelUnits
		end

		# Consultor del atributo shieldPower
		def shieldPower
			return @shieldPower
		end
		
		def to_s
			return "Ammo Power: #{@ammoPower}, Fuel Units: #{@fuelUnits}, " \
				+ "Shield Power: #{@shieldPower}"
		end

	end

end

# Código de prueba

=begin
	paquete1 = Deepspace::SuppliesPackage.new(0,5.25,100.333)
	puts paquete1.inspect
	puts paquete1.ammoPower
	puts paquete1.fuelUnits
	puts paquete1.shieldPower
	paquete2 = Deepspace::SuppliesPackage.newCopy(paquete1)
	puts paquete2.inspect
	puts paquete2.ammoPower
	puts paquete2.fuelUnits
	puts paquete2.shieldPower
	puts paquete1.to_s
=end
