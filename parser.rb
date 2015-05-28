require 'fileutils'


class HtmlTagParser
	
	attr_reader :file_location, :html_file
	attr_accessor :formatted_output_string
	
	def initialize(html_file,file_location=FileUtils.pwd)
		@html_file = html_file
		@file_location = file_location
	end

	def replace_images
		return_formatted_string_html_page_by_tag_type('img').to_html
	end



	protected

	def return_formatted_string_html_page_by_tag_type(tag)
		tag = "<#{tag}"
		output_string = ""
		@formatted_output_string = ""

		File.open(@html_file, "r") do |line|
			line.each_char do |char|
				output_string += char
			end
		end

	
		for i in 0..output_string.length-1
		
			full_word = output_string[i..i+tag.length-1]

			if full_word == tag
				x = i
				whole_line = ""
				bracket_count = 0
				havnt_found_everything_inside_brackets = true
				
				while havnt_found_everything_inside_brackets do 
					
					whole_line += output_string[x]
					
					bracket_count += 1 if output_string[x] == '"'

					if bracket_count != 2
						x += 1
					else
						

						whole_line_de_stringed = whole_line.gsub(/\"/, '')
						
						match = /(?<start><img src=)(?<middle>\w{0,4}\/\w{0,25}\/\d{0,10}\.\w{0,4})/.match(whole_line_de_stringed)
						
						new_formatted_line = "#{match[:start]} " + %Q["{% static '#{match[:middle]}' %}"] + ' '
						
						output_string[i..x] = ''

						@formatted_output_string += new_formatted_line

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
		File.open('file.html','a') {|line| line.write(@formatted_output_string)}
	end

end


# html_file = "../static/templates/layouts/base.html"

# f = HtmlTagParser.new(html_file)


# f.replace_images
