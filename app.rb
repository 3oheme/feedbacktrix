#!/usr/bin/env ruby

require 'pp'
require 'erb'

def raw_data_members
	return [
		"Ignacio",
		"Alina",
		"Taheerah",
		"Matt",
		"Mike",
		"Maryam",
		"Laura",
		"Mircea",
		"Richard",
		"Arvind",
		"Pablo",
		"Dan"
	]
end

def raw_data_feedback
	return [
		["Mircea","Alina"],
		["Matt","Laura"],
		["Ignacio","Mike"],
		["Ignacio","Alina"],
		["Ignacio","Maryam"],
		["Ignacio","Mircea"],
		["Ignacio","Taheerah"],
		["Ignacio","Mike"],
		["Alina","Laura"],
		["Alina","Richard"],
		["Alina","Matt"],
		["Alina","Mike"],
		["Taheerah","Richard"],
		["Taheerah","Matt"],
		["Taheerah","Laura"],
		["Taheerah","Maryam"],
		["Taheerah","Mike"],
		["Alina","Arvind"],
		["Mircea","Laura"],
		["Mircea","Maryam"],
		["Matt","Richard"],
		["Matt","Mike"],
		["Matt","Maryam"],
		["Matt","Mircea"],
		["Laura","Mike"],
		["Laura","Richard"],
		["Laura","Maryam"]
	]
end

class Person
	attr_accessor :name, :points, :has_give_feedback_to
	def initialize(name, raw_data_feedback)
		@name = name
		@points = 0
		@has_give_feedback_to = Hash.new
		raw_data_members.each do |member|
			@has_give_feedback_to[member] = 0
		end
		raw_data_feedback.each do |pair|
			if pair[0] == name 
				@has_give_feedback_to[pair[1]] += 1
			elsif pair[1] == name
				@has_give_feedback_to[pair[0]] += 1
			end
		end
	end

	def <=>(other_person)
		if self.name < other_person.name
			-1
		else
			1
		end
	end
end

class Person_list_with_points

	attr_accessor :persons, :feedback

	def initialize(raw_data_members, raw_data_feedback)
		@persons = Hash.new
		@feedback = raw_data_feedback
		raw_data_members.each do |member|
			@persons[member] = Person.new(member, raw_data_feedback)
		end
		calculate_points
	end

	private
	
	def calculate_points
		@persons.each do |person|
			give_1_point_for_each_feedback(person)
		end
	end

	def give_1_point_for_each_feedback(person)
		@feedback.each do |pair|
			if pair[0] == person[1].name or pair[1] == person[1].name
				@persons[person[0]].points += 1
			end
		end
	end

end

def print_feedback_matrix_section(person_list)
	output = ''
	sorted_list_of_names = raw_data_members
	sorted_list_of_names.sort!

	# print head of the table
	output += '
		<table>
	        <thead>
	         	<tr>
	        		<th>&nbsp;</th>'
	sorted_list_of_names.each do |member|
		output += '<th>' + member + '</th>'
	end
	output += '
				</tr>
        	</thead>
        	<tbody>'

    # print each line of the matrix

    sorted_list_of_names.each do |member_col|
		output += '<tr><td>'+ member_col +'</td>'
		sorted_list_of_names.each do |given_feedback|
			feedback_times = person_list.persons[member_col].has_give_feedback_to[given_feedback].to_s
			output += '<td class="feedbackmatrix-n' + feedback_times + '">' + feedback_times + '</td>'
		end
		output += '</tr>'
	end

	output += '</table>'

	return output
end

def print_leaderboard_section(person_list)
	output = ''
	sorted_list_of_names = []
	raw_data_members.each do |member|
		sorted_list_of_names.push([member, person_list.persons[member].points])
	end

	sorted_list_of_names.sort! { |a,b| b[1] <=> a[1] }

	max_points = sorted_list_of_names[0][1]

	sorted_list_of_names.each do |member|

		name = person_list.persons[member[0]].name
		points = person_list.persons[member[0]].points.to_s
		percentage = ((person_list.persons[member[0]].points * 100) / max_points).to_s
		output += '
			<div>
				<div class="item">
            		<div class="name">' + name +'</div>
            		<div class="rightboard">
              		<span class="points" >' + points +' points</span>
              		<span class="bar" style="width:' + percentage +'%">&nbsp;</span>
	            </div>
   		    </div>'
	end

	return output

end

person_list = Person_list_with_points.new(raw_data_members, raw_data_feedback)

feedback_matrix_section = print_feedback_matrix_section(person_list)
leaderboard_section = print_leaderboard_section(person_list)

template = ERB.new(File.read("index.erb"))
html_content = template.result(binding)
File.open("index.html", "w") do |file|
  file.puts html_content
end