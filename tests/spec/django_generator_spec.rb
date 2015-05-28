require_relative '../../django_generator'

describe DjangoGenerator do 
	before do 
		@project = DjangoGenerator.new('test_project','.')
	end


	it 'doesnt delete whole desktop' do 
		@project.clean_requirement_folder_so_can_reinstall
	end
end
