#encoding:utf-8

require_relative 'CardDealer'
require_relative 'SpaceStation'
require_relative 'SuppliesPackage'
require_relative 'Loot'
require_relative 'Damage'
require_relative 'GameUniverse'
require_relative 'CombatResult'

#Class for test main program for third practice
#
#@author Javier Gomez Lopez

class TestP3

    include Deepspace

    private 
    #@brief Test of the SpaceStation
    def self.testSpaceStation
        dealer = CardDealer.instance

        #Testing SpaceStation
        puts "TESTING Class: SpaceStation (3 times)"
        puts "**********************************"

        3.times do
            supplies_test = SuppliesPackage.new(1.05,3.14,2.1)
            station_test = SpaceStation.new("SpaceStation test", supplies_test)

            puts "The created SpaceStation is:"
            puts station_test
            puts

            #Testing setLoot
            puts "Adding a loot to the station"
            loot = Loot.new(rand(1..5),rand(1..5),rand(1..5),rand(1..5),rand(1..5))
            puts "The loot to add is:"
            puts loot
            puts 

            station_test.setLoot(loot)
            puts "After adding a the loot, the station is:"
            puts station_test
            puts

            #Testing setPendingDamage
            puts "We are going to add some elements and mount them in order to try setPendingDamage"
            puts

            station_test.mountShieldBooster(0)
            station_test.mountWeapon(0)
			puts station_test.shieldBoosters.inspect
            puts "Status of the station:"
            puts station_test
            puts

            puts "Adding some damage to the station..."
            damage = dealer.nextEnemy.damage
            puts "The damage to add is:"
            puts damage
            puts

            station_test.setPendingDamage(damage)
            puts "After adding the damage the state is:"
            puts station_test
            puts "The state of the space station is #{station_test.validState}"
            puts

            #Testing cleanUpMountedItems

            #With weapons
            puts "Testing SpaceStation.cleanUpMountedItems...\n\n"

            puts "Using the weapon until making it useless:"

            if !station_test.weapons.nil?
                if station_test.weapons.any? && !station_test.weapons[0].nil?
                    while station_test.weapons[0].uses > 0
                        station_test.weapons[0].useIt
                    end

                    puts "State before cleaning up mounted items:"
                    puts station_test

                    station_test.cleanUpMountedItems

                    puts "\nState after cleaning up mounted items:"
                    puts station_test
                    puts
                else
                    puts "There was no weapon to use"
                    puts
                end
            else
                puts "There was no weapon ArrayList to access"
                puts
            end

            #With shields
            puts "Using the shield until making it useless:"

            if !station_test.shieldBoosters.nil?
                if station_test.shieldBoosters.any? && !station_test.shieldBoosters[0].nil?
                    while station_test.shieldBoosters[0].uses > 0
                        station_test.shieldBoosters[0].useIt
                    end

                    puts "State before cleaning up mounted items:"
                    puts station_test

                    station_test.cleanUpMountedItems

                    puts "\nState after cleaning up mounted items:"
                    puts station_test
                else
                    puts "There was no shieldBooster to use"
                    puts
                end
            else
                puts "There was no ShieldBooster ArrayList to access"
                puts
            end

            puts

            #Testing discardShieldBooster and discardWeapon
            puts "We add some elements and mount them in order to discard them later"
            loot = Loot.new(2,2,2,2,2)

            station_test.setLoot(loot)
            station_test.mountShieldBooster(0)
            station_test.mountWeapon(0)

            puts "State of the Station before discarding"
            puts station_test

            puts "Discarding a shieldBooster..."
            station_test.discardShieldBooster(0)
            puts "State of the station after discarding a shieldBooster:"
            puts station_test
            puts

            puts "Discarding a weapon..."
            station_test.discardWeapon(0)
            puts "State of the station after discaring a weapon:"
            puts station_test
            puts

            #Testing space station actions
            puts "Adding some elements and mounting them in order to make some actions"
            loot = Loot.new(3,3,3,3,3)

            station_test.setLoot(loot)
            station_test.mountShieldBooster(0)
            station_test.mountWeapon(0)

            puts "State of the station"
            puts station_test
            puts

            puts "Fire: #{station_test.fire}"
            puts "Protect: #{station_test.protection}"
            puts 

            puts "State of the station:"
            puts station_test
            puts

            #Receiving some shots
            i = 20
            while i <= 101
                puts "Result of receiving a shot of power #{i}: #{station_test.receiveShot(i)}"
                i += 10
            end

            puts "-----------"
            puts
        end
    end

    #@brief Test of the GameUniverse

    def self.testGameUniverse
        #Testing Universe
        puts "TESTING Class: GameUniverse (3 times)"
        puts "**********************************"

        3.times do
            #Testing the constructor and init
            universe_test = GameUniverse.new
            puts "Testing constructor and init method for players Javi and Roberto:"
            player_names = ["Javi","Roberto"]

            puts "The players are: #{player_names.join(", ")}"
            universe_test.init(player_names)
            puts "After creating and starting a game, the universe state is:"
            puts universe_test
            puts

            #Testing the state of the ganme and haveAWinner
            puts "The current state of the game is: #{universe_test.state}"
            puts "Have we got a winner?: #{universe_test.haveAWinner}"
            puts

            #Testing combat
            puts "Testing the combat:"
            result_test = universe_test.combat
            puts "The result of the combat was: #{result_test}"
            puts

            puts "State of the game: #{universe_test.state}"
            puts universe_test
            puts

            #Testing nextTurn
            puts "Testing next turn:"
            universe_test.nextTurn
            puts "State after next turn:"
            puts universe_test
            puts

            puts "-----------"
            puts
        end




    end

    public 
    def self.main
        testSpaceStation
        testGameUniverse
    end

end #End of class

TestP3.main