class City
  attr_accessor :id
  attr_accessor :time
  
  def initialize( id, time = nil )
    self.id = id
    self.time = time
  end

  def duration_to( city )
    TourManager.duration_matrix[id][city.id]
  end

  def to_s
    "#{self.id}"
  end
end
