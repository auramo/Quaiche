
class TimetableSource

  def initialize(config)
    @config = config
  end
  
  def get_times()
    timetables = []
    raw_data.each do |raw_chunk|
      parsed = @parser.parse(raw_chunk)
      timetables << @next_time_extractor.extract(parsed)
    end
    timetables
  end

end
