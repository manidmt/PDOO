#encoding:utf-8

require_relative 'WeaponType'
require_relative 'Loot'
require_relative 'LootToUI'
require_relative 'SuppliesPackage'
require_relative 'ShieldBooster'
require_relative 'Weapon'
require_relative 'Dice'

#Class for test main program for first practice
#
#@author Javier Gomez Lopez

class TestP1

    include Deepspace

    def self.main
        #Testing WeaponType enum
        puts "TESTING ENUM: WeaponType"
        puts "**********************************"

        laser = Deepspace::WeaponType::LASER
        missile = Deepspace::WeaponType::MISSILE
        plasma = Deepspace::WeaponType::PLASMA

        puts "The power of laser is\t #{laser.power}"
        puts "The power of missile is\t #{missile.power}"
        puts "The power of plasma is\t #{plasma.power}"
        puts

        #Testing Loot class
        puts "TESTING CLASS: Loot (5 times)"
        puts "**********************************"

        5.times do
            nSupplies = rand(20)
            nWeapons = rand(20)
            nShields = rand(20)
            nHangars = rand(20)
            nMedals = rand(20)

            puts "Creating Loot.new{#{nSupplies}, #{nWeapons}, #{nShields}, #{nHangars}, #{nMedals})"
            
            loot_test = Loot.new(nSupplies, nWeapons, nShields, nHangars, nMedals)

            puts "Result: #{loot_test}"
            puts 
            puts "Testing Getters"
            puts "Supplies: #{loot_test.nSupplies}"
            puts "Weapons: #{loot_test.nWeapons}"
            puts "Shields: #{loot_test.nShields}"
            puts "Hangars: #{loot_test.nHangars}"
            puts "Medals: #{loot_test.nMedals}"
            puts "--------------------------------------------"
        end
        puts

        #Testing SuppliesPackage class
        puts "TESTING CLASS: SuppliesPackage (5 times)"
        puts "**********************************"

        5.times do
            ammoPower = rand(10)
            fuelUnits = rand(10)
            shieldPower = rand(10)

            puts "Creating SuppliesPackage.new(#{ammoPower}, #{fuelUnits}, #{shieldPower})"

            supplie_test = SuppliesPackage.new(ammoPower, fuelUnits, shieldPower)

            puts "Result: #{supplie_test}"
            puts
            puts "Testing copy initializer"
            supplie_copy = SuppliesPackage.newCopy(supplie_test)
            puts "Result: #{supplie_copy}"
            puts "--------------------------------------------"
        end
        puts

        #Testing ShieldBooster class
        puts "TESTING CLASS: ShieldBooster (5 times)"
        puts "**********************************"

        5.times do
            name = "shieldBoost Test"
            boost = rand(10) + rand()
            uses = rand(10)

            puts "Creating ShieldBooster.new(#{name}, #{boost}, #{uses})"

            shield_test = ShieldBooster.new(name, boost, uses)

            puts "Result: #{shield_test}"
            puts
            puts "Testing copy initializer"
            shield_copy = ShieldBooster.newCopy(shield_test)
            puts "Result: #{shield_copy}"
            puts

            puts "Testing useIt method"
            for i in 1..4 do 
                current_boost = shield_test.useIt

                puts "Iteration #{i}:"
                puts "\t-current boost = #{current_boost} \tuses left = #{shield_test.uses}"
            end
            puts

            puts "State of the original shield after useIt:"
            puts shield_test
            puts "State of the copied shield after useIt:"
            puts shield_copy
            puts "--------------------------------------------"
        end
        puts

        #Testing Weapon class
        puts "TESTING CLASS: Weapon (5 times)"
        puts "**********************************"

        5.times do
            name = "Weapon Test"
            type = [WeaponType::LASER, WeaponType::MISSILE, WeaponType::PLASMA].sample
            uses = rand(7)

            puts "Creating Weapon(#{name}, #{type}, #{uses})"

            weapon_test = Weapon.new(name, type, uses)

            puts "Result: #{weapon_test}"
            puts
            puts "Testing copy initializer"
            
            weapon_copy = Weapon.newCopy(weapon_test)

            puts "Result: #{weapon_copy}"
            puts

            puts "Testing Getters"
            puts "Type: #{weapon_test.type}"
            puts "Uses: #{weapon_test.uses}"
            puts

            puts "Testing useIt method"
            for i in 1..4
                current_power = weapon_test.useIt

                puts "Iteration #{i}:"
                puts "-current power = #{current_power} \t uses left = #{weapon_test.uses}"
            end

            puts "State of the original weapon after useIt:"
            puts weapon_test
            puts "State of the copied weapon after useIt:"
            puts weapon_copy
            puts "--------------------------------------------"
        end
        puts 

        #Testing Dice class
        puts "TESTING CLASS: Dice"
        puts "**********************************"

        #First we create an array of dices
        dices = []

        for i in 0..99
            dices << Dice.new
        end

        puts "Hundred dices initialized!"
        puts

        #Testing initWithNHangars
        puts "Testing initWithNHangars"
        zero_hangars = 0
        one_hangars = 0

        for dice in dices
            value = dice.initWithNHangars

            if value == 0
                zero_hangars += 1
            else
                one_hangars += 1
            end
        end

        puts "\t0: #{zero_hangars} %"
        puts "\t1: #{one_hangars} %"
        puts

        #Testing initWithNWeapons
        puts "Testing initWithNWeapons"
        one_weapons = 0
        two_weapons = 0
        three_weapons = 0

        for dice in dices
            value = dice.initWithNWeapons

            if value == 1
                one_weapons += 1
            elsif value == 2
                two_weapons += 1
            else
                three_weapons += 1
            end
        end

        puts "\t1: #{one_weapons} %"
        puts "\t2: #{two_weapons} %"
        puts "\t3: #{three_weapons} %"
        puts

        #Testing initWithNShields
        puts "Testing initWithNShields"
        zero_shields = 0
        one_shields = 0

        for dice in dices
            value = dice.initWithNShields

            if value == 0
                zero_shields += 1
            else
                one_shields += 1
            end
        end

        puts "\t0: #{zero_shields} %"
        puts "\t1: #{one_shields} %"
        puts

        #Testing whoStarts
        puts "Testing whoStarts for 10 players"
        players_values = Array.new(10,0)

        for dice in dices
            players_values[dice.whoStarts(10)] += 1
        end

        for index in 0..9
            puts "\t#{index}: #{players_values[index]} %"
        end
        puts

        #Testing firstShot
        puts "Testing firstShot"
        space_shot = 0
        enemy_shot = 0

        for dice in dices
            value = dice.firstShot

            if value == GameCharacter::SPACESTATION
                space_shot += 1
            else
                enemy_shot += 1
            end
        end

        puts "\tSPACESTATION: #{space_shot} %"
        puts "\tENEMYSTARTSHIP: #{enemy_shot} %"
        puts

        #Testing spaceStationMoves
        puts "Testing spaceStationMoves with 0.54 speed"
        avoids = 0
        receives = 0

        for dice in dices
            value = dice.spaceStationMoves(0.54)

            if value
                avoids += 1
            else 
                receives += 1
            end
        end

        puts "\tAvoids the shoot: #{avoids} %"
        puts "\tRecieves the shoot: #{receives} %"
        puts "--------------------------------------------"

    end
        
end #End TestP1

TestP1.main