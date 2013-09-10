class Population
  attr_accessor :size

  def initialize( population_size, should_initialize)
    initialize_population(population_size, should_initialize)
  end

  def get_tour( index )
    tours[index]
  end

  def fittest
    tours.max_by{ |t| t.fitness }
  end

  def save_tour( index, tour )
    tours[index] = tour
  end

  def each( offset )
    tours.each_with_index do |tour, index|
      next if index < offset
      yield tour
    end
  end

  private
  def initialize_population( population_size, should_initialize = false)
    @size = population_size
    reset_tours

    if should_initialize
      population_size.times do
        new_tour = Tour.new
        new_tour.generate_individual
        tours << new_tour
      end
    end
  end

  def tours
    @tours
  end

  def reset_tours
    @tours = []
  end
end
