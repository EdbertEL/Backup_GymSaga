from django.conf import settings
from django.conf.urls.static import static
from django.urls import path, include
<<<<<<< HEAD
from django.contrib import admin  
=======
from django.contrib import admin

from authentication.views import EmailLoginView, GoogleLoginView
>>>>>>> 0476b3c (backend register login + google)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),  # Include API URLs
    path('auth/', include('authentication.urls')),  # Include Authentication URLs
    path('google-login/', GoogleLoginView.as_view(), name='google_login'),
    path('login/', EmailLoginView.as_view(), name='email_login'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
