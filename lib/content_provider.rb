#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'timetable_service_initializer'
require 'logger'

begin
  service = TimetableServiceInitializer.init_service
  time_tables = service.get_time_tables

  output='<table class="busTable">'
  output +='<tr><th>Bussi</th><th>Suunta</th><th>Ajat (min)</th></tr>'
  
  time_tables.each do |bus, times|
    output += '<tr>'
    output += '<td>' + bus.name + '</td>'
    output += '<td>' + bus.last_stop[0..5] + '</td>'
    output += '<td>'
    times.each do |time|
      output += " " + time.to_s
    end
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









