require_relative '../../src/parser'

describe HtmlTagParser do 
	before do 
		@string_file = "/a>\n                </div>\n                <div class=\"col-lg-4 col-sm-6\">\n                    <a href=\"#\" class=\"portfolio-box\">\n                        <img src=\"img/portfolio/4.jpg\" class=\"img-responsive\" alt=\"\">\n                        <div class=\"portfolio-box-caption\">\n                            <div class=\"portfolio-box-caption-content\">\n                                <div class=\"project-category text-faded\">\n                                    Category\n                                </div>\n                                <div class=\"project-name\">\n                                    Project Name\n                                </div>\n                            </div>\n                        </div>\n                    </a>\n                </div>\n                <div class=\"col-lg-4 col-sm-6\">\n                    <a href=\"#\" class=\"portfolio-box\">\n                        <img src=\"img/portfolio/5.jpg\" class=\"img-responsive\" alt=\"\">\n                        <div class=\"portfolio-box-caption\">\n                            <div class=\"portfolio-box-caption-content\">\n                                <div class=\"project-category text-faded\">\n                                    Category\n                                </div>\n                                <div class=\"project-name\">\n                                    Project Name\n                                </div>\n                            </div>\n                        </div>\n                    </a>\n                </div>\n                <div class=\"col-lg-4 col-sm-6\">\n                    <a href=\"#\" class=\"portfolio-box\">\n                        <img src=\"img/portfolio/6.jpg\" class=\"img-responsive\" alt=\"\">\n                        <div class=\"portfolio-box-caption\">\n                            <div class=\"portfolio-box-caption-content\">\n                                <div class=\"project-category text-faded\">\n                                    Category\n                                </div>\n                                <div class=\"project-name\">\n                                    Project Name\n                                </div>\n                            </div>\n                        </div>\n                    </a>\n                </div>\n            </div>\n        </div>\n    </section>\n\n    <aside class=\"bg-dark\">\n        <div class=\"container text-center\">\n            <div class=\"call-to-action\">\n                <h2>Free Download at Start Bootstrap!</h2>\n                <a href=\"#\" class=\"btn btn-default btn-xl wow tada\">Download Now!</a>\n            </div>\n        </div>\n    </aside>\n\n    <section id=\"contact\">\n        <div class=\"container\">\n            <div class=\"row\">\n                <div class=\"col-lg-8 col-lg-offset-2 text-center\">\n    "
		@file = 'test_html/index.html'
		@parser = HtmlTagParser.new(@file,'test_html')
		@new_parser = HtmlTagParser.new('../../files/settings.py','/Users/mzakany/Desktop')
	end

	# it 'replaces all index page with django tags and creates output file' do 
	# 	@parser.replace_index_page_with_django_tags.to_html
	# end

	it 'append settings' do 
		lookup = "SESSION_COOKIE_AGE = 14000"
		arr = ["ROOT_URLCONF = 'new_django_project.urls' ", "WSGI_APPLICATION = 'new_django_project.wsgi.application'"]
		# @new_parser.parse_file_and_append_some_lines_and_create_file(lookup,arr,'/Users/mzakany/Desktop/settings.py')
	end

	it 'test system' do 
		
	end
end

#