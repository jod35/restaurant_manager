from .models import Order
from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404
from datetime import datetime
from django.http import HttpRequest


def order_processor(request:HttpRequest):
    try:
        order_id = request.session['cart']

        order = Order.objects.get(id=order_id)
        print(order)

        return {'current_order':order}
    except:
        order = {'id':1}
        print(order)
        return {"current_order":order}


