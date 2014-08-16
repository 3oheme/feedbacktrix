#!/usr/bin/env ruby

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