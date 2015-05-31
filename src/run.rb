require_relative 'django_generator'
require_relative 'parser'

project = DjangoGenerator.new('new_django_project','template')
parser = HtmlTagParser.new("/Users/mzakany/Desktop/template/index.html","/Users/mzakany/Desktop/new_django_project/static/templates/layouts/base.html")


project.setup
parser.replace_index_page_with_django_tags.to_html


