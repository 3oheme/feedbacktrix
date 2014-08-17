#!/usr/bin/env ruby

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

		badge_string = ''
		person_list.persons[member[0]].badges.each do |badge|
			badge_string += '<span class="badge badge-' + badge + '">'+ badge +'</span>'
		end
		percentage = ((person_list.persons[member[0]].points * 100) / max_points).to_s
		output += '
			<div>
				<div class="item">
            		<div class="name">' + name +'</div>
            		<div class="rightboard">
              		<span class="points" >' + points +' points '+ badge_string +'</span>
              		<span class="bar" style="width:' + percentage +'%">&nbsp;</span>
	            </div>
   		    </div>'
	end

	return output

end