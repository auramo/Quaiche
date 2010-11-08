
class TimetableService

  def initialize(sources)
    @sources = sources
  end

  def get_time_tables
    next_times = {}
    for source in @sources
      next_times_for_stop = source.get_times
      next_times.update(next_times_for_stop)
    end
    next_times
  end
  
end


