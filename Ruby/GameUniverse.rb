#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

require_relative 'GameUniverseToUI'
require_relative 'GameState'
require_relative 'GameStateController'
require_relative 'CardDealer'
require_relative 'SpaceStation'
require_relative 'Dice'
require_relative 'CombatResult'
require_relative 'GameCharacter'
require_relative 'ShotResult'

module Deepspace
	
	class GameUniverse

		private
		
		@@WIN = 10

		public

		def initialize
			# Atributos de instancia
			@currentStationIndex = -1
			@turns = 0
			# Atributos de referencia (también son de instancia)
			@gameState = GameStateController.new
			@dice = Dice.new
			@currentStation = nil
			@spaceStations = nil
			@currentEnemy = nil
			@haveSpaceCity = false
		end

		# Se realiza un combate entre la estación espacial y el enemigo que se reciben
		# como parámetros. Se sigue el procedimiento descrito en las reglas del juego:
		# sorteo de quién dispara primero, posibilidad de escapar, asignación del botín,
		# anotación del daño pendiente, etc. Se devuelve el resultado del combate.

		def combatGo(station, enemy)
			if @dice.firstShot == GameCharacter::ENEMYSTARSHIP
				fire = enemy.fire
				result = station.receiveShot(fire)
				if result == ShotResult::RESIST
					fire = station.fire
					result = enemy.receiveShot(fire)
					enemyWins = (result == ShotResult::RESIST)
				else
					enemyWins = true
				end
			else
				fire = station.fire
				result = enemy.receiveShot(fire)
				enemyWins = (result == ShotResult::RESIST)
			end

			if enemyWins
				if !(@dice.spaceStationMoves(station.speed))
					station.setPendingDamage(enemy.damage)
					combatResult = CombatResult::ENEMYWINS
				else
					station.move
					combatResult = CombatResult::STATIONESCAPES
				end
			else
				aLoot = enemy.loot
				transformation = station.setLoot(aLoot)
				
				if transformation == Transformation::GETEFFICIENT
					makeStationEfficient
					combatResult = CombatResult::STATIONWINSANDCONVERTS
				elsif transformation ==  Transformation::SPACECITY
					createSpaceCity
					combatResult = CombatResult::STATIONWINSANDCONVERTS
				else
					combatResult = CombatResult::STATIONWINS	
				end
			end

			@gameState.next(@turns, @spaceStations.size)
			return combatResult
		end

		# Si la aplicación se encuentra en un estado en donde el combatir está
		# permitido, se realiza un combate entre la estación espacial que tiene el
		# turno y el enemigo actual. Se devuelve el resultado del combate.

		def combat
			if (state == GameState::BEFORECOMBAT || state == GameState::INIT)
				return combatGo(@currentStation, @currentEnemy)
			else
				return CombatResult::NOCOMBAT
			end
		end

		def discardHangar
			if (state==GameState::INIT || state==GameState::AFTERCOMBAT)
				@currentStation.discardHangar
			end
		end

		def discardShieldBooster(i)
			if (state==GameState::INIT || state==GameState::AFTERCOMBAT)
				@currentStation.discardShieldBooster(i)
			end
		end

		def discardShieldBoosterInHangar(i)
			if (state==GameState::INIT || state==GameState::AFTERCOMBAT)
				@currentStation.discardShieldBoosterInHangar(i)
			end
		end

		def discardWeapon(i)
			if (state==GameState::INIT || state==GameState::AFTERCOMBAT)
				@currentStation.discardWeapon(i)
			end
		end

		def discardWeaponInHangar(i)
			if (state==GameState::INIT || state==GameState::AFTERCOMBAT)
				@currentStation.discardWeaponInHangar(i)
			end
		end

		def state
			return @gameState.state
		end

		def getUIversion
			return GameUniverseToUI.new(@currentStation, @currentEnemy)
		end

		def haveAWinner
			return @currentStation.nMedals >= @@WIN
		end

		# Este método inicia una partida. Recibe una colección con los nombres de los
		# jugadores. Para cada jugador, se crea una estación espacial y se equipa con
		# suministros, hangares, armas y potenciadores de escudos tomados de los mazos
		# de cartas correspondientes. Se sortea qué jugador comienza la partida, se
		# establece el primer enemigo y comienza el primer turno.

		def init(names)
			if @gameState.state == GameState::CANNOTPLAY
				@spaceStations = Array.new
				dealer = CardDealer.instance
				names.each do |name| # for name in names do
					station = SpaceStation.new(name, dealer.nextSuppliesPackage)
					@spaceStations << station
					nh = @dice.initWithNHangars
					nw = @dice.initWithNWeapons
					ns = @dice.initWithNShields
					lo = Loot.new(0, nw, ns, nh, 0)
					station.setLoot(lo)
					puts station.to_s
				end
				@currentStationIndex = @dice.whoStarts(names.size)
				@currentStation = @spaceStations.at(@currentStationIndex)
				@currentEnemy = dealer.nextEnemy
				@gameState.next(@turns, @spaceStations.size)
			end
		end

		def mountShieldBooster(i)
			if (state==GameState::INIT || state==GameState::AFTERCOMBAT)
				@currentStation.mountShieldBooster(i)
			end
		end

		def mountWeapon(i)
			if (state==GameState::INIT || state==GameState::AFTERCOMBAT)
				@currentStation.mountWeapon(i)
			end
		end

		# Se comprueba que el jugador actual no tiene ningún daño pendiente de cumplir,
		# en cuyo caso se realiza un cambio de turno al siguiente jugador con un nuevo
		# enemigo con quien combatir, devolviendo true. Se devuelve false en otro caso.

		def nextTurn
			if state == GameState::AFTERCOMBAT
				if @currentStation.validState
					@currentStationIndex = (@currentStationIndex+1) % @spaceStations.size
					@turns+=1
					@currentStation = @spaceStations.at(@currentStationIndex)
					@currentStation.cleanUpMountedItems
					dealer = CardDealer.instance
					@currentEnemy = dealer.nextEnemy
					@gameState.next(@turns, @spaceStations.size)
					return true
				end
				return false
			end
			return false
		end
		
		def makeStationEfficient
			@currentStation = PowerEfficientStation.new(@currentStation)
			
			if @dice.extraEfficiency
				@currentStation = BetaPowerEfficentStation.new(@currentStation)
			end
			
			@spaceStations[@currentStationIndex] = @currentStaion
		end
		
		def createSpaceCity
			if !@haveSpaceCity
				rest = Array.new
				
				@spaceStations.each do |s|
					if s != @currentStation
						rest << s
					end
				end
				
				@currentStation = SpaceCity.new(@currentStation, rest)
				
				@spaceStations[@currentStationIndex] = @currentStaion
				@haveSpaceCity = true
			end
		end

		def to_s
			return getUIversion.to_s
		end

	end
end
