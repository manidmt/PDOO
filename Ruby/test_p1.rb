#encoding: UTF-8
require_relative 'Loot.rb'
require_relative 'SuppliesPackage.rb'
require_relative 'ShieldBooster.rb'
require_relative 'Weapon.rb'
require_relative 'WeaponType.rb'
require_relative 'Dice.rb'

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Esta clase crea varias instancias de cada clase creada en esta práctica y,
# utilizando los consultores, muestra en la consola toda la información posible
# de esos objetos creados.

module Deepspace

	class TestP1

		def self.testLoot

			puts "Probando la clase Loot (botín)"
			print "Introduzca el número de suministros: "
			supplies = gets.to_i
			print "Introduzca el número de armas: "
			weapons = gets.to_i
			print "Introduzca el número de escudos: "
			shields = gets.to_i
			print "Introduzca el número de hangares: "
			hangars = gets.to_i
			print "Introduzca el número de medallas: "
			medals = gets.to_i

			l1 = Loot.new(supplies, weapons, shields, hangars, medals)

			puts "Info. botín creado:"
			puts l1.inspect
			puts "Suministros = #{l1.nSupplies}"
			puts "Armas = #{l1.nWeapons}"
			puts "Escudos = #{l1.nShields}"
			puts "Hangares = #{l1.nHangars}"
			puts "Medallas = #{l1.nMedals}"

		end

		def self.testSuppliesPackage

			puts "Probando la clase SuppliesPackage (paquete de suministros)"
			print "Introduzca la potencia de la munición: "
			ammo = gets.to_f
			print "Introduzca las unidades de combustible: "
			fuel = gets.to_f
			print "Introduzca la potencia de escudo: "
			shield = gets.to_f

			sp1 = SuppliesPackage.new(ammo, fuel, shield)
			sp2 = SuppliesPackage.newCopy(sp1)
			
			puts "Info. paquete creado (1)"
			puts sp1.inspect
			puts "Info. copia del paquete (2)"
			puts sp2.inspect
			puts "Potencia de munición 1 = #{sp1.ammoPower}"
			puts "Potencia de munición 2 = #{sp2.ammoPower}"
			puts "Unidades de combustible 1 = #{sp1.fuelUnits}"
			puts "Unidades de combustible 2 = #{sp2.fuelUnits}"
			puts "Potencia de escudo 1 = #{sp1.shieldPower}"
			puts "Potencia de escudo 2 = #{sp2.shieldPower}"		

		end

		def self.testShieldBooster

			puts "Probando la clase ShieldBooster (potenciador de escudo)"
			print "Introduzca el nombre: "
			name = gets.chomp
			print "Introduzca la potencia: "
			boost = gets.to_f
			print "Introduzca el número de usos: "
			uses = gets.to_i

			sb1 = ShieldBooster.new(name, boost, uses)
			sb2 = ShieldBooster.newCopy(sb1)

			puts "Info. potenciador de escudo creado (1)"
			puts sb1.inspect
			puts "Info. copia (2)"
			puts sb2.inspect

			puts "Nombre 1 = #{sb1.name}"
			puts "Nombre 2 = #{sb2.name}"
			puts "Potencia 1 = #{sb1.boost}"
			puts "Potencia 2 = #{sb2.boost}"
			puts "Usos 1 = #{sb1.uses}"
			puts "Usos 2 = #{sb2.uses}"

			while sb1.uses > 0
				puts "Se ha usado el potenciador de escudo 1, POTENCIA = #{sb1.useIt}"
				puts "Usos restantes: #{sb1.uses}"
			end
			puts "El número de usos debe ser 0 = #{sb1.uses}"
			puts "Al usar el potenciador de escudo 1 obtenemos 1.0 = #{sb1.useIt}"

			while sb2.uses > 0
				puts "Se ha usado el potenciador de escudo 2, POTENCIA = #{sb2.useIt}"
				puts "Usos restantes: #{sb2.uses}"
			end
			puts "El número de usos debe ser 0 = #{sb2.uses}"
			puts "Al usar el potenciador de escudo 2 obtenemos 1.0 = #{sb2.useIt}"
			
		end

		def self.testWeapon

			puts "Probando la clase Weapon (arma)"
			print "Introduzca el nombre: "
			name = gets.chomp
			print "Introduzca el número de usos: "
			uses = gets.to_i
			puts "El tipo de arma (junto con su potencia asociada) se asigna de forma pseudo-aleatoria"

			dado = Dice.new
			v = dado.initWithNWeapons
			type = WeaponType::LASER
			if v == 1
				type = WeaponType::MISSILE
			elsif v == 2
				type = WeaponType::PLASMA
			end

			w1 = Weapon.new(name, type, uses)
			w2 = Weapon.newCopy(w1)

			puts "Info. arma creada (1)"
			puts w1.inspect
			puts "Info. copia del arma (2)"
			puts w2.inspect

			puts "Nombre 1 = #{w1.name}"
			puts "Nombre 2 = #{w2.name}"
			puts "Tipo 1 = #{w1.type.name}"
			puts "Tipo 2 = #{w2.type.name}"
			puts "Usos 1 = #{w1.uses}"
			puts "Usos 2 = #{w2.uses}"
			puts "Potencia 1 = #{w1.power}"
			puts "Potencia 2 = #{w2.power}"

			while w1.uses > 0
				puts "Se ha usado el arma 1, POTENCIA = #{w1.useIt}"
				puts "Usos restantes: #{w1.uses}"
			end
			puts "El número de usos debe ser 0 = #{w1.uses}"
			puts "Al usar el arma 1 obtenemos 1.0 = #{w1.useIt}"

			while w2.uses > 0
				puts "Se ha usado el arma 2, POTENCIA = #{w2.useIt}"
				puts "Usos restantes: #{w2.uses}"
			end
			puts "El número de usos debe ser 0 = #{w2.uses}"
			puts "Al usar el arma 2 obtenemos 1.0 = #{w2.useIt}"

		end

		def self.testDice

			nPRUEBAS = 100
			speed = 0.5

			# Instancia de la clase Dice
			dado = Dice.new

			# Contadores de los posibles valores a obtener con cada método
			contHangars = [0, 0]
			contWeapons = [0, 0, 0]
			contShields = [0, 0]
			contStarter = [0, 0, 0, 0] # habrá 4 jugadores, por ejemplo
			contfirstShot = [0, 0]
			contMoves = [0, 0]

			nPRUEBAS.times {

				contHangars[dado.initWithNHangars]+=1
				contWeapons[dado.initWithNWeapons-1]+=1
				contShields[dado.initWithNShields]+=1
				contStarter[dado.whoStarts(4)]+=1

				if dado.firstShot == GameCharacter::SPACESTATION
					contfirstShot[0]+=1
				else
					contfirstShot[1]+=1
				end

				if dado.spaceStationMoves(speed)
					contMoves[0]+=1
				else
					contMoves[1]+=1
				end
			}

			puts "Probando la clase Dice (dado)"
			puts "Resultado de llamar a initWithNHangars #{nPRUEBAS} veces"
			puts "\t0: #{contHangars[0]} veces"
			puts "\t1: #{contHangars[1]} veces"
			puts "Resultado de llamar a initWithNWeapons #{nPRUEBAS} veces"
			puts "\t1: #{contWeapons[0]} veces"
			puts "\t2: #{contWeapons[1]} veces"
			puts "\t3: #{contWeapons[2]} veces"
			puts "Resultado de llamar a initWithNShields #{nPRUEBAS} veces"
			puts "\t0: #{contShields[0]} veces"
			puts "\t1: #{contShields[1]} veces"
			puts "Resultado de llamar a whoStarts #{nPRUEBAS} veces con 4 jugadores"
			puts "\tj1: #{contStarter[0]} veces"
			puts "\tj2: #{contStarter[1]} veces"
			puts "\tj3: #{contStarter[2]} veces"
			puts "\tj4: #{contStarter[3]} veces"
			puts "Resultado de llamar a firstShot #{nPRUEBAS} veces"
			puts "\tSPACESTATION: #{contfirstShot[0]} veces"
			puts "\tENEMYSTARSHIP: #{contfirstShot[1]} veces"
			puts "Resultado de llamar a spaceStationMoves #{nPRUEBAS} veces"
			puts "\tSe mueve (true): #{contMoves[0]} veces"
			puts "\tNo se mueve (false): #{contMoves[1]} veces"


		end

		def self.main

			puts "\nTEST LOOT"
			self.testLoot
			puts "\nTEST SUPPLIESPACKAGE"
			self.testSuppliesPackage
			puts "\nTEST SHIELDBOOSTER"
			self.testShieldBooster
			puts "\nTEST WEAPON"
			self.testWeapon
			puts "\nTEST DICE"
			self.testDice

		end

	end

	TestP1.main

end
