#encoding: UTF-8

# Autores: Manuel Díaz-Meco Terrés y Ana Graciani Donaire
# 2ºDGIIM		PDOO

# Esta clase representa el concepto de estación espacial así como
# sus atributos y funcionalidades

require_relative 'SpaceStationToUI'
require_relative 'SuppliesPackage'
require_relative 'Damage'
require_relative 'Transformation'
require_relative 'Hangar'
require_relative 'CardDealer'

module Deepspace
	class SpaceStation
		
		private

		# Atributos de clase (son privados)
		
		# Máxima cantidad de unidades de combustible que puede tener una estación
		# espacial
		@@MAXFUEL = 100.0
		
		# Unidades de escudo que se pierden por cada unidad de potencia de disparo
		# recibido
		@@SHIELDLOSSPERUNITSHOT = 0.1
	
		public

		# Constructor
		def initialize (n, supplies)

			# Atributos de instancia (son privados)
			@ammoPower = supplies.ammoPower
			assignFuelValue(supplies.fuelUnits)
			@name = n
			@nMedals = 0
			@shieldPower = supplies.shieldPower
			
			# Atributos de referencia
			@pendingDamage  = nil
			@weapons = Array.new
			@shieldBoosters = Array.new
			@hangar = nil
		end
		
		# Constructor copia
		
		def copy(station)
		    @ammoPower = station.ammoPower
			assignFuelValue(station.fuelUnits)
		    @name = station.name
		    @nMedals = station.nMedals
		    @shieldPower = station.shieldPower

		    if !station.pendingDamage.nil?
		        @pendingDamage = station.pendingDamage.copy 
		    else
		        @pendingDamage = nil
		    end

		    @weapons = Array.new

		    station.weapons.each do |w|
		        @weapons << w
		    end

		    @shieldBoosters = Array.new

		    station.shieldBoosters.each do |s|
		        @shieldBoosters << s
		    end

		    if !station.hangar.nil?
		        @hangar = Hangar.newCopy(station.hangar)
		    else
		        @hangar = nil
		    end
		end
		
		private
		
		# Fija la cantidad de combustible al valor pasado como parámetro sin que nunca
		# se exceda del límite

		def assignFuelValue(f)
			@fuelUnits = [f, 0.0].max
			@fuelUnits = [@fuelUnits, @@MAXFUEL].min
		end
		
		public 
		
		# Si el daño pendiente (pendingDamage) no tiene efecto fija la referencia del
		# mismo a null

		def cleanPendingDamage
			if @pendingDamage.hasNoEffect
				@pendingDamage = nil
			end
		end
		
		# Eliminar todas las armas y los potenciadores de escudo montados a
		# las que no les queden usos.

		def cleanUpMountedItems
			@weapons.delete_if {|w| w.uses <= 0}
			@shieldBoosters.delete_if {|s| s.uses <= 0}
		end
		
		# Fija la referencia del hangar a null para indicar que no se dispone del mismo.
		
		def discardHangar
			@hangar = nil
		end
		
		# Se intenta descartar el potenciador de escudo con índice i de la colección
		# de potenciadores de escudo en uso. Además de perder el potenciador de escudo,
		# se debe actualizar el daño pendiente (pendingDamage) si es que se tiene
		# alguno.

		def discardShieldBooster(i)
				sb = @shieldBoosters.delete_at(i)
				if (@pendingDamage!=nil && sb!=nil)
					@pendingDamage.discardShieldBooster
					cleanPendingDamage
				end
		end
		
		# Si se dispone de hangar, se solicita al mismo descartar el potenciador de 
		# escudo con índice i.
		
		def discardShieldBoosterInHangar(i)
			if @hangar != nil
				@hangar.removeShieldBooster(i)
			end
		end
		
		# Se intenta descartar el arma con índice i de la colección de armas en uso.
		# Además de perder el arma, se debe actualizar el daño pendiente
		# (pendingDamage) si es que se tiene alguno.

		def discardWeapon(i)
				w = @weapons.delete_at(i)
				if (@pendingDamage!=nil && w!=nil)
					@pendingDamage.discardWeapon(w)
					cleanPendingDamage
				end
		end
		
		# Si se dispone de hangar, se solicita al mismo descartar el arma
		# con índice i.
		
		def discardWeaponInHangar(i)
			if @hangar != nil
				@hangar.removeWeapon(i)
			end
		end
		
		# Realiza un disparo y se devuelve la energía o potencia del mismo. Para ello
		# se multiplica la potencia de disparo por los factores potenciadores
		# proporcionados por todas las armas.

		def fire
			factor = 1.0
			for w in @weapons do
				factor*=w.useIt
			end
			return @ammoPower*factor
		end
		
		# Consultores
		
		def ammoPower
			return @ammoPower
		end
		
		def fuelUnits
			return @fuelUnits
		end
		
		def hangar
			return @hangar
		end
		
		def name
			return @name
		end
		
		def nMedals
			return @nMedals
		end
		
		def pendingDamage
			return @pendingDamage
		end
		
		def shieldBoosters
			return @shieldBoosters
		end
		
		def shieldPower
			return @shieldPower
		end
		
		# Devuelve la velocidad de la estación espacial. Esta se calcula como la fracción
		# entre las unidades de combustible de las que dispone en la actualidad la 
		# estación espacial respecto al máximo unidades de combustible que es posible 
		# almacenar. La velocidad se representa por tanto como un número del intervalo 
		# [0,1].

		def speed 
			return (@fuelUnits/@@MAXFUEL)
		end
		
		def getUIversion
			return SpaceStationToUI.new(self)
		end
		
		def weapons
			return @weapons
		end
		
		# Se intenta montar el potenciador de escudo con el índice i dentro del hangar. 
		# Si se dispone de hangar, se le indica que elimine el potenciador de escudo de 
		# esa posición y si esta operación tiene éxito (el hangar proporciona el 
		# potenciador), se añade el mismo a la colección de potenciadores en uso.
		
		def mountShieldBooster(i)
			if !@hangar.nil?
				s = @hangar.removeShieldBooster(i)

				if !s.nil?
					@shieldBoosters << s
				end
			end
		end
		
		# Se intenta montar el arma con el índice i dentro del hangar. Si se dispone
		# de hangar, se le indica que elimine el arma de esa posición y si esta 
		# operación tiene éxito (el hangar proporciona el arma), se añade el arma a la 
		# colección de armas en uso.
		
		def mountWeapon(i)
			if !@hangar.nil? && i>=0
				w = @hangar.removeWeapon(i)

				if !w.nil?
					@weapons << w
				end
			end
		end
		
		# Decremento de unidades de combustible disponibles a causa de un 
		# desplazamiento. Al número de las unidades almacenadas se les resta una 
		# fracción de las mismas que es igual a la velocidad de la estación. Las 
		# unidades de combustible no pueden ser inferiores a 0.
		
		def move
			assignFuelValue(@fuelUnits-(@fuelUnits*speed))
		end
		
		# Se usa el escudo de protección y se devuelve la energía del mismo. Para ello
		# se multiplica la potencia del escudo por los factores potenciadores
		# proporcionados por todos los potenciadores de escudos de los que se dispone.

		def protection
			factor = 1.0
			@shieldBoosters.each do |s| 
				factor*=s.useIt
			end
			return @shieldPower*factor
		end
		
		# Si no se dispone de hangar, el parámetro pasa a ser el hangar de la estación
		# espacial. Si ya se dispone de hangar esta operación no tiene efecto
		
		def receiveHangar(h)
			if @hangar.nil? && !h.nil?
				@hangar = h
			end
		end
		
		# Si se disponde de hangar, devuelve el resultado de intentar añadir el 
		# potenciador de escudo al mismo. Si no se dispone de hangar devuelve false
		
		def receiveShieldBooster(s)
			if @hangar != nil
				return @hangar.addShieldBooster(s)
			else
				return false
			end
		end
		
		# Realiza las operaciones relacionadas con la recepción del impacto de un
		# disparo enemigo. Ello implica decrementar la potencia del escudo en función
		# de la energía del disparo recibido como parámetro y devolver el resultado de
		# si se ha resistido el disparo o no.

		def receiveShot(shot)
			if (protection >= shot)
				@shieldPower=[0.0, @shieldPower-@@SHIELDLOSSPERUNITSHOT*shot].max
				return ShotResult::RESIST
			else
				@shieldPower = 0.0
				return ShotResult::DONOTRESIST
			end
		end
		
		# La potencia de disparo, la del escudo y las unidades de combustible se
		# incrementan con el contenido del paquete de suministro.
		
		def receiveSupplies(s)		 
			@ammoPower+= s.ammoPower
			@shieldPower+= s.shieldPower
			assignFuelValue(@fuelUnits+s.fuelUnits)
		end
		
		# Si se dispone de hangar, devuelve el resultado de intentar añadir el arma al 
		# mismo. Si no se dispone de hangar devuelve false.
		
		def receiveWeapon(w)
			if @hangar != nil
				return @hangar.addWeapon(w)
			else
				return false
			end
		end
		
		# Recepción de un botín. Por cada elemento que indique el botín (pasado como
		# parámetro) se le pide a CardDealer un elemento de ese tipo y se intenta
		# almacenar con el método receive*() correspondiente. Para las medallas,
		# simplemente se incrementa su número según lo que indique el botín.

		def setLoot(loot)
			dealer = CardDealer.instance

			if (loot.nHangars > 0)
				receiveHangar(dealer.nextHangar)
			end

			loot.nSupplies.times do
				receiveSupplies(dealer.nextSuppliesPackage)
			end

			loot.nWeapons.times do
				receiveWeapon(dealer.nextWeapon)
			end

			loot.nShields.times do
				receiveShieldBooster(dealer.nextShieldBooster)
			end

			@nMedals+= loot.nMedals
			
			if loot.getEfficient
				return Transformation::GETEFFICIENT
		    elsif loot.spaceCity
				return Transformation::SPACECITY
		    else
				return Transformation::NOTRANSFORM
		    end
		end
		
		# Se calcula el parámetro ajustado (adjust) a la lista de armas y potenciadores 
		# de escudo de la estación y se almacena el resultado en el atributo 
		# correspondiente.
		
		def setPendingDamage(d)
			@pendingDamage = d.adjust(@weapons, @shieldBoosters)
		end
		
		# Devuelve true si la estación espacial está en un estado válido. Eso implica que
		# o bien no se tiene ningún daño pendiente o que este no tiene efecto.
		
		def validState
			return (@pendingDamage == nil || @pendingDamage.hasNoEffect)
			# @pendingDamage.nil? es lo mismo
		end	
		
		def to_s
			return getUIversion.to_s
		end
	
	end
	
	
	# Código de prueba

=begin
	sp = SuppliesPackage.new(10, 8, 6)
	s = SpaceStation.new("prueba", sp)

	puts s.weapons.at(2).to_s
	puts s.shieldBoosters.at(2).to_s
	s.cleanUpMountedItems
	puts s.weapons.at(2).to_s
	puts s.shieldBoosters.at(2).to_s
	s.mountShieldBooster(0)
	a = Weapon.new("a", WeaponType::PLASMA, 2)
	s.receiveWeapon(a)

	arma1 = Weapon.new("manolo", WeaponType::LASER, 2)	# Prueba
	shield1 = ShieldBooster.new("Prueba1", 2.0, 10)	# Prueba
	h = Hangar.new(10)					# Prueba	
	h.addWeapon(arma1)					# Prueba
	h.addShieldBooster(shield1)				# Prueba
	s.receiveHangar(h)
	puts s.hangar.inspect

	puts s.fuelUnits
	puts s.speed
	s.receiveSupplies(sp)
	puts s.speed
	s.move
	puts s.fuelUnits

	puts s.to_s

=end
	
end
