from django.conf import settings
from django.conf.urls.static import static
from django.urls import path, include
from django.contrib import admin
from authentication.views import EmailLoginView, GoogleLoginView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),  # Include API URLs
    path('auth/', include('authentication.urls')),  # Include Authentication URLs
    path('google-login/', GoogleLoginView.as_view(), name='google_login'),
    path('login/', EmailLoginView.as_view(), name='email_login'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
