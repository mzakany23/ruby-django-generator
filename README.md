## Django Bootstrap Generator in ruby

This is a project of some scripts that automate making a base django project inside of a virtualenv. 

Once the project is made there's a command that will take a bootstrap template and turn it into the django project that was created.


```ruby

# download a bootstrap template 
cd ~/Desktop
https://github.com/IronSummitMedia/startbootstrap-creative.git bootstrap_template

# download ruby-django-generator
git clone https://github.com/mzakany23/ruby-django-generator.git ruby-django-generator

# copy the django file to path
cp ruby-django-generator/django /bin

# edit the config.rb file locations
DJANGO_PROJECT_DIR = '/Users/mzakany/Desktop'
RUBY_DJANGO_GENERATOR_DIR = '/Users/mzakany/Desktop/ruby-django-generator'
BOOTSTRAP_TEMPLATE_DIR = '/Users/mzakany/Desktop/template'
BOOTSTRAP_TEMPLATE_INDEX_FILE = "#{BOOTSTRAP_TEMPLATE_DIR}/index.html"

# make django project and combine with bootstrap bootstrap_template
django g test_project bootstrap_template

# or just make a django project
django g test_project


```