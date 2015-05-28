require 'optparse'
require 'fileutils'

class DjangoGenerator

	def initialize(project_name,location='/Users/mzakany/Desktop')
		@project_name = project_name
		@location = location
		@base = "#{location}/#{project_name}/#{project_name}/static/templates/layouts"
		@django_build_directory = "/Users/mzakany/Desktop/django-build-scripts"
		@full_settings_location = "#{location}/#{project_name}/#{project_name}/#{project_name}"
		@virtualenv_folder = "#{location}/#{project_name}"
		@private_folder = "/private/var/folders/sn/rfwbfk455x9fvl0bldkbj8x40000gn/T/pip_build_mzakany"
	end

	
	def set_up
		create_virtual_env
		make_requirements_file("django==1.7.7,psycopg2")
		install_requirements_file

		# Dir.chdir("#{@location}") do 
		# 	system("virtualenv #{@project_name}")
		# 	Dir.chdir("#{@project_name}") do 
		# 		make_requirements_file("django==1.7.7,psycopg2")
		# 		install_requirements_file
		# 		system("mkdir db static static/media static/templates static/templates/home static/templates/layouts static/static static/static/css static/static/js static/static/img")
		# 		FileUtils.cp("#{@django_build_directory}/base.html","static/templates/layouts/base.html")
		# 		system("django-admin.py startproject #{@project_name}")
		# 		Dir.chdir("#{@project_name}") do 
		# 			system("python manage.py startapp home")
		# 			FileUtils.cp("#{@django_build_directory}/settings.py","#{@full_settings_location}/settings.py")
		# 		end
		# 	end
		# end
	end

	def create_virtual_env
		system("virtualenv #{@location}/#{@project_name}")
	end

	def clean_requirement_folder_so_can_reinstall
		directory = Dir.new("#{@private_folder}")
		Dir.foreach(directory) {|folder| p folder}
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

end





