from django.shortcuts import render

def home(request):
	context = {}
	template = 'home/index.html'
	return render(request,template,context,context_instance=RequestContext(request, processors=[get_home_variables]))




	
