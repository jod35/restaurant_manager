from . import views
from django.urls import path

urlpatterns = [
    path('order_items/', views.order_items, name='order_items'),
    
   
    path('make_order/<int:item_id>/',views.make_order,name='make_order')
    
]