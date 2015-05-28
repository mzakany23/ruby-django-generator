from django.contrib import admin

urlpatterns = patterns('',
  url(r'^admin/', include(admin.site.urls)),
)

urlpatterns += patterns('home.views',
	url(r'^$', 'home',name='home'),
)