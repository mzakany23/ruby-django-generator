require_relative 'django_generator'
require_relative 'parser'

class DjangoProjectGenerator
	def initialize(project_name,bootstrap_template_name=nil)
		if bootstrap_template_name.nil?
			@project = DjangoGenerator.new(project_name)
		else
			@project = DjangoGenerator.new(project_name, bootstrap_template_name)
		end

		location_of_bootstrap_dir = "/Users/mzakany/Desktop/template/index.html"
		if File.exist?(location_of_bootstrap_dir)
			@parser = HtmlTagParser.new("/Users/mzakany/Desktop/template/index.html","/Users/mzakany/Desktop/#{project_name}/static/templates/layouts/base.html")
		else 
			@parser = nil
		end		
	end

	def create
		p 'setting up project...'
		@project.setup
		p 'replacing index page'
		@parser.replace_index_page_with_django_tags.to_html
		p 'migrating database...'
		@project.migrate
		p 'running server...'
		@project.runserver
	end
end


DjangoProjectGenerator.new("new_project").create



