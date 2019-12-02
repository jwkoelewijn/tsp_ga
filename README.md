This is Ruby implementation of a Genetic Algorithm to solve the Traveling Salesman Problem.

It is based on a Java implementation at:
http://www.theprojectspot.com/tutorial-post/applying-a-genetic-algorithm-to-the-travelling-salesman-problem/5

## Features
This implementation solves TSP with following assumptions:
* Start city is fixed
* Some cities should be visited before certain time
* Travelling time between each pair of cities is defined in matrix 

## Usage
```ruby
#duration from city to city in seconds
duration_matrix = {
  1538=>{1539=>1453, 1540=>1492, 1541=>976, 1542=>1204, 1543=>1119, 1546=>1954, 1547=>1459, 1549=>919, 1544=>973, 1552=>1154}, 
  1539=>{1538=>1564, 1540=>935, 1541=>1171, 1542=>1237, 1543=>1181, 1546=>2242, 1547=>901, 1549=>1474, 1544=>836, 1552=>1285}, 
  1540=>{1538=>1477, 1539=>930, 1541=>796, 1542=>540, 1543=>655, 1546=>1729, 1547=>360, 1549=>1024, 1544=>621, 1552=>722}, 
  1541=>{1538=>1060, 1539=>1185, 1540=>818, 1542=>353, 1543=>267, 1546=>1296, 1547=>1071, 1549=>451, 1544=>377, 1552=>307}, 
  1542=>{1538=>1377, 1539=>1218, 1540=>497, 1541=>490, 1543=>372, 1546=>1419, 1547=>750, 1549=>741, 1544=>536, 1552=>427}, 
  1543=>{1538=>1180, 1539=>1151, 1540=>711, 1541=>382, 1542=>363, 1546=>1385, 1547=>965, 1549=>611, 1544=>336, 1552=>405}, 
  1544=>{1542=>520, 1549=>592, 1540=>629, 1552=>461, 1538=>919, 1539=>799, 1541=>368, 1543=>290, 1546=>1276, 1547=>877}, 
  1546=>{1538=>1872, 1539=>2160, 1540=>1640, 1541=>1237, 1542=>1176, 1543=>1218, 1547=>1681, 1549=>1074, 1544=>1313, 1552=>1029}, 
  1547=>{1538=>1542, 1539=>1041, 1540=>442, 1541=>1112, 1542=>857, 1543=>971, 1546=>1829, 1549=>1341, 1544=>931, 1552=>1032}, 
  1549=>{1538=>925, 1539=>1387, 1540=>1081, 1541=>541, 1542=>631, 1543=>538, 1546=>1142, 1547=>1334, 1544=>647, 1552=>460}, 
  1552=>{1540=>1068, 1542=>541, 1544=>655, 1549=>532, 1538=>1247, 1539=>1402, 1541=>545, 1543=>543, 1546=>875, 1547=>1315}
}
TourManager.set_duration_matrix(duration_matrix)

start_city = City.new(1538);
TourManager.add_city(start_city);
#new city (id - unique identifier of city, time - offset from start time in seconds)
city2 = City.new(1539, 120*60);
TourManager.add_city(city2);
city3 = City.new(1540, 120*60);
TourManager.add_city(city3);
city4 = City.new(1541, 40*60);
TourManager.add_city(city4);
city5 = City.new(1542, 30*60);
TourManager.add_city(city5);
city6 = City.new(1543, 40*60);
TourManager.add_city(city6);
city7 = City.new(1544, 35*60);
TourManager.add_city(city7);
city8 = City.new(1546);
TourManager.add_city(city8);
city9 = City.new(1547);
TourManager.add_city(city9);
city10 = City.new(1549, 150*60);
TourManager.add_city(city10);
city11 = City.new(1552);
TourManager.add_city(city11);

# Initialize population
population = Population.new(100, true)
puts "Initial duration: #{population.fittest.duration} seconds"

# Evolve population
100.times do
  population = GA.evolve_population( population )
end

puts "Finished"
puts "Final duration: #{population.fittest.duration} seconds"

duration = 0
route = population.fittest

puts "Solution:"
route.each_with_index do |city, index|
  puts "#{city.id} \t should arrive before #{city.time} \t will arrive at #{duration}"
  duration += city.duration_to(route.get_city(index + 1)) if index + 1 < route.size
end
```