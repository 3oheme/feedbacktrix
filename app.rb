#!/usr/bin/env ruby

require 'pp'
require 'erb'

require_relative 'data_loader'
require_relative 'view.rb'
require_relative 'model.rb'

person_list = Person_list_with_points.new(raw_data_members, raw_data_feedback)

feedback_matrix_section = print_feedback_matrix_section(person_list)
leaderboard_section = print_leaderboard_section(person_list)

template = ERB.new(File.read("templates/index.erb"))
html_content = template.result(binding)
File.open("index.html", "w") do |file|
  file.puts html_content
end