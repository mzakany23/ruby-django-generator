require_relative '../src/run'
require_relative '../config'

type_of_script = ARGV[0]
project_name = ARGV[1]
bootstrap_folder_name = ARGV[2]

if project_name.nil? and bootstrap_folder_name.nil?
		p "Django Generator Command Line: \n"
		p "see https://github.com/mzakany23/ruby-django-generator for usage"
		p 'try this:'
		p 'django g run_test'
end

if type_of_script == 'generate' or type_of_script == 'g'
	unless project_name.nil?
		if BOOTSTRAP_TEMPLATE_DIR.nil?
			project = DjangoProjectGenerator.new(project_name)
		else
			if File.directory?(BOOTSTRAP_TEMPLATE_DIR) and File.exist?(BOOTSTRAP_TEMPLATE_INDEX_FILE) and bootstrap_folder_name != nil and bootstrap_folder_name == File.basename(BOOTSTRAP_TEMPLATE_DIR)
				project = DjangoProjectGenerator.new(project_name, BOOTSTRAP_TEMPLATE_DIR)
			else
				if bootstrap_folder_name.nil?
					p 'it appears there is a bootstrap folder to swap over, but '
					p 'wasnt specified in the django g command.'
					p 'i.e: django g test_project bootstrap_template'
				else
					p "bootstrap folder doesn't exist of isn't set up correctly in config.rb."
					p "setting up django project without bootstrap project"	
				end
				
				project = DjangoProjectGenerator.new(project_name)
			end
		end

		project.create
	else
		p 'specify a django project name (i.e.): django g test_project'
	end	
end