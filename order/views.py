from typing import Any, Dict
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.urls import reverse
from django.contrib.auth.decorators import login_required
from menu.models import MenuItem
from .models import Order, OrderItem
from django.shortcuts import render
from reportlab.pdfgen import canvas
from django.http import HttpResponse
from django.db.models import Sum
from django.views.generic import UpdateView
from django.views.decorators.http import require_http_methods
from dotenv import load_dotenv
import requests
import random
import math
import os


load_dotenv()

@login_required
def create_new_order(request):
    if request.method == "POST":
        user = request.user
        new_order = Order.objects.create(user=user)

        new_order.save()

        request.session['cart'] = new_order.id

        return redirect(reverse('menu_items'))
    
    return redirect(reverse('homepage'))


@login_required
def add_order_item(request, item_id):
    menu_item = get_object_or_404(MenuItem, id=item_id)

    if request.method == 'POST': 
        user = request.user
        menu_item_id = request.POST.get('menu_item')
        quantity = request.POST.get('quantity')
        phone_number = request.POST.get('phone_number')

        try:
            menu_item = MenuItem.objects.get(pk=menu_item_id)
            # Process the order and save it to the database
            order_item = OrderItem.objects.create(user=user, item=menu_item, quantity=quantity,phone=phone_number)

            order_item.save()

            print(request.user)

            order_id = request.session['cart']

            order = Order.objects.get(id=order_id)

            print(order)

            order.items.add(order_item)

            order.save()

            messages.success(request,"Item added successfully")

            return redirect('menu_items')
        except MenuItem.DoesNotExist:
            messages.error(request, "Order not created")
            print("Order not created")
            return redirect(reverse('menu_items'))

    return render(request, 'order/make_order.html', {'selected_item': menu_item})

@login_required
def order_items(request):
    orders = Order.objects.filter(user=request.user).all()
   
    # first_item = orders.first().items.first()

    return render(request, 'order/order_items.html',{'orders':orders})


@login_required
def order_item_detail(request,item_id):
    order = get_object_or_404(Order,id=item_id)

    return render(request,'order/order_details.html',{'order':order,'total_price':order.cart_total()})

@login_required
def delete_item_from_order(request,order_id,item_id):
    order = get_object_or_404(Order, pk=order_id)
    item = get_object_or_404(OrderItem, pk=item_id)
    
    order.items.remove(item)

    return redirect(reverse('order_detail',kwargs={'item_id':item.id}))

@login_required
def order_checkout(request, order_id):
    order = get_object_or_404(Order, id= order_id)
    if request.method == 'POST':
        name = request.POST['name']
        email = request.POST['email']
        amount = order.grand_total()
        phone = request.POST['phone']

        print(email,amount,phone)

        request.session['cart'] = {'id':1}
        return redirect(str(process_payment(name, email, amount, phone)))

    context = {'order': order}
    return render(request, 'order/order_checkout.html', context)



def process_payment(name, email, amount, phone):
    auth_token = os.getenv('FLUTTERWAVE_SECRET_KEY')
    hed = {'Authorization': 'Bearer ' + auth_token}
    data = {
        "tx_ref": ''+str(math.floor(1000000 + random.random()*9000000)),
        "amount": amount,
        "currency": "UGX",
        "redirect_url": "https://localhost:8000/",
        "payment_options": " ",
        "meta": {
            "consumer_id": 23,
            "consumer_mac": "92a3-912ba-1192a"
        },
        "customer": {
            "email": email,
            "phonenumber": phone,
            "name": name
        },
        "customizations": {
            "title": "My Restaurant",
            "description": "This is my restaurant"
        }
    }
    url = ' https://api.flutterwave.com/v3/payments'
    response = requests.post(url, json=data, headers=hed)
    response = response.json()
    link = response['data']['link']
    return link


@require_http_methods(['GET', 'POST'])
def payment_response(request):
    status = request.GET.get('status', None)
    tx_ref = request.GET.get('tx_ref', None)
    print(status)
    print(tx_ref)
    return render(request, 'landing/success.html')


@login_required
def delete_order(request,order_id):
    order = get_object_or_404(Order,id=order_id)

    order.delete()

    return redirect(reverse('order_items'))



class OrderItemUpdateView(UpdateView):
    model = OrderItem
    template_name = "order/order_item_update.html"
    fields = ['quantity']
    context_object_name = 'selected_item'
    
    def get_context_data(self, **kwargs: Any):
        context = super().get_context_data(**kwargs)

        previous_url = self.request.META.get("HTTP_REFERER")

        context['previous_url'] = previous_url
        return super().get_context_data(**kwargs)


def generate_report(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="order_report.pdf"'

    # Create a canvas object with the response
    p = canvas.Canvas(response)

    # Fetch the orders
    orders = Order.objects.all()

    # Set the starting y-coordinate for the report
    y = 800

    # Iterate over the orders and add them to the report
    for order in orders:
        for order_item in order.items.all():
            order_name = order_item.item.name
            quantity = order_item.quantity
            created_at = order_item.created_at.strftime('%Y-%m-%d %H:%M:%S')
            order_user = order.user.username
            user_name = order.user.get_full_name()
            phone_number = order_item.phone

            # Write the order details to the report
            p.drawString(100, y, f"Order Name: {order_name}")
            p.drawString(100, y - 20, f"Quantity: {quantity}")
            p.drawString(100, y - 40, f"Time Created: {created_at}")
            p.drawString(100, y - 60, f"Order User: {order_user}")
            p.drawString(100, y - 80, f"User Name: {user_name}")
            p.drawString(100, y - 100, f"Phone Number: {phone_number}")

            # Adjust the y-coordinate for the next order
            y -= 120

    # Save the PDF canvas
    p.save()

    return response


