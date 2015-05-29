require 'optparse'
require 'fileutils'

class DjangoGenerator

	attr_reader :base

	def initialize(project_name, bootstrap_template=nil, location='/Users/mzakany/Desktop')
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
		@django_build_directory = File.absolute_path('files')
		@full_settings_location = "#{location}/#{@project_name}/#{@project_name}/#{@project_name}"
		@private_folder = "/private/var/folders/sn/rfwbfk455x9fvl0bldkbj8x40000gn/T/pip_build_mzakany"
		@static_django_location = "#{@virtualenv_folder}/static/static"
	end

	
	def setup
		create_virtualenv
		create_structure
		if File.exist?(@bootstrap_template_project_dir)
			copy_over_boostrap_files 
		else
			p "There's no bootstrap folder to merge over on the desktop."
		end
	end

	

	private

	def copy_over_boostrap_files
		files = []
		Dir.foreach(@bootstrap_template_project_dir) do |line|
			if line == 'img' or line == 'images'
				FileUtils.cp_r("#{@bootstrap_template_project_dir}/#{line}", "#{@static_django_location}")
			elsif line == 'js' or line == 'javascripts'
				FileUtils.cp_r("#{@bootstrap_template_project_dir}/#{line}", "#{@static_django_location}")
			elsif line == 'css'
				FileUtils.cp_r("#{@bootstrap_template_project_dir}/#{line}", "#{@static_django_location}")
			elsif line == 'fonts'
				FileUtils.cp_r("#{@bootstrap_template_project_dir}/#{line}", "#{@static_django_location}")
			elsif line == 'index.html'
				FileUtils.cp("#{@bootstrap_template_project_dir}/#{line}", "#{@virtualenv_folder}/static/templates/layouts/base.html")
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
				copy_django_files_over
			end
		else
			raise "There is no virtualenv folder setup. Set that up first"
		end
	end
	
	def copy_django_files_over
		django_main_folder = "#{@virtualenv_folder}/#{@project_name}/#{@project_name}"
		settings_file = "#{@django_build_directory}/settings.py"
		django_settings = "#{django_main_folder}/settings.py"
		requirements_file = "#{@django_build_directory}/requirements.txt"
		urls_file = "#{@django_build_directory}/urls.py"
		home_view_file = "#{@django_build_directory}/views.py"
		base_html = "#{@django_build_directory}/base.html"
		index_html = "#{@django_build_directory}/index.html"
		FileUtils.cp(base_html,"#{@virtualenv_folder}/static/templates/layouts/base.html")
		FileUtils.cp(index_html,"#{@virtualenv_folder}/static/templates/home/index.html")
		FileUtils.cp(settings_file,django_settings)
		FileUtils.cp(requirements_file,"#{@virtualenv_folder}")
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





