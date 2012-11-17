#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'timetable_service_initializer'
require 'logger'

begin
  service = TimetableServiceInitializer.init_service
  time_tables = service.get_time_tables
  sorted_time_tables = time_tables.sort_by { |bus, nbt| bus.name }

  output='<table class="busTable">'
  output +='<tr><th>Bussi</th><th>Suunta</th><th>Min (klo)</th></tr>'
  
  sorted_time_tables.each do |bus, next_bus_times|
    output += '<tr>'
    output += '<td>' + bus.name + '</td>'
    output += '<td>' + bus.last_stop[0..5] + '</td>'
    output += '<td>'
    output += next_bus_times.join(", ")
    output += '</td>'
    output += '</tr>'
  end

  output += '</table>'
  
  puts output


rescue => ex
  err_msg = "#{ex.class}: #{ex.message}" 
  Logger.error(err_msg + "\n" + ex.backtrace.join("\n"))
  puts "<p>#{err_msg}</p>"
end









