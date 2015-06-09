require_relative 'django_generator'
require_relative 'parser'
require_relative '../config'

class DjangoProjectGenerator
	def initialize(project_name, bootstrap_template_index_location=nil)
		
		@bootstrap_template_index_location = bootstrap_template_index_location

		if bootstrap_template_index_location.nil?
			@project = DjangoGenerator.new(project_name)
		else
			@project = DjangoGenerator.new(project_name, bootstrap_template_index_location)
			@parser = HtmlTagParser.new("#{BOOTSTRAP_TEMPLATE_DIR}/index.html","#{DJANGO_PROJECT_DIR}/#{project_name}/static/templates/layouts/base.html")	
		end
	end 

	def create
		p 'setting up project...'
		@project.setup
		unless @bootstrap_template_index_location.nil?
			p 'replacing index page'
			@parser.replace_index_page_with_django_tags.to_html
			p 'migrating database...'
			@project.migrate
			p 'running server...'
			@project.runserver
		else
			@project.migrate
			@project.runserver
		end
	end
end






