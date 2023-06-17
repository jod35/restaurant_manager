from . import views
from django.urls import path

urlpatterns = [
    path('', views.order_items, name='order_items'),
]