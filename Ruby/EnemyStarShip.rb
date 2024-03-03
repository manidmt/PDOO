#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

require_relative 'EnemyToUI'
require_relative 'ShotResult'

module Deepspace
	class EnemyStarShip
		
		# Constructor
		
		def initialize(n, a, s, l, d)
			# Atributos de instancia (son privados)
			@name = n
			@ammoPower = a
			@shieldPower = s
			
			# Atributos de referencia
			@loot = l
			@damage = d.copy
		end
		
		# Constructor de copia
		def self.newCopy(e)
			new(e.name, e.ammoPower, e.shieldPower, e.loot, e.damage)
		end
		
		def getUIversion
			return EnemyToUI.new(self)
		end
		
		# Devuelve el nivel de energía de disparo de la nave enemiga (ammoPower)
		def fire
			return @ammoPower
		end
		
		# Consultor del nivel de energía de disparo (ammoPower)
		def ammoPower
			return @ammoPower
		end
		
		# Consultor del daño (damage)
		def damage
			return @damage.copy
		end

		# Consultor del botín (loot)
		def loot
			return @loot
		end
		
		# Consultor del nombre de la nave enemiga (name)
		def name
			return @name
		end
		
		# Consultor del nivel de energía del escudo (shieldPower)
		def shieldPower
			return @shieldPower
		end
		
		# Devuelve el nivel de energía del escudo de la nave enemiga (shieldPower)
		def protection
			return @shieldPower
		end
		
		# Devuelve el resultado que se produce al recibir un disparo de una determinada 
		# potencia (pasada como parámetro). Si el nivel de la protección de los escudos es
		# menor que la intensidad del disparo, la nave enemiga no resiste (DONOTRESIST). En 
		# caso contrario resiste el disparo (RESIST). Se devuelve el resultado producido por  
		# el disparo recibido.
		def receiveShot(shot)
			if @shieldPower < shot
				return ShotResult::DONOTRESIST
			else
				return ShotResult::RESIST
			end
		end	

		def to_s
			getUIversion.to_s
		end


	end

	# Código de prueba
=begin

require_relative 'Damage'
require_relative 'Loot' 

	l = Loot.new(1, 2, 3, 4, 5)
	d = Damage.newNumericWeapons(6, 7)
	e = EnemyStarShip.new("Prueba", 1.0, 2.0, l, d)
	ecopy = EnemyStarShip.newCopy(e)
	puts e.inspect
	puts ecopy.inspect
	puts e.recieveShot(5)
	puts e.recieveShot(3)

	puts e.to_s
	puts ecopy.to_s
	
=end
end

