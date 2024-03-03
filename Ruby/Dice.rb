#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Esta clase tiene la responsabilidad de tomar todas las decisiones que depende del azar del
# juego. Es como una especie de dado, pero algo más sofisticado, ya que no proporciona simple-
# mente un número del 1 al 6, sino decisiones concretas en base a una serie de probabilidades
# establecidas

require_relative 'GameCharacter.rb'

module Deepspace
	class Dice

		# Constructor sin parámetros

		def initialize
			# Atributos de instancia constantes (son privados)
			@NHANGARSPROB  = 0.25
			@NSHIELDSPROB  = 0.25
			@NWEAPONSPROB  = 0.33
			@FIRSTSHOTPROB = 0.50
			@EXTRAEFFICIENCYPROB = 0.80
			# Generador de números pseudo-aleatorios (atributo privado)
			@generator = Random.new
		end

		# Este método determina el número de hangares que recibirá una estación
		# espacial al ser creada.

		def initWithNHangars
			rvalue = 1
			if @generator.rand(1.0) <= @NHANGARSPROB
				rvalue = 0
			end
			return rvalue
		end

		# Este método determina el número de armas que recibirá una estación
		# espacial al ser creada.

		def initWithNWeapons	
			rvalue = 3
			probability = @generator.rand(1.0)
			if probability <= @NWEAPONSPROB
				rvalue = 1
			elsif (probability <= 2*@NWEAPONSPROB)
				rvalue = 2
			end
			return rvalue
		end

		# Este método determina el número de potenciadores de escudo que recibirá
		# una estación espacial al ser creada.

		def initWithNShields
			rvalue = 1
			if @generator.rand(1.0) <= @NSHIELDSPROB
				rvalue = 0
			end
			return rvalue
		end

		# Este método determina el jugador (su índice) que iniciará la partida.

		def whoStarts (nPlayers)
			return @generator.rand(nPlayers)
		end

		# Este método determina quién (de los dos tipos de personajes del juego)
		# dispara primero en un combate: la estación espacial o la nave enemiga.

		def firstShot
			if @generator.rand(1.0) <= @FIRSTSHOTPROB
				return GameCharacter::SPACESTATION
			else
				return GameCharacter::ENEMYSTARSHIP
			end
		end

		# Este método determina si la estación espacial se moverá para esquivar
		# un disparo. 

		def spaceStationMoves (speed)
			rvalue = false
			if @generator.rand(1.0) <= speed
				rvalue = true
			end
			return rvalue
		end
		
		# Determina si una estación espacial recibe eficiencia extra
		
		def extraEfficiency
			rvalue = false
			if @generator.rand(1.0) <= @EXTRAEFFICIENCYPROB
				rvalue = true
			end
			return rvalue
		end
		
	end
	
	# Comprobación de código
=begin
	dice = Dice.new
	puts "Número de Hangares: " + dice.initWithNHangars.to_s
	puts "Número de Armas: " + dice.initWithNWeapons.to_s
	puts "Jugador escogido entre 3 jugadores: " + dice.whoStarts(3).to_s
	puts "Primero en disparar" + dice.firstShot.to_s
=end
end
