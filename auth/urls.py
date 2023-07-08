from django.urls import path
import django.contrib.auth.views as auth_views
from . import views



urlpatterns = [
    path('login/', auth_views.LoginView.as_view(
        template_name= 'auth/login.html'
    ), name='login'),
    path('signup/',views.register, name='signup'),
    path('logout/',auth_views.LogoutView.as_view(next_page='/'),name='logout')
]