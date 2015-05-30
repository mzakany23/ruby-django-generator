## Django Bootstrap Generator in ruby

This is a project of some scripts that automate making a base django project inside of a virtualenv. 

Once the project is made there's a command that will take a bootstrap template and turn it into the django project that was created.


'''ruby

require 'parser'

### create django project structure on desktop
project = DjangoGenerator.new('django_project_title','bootstrap_template_dir_location')
project.set_up

### replace bootstrap index.html page with django tags
parser = HtmlTagParser.new(bootstrap_index_page_location,'where_to_save/index.html')
parser.replace_index_page_with_django_tags.to_html

'''