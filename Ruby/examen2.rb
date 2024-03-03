require_relative 'CardDealer'
require_relative 'SpaceStation'
require_relative 'SpaceCity'

class Examen

	def self.run
		card = Deepspace::CardDealer.instance
		lista = []

		3.times{
			lista << Deepspace::SpaceStation.new("s", card.nextSuppliesPackage)
		}

		lista2 = lista
		puts lista2.inspect
		lista2.delete_at(1)
		puts lista2.inspect
		city = Deepspace::SpaceCity.new(lista[1], lista2)
		lista[1]=city
		puts lista2.inspect

		for s in lista do
			s.fire
		end


	end
end

Examen.run