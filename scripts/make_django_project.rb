require_relative '../src/run'

type_of_script = ARGV[0]
project_name = ARGV[1]
bootstrap_folder_location = ARGV[2]


if type_of_script == 'generate' or type_of_script == 'g'
	unless project_name.nil?
		if bootstrap_folder_location.nil?
			project = DjangoProjectGenerator.new(project_name)
		else
			project = DjangoProjectGenerator.new(project_name, bootstrap_folder_location)
		end

		project.create
	else
		p 'specify a django project name (i.e.): django g test_project'
	end	
end