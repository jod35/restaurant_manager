from . import views
from django.urls import path


urlpatterns = [
    path('', views.delivery_items, name='delivery'),
]