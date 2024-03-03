#encoding:utf-8

require_relative 'NumericDamage'
require_relative 'SpecificDamage'
require_relative 'SpaceCity'
require_relative 'PowerEfficientSpaceStation'
require_relative 'BetaPowerEfficientSpaceStation'
require_relative 'CardDealer'
require_relative 'Weapon'
require_relative 'ShieldBooster'
require_relative 'WeaponType'
require_relative 'SuppliesPackage'
require_relative 'SpaceStation'

#Class for test the foruth practice of the subject
#
#@author Javier Gomez Lopez

class TestP4
    include Deepspace

    private
    #@brief Test of Numeric Damage

    def self.testNumericDamage
        puts "TESTING Class: NumericDamage (3 times)"
        puts "**********************************"

        dealer = CardDealer.instance

        3.times do
            w = []
            s = []

            w << dealer.nextWeapon
            s << dealer.nextShieldBooster

            w_num = rand(1..5)
            s_num = rand(1..5)

            numeric_test = NumericDamage.new(w_num, s_num)
            puts "Creating new NumericDamage(#{w_num},#{s_num})"
            puts "The state of the new Numeric Damage is"
            puts numeric_test
            puts

            puts "Creating a copy of the numeric damage..."
            copy_test = numeric_test.copy
            puts "State of the copy"
            puts copy_test
            puts

            puts "Testing hasNoEffect()..."
            puts "Our Damage hasNoEffect: #{numeric_test.hasNoEffect}"
            puts "NumericDamage(0,0) hasNoEffect: #{NumericDamage.new(0,0).hasNoEffect}"
            puts

            puts "Discarding a shield booster..."
            numeric_test.discardShieldBooster
            puts "State after discarding a shieldBooster:"
            puts numeric_test
            puts

            puts "Testing adjust"
            puts "Weapon List: #{w.join(", ")}"
            puts "Shield List: #{s.join(", ")}"
            numeric_test = numeric_test.adjust(w,s)
            puts "State after adjusting:"
            puts numeric_test
            puts

            puts "State of the original version"
            puts numeric_test
            puts "State of the copy"
            puts copy_test
            puts "**********************************"
            puts
        end

    end

    #@brief Test of Specific Damage
    def self.testSpecificDamage
        puts "TESTING Class: SpecificDamage (3 times)"
        puts "**********************************"

        dealer = CardDealer.instance

        3.times do
            weapon_list = []
            weapon_list << WeaponType::LASER 
            s_num = rand(1..5)

            specific_test = SpecificDamage.new(weapon_list, s_num)

            puts "Creating new SpecificDamage(#{weapon_list.join(",")}, #{s_num})"
            puts "The state of the new SpecificDamage is:"
            puts specific_test
            puts

            puts "Creating a copy of the specific damage..."
            copy_test = specific_test.copy
            puts "State of the copy:"
            puts copy_test
            puts

            puts "Testing hasNoEffect()"
            puts "Our Damage hasNoEffect(): #{specific_test.hasNoEffect}"
            puts "SpecificDamage(nil,0) hasNoEffect: #{SpecificDamage.new(nil,0).hasNoEffect}"
            puts 

            puts "Testing adjust..."
            w = []
            s = []

            w << dealer.nextWeapon
            s << dealer.nextShieldBooster

            puts "State before adjust:"
            puts specific_test
            puts
            puts "Weapons to adjust: #{w.join(",")}"
            puts "Shields to adjust: #{s.join(", ")}"
            specific_test = specific_test.adjust(w,s)
            puts "State after the adjust"
            puts specific_test
            puts       
            
            puts "Testing discard weapon"
            test_w_1 = Weapon.new("Weapon1", WeaponType::LASER, 3)
            test_w_2 = Weapon.new("Weapon2", WeaponType::PLASMA, 2)

            puts "Discarding a PLASMA..."
            specific_test.discardWeapon(test_w_2)
            puts "State of the damage"
            puts specific_test

            puts "Discarding a LASER"
            specific_test.discardWeapon(test_w_1)
            puts "State of the damage"
            puts specific_test
            puts

            puts "Discarding a shield booster..."
            specific_test.discardShieldBooster
            puts "State of the damage"
            puts specific_test
            puts

            puts "State of the original damage"
            puts specific_test

            puts "State of the copy"
            puts copy_test

            puts "**********************************"
            puts
        end
    end

    #@brief Test of SpaceCity

    def self.testSpaceCity
        puts "TESTING Class: SpaceCity"
        puts "**********************************"

        base = SuppliesPackage.new(1.23,3.14,2.22)
        javi = SpaceStation.new("Javi", base)
        soledad = SpaceStation.new("Soledad", base)
        roberto = SpaceStation.new("Roberto", base)

        collaborators = []

        collaborators << soledad
        collaborators << roberto

        city_test = SpaceCity.new(javi, collaborators)
        puts "The created SpaceCity is: "
        puts city_test
        puts

        puts "Firing with a power of #{city_test.fire}"
        puts "Protecting with a power of #{city_test.protection}"

        loot_test = Loot.new(1,2,3,4,5,false,true)
        puts "Adding the loot: "
        puts loot_test
        puts

        city_test.setLoot(loot_test)

        puts "State of the city"
        puts city_test
        puts

        puts "**********************************"
        puts

    end

    #@brief Test of PowerWfficientStation
    def self.testPowerEfficientStation
        puts "TESTING Class: PowerEfficientSpaceStation"
        puts "**********************************"

        base = SuppliesPackage.new(1.23,3.14,2.22)
        station_test = SpaceStation.new("Javi", base)
        power_test = PowerEfficientSpaceStation.new(station_test)

        puts "The created power efficient station is:"
        puts power_test
        puts

        puts "The station fire: #{power_test.fire}"
        puts "The station protects: #{power_test.protection}"
        puts

        loot_test = Loot.new(1,2,3,4,5,false,true)
        puts "Adding the loot #{loot_test}"
        trans_test = power_test.setLoot(loot_test)
        puts "Transformation returned: #{trans_test}"
        puts "State of the power efficient station:"
        puts power_test
        puts 

        puts "**********************************"
        puts
    end

    #@brief Test of BetaPowerEfficientStation

    def self.testBetaPowerEfficientStation
        puts "TESTING Class: BetaPowerEfficientSpaceStation"
        puts "**********************************"

        base = SuppliesPackage.new(1.23,3.14,2.22)
        station_test = SpaceStation.new("Javi", base)

        beta_test = BetaPowerEfficientSpaceStation.new(station_test)
        puts "The created beta power efficient station is:"
        puts station_test
        puts

        puts "Firing a few times"

        5.times do
            puts "The station fires: #{beta_test.fire}"
        end
        puts
        puts "**********************************"
        puts

    end


    public 
    def self.main
        testNumericDamage
        testSpecificDamage
        testSpaceCity
        testPowerEfficientStation
        testBetaPowerEfficientStation
    end
end #End class

TestP4.main
