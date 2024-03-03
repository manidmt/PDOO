#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Esta clase representa el Hangar y sus múltiples atributos así como
# el espacio del que se dispone y las armas que se tienen

require_relative 'HangarToUI'

module Deepspace
	class Hangar
	
		# Constructor
		
		def initialize (capacity)
			@maxElements = capacity
			# Atributos de referencia
			@weapons = Array.new # otra opción: @weapons = []
			@shieldBoosters = Array.new
		end	
		
		# Método de copia (método de clase)
		def self.newCopy(h)
			copy = Hangar.new(h.maxElements)
			h.weapons.each {|x| copy.addWeapon(x)}
			h.shieldBoosters.each {|x| copy.addShieldBooster(x)}
			return copy
		end
		
		private
		
		# Devuelve true si aún hay esacio para añadir elementos y que
		# por lo tanto no se ha llegado a la capacidad máxima
		def spaceAvailable
			return (@weapons.size + @shieldBoosters.size) < @maxElements
		end
		
		public
		
		# Añade el arma al hangar si queda espacio en el Hangar, devolviendo
		# true en ese caso. Devuelve false en cualquier otro caso
		
		def addWeapon(w)
			rvalue = false
			if spaceAvailable
				@weapons.push(w) # devuelve el array
				rvalue = true
			end
			return rvalue
		end
		
		# Añade el potenciador de escudo al hangar si queda espacio. 
		# Devuelve true si ha sido posible añadir el potenciador, false en
		# otro caso
		
		def addShieldBooster(s)
			rvalue = false
			if spaceAvailable
				@shieldBoosters.push(s)
				rvalue = true
			end
			return rvalue
		end
		
		# Consultores
		
		def maxElements
			@maxElements
		end
		
		def shieldBoosters
			@shieldBoosters
		end
		
		def weapons
			@weapons
		end
		
		# Elimina el potenciador de escudo número s del hangar y lo devuelve, 
		# siempre que este exista. Si el ínidice suminstrado es incorrecto
		# devuelve nil
		
		def removeShieldBooster(s)
			return @shieldBoosters.delete_at(s)
		end
		
		# Elimina el arma número w del hangar y la devuelve, siempre que esta
		# exista. Si el índice suminstrado es incorrecto devuelve nil
		
		def removeWeapon(w)
			return @weapons.delete_at(w)
		end

		def getUIversion
			return HangarToUI.new(self)
		end

		def to_s
			return getUIversion.to_s
		end
		
	end

	
	# código de prueba (constructor de copia)
=begin
	require_relative 'WeaponType'
	require_relative 'Weapon'
	require_relative 'ShieldBooster'

	hangar1 = Hangar.new(3)
	puts "Hangar 1 vacio"
	puts hangar1.inspect
	puts hangar1.to_s
	wt = WeaponType::LASER
	weapon = Weapon.new("meinol", wt, 3)
	shieldb = ShieldBooster.new("sunage", 2.0, 3)
	hangar1.addWeapon(weapon)
	hangar1.addShieldBooster(shieldb)
	hangar2 = Hangar.newCopy(hangar1)

	puts "Hangar 1"
	puts hangar1.inspect
	puts hangar1.to_s
	puts "Hangar 2"
	puts hangar2.inspect
	puts hangar2.to_s
=end

end
