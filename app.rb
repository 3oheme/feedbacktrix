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
	attr_accessor :name, :points
	def initialize(name, role = 'none')
		@name = name
		@role = role
		@points = 0
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
	def initialize(raw_data_members, raw_data_feedback)
		@persons = Hash.new
		@feedback = raw_data_feedback
		raw_data_members.each do |member|
			@persons[member] = Person.new(member)
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

person_list = Person_list_with_points.new(raw_data_members, raw_data_feedback)


