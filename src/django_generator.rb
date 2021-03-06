require 'optparse'
require 'fileutils'
require_relative 'parser'
require_relative '../config'

class DjangoGenerator

	attr_reader :base

	def initialize(project_name, bootstrap_template=nil, location=DJANGO_PROJECT_DIR)
		scrubbed_project_name = project_name.gsub('-','_')
		@project_name = scrubbed_project_name
		@location = location
		if bootstrap_template.nil?
			@bootstrap_template_project_dir = nil
		else
			if File.directory?(bootstrap_template)
				@bootstrap_template_project_dir = bootstrap_template
			else
				@bootstrap_template_project_dir = "#{@location}/#{bootstrap_template}"
			end
		end
		@base = "#{@location}/#{@project_name}/static/templates/layouts"
		@virtualenv_folder = "#{location}/#{@project_name}"
		@django_build_directory = "#{RUBY_DJANGO_GENERATOR_DIR}/files"
		@full_settings_location = "#{location}/#{@project_name}/#{@project_name}/#{@project_name}"
		@private_folder = "/private/var/folders/sn/rfwbfk455x9fvl0bldkbj8x40000gn/T/pip_build_mzakany"
		@static_django_location = "#{@virtualenv_folder}/static/static"
	end

	
	def setup
		p 'creating virtualenv'
		create_virtualenv
		p 'creating structure'
		create_structure
		unless @bootstrap_template_project_dir.nil?
			p 'copying over bootstrap files'
			copy_over_boostrap_files 
		else
			p "There's no bootstrap folder to merge over on the desktop."
		end
	end

	def migrate
		Dir.chdir("#{@virtualenv_folder}/#{@project_name}") do 
			system("python manage.py migrate")
		end
	end

	def runserver
		Dir.chdir("#{@virtualenv_folder}/#{@project_name}") do 
			system("python manage.py runserver")
		end
	end	










	private


	def copy_over_boostrap_files
		files = []

		Dir.foreach(@bootstrap_template_project_dir) do |line|
			BOOTSTRAP_TAGS_TO_LOOK_FOR.each do |tag|
				if line == tag
					FileUtils.cp_r("#{@bootstrap_template_project_dir}/#{line}", "#{@static_django_location}")
				end
			end	
		end

	end

	def create_virtualenv
		if virtualenv_exists == false
			Dir.chdir("#{@location}") do 
				system("virtualenv #{@location}/#{@project_name}")
			end
		else
			return "#{@project_name} is already set up"
		end
	end

	def create_structure
		if virtualenv_exists
			Dir.chdir(@virtualenv_folder) do 
				system("django-admin.py startproject #{@project_name}")
				Dir.chdir(@project_name) do 
					system("python manage.py startapp home")
				end
				system("mkdir db static static/media static/templates static/templates/home static/templates/layouts static/static static/static/css static/static/js static/static/img")
				system("touch .gitignore")
				system("git init .")
			end
		else
			raise "There is no virtualenv folder setup. Set that up first"
		end
		copy_django_files_over
	end
	
	def copy_django_files_over
		lookup = "SESSION_COOKIE_AGE = 14000"
		arr = ["ROOT_URLCONF = '#{@project_name}.urls' ", "WSGI_APPLICATION = '#{@project_name}.wsgi.application'"]

		django_main_folder = "#{@virtualenv_folder}/#{@project_name}/#{@project_name}"
		django_settings = "#{django_main_folder}/settings.py"
		requirements_file = "#{@django_build_directory}/requirements.txt"
		urls_file = "#{@django_build_directory}/urls.py"
		home_view_file = "#{@django_build_directory}/views.py"
		base_html = "#{@django_build_directory}/base.html"
		index_html = "#{@django_build_directory}/index.html"
		FileUtils.cp(base_html,"#{@virtualenv_folder}/static/templates/layouts/base.html")
		FileUtils.cp(index_html,"#{@virtualenv_folder}/static/templates/home/index.html")
		parser = HtmlTagParser.new("#{@django_build_directory}/settings.py")
		parser.parse_file_and_append_some_lines_and_create_file(lookup,arr,"#{django_main_folder}/settings.py")
		FileUtils.cp(requirements_file,"#{@virtualenv_folder}")
		system("sudo cp #{urls_file} #{django_main_folder}/urls.py")		
		FileUtils.cp(home_view_file,"#{@virtualenv_folder}/#{@project_name}/home/views.py")
	end

	

	def clean_requirement_folder_so_can_reinstall
		directory = Dir.new("#{@private_folder}")
		Dir.foreach(directory) do |folder|
			match = /(?<words>\w{0,10})/.match(folder)
			system("rm -rf #{match[:words]}")
		end
	end

	def make_requirements_file(requirements)
		FileUtils.touch("#{@virtualenv_folder}/requirements.txt")	
		requirement_arr = requirements.split(",")
		
		begin
		  file = File.open("#{@virtualenv_folder}/requirements.txt", 'w')
		  for req in requirement_arr
		  	file.write("#{req}\n")
		  end
		rescue IOError => e
		  
		ensure
		  file.close unless file == nil
		end
	end

	def install_requirements_file
		clean_requirement_folder_so_can_reinstall
		system("pip install -r #{@virtualenv_folder}/requirements.txt -t #{@virtualenv_folder}/lib/python2.7/site-packages")
	end

	def virtualenv_exists
		File.directory?("#{@location}/#{@project_name}")
	end

end





