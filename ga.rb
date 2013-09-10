class GA
  def self.mutation_rate
    0.015
  end

  def self.tournament_size
    5
  end

  def self.elitism
    true
  end

  def self.evolve_population( population )
    new_population = Population.new( population.size, false )

    # if elitism is enabled we keep the best individual
    elitism_offset = 0
    if elitism
      #puts "Saving fittest: #{population.fittest.distance}"
      new_population.save_tour(0, population.fittest)
      elitism_offset = 1
    end

    # Crossover population
    # Loop over the new population's size
    (elitism_offset...population.size).each do |i|
      # Select parents
      parent1 = tournament_selection( population )
      parent2 = tournament_selection( population )

      # Crossover parents
      child = crossover( parent1, parent2 )
      new_population.save_tour(i, child)
    end

    # Mutate the new population a bit to add some new genetic material
    new_population.each(elitism_offset) do |tour|
      mutate(tour)
    end

    new_population
  end

  # Applies crossover of random genes and creates offspring
  def self.crossover( parent1, parent2)
    child = Tour.new

    # Get random start and end sub tour positions for parent1's tour
    start_pos = Integer(rand * parent1.size)
    end_pos = Integer(rand * parent2.size)

    parent1_genes = []
    parent2_genes = []
    # Loop and add the sub tour from parent1 to our child
    (0...child.size).each do |i|
      # if our start position is less than the end position
      if start_pos < end_pos && i > start_pos && i < end_pos
        parent1_genes << i
        child.set_city( i, parent1.get_city(i) )
      elsif start_pos > end_pos # if it is larger
        if !(i < start_pos && i > end_pos)
          parent1_genes << i
          child.set_city(i, parent1.get_city(i) )
        end
      end
    end

    # Loop through parent2's city tour
    parent2.each_with_index do |city, index|
      if !child.contains_city?( city )
        parent2_genes << child.set_at_first_available( city )
      end
    end

    child
  end

  # Mutate a tour using swap mutation
  def self.mutate( tour )
    (0...tour.size).each do | tourPos1 |
      # Apply mutation rate
      if rand < mutation_rate
        tourPos2 = Integer( rand * tour.size)

        city1 = tour.get_city( tourPos1 )
        city2 = tour.get_city( tourPos2 )

        tour.set_city( tourPos2, city1 )
        tour.set_city( tourPos1, city2 )
      end
    end
  end

  def self.tournament_selection( population )
    # Create a tournament population
    tournament = Population.new( tournament_size, false)

    # For each place in the tournament get a random candidate tour and and it
    (0...tournament_size).each do |index|
      random_index = Integer(rand * population.size)
      tournament.save_tour(index, population.get_tour( random_index ) )
    end

    tournament.fittest
  end
end
