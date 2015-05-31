from django.conf.urls import patterns, include, url
from django.conf import settings

from django.contrib import admin
admin.autodiscover()

# main
urlpatterns = patterns('',
 		url(r'^/error', 'home.views.error',name='error'),
    url(r'^admin/', include(admin.site.urls)),
)

# home
urlpatterns += patterns('home.views',
	url(r'^$', 'home',name='home'),
)

# media
urlpatterns += patterns('',
    (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}))
