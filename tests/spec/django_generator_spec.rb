require_relative '../../django_generator'

describe DjangoGenerator do 
	before do 
		@project = DjangoGenerator.new('test_project')
	end


	# it 'clean private folder' do 
	# 	@project.clean_requirement_folder_so_can_reinstall
	# end

	# it 'check virtualenv exists' do 
	# 	@project.create_virtualenv
	# end

	it 'build dir' do 
		Dir.chdir("/Users/mzakany/Desktop/ruby-django-generator/") do 
			
		end
	end
end
