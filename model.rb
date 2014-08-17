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
		@raw_data_members = raw_data_members
		raw_data_members.each do |member|
			@persons[member] = Person.new(member, raw_data_feedback)
		end
		calculate_points
	end

	private
	
	def calculate_points
		@persons.each do |person|
			person_info = person[1]
			give_1_point_for_each_feedback(person_info)
			give_10_points_if_giving_feedback_to_everyone(person_info)
		end
	end

	def give_1_point_for_each_feedback(person)
		@feedback.each do |pair|
			if pair[0] == person.name or pair[1] == person.name
				@persons[person.name].points += 1
			end
		end
	end

	def give_10_points_if_giving_feedback_to_everyone(person)
		list_of_all_users = @raw_data_members.dup
		@feedback.each do |pair|
			if pair[0] == person.name or pair[1] == person.name
				list_of_all_users.delete(pair[0])
				list_of_all_users.delete(pair[1])
			end
		end
		if list_of_all_users.length == 0
			@persons[person.name].points += 10
		end
	end

end