require_relative '../../parser'

describe HtmlTagParser do 
	before do 
		@string_file = "/a>\n                </div>\n                <div class=\"col-lg-4 col-sm-6\">\n                    <a href=\"#\" class=\"portfolio-box\">\n                        <img src=\"img/portfolio/4.jpg\" class=\"img-responsive\" alt=\"\">\n                        <div class=\"portfolio-box-caption\">\n                            <div class=\"portfolio-box-caption-content\">\n                                <div class=\"project-category text-faded\">\n                                    Category\n                                </div>\n                                <div class=\"project-name\">\n                                    Project Name\n                                </div>\n                            </div>\n                        </div>\n                    </a>\n                </div>\n                <div class=\"col-lg-4 col-sm-6\">\n                    <a href=\"#\" class=\"portfolio-box\">\n                        <img src=\"img/portfolio/5.jpg\" class=\"img-responsive\" alt=\"\">\n                        <div class=\"portfolio-box-caption\">\n                            <div class=\"portfolio-box-caption-content\">\n                                <div class=\"project-category text-faded\">\n                                    Category\n                                </div>\n                                <div class=\"project-name\">\n                                    Project Name\n                                </div>\n                            </div>\n                        </div>\n                    </a>\n                </div>\n                <div class=\"col-lg-4 col-sm-6\">\n                    <a href=\"#\" class=\"portfolio-box\">\n                        <img src=\"img/portfolio/6.jpg\" class=\"img-responsive\" alt=\"\">\n                        <div class=\"portfolio-box-caption\">\n                            <div class=\"portfolio-box-caption-content\">\n                                <div class=\"project-category text-faded\">\n                                    Category\n                                </div>\n                                <div class=\"project-name\">\n                                    Project Name\n                                </div>\n                            </div>\n                        </div>\n                    </a>\n                </div>\n            </div>\n        </div>\n    </section>\n\n    <aside class=\"bg-dark\">\n        <div class=\"container text-center\">\n            <div class=\"call-to-action\">\n                <h2>Free Download at Start Bootstrap!</h2>\n                <a href=\"#\" class=\"btn btn-default btn-xl wow tada\">Download Now!</a>\n            </div>\n        </div>\n    </aside>\n\n    <section id=\"contact\">\n        <div class=\"container\">\n            <div class=\"row\">\n                <div class=\"col-lg-8 col-lg-offset-2 text-center\">\n    "
	end

	# it 'finds returns a formatted html in string' do 
	# 	word_trying_to_find = '<img'
	# 	for i in 0..@string_file.length
	# 		full_word = @string_file[i..i+word_trying_to_find.length-1]
	# 		if full_word == word_trying_to_find
	# 			x = i
	# 			whole_line = ""
	# 			bracket_count = 0
	# 			havnt_found_everything_inside_brackets = true
				
	# 			while havnt_found_everything_inside_brackets do 
					
	# 				whole_line += @string_file[x]
	# 				bracket_count += 1 if @string_file[x] == '"'
	# 				if bracket_count != 2
	# 					x += 1
	# 				else
	# 					start_of_replace = i
	# 					ending_of_replace = x
						
	# 					havnt_found_everything_inside_brackets = false
	# 				end
	# 			end
			
	# 			line_to_replace = @string_file[i..x]
	# 			p line_to_replace
	# 			# whole_line_de_stringed = whole_line.gsub(/\"/, '')
	# 			# match = /(?<start><img src=)(?<middle>\w{0,4}\/\w{0,25}\/\d{0,10}\.\w{0,4})/.match(whole_line_de_stringed)
	# 			# p match[:start]
				

	# 		end
	# 	end	
	# end

	it 'deletes a portion of the string' do 
		output = "hey man"
		print output
		for i in 0..output.length-1
			if output[i] == 'h'
				output[i..i+4] = ''
			end
		end


		print "\n" + output


	end
end
