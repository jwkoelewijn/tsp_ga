require './city'
require './tour'
require './tour_manager'
require './population'
require './ga'

city = City.new(60, 200);
TourManager.add_city(city);
city2 = City.new(180, 200);
TourManager.add_city(city2);
city3 = City.new(80, 180);
TourManager.add_city(city3);
city4 = City.new(140, 180);
TourManager.add_city(city4);
city5 = City.new(20, 160);
TourManager.add_city(city5);
city6 = City.new(100, 160);
TourManager.add_city(city6);
city7 = City.new(200, 160);
TourManager.add_city(city7);
city8 = City.new(140, 140);
TourManager.add_city(city8);
city9 = City.new(40, 120);
TourManager.add_city(city9);
city10 = City.new(100, 120);
TourManager.add_city(city10);
city11 = City.new(180, 100);
TourManager.add_city(city11);
city12 = City.new(60, 80);
TourManager.add_city(city12);
city13 = City.new(120, 80);
TourManager.add_city(city13);
city14 = City.new(180, 60);
TourManager.add_city(city14);
city15 = City.new(20, 40);
TourManager.add_city(city15);
city16 = City.new(100, 40);
TourManager.add_city(city16);
city17 = City.new(200, 40);
TourManager.add_city(city17);
city18 = City.new(20, 20);
TourManager.add_city(city18);
city19 = City.new(60, 20);
TourManager.add_city(city19);
city20 = City.new(160, 20);
TourManager.add_city(city20);

# Initialize population
population = Population.new(100, true)
puts "Initial distance: #{population.fittest.distance}"

# Evolve population
population = GA.evolve_population( population )
population = GA.evolve_population( population )
100.times do
  population = GA.evolve_population( population )
end

puts "Finished"
puts "Final distance: #{population.fittest.distance}"
puts "Solution:"
puts population.fittest.to_s
