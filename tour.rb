class Tour
  def initialize( tour = nil )
    if tour
      set_tour( tour )
    else
      reset_tour
    end
  end

  def generate_individual
    set_tour
    # Loop through all our destination cities and add them to our tour
    TourManager.each_city do |city|
      tour << city
    end

    # randomly reorder the tour
    shuffle_tour!
  end

  def set_at_first_available( city )
    index = tour.index( nil )
    raise "No available spot left in tour! #{to_s}" unless index
    tour[index] = city
    index
  end

  def get_city( tour_position )
    tour[ tour_position ]
  end

  def set_city( tour_position, city )
    tour[tour_position] = city

    # reset cached fitness and distance
    @fitness = @distance = 0
  end

  def fitness
    if @fitness == 0
      @fitness = 1.0/distance
    end
    @fitness
  end

  def distance
    if @distance == 0
      tour_distance = 0
      tour.each_with_index do |city, index|
        from_city = city
        if index + 1 < size
          destination_city = get_city(index+1)
        else
          # If it is the last city in the turn, set
          # the first city as the destination
          destination_city = get_city(0)
        end

        tour_distance += from_city.distance_to(destination_city)
      end
      @distance = tour_distance
    end
    @distance
  end

  def contains_city?( city )
    tour.include?( city )
  end

  def each_with_index(&block)
    tour.each_with_index &block
  end

  def to_s
    gene_string = "|"
    tour.each do |city|
      gene_string << "#{city}|"
    end
    "#{gene_string} => #{distance}"
  end

  def size
    @tour.size
  end

  private
  def tour
    @tour
  end

  def shuffle_tour!
    @tour = tour.shuffle
  end

  def set_tour( tour = [])
    @fitness = 0
    @distance = 0
    @tour = tour
  end

  def reset_tour
    set_tour
    TourManager.number_of_cities.times { |i| tour << nil }
  end
end
