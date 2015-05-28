require 'optparse'
require 'fileutils'

class DjangoGenerator

	def initialize(project_name,location='/Users/mzakany/Desktop')
		scrubbed_project_name = project_name.gsub('-','_')
		@project_name = scrubbed_project_name
		@location = location
		@base = "#{location}/#{@project_name}/#{@project_name}/static/templates/layouts"
		@virtualenv_folder = "#{location}/#{@project_name}"
		@django_build_directory = File.absolute_path('files')
		@full_settings_location = "#{location}/#{@project_name}/#{@project_name}/#{@project_name}"
		@private_folder = "/private/var/folders/sn/rfwbfk455x9fvl0bldkbj8x40000gn/T/pip_build_mzakany"
	end

	
	def setup
		create_virtualenv
		create_structure
	end


	private

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





