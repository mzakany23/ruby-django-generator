require_relative 'django_generator'
require_relative 'parser'

project = DjangoGenerator.new('new_django_project','bootstrap_template')
index_location = "#{project.base}/base.html"
parser = HtmlTagParser.new(index_location)

project.setup
parser.replace_images

