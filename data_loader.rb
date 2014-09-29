#!/usr/bin/env ruby

require 'csv'

def raw_data_members
	raw_array_data_members = [
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
		"Dan",
    "Darren",
    "Julie",
    "Andy"
	]
	return raw_array_data_members.dup
end

def raw_data_feedback

	csv = CSV.read('feedback.csv')
	csv.delete_at(0)
	csv.map { |row| row.delete_at(0) }
	csv.each do |row|
		row[0].strip!
		row[1].strip!
	end

	return csv.dup
end
