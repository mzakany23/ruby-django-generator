require 'fileutils'


class HtmlTagParser 
	
	attr_reader :html_file, :file_location, :tag
	attr_accessor :formatted_output_string
	
	def initialize(html_file,file_location=FileUtils.pwd)
		@html_file = html_file
		@file_location = file_location	
	end

	def replace_images
		if File.exist?(@html_file)
			return_formatted_string_html_page_by_tag_type('img').to_html
		else
			raise 'There is nothing to parse'
		end
	end

	def replace_css
		
	end

	def replace_js

	end







	# protected

	def return_formatted_string_html_page_by_tag_type(tag)
		if tag == 'img' 
			tag = " <#{tag}"
		end

		@tag = tag
		
		@formatted_output_string = ""

		output_string = generate_output_string

		for i in 0..output_string.length-1
			
			full_word = output_string[i..i+tag.length-1]

			if full_word == tag
				x = i
				whole_line = ""
				bracket_count = 0
				havnt_found_everything_inside_brackets = true
								
				while havnt_found_everything_inside_brackets do 
	
					whole_line += output_string[x]
					
					bracket_count += 1 if output_string[x] == '>'

					if bracket_count != 1
						x += 1
					else
						
						match = return_relavant_tag_regex(whole_line)

						unless match.nil?
							new_formatted_line = "#{match[:start]} " + %Q["{% static '#{match[:middle]}' %}"] + ' ' + "class='#{match[:class]}' + alt=''"
					
							output_string[i..x] = ''
					
							@formatted_output_string += new_formatted_line
						end

						havnt_found_everything_inside_brackets = false
					end
				end
				
			else
				@formatted_output_string += output_string[i] unless output_string[i].nil?
			end
		end

		return self

	end

	def to_html
		File.open('file.html','w') {|line| line.write(@formatted_output_string)}
	end

	def generate_output_string
		output_string = ""
		File.open(@html_file, "r") do |line|
			line.each_char do |char|
				output_string += char
			end
		end
		return output_string
	end

	def return_relavant_tag_regex(line)
		whole_line_de_stringed = line.gsub(/\"/, '')
		if @tag == 'img'
			match = /(?<start><img src=)(?<middle>\w{0,4}\/\w{0,25}\/\d{0,10}\.\w{0,4})\s\w{0,9}\=(?<class>\w{0,5}.\w{0,20})(?<all_else>.{0,10})/.match(whole_line_de_stringed)
		end
		return match
	end
end




# html_file = "../static/templates/layouts/base.html"

# f = HtmlTagParser.new(html_file)


# f.replace_images
